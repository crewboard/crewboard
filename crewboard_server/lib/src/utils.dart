import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'generated/protocol.dart';
import 'dart:io';

/// Helper class for authentication-related operations
class AuthHelper {
  /// Get the authenticated user from the session
  ///
  /// This method extracts the authenticated user information from the session
  /// and returns the corresponding User record from the database.
  ///
  /// Throws an Exception if:
  /// - The session is not authenticated
  /// - The user cannot be found in the database
  static Future<User> getAuthenticatedUser(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw Exception('Not authenticated');
    }

    final identifier = authInfo.userIdentifier;
    User? user;

    try {
      // 1. Try direct lookup in our User table if identifier is a UUID
      // This handles cases where the identifier might already be our record ID
      final uuid = UuidValue.fromString(identifier);
      user = await User.db.findById(
        session,
        uuid,
        include: User.include(color: SystemColor.include()),
      );
    } catch (e) {
      // Not a UUID or not found by ID
    }

    if (user != null) return user;

    // 2. Try looking up UserProfile via modern AuthServices (Serverpod 3.x)
    try {
      final authUserId = UuidValue.fromString(identifier);
      final profile = await AuthServices.instance.userProfiles
          .maybeFindUserProfileByUserId(
            session,
            authUserId,
          );

      if (profile != null && profile.email != null) {
        user = await User.db.findFirstRow(
          session,
          where: (t) => t.email.equals(profile.email!),
          include: User.include(color: SystemColor.include()),
        );

        if (user != null) {
          stdout.writeln(
            'DEBUG: Linked User to Auth system via email: ${profile.email}',
          );
          return user;
        }
      }
    } catch (e) {
      // Ignore lookup errors
    }

    // 3. Fallback to legacy UserInfo lookup
    try {
      UserInfo? userInfo;
      final id = int.tryParse(identifier);
      if (id != null) {
        userInfo = await UserInfo.db.findById(session, id);
      }

      userInfo ??= await UserInfo.db.findFirstRow(
        session,
        where: (t) => t.userIdentifier.equals(identifier),
      );

      if (userInfo != null && userInfo.email != null) {
        user = await User.db.findFirstRow(
          session,
          where: (t) => t.email.equals(userInfo!.email!),
          include: User.include(color: SystemColor.include()),
        );

        if (user != null) return user;
      }
    } catch (e) {
      // Ignore lookup errors
    }

    throw Exception('User record not found for auth identifier: $identifier');
  }
}
