import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/user_service.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'dart:io';

class AuthEndpoint extends Endpoint {
  Future<CheckUsernameResponse> checkUsername(
    Session session,
    String userName,
  ) async {
    try {
      final user = await User.db.findFirstRow(
        session,
        where: (t) => t.userName.equals(userName),
      );
      return CheckUsernameResponse(exists: user != null);
    } catch (e) {
      stdout.writeln('Check username error: $e');
      return CheckUsernameResponse(exists: false);
    }
  }

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
      stdout.writeln('Check organization error: $e');
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
    UuidValue? organizationId,
  ) async {
    try {
      // 1. Validate email
      if (!UserService.isValidEmail(email)) {
        return RegisterAdminResponse(
          success: false,
          message: 'Invalid email format',
        );
      }

      // 2. Validate password
      final passwordError = UserService.validatePassword(password);
      if (passwordError != null) {
        return RegisterAdminResponse(
          success: false,
          message: passwordError,
        );
      }

      // 3. Check username availability
      final existingUser = await User.db.findFirstRow(
        session,
        where: (t) => t.userName.equals(username),
      );
      if (existingUser != null) {
        stdout.writeln(
          'Registration failed: Username $username already exists',
        );
        return RegisterAdminResponse(
          success: true,
          message: 'Username already exists',
          userId: existingUser.id.toString(),
        );
      }

      // 4. Get system defaults
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

      // 5. Determine organization ID
      UuidValue finalOrgId;
      if (signupType == 'organization') {
        // Create new organization
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

      // 6. Create user with auth integration using unified service
      final newUser = User(
        userName: username,
        email: email,
        organizationId: finalOrgId,
        colorId: defaultColor.id!,
        userTypeId: adminUserType.id!,
        leaveConfigId: defaultLeaveConfig.id!,
        firstName: username,
        lastName: '',
        gender: 'unspecified',
        phone: '',
        performance: 0,
        online: false,
        onsite: false,
        deleted: false,
      );

      final insertedUser = await UserService.createUserWithAuth(
        session,
        newUser,
        password,
      );

      stdout.writeln('Registration successful for $username');
      return RegisterAdminResponse(
        success: true,
        message: 'User registered successfully',
        userId: insertedUser.id.toString(),
      );
    } catch (e) {
      stdout.writeln('Registration error: $e');
      return RegisterAdminResponse(
        success: false,
        message: 'Registration failed: ${e.toString()}',
      );
    }
  }

  Future<SignInResponse> simpleLogin(
    Session session,
    String username,
    String password,
  ) async {
    try {
      // 1. Find User to get email from Custom User table (UserInfo is legacy/unused)
      final user = await User.db.findFirstRow(
        session,
        where: (t) => t.userName.equals(username),
      );

      if (user == null) {
        return SignInResponse(
          success: false,
          message: 'User not found',
        );
      }

      // 2. Use EmailIdp to login
      try {
        final emailIdp = AuthServices.getIdentityProvider<EmailIdp>();
        final authSuccess = await emailIdp.login(
          session,
          email: user.email,
          password: password,
        );

        return SignInResponse(
          success: true,
          message: 'Login successful',
          userId: user.id.toString(),
          organizationId: user.organizationId.toString(),
          authKeyId: 0, // Dummy ID, SAS uses encoded token
          authToken: authSuccess.token,
          authUserId: authSuccess.authUserId.toString(),
        );
      } catch (e) {
        // EmailIdp throws exceptions for invalid credentials
        stdout.writeln('EmailIdp login error: $e');
        return SignInResponse(
          success: false,
          message: 'Invalid credentials',
        );
      }
    } catch (e) {
      stdout.writeln('Simple login error: $e');
      return SignInResponse(
        success: false,
        message: 'Login failed: ${e.toString()}',
      );
    }
  }
}
