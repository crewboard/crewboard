import 'package:crewboard_server/src/generated/endpoints.dart';
import 'package:crewboard_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

void main(List<String> args) async {
  final pod = Serverpod(args, Protocol(), Endpoints());
  try {
    final session = await pod.createSession();
    final doneStatus = await Status.db.findFirstRow(session, where: (s) => s.completed.equals(true));
    if (doneStatus == null) return;
    
    final tickets = await Ticket.db.find(
      session,
      where: (t) => t.statusId.equals(doneStatus.id!),
      limit: 20,
    );
    
    int onTime = 0;
    int overdue = 0;
    
    for (var t in tickets) {
      final changes = await TicketStatusChange.db.find(
        session,
        where: (c) => c.ticketId.equals(t.id!) & c.newStatusId.equals(doneStatus.id!),
        orderBy: (c) => c.changedAt,
        orderDescending: true,
      );
      if (changes.isEmpty) continue;
      final completedAt = changes.first.changedAt!;
      final deadline = t.deadline!;
      
      final isOverdue = !completedAt.isBefore(deadline);
      if (isOverdue) overdue++; else onTime++;
      
      print('Ticket: ${t.ticketName}');
      print('  Deadline: $deadline');
      print('  CompletedAt: $completedAt');
      print('  Status: ${isOverdue ? "OVERDUE" : "ON TIME"}');
    }
    print('\nTotal: ${onTime + overdue}, On Time: $onTime, Overdue: $overdue');
    await session.close();
  } finally {
    await pod.shutdown();
  }
}
