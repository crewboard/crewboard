import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:crewboard_server/src/generated/protocol.dart';

void main(List<String> args) async {
  final session = await RuntimeSettings.createSession();

  try {
    print('Checking custom User table...');
    final users = await User.db.find(
      session,
      where: (t) => t.userName.equals('jerin'),
    );
    if (users.isEmpty) {
      print('No user "jerin" found in custom users table.');
    } else {
      for (var user in users) {
        print(
          'Found User: id=${user.id}, userName=${user.userName}, email=${user.email}',
        );
      }
    }

    print('\nChecking Serverpod AuthUser table...');
    // We can't directly check AuthUser easily without internal access, but we can check profiles or email auth
    final profiles = await UserProfile.db.find(
      session,
      where: (t) => t.userName.equals('jerin'),
    );
    if (profiles.isEmpty) {
      print('No UserProfile found for "jerin".');
    } else {
      for (var profile in profiles) {
        print(
          'Found UserProfile: id=${profile.id}, userId=${profile.userId}, userName=${profile.userName}, email=${profile.email}',
        );
      }
    }

    print('\nChecking EmailAuth table (via direct query)...');
    final query =
        'SELECT * FROM serverpod_auth_email_auth WHERE email LIKE \'%jerin%\'';
    final result = await session.db.query(query);
    if (result.isEmpty) {
      print('No EmailAuth record found for email containing "jerin".');
    } else {
      for (var row in result) {
        print('Found EmailAuth: $row');
      }
    }
  } catch (e) {
    print('Error during diagnostics: $e');
  } finally {
    await session.close();
  }
}

// Mocking RuntimeSettings if needed, or just use a standard way to get a session
class RuntimeSettings {
  static Future<Session> createSession() async {
    // This is a bit tricky to do in a standalone script without full serverpod init
    // Better to run it as a maintenance task or within the server context
    throw UnimplementedError('Use server context');
  }
}
