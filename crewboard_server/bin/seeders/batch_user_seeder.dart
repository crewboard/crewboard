import 'dart:io';

import 'package:crewboard_server/src/generated/endpoints.dart';
import 'package:crewboard_server/src/generated/protocol.dart';
import 'package:crewboard_server/src/services/user_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

// Copy of configuration from lib/server.dart
void _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  // Silent or log
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  // Silent or log
}

void main(List<String> args) async {
  // Initialize Serverpod
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  // Initialize Auth Services
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      ServerSideSessionsConfig(
        sessionKeyHashPepper: 'crewboard_dev_session_pepper',
      ),
    ],
    identityProviderBuilders: [
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCode,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
      ),
    ],
  );

  // Start Serverpod (connects to DB)
  await pod.start();

  try {
    final session = await pod.createSession();
    
    print('\n--- Batch User Seeder ---');

    final userList = [
      'Aethera',
      'Nyvora',
      'Lumis',
      'Zephyra',
      'Kaivon',
      'Orinex',
      'Vireon',
      'Solvex',
      'Nexora',
      'Elvyn',
      'Astrael',
      'Morixa',
      'Valenor',
      'Eryx',
      'Kairox',
      'Thryva',
      'Orynn',
      'Zenvik',
      'Calyra',
      'Ilyon',
      'Ravix',
      'Sorex',
      'Velora',
      'Axion',
      'Myntra',
      'Kryon',
      'Altair',
      'Zorik',
      'Lyra',
      'Noven',
    ];

    final password = '0007!Asd';
    
    // Fetch defaults once
    final userType = await UserTypes.db.findFirstRow(
      session,
      where: (t) => t.userType.equals('user'),
    );
     final organization = await Organization.db.findFirstRow(session);
    final defaultColor = await SystemColor.db.findFirstRow(session, where: (t) => t.isDefault.equals(true)) 
        ?? await SystemColor.db.findFirstRow(session);
    final defaultLeaveConfig = await LeaveConfig.db.findFirstRow(session);


    if (userType == null || organization == null || defaultColor == null || defaultLeaveConfig == null) {
      print('Error: Missing default resources (UserType, Org, Color, or LeaveConfig).');
      exit(1);
    }

    print('Creating ${userList.length} users...');

    for (final username in userList) {
      try {
        final email = '${username.toLowerCase()}@crewboard.com';
        print('Creating $username ($email)...');

        // Check if exists
        final existingUser = await User.db.findFirstRow(
            session,
            where: (t) => t.userName.equals(username),
        );

        if (existingUser != null) {
            print(' - Skipped: Username already exists.');
            continue;
        }

        final newUser = User(
          userName: username,
          email: email,
          organizationId: organization.id!,
          colorId: defaultColor.id!,
          userTypeId: userType.id!,
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

        await UserService.createUserWithAuth(
          session,
          newUser,
          password,
        );
        print(' - Success');

      } catch (e) {
        print(' - Failed: $e');
      }
    }

    print('\nBatch seeding completed.');

    await session.close();
  } catch (e) {
    print('\nError during batch seeding: $e');
  } finally {
    await pod.shutdown();
  }
}
