import 'dart:convert';
import 'dart:math';

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

enum Direction { down, right, left }
enum FlowType { terminal, process, condition, user }

class FlowGenerator {
  String generateFlowJson(Random random, String scenarioName) {
    final List<dynamic> flowData = [];
    
    switch (scenarioName) {
      case 'User Authentication Flow':
        _buildLoginFlow(flowData);
        break;
      case 'Bug Reporting Workflow':
        _buildBugFlow(flowData);
        break;
      case 'Feature Request Approval':
        _buildFeatureFlow(flowData);
        break;
      case 'Deployment Pipeline':
        _buildDeployFlow(flowData);
        break;
      default:
        _buildGenericFlow(flowData, random);
    }

    // Add loops and pad
    flowData.add({"_loops": []});
    flowData.add({"_loopPad": 40.0});

    return jsonEncode(flowData);
  }

  void _buildLoginFlow(List<dynamic> data) {
    data.add(_createNode(id: 0, value: "Start", type: FlowType.terminal, pid: null, direction: null));
    data.add(_createNode(id: 1, value: "Enter Credentials", type: FlowType.process, pid: 0, direction: Direction.down));
    data.add(_createNode(id: 2, value: "Valid Login?", type: FlowType.condition, pid: 1, direction: Direction.down));
    data.add(_createNode(id: 3, value: "Show Error", type: FlowType.process, pid: 2, direction: Direction.left));
    data.add(_createNode(id: 4, value: "Redirect to Dashboard", type: FlowType.process, pid: 2, direction: Direction.down));
    data.add(_createNode(id: 5, value: "End", type: FlowType.terminal, pid: 4, direction: Direction.down));
  }

  void _buildBugFlow(List<dynamic> data) {
    data.add(_createNode(id: 0, value: "Start", type: FlowType.terminal, pid: null, direction: null));
    data.add(_createNode(id: 1, value: "Submit Bug Report", type: FlowType.process, pid: 0, direction: Direction.down));
    data.add(_createNode(id: 2, value: "Reproducible?", type: FlowType.condition, pid: 1, direction: Direction.down));
    data.add(_createNode(id: 3, value: "Request More Info", type: FlowType.process, pid: 2, direction: Direction.right));
    data.add(_createNode(id: 4, value: "Assign Developer", type: FlowType.process, pid: 2, direction: Direction.down));
    data.add(_createNode(id: 5, value: "Fix Bug", type: FlowType.process, pid: 4, direction: Direction.down));
    data.add(_createNode(id: 6, value: "End", type: FlowType.terminal, pid: 5, direction: Direction.down));
  }

  void _buildFeatureFlow(List<dynamic> data) {
    data.add(_createNode(id: 0, value: "Start", type: FlowType.terminal, pid: null, direction: null));
    data.add(_createNode(id: 1, value: "Submit Feature Idea", type: FlowType.user, pid: 0, direction: Direction.down));
    data.add(_createNode(id: 2, value: "Feasible?", type: FlowType.condition, pid: 1, direction: Direction.down));
    data.add(_createNode(id: 3, value: "Reject & Notify", type: FlowType.process, pid: 2, direction: Direction.left));
    data.add(_createNode(id: 4, value: "Move to Backlog", type: FlowType.process, pid: 2, direction: Direction.down));
    data.add(_createNode(id: 5, value: "Prioritize", type: FlowType.process, pid: 4, direction: Direction.down));
    data.add(_createNode(id: 6, value: "End", type: FlowType.terminal, pid: 5, direction: Direction.down));
  }

  void _buildDeployFlow(List<dynamic> data) {
    data.add(_createNode(id: 0, value: "Commit Code", type: FlowType.terminal, pid: null, direction: null));
    data.add(_createNode(id: 1, value: "Run Tests", type: FlowType.process, pid: 0, direction: Direction.down));
    data.add(_createNode(id: 2, value: "Tests Passed?", type: FlowType.condition, pid: 1, direction: Direction.down));
    data.add(_createNode(id: 3, value: "Fix Issues", type: FlowType.process, pid: 2, direction: Direction.right));
    data.add(_createNode(id: 4, value: "Deploy to Staging", type: FlowType.process, pid: 2, direction: Direction.down));
    data.add(_createNode(id: 5, value: "Deploy to Prod", type: FlowType.process, pid: 4, direction: Direction.down));
    data.add(_createNode(id: 6, value: "Complete", type: FlowType.terminal, pid: 5, direction: Direction.down));
  }

  void _buildGenericFlow(List<dynamic> data, Random random) {
    data.add(_createNode(id: 0, value: "Start", type: FlowType.terminal, pid: null, direction: null));
    int currentPid = 0;
    FlowType lastType = FlowType.terminal;
    for (int i = 1; i < 4; i++) {
      final type = random.nextBool() ? FlowType.process : FlowType.condition;
      final direction = lastType == FlowType.condition ? (random.nextBool() ? Direction.right : Direction.left) : Direction.down;
      data.add(_createNode(id: i, value: "Step $i", type: type, pid: currentPid, direction: direction));
      currentPid = i;
      lastType = type;
    }
    data.add(_createNode(id: 4, value: "End", type: FlowType.terminal, pid: currentPid, direction: Direction.down));
  }

  Map<String, dynamic> _createNode({
    required int id,
    required String value,
    required FlowType type,
    int? pid,
    Direction? direction,
  }) {
    return {
      'id': id,
      'pid': pid,
      'width': 100.0,
      'height': type == FlowType.condition ? 100.0 : 40.0,
      'x': 0.0,
      'y': 0.0,
      'value': value,
      'type': type.index,
      'direction': direction?.index,
      'down': {'lineHeight': 25.0, 'hasChild': false},
      'left': {'lineHeight': 25.0, 'hasChild': false},
      'right': {'lineHeight': 25.0, 'hasChild': false},
      'yes': type == FlowType.condition ? 0 : null,
    };
  }
}

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
    print('Warning: Failed to start server listeners (likely port conflict), attempting to continue with database session: $e');
  }

  try {
    final session = await pod.createSession();
    final random = Random(42); // Seeded for consistency
    final generator = FlowGenerator();

    print('\n--- Flow Chart Seeder ---');

    // 1. Fetch Projects (PlannerApps)
    final apps = await PlannerApp.db.find(session);
    if (apps.isEmpty) {
      print('No projects (PlannerApps) found. Run ticket_seeder first or create a project.');
      await session.close();
      await pod.shutdown();
      return;
    }
    print('Found ${apps.length} projects.');

    final flowNames = [
      'User Authentication Flow',
      'Ticket Lifecycle',
      'Data Sync Process',
      'Deployment Pipeline',
      'Bug Reporting Workflow',
      'Feature Request Approval',
      'Notification Service Flow',
      'Inventory Management',
      'Refund Request Flow'
    ];

    for (var app in apps) {
      final numFlows = random.nextInt(4) + 2; // 2-5 flow charts
      print('Seeding $numFlows flow charts for project: ${app.appName}...');

      // Shuffle names to get random but unique ones per app if possible
      final shuffledNames = List.from(flowNames)..shuffle(random);

      for (int i = 0; i < numFlows && i < shuffledNames.length; i++) {
        final name = shuffledNames[i];
        
        final flowModel = FlowModel(
          appId: app.id!,
          name: name,
          flow: generator.generateFlowJson(random, name),
          lastUpdated: DateTime.now(),
        );

        await FlowModel.db.insertRow(session, flowModel);
        print('  Created flow: $name');
      }
    }

    print('\nSuccessfully seeded flow charts.');
    await session.close();
  } catch (e) {
    print('Error seeding flow charts: $e');
  } finally {
    await pod.shutdown();
  }
}
