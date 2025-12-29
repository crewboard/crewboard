import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class DocsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<bool> createFlow(Session session, FlowModel flow) async {
    await FlowModel.db.insertRow(session, flow);
    return true;
  }

  Future<bool> updateFlow(Session session, FlowModel flow) async {
    await FlowModel.db.updateRow(session, flow);
    return true;
  }

  Future<List<FlowModel>> getFlows(Session session, UuidValue appId) async {
    return await FlowModel.db.find(
      session,
      where: (t) => t.appId.equals(appId),
    );
  }

  Future<FlowModel?> getFlow(Session session, UuidValue flowId) async {
    return await FlowModel.db.findById(session, flowId);
  }

  Future<bool> deleteFlow(Session session, UuidValue flowId) async {
    final flow = await FlowModel.db.findById(session, flowId);
    if (flow != null) {
      await FlowModel.db.deleteRow(session, flow);
      return true;
    }
    return false;
  }

  // Doc endpoints
  Future<List<Doc>> getDocs(Session session, UuidValue appId) async {
    return await Doc.db.find(
      session,
      where: (t) => t.appId.equals(appId),
      orderBy: (t) => t.lastUpdated,
      orderDescending: true,
    );
  }

  Future<bool> addDoc(Session session, UuidValue appId, String name) async {
    final doc = Doc(
      appId: appId,
      name: name,
      doc: null,
      outline: null,
      lastUpdated: DateTime.now(),
    );
    await Doc.db.insertRow(session, doc);
    return true;
  }

  Future<bool> saveDoc(
    Session session,
    UuidValue docId,
    String? docContent,
    String? outline,
  ) async {
    final doc = await Doc.db.findById(session, docId);
    if (doc != null) {
      doc.doc = docContent;
      doc.outline = outline;
      doc.lastUpdated = DateTime.now();
      await Doc.db.updateRow(session, doc);
      return true;
    }
    return false;
  }
}
