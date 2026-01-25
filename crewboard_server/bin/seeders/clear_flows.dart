import 'package:crewboard_server/src/generated/endpoints.dart';
import 'package:crewboard_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

void _sendRegistrationCode(Session s, {required String email, required UuidValue accountRequestId, required String verificationCode, required Transaction? transaction}) {}
void _sendPasswordResetCode(Session s, {required String email, required UuidValue passwordResetRequestId, required String verificationCode, required Transaction? transaction}) {}

void main(List<String> args) async {
  try {
    final pod = Serverpod(args, Protocol(), Endpoints());
    pod.initializeAuthServices(
      tokenManagerBuilders: [ServerSideSessionsConfig(sessionKeyHashPepper: 'crewboard_dev_session_pepper')],
      identityProviderBuilders: [EmailIdpConfigFromPasswords(sendRegistrationVerificationCode: _sendRegistrationCode, sendPasswordResetVerificationCode: _sendPasswordResetCode)],
    );
    try {
      print('Attempting to start Serverpod...');
      await pod.start();
      print('Serverpod started.');
    } catch (e) {
      print('Warning: Port conflict or other start error (ignoring): $e');
    }
    
    try {
      print('Creating session...');
      final session = await pod.createSession();
      print('Session created.');
      
      print('Fetching all flow charts...');
      final allFlows = await FlowModel.db.find(session);
      print('Found ${allFlows.length} flow charts.');
      
      if (allFlows.isNotEmpty) {
        print('Deleting ${allFlows.length} flow charts via ORM...');
        try {
          await FlowModel.db.delete(session, allFlows);
          print('ORM Delete successful.');
        } catch (e) {
          print('ORM Delete failed: $e. Trying direct SQL...');
          await session.db.unsafeQuery('DELETE FROM "flow";');
          print('SQL Delete successful.');
        }
      } else {
        print('No flow charts found via ORM. Trying direct SQL just in case...');
        await session.db.unsafeQuery('DELETE FROM "flow";');
        print('SQL Delete successful (ensured empty).');
      }
      
      final countAfter = await FlowModel.db.count(session);
      print('Final count in database: $countAfter');
      
      await session.close();
    } catch (e) {
      print('Critical Error during deletion: $e');
    } finally {
      print('Shutting down...');
      await pod.shutdown();
    }
  } catch (e, stack) {
    print('Global Crash: $e');
    print(stack);
  }
}
