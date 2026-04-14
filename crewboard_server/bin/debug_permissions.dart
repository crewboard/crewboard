// ignore_for_file: avoid_print
import 'package:crewboard_server/src/generated/protocol.dart';
import 'package:crewboard_server/src/generated/endpoints.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'dart:io';
import 'dart:convert';

void _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {}

void main(List<String> args) async {
  final pod = Serverpod(args, Protocol(), Endpoints());

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

  try {
    await pod.start();
    final session = await pod.createSession();

    print('\n--- Inspecting UserTypes ---');
    final types = await UserTypes.db.find(session);
    for (var t in types) {
      print('Type: ${t.userType}');
      print('  isAdmin: ${t.isAdmin}');
      print('  Permissions: ${t.permissions}');
      try {
        final perms = jsonDecode(t.permissions);
        print('  Decoded: $perms');
      } catch (e) {
        print('  ERROR decoding permissions: $e');
      }
    }

    print('\n--- Inspecting Users ---');
    final users = await User.db.find(
      session,
      include: User.include(userType: UserTypes.include()),
    );
    for (var u in users) {
      print('User: ${u.userName} (${u.email})');
      print('  Type: ${u.userType?.userType ?? 'NULL'}');
      print('  Type isAdmin: ${u.userType?.isAdmin ?? 'N/A'}');
    }

    await session.close();
  } catch (e) {
    print('Error: $e');
  } finally {
    await pod.shutdown();
    exit(0);
  }
}
