import 'package:crewboard_server/src/generated/endpoints.dart';
import 'package:crewboard_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

void main(List<String> args) async {
  final pod = Serverpod(args, Protocol(), Endpoints());
  try {
    final session = await pod.createSession();
    final doneStatus = await Status.db.findFirstRow(session, where: (s) => s.completed.equals(true));
    if (doneStatus == null) return;
    
    final users = await User.db.find(session);
    print('--- Per-User On-Time Ratios ---');

    for (var user in users) {
      final userBuckets = await Bucket.db.find(session, where: (b) => b.userId.equals(user.id!) & b.bucketName.equals(doneStatus.statusName));
      if (userBuckets.isEmpty) continue;
      
      final maps = await BucketTicketMap.db.find(
        session,
        where: (t) => t.bucketId.inSet(userBuckets.map((b) => b.id!).toSet()),
        include: BucketTicketMap.include(ticket: Ticket.include()),
      );
      
      int done = 0;
      int onTime = 0;
      
      for (var map in maps) {
        final t = map.ticket;
        if (t == null || t.deadline == null) continue;
        
        final changes = await TicketStatusChange.db.find(
          session,
          where: (c) => c.ticketId.equals(t.id!) & c.newStatusId.equals(doneStatus.id!),
          orderBy: (c) => c.changedAt,
          orderDescending: true,
        );
        if (changes.isEmpty) continue;
        
        done++;
        if (changes.first.changedAt!.isBefore(t.deadline!)) {
          onTime++;
        }
      }
      
      final ratio = done == 0 ? 0 : (onTime / done * 100);
      print('User: ${user.userName.padRight(12)} | Done: ${done.toString().padLeft(3)} | On Time: ${onTime.toString().padLeft(3)} | Ratio: ${ratio.toStringAsFixed(1)}%');
    }
    
    await session.close();
  } finally {
    await pod.shutdown();
  }
}
