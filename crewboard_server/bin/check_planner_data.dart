// ignore_for_file: avoid_print
import 'package:crewboard_server/src/generated/endpoints.dart';
import 'package:crewboard_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

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
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

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
  } catch (e) {
    print('Warning: Port conflict: $e');
  }

  try {
    final session = await pod.createSession();

    print('\n=== Database Check ===\n');

    // Check Organizations
    final orgs = await Organization.db.find(session);
    print('Organizations: ${orgs.length}');
    for (var org in orgs) {
      print('  - ${org.name} (${org.id})');
    }

    // Check Users
    final users = await User.db.find(session);
    print('\nUsers: ${users.length}');
    for (var user in users) {
      print('  - ${user.userName} (Org: ${user.organizationId})');
    }

    // Check Planner Apps
    final apps = await PlannerApp.db.find(session);
    print('\nPlanner Apps: ${apps.length}');
    for (var app in apps) {
      print('  - ${app.appName} (Org: ${app.organizationId})');
    }

    // Check Buckets
    final buckets = await Bucket.db.find(session);
    print('\nBuckets: ${buckets.length}');
    for (var bucket in buckets) {
      print(
        '  - ${bucket.bucketName} (App: ${bucket.appId}, User: ${bucket.userId})',
      );
    }

    // Check Tickets
    final tickets = await Ticket.db.find(session);
    print('\nTickets: ${tickets.length}');

    // Check Statuses
    final statuses = await Status.db.find(session);
    print('\nStatuses: ${statuses.length}');
    for (var status in statuses) {
      print('  - ${status.statusName}');
    }

    // Check Priorities
    final priorities = await Priority.db.find(session);
    print('\nPriorities: ${priorities.length}');
    for (var priority in priorities) {
      print('  - ${priority.priorityName}');
    }

    await session.close();
  } catch (e, stack) {
    print('Error: $e');
    print(stack);
  } finally {
    await pod.shutdown();
  }
}
