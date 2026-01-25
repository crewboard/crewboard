import 'package:crewboard_server/src/generated/protocol.dart';
import 'package:crewboard_server/src/generated/endpoints.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'dart:io';

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
  print('Initializing Serverpod...');
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
    try {
    print('Starting Serverpod...');
    await pod.start();
  } catch (e) {
    print('Warning: Failed to start server listeners (likely port conflict), attempting to continue with database session: $e');
  }
    print('Creating session...');
    final session = await pod.createSession();

    print('\n--- Database Inspection ---');
    
    final flows = await FlowModel.db.find(session);
    print('Flows Found: ${flows.length}');
    for (var f in flows) {
      print('  - Flow: "${f.name}" (ID: ${f.id})');
    }

    final users = await User.db.find(session);
    print('\nUsers Found: ${users.length}');
    for (var u in users) {
      print('  - User: "${u.userName}" (Email: ${u.email})');
    }

    final apps = await PlannerApp.db.find(session);
    print('\nApps Found: ${apps.length}');
    for (var a in apps) {
      print('  - App: "${a.appName}" (ID: ${a.id}, OrgID: ${a.organizationId})');
      
      final buckets = await Bucket.db.find(
        session,
        where: (t) => t.appId.equals(a.id!),
      );
      print('    - Buckets: ${buckets.length}');
      for (var b in buckets) {
          final ticketCount = await BucketTicketMap.db.count(
              session,
              where: (t) => t.bucketId.equals(b.id!),
          );
          print('      - Bucket: "${b.bucketName}" (Tickets: $ticketCount, UserID: ${b.userId})');
      }
    }

    final tickets = await Ticket.db.find(session);
    print('\nTotal Tickets Found: ${tickets.length}');

    print('\nClosing session...');
    await session.close();
  } catch (e, stack) {
    print('Error inspecting database: $e');
    print(stack);
  } finally {
    print('Shutting down Serverpod...');
    await pod.shutdown();
    print('Shutdown complete.');
    exit(0);
  }
}
