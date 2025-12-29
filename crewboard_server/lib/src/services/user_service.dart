import 'dart:io';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod_auth_idp_server/core.dart';

/// Unified service for user creation with Serverpod auth synchronization.
/// This consolidates the duplicate logic from registerAdmin, createUser, and seedDatabase.
class UserService {
  /// Creates a new user with full Serverpod auth integration.
  ///
  /// This method handles:
  /// 1. User record creation in the custom User table
  /// 2. AuthUser creation for Serverpod's auth system
  /// 3. UserProfile creation for user metadata
  /// 4. EmailAuth creation for email/password authentication
  ///
  /// Parameters:
  /// - [session]: The current database session
  /// - [user]: The user object to create (must have email, userName set)
  /// - [password]: Plain text password (will be hashed securely)
  /// - [organizationId]: Optional organization ID (if null, must be set in user object)
  ///
  /// Returns: The created User object with ID populated
  ///
  /// Throws: Exception if user creation or auth sync fails
  static Future<User> createUserWithAuth(
    Session session,
    User user,
    String password, {
    UuidValue? organizationId,
  }) async {
    try {
      // 1. Validate inputs
      if (user.email.isEmpty) {
        throw Exception('Email is required');
      }
      if (user.userName.isEmpty) {
        throw Exception('Username is required');
      }
      if (password.length < 8) {
        throw Exception('Password must be at least 8 characters');
      }

      // 2. Set organization ID if provided
      if (organizationId != null) {
        user.organizationId = organizationId;
      }

      // 3. Check for existing user
      final existingUser = await User.db.findFirstRow(
        session,
        where: (t) => t.userName.equals(user.userName),
      );
      if (existingUser != null) {
        throw Exception('Username already exists');
      }

      // 4. Generate password hash using Serverpod's secure method
      final hashedPassword = await Emails.generatePasswordHash(password);

      // 5. Insert User record with hashed password
      final insertedUser = await User.db.insertRow(
        session,
        UserImplicit(user, $password: hashedPassword),
      );

      stdout.writeln('User created: ${user.userName} (${insertedUser.id})');

      // 6. Sync with Serverpod Auth using service-based approach
      await _syncWithServerpodAuth(
        session,
        insertedUser,
        password,
      );

      stdout.writeln('Auth sync completed for: ${user.userName}');

      return insertedUser;
    } catch (e) {
      stdout.writeln('Error creating user: $e');
      rethrow;
    }
  }

  /// Synchronizes the custom User with Serverpod's auth system.
  /// Uses the clean service-based approach from admin_endpoint.dart::createUser()
  static Future<void> _syncWithServerpodAuth(
    Session session,
    User user,
    String password,
  ) async {
    try {
      // 1. Create AuthUser (UUID-based)
      final authUser = await AuthServices.instance.authUsers.create(session);
      final authUserId = authUser.id;

      stdout.writeln('AuthUser created with ID: $authUserId');

      // 2. Create UserProfile
      await AuthServices.instance.userProfiles.createUserProfile(
        session,
        authUserId,
        UserProfileData(
          email: user.email,
          userName: user.userName,
        ),
      );

      stdout.writeln('UserProfile created for: ${user.userName}');

      // 3. Create Email Authentication
      final emailIdp = AuthServices.getIdentityProvider<EmailIdp>();
      await emailIdp.admin.createEmailAuthentication(
        session,
        authUserId: authUserId,
        email: user.email,
        password: password,
      );

      stdout.writeln('EmailAuth created for: ${user.email}');
    } catch (e) {
      stdout.writeln('Error syncing with Serverpod auth: $e');
      rethrow;
    }
  }

  /// Validates email format
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
    return emailRegex.hasMatch(email);
  }

  /// Validates password strength
  static String? validatePassword(String password) {
    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }
    // Add more validation rules as needed
    return null;
  }
}
