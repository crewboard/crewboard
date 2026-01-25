// ignore_for_file: avoid_print
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
      'Altair',
      'Ravix',
      'Ilyon',
      'Aethera',
      'Nyvora',
      'Lumis',
    ];

    final password = '0007!Asd';
    
    print('Fetching userType...');
    final userType = await UserTypes.db.findFirstRow(
      session,
      where: (t) => t.userType.equals('user'),
    );
    print('userType: $userType');
    
    print('Fetching organization...');
    var organization = await Organization.db.findFirstRow(
      session,
      where: (t) => t.name.equals('test'),
    );
    
    if (organization == null) {
      print('Creating "test" organization...');
      organization = await Organization.db.insertRow(
        session,
        Organization(name: 'test'),
      );
    }
    print('organization: $organization');

    print('Fetching colors...');
    final systemColors = await SystemColor.db.find(session);
    print('Found ${systemColors.length} colors.');

    print('Fetching defaultLeaveConfig...');
    final defaultLeaveConfig = await LeaveConfig.db.findFirstRow(session);
    print('defaultLeaveConfig: $defaultLeaveConfig');

    if (userType == null || systemColors.isEmpty || defaultLeaveConfig == null) {
      print('Error: Missing default resources.');
      print('userType: $userType');
      print('colors count: ${systemColors.length}');
      print('defaultLeaveConfig: $defaultLeaveConfig');
      exit(1);
    }

    print('Creating ${userList.length} users with dynamic colors...');

    int colorIndex = 0;
    for (final username in userList) {
      try {
        final email = '${username.toLowerCase()}@crewboard.com';
        final userColor = systemColors[colorIndex % systemColors.length];
        colorIndex++;

        print('Creating $username ($email) with color ${userColor.colorName}...');

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
          colorId: userColor.id!,
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
