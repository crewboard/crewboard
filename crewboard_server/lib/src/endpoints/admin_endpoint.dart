import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class AdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<PlannerApp>> getApps(Session session) async {
    return await PlannerApp.db.find(session);
  }

  Future<PlannerApp> addApp(
    Session session,
    String name,
    int colorId,
  ) async {
    final app = PlannerApp(
      appName: name,
      colorId: colorId,
    );
    return await PlannerApp.db.insertRow(session, app);
  }
}
