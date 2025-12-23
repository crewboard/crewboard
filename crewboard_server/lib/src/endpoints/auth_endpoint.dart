import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../utils.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_auth_idp_server/core.dart';

class AuthEndpoint extends Endpoint {
  Future<CheckOrganizationResponse> checkOrganization(
    Session session,
    String name,
  ) async {
    try {
      final org = await Organization.db.findFirstRow(
        session,
        where: (t) => t.name.equals(name),
      );
      return CheckOrganizationResponse(exists: org != null);
    } catch (e) {
      print('Check organization error: $e');
      return CheckOrganizationResponse(exists: false);
    }
  }

  Future<RegisterAdminResponse> registerAdmin(
    Session session,
    String email,
    String username,
    String password,
    String signupType,
    String? organizationName,
    int? organizationId,
  ) async {
    try {
      // 1. Validate email (basic regex)
      final emailRegex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
      if (!emailRegex.hasMatch(email)) {
        return RegisterAdminResponse(
          success: false,
          message: 'Invalid email format',
        );
      }

      // 2. Validate password
      if (password.length < 8) {
        return RegisterAdminResponse(
          success: false,
          message: 'Password too short',
        );
      }

      // 3. Check username
      final existingUser = await User.db.findFirstRow(
        session,
        where: (t) => t.userName.equals(username),
      );
      if (existingUser != null) {
        print('Registration failed: Username $username already exists');
        return RegisterAdminResponse(
          success: false,
          message: 'Username already exists',
          userId: existingUser.id.toString(),
        );
      }

      // 4. Defaults
      // Need default SystemColor, UserType(admin), LeaveConfig.
      // This implies we have seeded data. If not, this might fail or we create them.
      // For now, let's look for defaults.

      final adminUserType = await UserTypes.db.findFirstRow(
        session,
        where: (t) => t.userType.equals('admin'),
      );
      final defaultColor = await SystemColor.db.findFirstRow(
        session,
        where: (t) => t.isDefault.equals(true),
      );
      final defaultLeaveConfig = await LeaveConfig.db.findFirstRow(session);

      if (adminUserType == null ||
          defaultColor == null ||
          defaultLeaveConfig == null) {
        return RegisterAdminResponse(
          success: false,
          message: 'System defaults not found. Seeding required.',
        );
      }

      int finalOrgId;
      if (signupType == 'organization') {
        // Create Org
        final org = Organization(
          name: organizationName ?? 'Default Organization',
        );
        final insertedOrg = await Organization.db.insertRow(session, org);
        finalOrgId = insertedOrg.id!;
      } else if (signupType == 'self-hosting') {
        if (organizationId == null) {
          return RegisterAdminResponse(
            success: false,
            message: 'Organization ID required',
          );
        }
        finalOrgId = organizationId;
      } else {
        return RegisterAdminResponse(
          success: false,
          message: 'Invalid signup type',
        );
      }

      // 5. Create User
      final hashedPassword = hashPassword(password);

      final newUser = User(
        userName: username,
        password: hashedPassword,
        email: email,
        organizationId: finalOrgId,
        colorId: defaultColor.id!,
        userTypeId: adminUserType.id!,
        leaveConfigId: defaultLeaveConfig.id!,
        firstName: username, // Default
        lastName: '',
        gender: 'unspecified',
        phone: '',
        performance: 0,
        online: false,
        onsite: false,
        deleted: false,
      );

      print('Creating custom User record for $username...');
      final insertedUser = await User.db.insertRow(session, newUser);

      // --- serverpod_auth integration ---
      print('Syncing with serverpod_auth for $email...');
      // Create AuthUser
      final authUser = await AuthServices.instance.authUsers.create(
        session,
      );
      final authUserId = authUser.id;
      print('AuthUser created with ID: $authUserId');

      // Create UserProfile
      await AuthServices.instance.userProfiles.createUserProfile(
        session,
        authUserId,
        UserProfileData(
          email: email,
          userName: username,
        ),
      );
      print('UserProfile created.');

      // Create Email Authentication
      final emailIdp = AuthServices.getIdentityProvider<EmailIdp>();
      await emailIdp.admin.createEmailAuthentication(
        session,
        authUserId: authUserId,
        email: email,
        password: password,
      );
      print('EmailAuthentication created for $email.');
      // ----------------------------------

      print('Registration successful for $username');
      return RegisterAdminResponse(
        success: true,
        message: 'User registered successfully',
        userId: insertedUser.id.toString(),
      );
    } catch (e) {
      print('Registration error: $e');
      return RegisterAdminResponse(
        success: false,
        message: 'Registration failed',
      );
    }
  }
}
