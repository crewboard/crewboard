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
  print('[EmailIdp] Registration code ($email): $verificationCode');
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  print('[EmailIdp] Password reset code ($email): $verificationCode');
}

void main(List<String> args) async {
  // Initialize Serverpod
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  // Initialize Auth Services (Required for UserService to work)
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
    
    print('\n--- User Seeder ---');
    
    // Get inputs
    stdout.write('Enter Username: ');
    final username = stdin.readLineSync()?.trim();
    if (username == null || username.isEmpty) {
      print('Username is required.');
      exit(1);
    }

    stdout.write('Enter Email: ');
    final email = stdin.readLineSync()?.trim();
    if (email == null || email.isEmpty) {
      print('Email is required.');
      exit(1);
    }

    stdout.write('Enter Password (min 8 chars): ');
    // Note: echoing password for simplicity in this dev script
    final password = stdin.readLineSync()?.trim();
    if (password == null || password.length < 8) {
      print('Password must be at least 8 characters.');
      exit(1);
    }

    // Optional: Select User Type (default to 'user' for now, or fetch from DB)
    final userType = await UserTypes.db.findFirstRow(
      session,
      where: (t) => t.userType.equals('user'),
    );
    if (userType == null) {
      print('Error: "user" UserType not found in database. Run migrations/seeds first.');
      exit(1);
    }

    // Optional: Select Organization (default to first/main one for now)
     final organization = await Organization.db.findFirstRow(session);
    if (organization == null) {
      print('Error: No organizations found. Run migrations/seeds first.');
      exit(1);
    }
    
    // Default Color/LeaveConfig
    final defaultColor = await SystemColor.db.findFirstRow(session, where: (t) => t.isDefault.equals(true)) 
        ?? await SystemColor.db.findFirstRow(session);
    final defaultLeaveConfig = await LeaveConfig.db.findFirstRow(session);

    if (defaultColor == null || defaultLeaveConfig == null) {
        print('Error: Missing default SystemColor or LeaveConfig.');
         exit(1);
    }

    print('\nCreating user...');

    // Construct User object
    // Note: IDs for organization, color, etc, will be effectively set/overridden or used as defaults
    // UserService.createUserWithAuth handles some logic, but expects a User object with some fields.
    final newUser = User(
      userName: username,
      email: email,
      organizationId: organization.id!,
      colorId: defaultColor.id!,
      userTypeId: userType.id!,
      leaveConfigId: defaultLeaveConfig.id!,
      firstName: username, // Default to username
      lastName: '',
      gender: 'unspecified',
      phone: '',
      performance: 0,
      online: false,
      onsite: false,
      deleted: false,
    );

    // Call the service
    await UserService.createUserWithAuth(
      session,
      newUser,
      password,
    );

    print('\nUser created successfully! You can now log in.');

    await session.close();
  } catch (e) {
    print('\nError creating user: $e');
  } finally {
    await pod.shutdown();
  }
}
