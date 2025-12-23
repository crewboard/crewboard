import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Seeds default planner data (statuses, priorities, ticket types)
class PlannerSeed {
  /// Seed default statuses
  static Future<void> seedStatuses(Session session) async {
    final existingStatuses = await Status.db.find(session);

    if (existingStatuses.isEmpty) {
      final statuses = [
        Status(statusName: 'New'),
        Status(statusName: 'In Progress'),
        Status(statusName: 'Review'),
        Status(statusName: 'Done'),
        Status(statusName: 'Blocked'),
      ];

      for (final status in statuses) {
        await Status.db.insertRow(session, status);
      }

      session.log('Seeded ${statuses.length} default statuses');
    }
  }

  /// Seed default priorities
  static Future<void> seedPriorities(Session session) async {
    final existingPriorities = await Priority.db.find(session);

    if (existingPriorities.isEmpty) {
      final priorities = [
        Priority(priorityName: 'Low', priority: 1),
        Priority(priorityName: 'Medium', priority: 2),
        Priority(priorityName: 'High', priority: 3),
        Priority(priorityName: 'Critical', priority: 4),
      ];

      for (final priority in priorities) {
        await Priority.db.insertRow(session, priority);
      }

      session.log('Seeded ${priorities.length} default priorities');
    }
  }

  /// Seed default ticket types with colors
  static Future<void> seedTicketTypes(Session session) async {
    final existingTypes = await TicketType.db.find(session);

    if (existingTypes.isEmpty) {
      // First, ensure we have colors for ticket types
      final colors = await SystemColor.db.find(session);

      if (colors.length < 4) {
        session.log(
          'Warning: Not enough system colors for ticket types. Need at least 4 colors.',
        );
        return;
      }

      final ticketTypes = [
        TicketType(typeName: 'Bug', colorId: colors[0].id!),
        TicketType(typeName: 'Feature', colorId: colors[1].id!),
        TicketType(typeName: 'Task', colorId: colors[2].id!),
        TicketType(typeName: 'Epic', colorId: colors[3].id!),
      ];

      for (final type in ticketTypes) {
        await TicketType.db.insertRow(session, type);
      }

      session.log('Seeded ${ticketTypes.length} default ticket types');
    }
  }

  /// Seed all planner defaults
  static Future<void> seedAll(Session session) async {
    session.log('Starting planner seed...');

    await seedStatuses(session);
    await seedPriorities(session);
    await seedTicketTypes(session);

    session.log('Planner seed completed');
  }
}
