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
  // Silence logs for seeder unless explicitly needed
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  // Silence logs for seeder unless explicitly needed
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
  try {
    await pod.start();
  } catch (e) {
    print('Note: Server listeners did not start (likely port conflict), continuing with database session.');
  }

  try {
    final session = await pod.createSession();

    print('\n--- User Seeder (Interactive Admin + Automatic Test Users) ---');

    // 1. Fetch Shared Resources
    final adminType = await UserTypes.db.findFirstRow(
      session,
      where: (t) => t.userType.equals('admin'),
    );
    if (adminType == null) {
      print('Error: "admin" UserType not found. Run main server migrations/seeds first.');
      exit(1);
    }

    final organization = await Organization.db.findFirstRow(session);
    if (organization == null) {
      print('Error: No organizations found. Run migrations/seeds first.');
      exit(1);
    }

    final allColors = await SystemColor.db.find(session);
    if (allColors.isEmpty) {
      print('Error: Missing SystemColors. Ensure they are seeded.');
      exit(1);
    }
    final colorsList = allColors.toList()..shuffle();

    final defaultLeaveConfig = await LeaveConfig.db.findFirstRow(session);
    if (defaultLeaveConfig == null) {
      print('Error: Missing LeaveConfig.');
      exit(1);
    }

    // --- PHASE 1: INTERACTIVE ADMIN CREATION ---

    print('\n[Step 1/2] Create Main Admin User');
    stdout.write('Enter Username: ');
    final adminUsername = stdin.readLineSync()?.trim();
    if (adminUsername == null || adminUsername.isEmpty) {
      print('Username is required.');
      exit(1);
    }

    stdout.write('Enter Email: ');
    final adminEmail = stdin.readLineSync()?.trim();
    if (adminEmail == null || adminEmail.isEmpty) {
      print('Email is required.');
      exit(1);
    }

    stdout.write('Enter Password (min 8 chars): ');
    final adminPassword = stdin.readLineSync()?.trim();
    if (adminPassword == null || adminPassword.length < 8) {
      print('Password must be at least 8 characters.');
      exit(1);
    }

    try {
      print('\nChecking/Creating admin user "$adminUsername"...');
      final existingAdmin = await User.db.findFirstRow(
        session,
        where: (t) => t.userName.equals(adminUsername),
      );

      if (existingAdmin == null) {
        final adminUser = User(
          userName: adminUsername,
          email: adminEmail,
          organizationId: organization.id!,
          colorId: colorsList.first.id!,
          userTypeId: adminType.id!,
          leaveConfigId: defaultLeaveConfig.id!,
          firstName: adminUsername,
          lastName: '',
          gender: 'unspecified',
          phone: '',
          performance: 0,
          online: false,
          onsite: false,
          deleted: false,
        );

        await UserService.createUserWithAuth(session, adminUser, adminPassword);
        print('Admin user "$adminUsername" created successfully!');
      } else {
        print('Admin user "$adminUsername" already exists, skipping creation.');
      }
    } catch (e) {
      print('Error creating admin user: $e');
      print('Proceeding to automatic seeding...');
    }

    // --- PHASE 2: AUTOMATIC TEST USERS ---

    print('\n[Step 2/2] Automatically Seeding Test Users...');
    final testUsers = ['Altair', 'Ravix', 'Ilyon', 'Aethera', 'Nyvora', 'Lumis'];
    final defaultPassword = '0007!Asd'; // Consistent test password

    int colorIndex = 1; // Start from next color
    for (final username in testUsers) {
      final email = '${username.toLowerCase()}@crewboard.com';
      
      // Check if exists
      final existing = await User.db.findFirstRow(
        session,
        where: (t) => t.userName.equals(username),
      );
      if (existing != null) {
        print(' - Skipping $username: Already exists.');
        continue;
      }

      print(' - Seeding $username ($email)...');
      final userColor = colorsList[colorIndex % colorsList.length];
      colorIndex++;

      final newUser = User(
        userName: username,
        email: email,
        organizationId: organization.id!,
        colorId: userColor.id!,
        userTypeId: adminType.id!, // Seed all as admins per user request "needs to be admin with all permissions"
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

      await UserService.createUserWithAuth(session, newUser, defaultPassword);
    }

    print('\nAll users seeded successfully! You can now log in.');

    await session.close();
  } catch (e) {
    print('\nError during seeding: $e');
  } finally {
    await pod.shutdown();
  }
}
