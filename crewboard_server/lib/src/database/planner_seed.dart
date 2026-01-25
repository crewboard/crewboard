import 'dart:convert';
import 'dart:math';

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

  /// Seed default flow charts for all available apps
  static Future<void> seedFlowCharts(Session session) async {
    final existingFlowsCount = await FlowModel.db.count(session);
    if (existingFlowsCount > 0) {
      return; // Skip if already seeded
    }

    final apps = await PlannerApp.db.find(session);
    if (apps.isEmpty) {
      session.log('No PlannerApps found to seed flow charts for.');
      return;
    }

    final random = Random(42); // Seeded for consistency
    final flowNames = [
      'User Authentication',
      'Ticket Lifecycle',
      'Data Sync',
      'Deployment Pipeline',
      'Bug Reporting',
      'Feature Approval',
    ];

    for (var app in apps) {
      final numFlows = random.nextInt(4) + 2; // 2-5 flow charts
      // Shuffle names to get random but unique ones per app if possible
      final shuffledNames = List.from(flowNames)..shuffle(random);
      
      for (int i = 0; i < numFlows && i < shuffledNames.length; i++) {
        final name = shuffledNames[i];
        
        final List<dynamic> flowData = _generateMockFlow(random);
        
        final flowModel = FlowModel(
          appId: app.id!,
          name: name,
          flow: jsonEncode(flowData),
          lastUpdated: DateTime.now(),
        );

        await FlowModel.db.insertRow(session, flowModel);
      }
    }
    session.log('Seeded flow charts for ${apps.length} apps');
  }

  static List<dynamic> _generateMockFlow(Random random) {
    final List<dynamic> nodes = [];
    final int nodeCount = random.nextInt(4) + 3; // 3 to 6 nodes
    
    // Node types from types.dart: terminal=0, process=1, condition=2, user=3
    // Directions from types.dart: down=0, right=1, left=2

    // Add Start node
    nodes.add({
      'id': 0,
      'pid': null,
      'width': 100.0,
      'height': 40.0,
      'x': 0.0,
      'y': 0.0,
      'value': 'Start',
      'type': 0, // terminal
      'direction': null,
      'down': {'lineHeight': 40.0, 'hasChild': true},
      'left': {'lineHeight': 40.0, 'hasChild': false},
      'right': {'lineHeight': 40.0, 'hasChild': false},
    });

    int currentPid = 0;
    final processLabels = ['Initialize', 'Fetch Data', 'Process Input', 'Validate', 'Save Changes', 'Send Notification'];
    
    for (int i = 1; i < nodeCount - 1; i++) {
        final isCondition = random.nextBool();
        nodes.add({
            'id': i,
            'pid': currentPid,
            'width': isCondition ? 100.0 : 120.0,
            'height': isCondition ? 100.0 : 40.0,
            'x': 0.0,
            'y': 0.0,
            'value': isCondition ? 'Retry?' : processLabels[random.nextInt(processLabels.length)],
            'type': isCondition ? 2 : 1, // condition or process
            'direction': 0, // down
            'down': {'lineHeight': 40.0, 'hasChild': true},
            'left': {'lineHeight': 40.0, 'hasChild': false},
            'right': {'lineHeight': 40.0, 'hasChild': false},
            'yes': isCondition ? 0 : null,
        });
        currentPid = i;
    }

    // Add End node
    nodes.add({
      'id': nodeCount - 1,
      'pid': currentPid,
      'width': 100.0,
      'height': 40.0,
      'x': 0.0,
      'y': 0.0,
      'value': 'End',
      'type': 0, // terminal
      'direction': 0, // down
      'down': {'lineHeight': 40.0, 'hasChild': false},
      'left': {'lineHeight': 40.0, 'hasChild': false},
      'right': {'lineHeight': 40.0, 'hasChild': false},
    });

    // Add special metadata
    nodes.add({"_loops": []});
    nodes.add({"_loopPad": 40.0});

    return nodes;
  }

  /// Seed all planner defaults
  static Future<void> seedAll(Session session) async {
    session.log('Starting planner seed...');

    await seedStatuses(session);
    await seedPriorities(session);
    await seedTicketTypes(session);
    // await seedFlowCharts(session);

    session.log('Planner seed completed');
  }
}
