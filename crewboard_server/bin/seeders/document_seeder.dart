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

class DocGenerator {
  final Random random;

  DocGenerator(this.random);

  String generateDeltaJson(String docTitle) {
    final List<Map<String, dynamic>> ops = [];

    // Title (H1)
    ops.add({"insert": docTitle});
    ops.add({
      "insert": "\n",
      "attributes": {"header": 1}
    });

    // Executive Summary / Introduction
    ops.add({"insert": "\nExecutive Summary\n", "attributes": {"header": 2}});
    ops.add({
      "insert": "This document outlines the detailed specifications for $docTitle. "
          "It serves as the primary reference for the development, design, and QA teams. "
          "Please review the sections below carefully.\n"
    });
    
    // Detailed Sections
    if (docTitle.contains("Requirements") || docTitle.contains("Meeting")) {
      _addDetailedRequirements(ops);
    } else if (docTitle.contains("Architecture") || docTitle.contains("Infrastructure") || docTitle.contains("Database")) {
      _addTechnicalDeepDive(ops);
    } else if (docTitle.contains("API") || docTitle.contains("Frontend") || docTitle.contains("Security")) {
      _addSpecificationDetails(ops);
    } else {
      _addGeneralDocumentation(ops);
    }

    // Standard Appendices
    _addAppendices(ops);

    return jsonEncode({"ops": ops});
  }

  void _addDetailedRequirements(List<Map<String, dynamic>> ops) {
    // Section 1: Scope
    ops.add({"insert": "\n1. Project Scope\n", "attributes": {"header": 2}});
    ops.add({"insert": "1.1 In-Scope Items\n", "attributes": {"header": 3}});
    ops.add({"insert": "• Core feature implementation including authentication and user management.\n"});
    ops.add({"insert": "• Integration with third-party payment gateways.\n"});
    ops.add({"insert": "• Real-time notification system via WebSockets.\n"});

    ops.add({"insert": "\n1.2 Out-of-Scope Items\n", "attributes": {"header": 3}});
    ops.add({"insert": "• Legacy data migration (handled in a separate phase).\n"});
    ops.add({"insert": "• Mobile application development (Phase 2).\n"});

    // Section 2: User Stories
    ops.add({"insert": "\n2. User Stories\n", "attributes": {"header": 2}});
    ops.add({"insert": "As a ", "attributes": {"bold": true}});
    ops.add({"insert": "System Admin", "attributes": {"italic": true, "bold": true}});
    ops.add({"insert": ", I want to ", "attributes": {"bold": true}});
    ops.add({"insert": "manage user roles ", "attributes": {"underline": true}});
    ops.add({"insert": "so that I can control access levels.\n\n"});

    ops.add({"insert": "As a ", "attributes": {"bold": true}});
    ops.add({"insert": "End User", "attributes": {"italic": true, "bold": true}});
    ops.add({"insert": ", I want to ", "attributes": {"bold": true}});
    ops.add({"insert": "reset my password ", "attributes": {"underline": true}});
    ops.add({"insert": "so that I can regain access to my account.\n"});
  }

  void _addTechnicalDeepDive(List<Map<String, dynamic>> ops) {
    // Architecture Diagram description
    ops.add({"insert": "\nArchitecture Overview\n", "attributes": {"header": 2}});
    ops.add({"insert": "The system utilizes a Hexagonal Architecture pattern to isolate core business logic from external concerns.\n"});
    
    ops.add({"insert": "\nCore Components\n", "attributes": {"header": 3}});
    ops.add({"insert": "1. "});
    ops.add({"insert": "API Gateway", "attributes": {"bold": true}});
    ops.add({"insert": ": Handles routing, rate limiting, and authentication.\n"});
    ops.add({"insert": "2. "});
    ops.add({"insert": "Service Mesh", "attributes": {"bold": true}});
    ops.add({"insert": ": Manages inter-service communication.\n"});
    ops.add({"insert": "3. "});
    ops.add({"insert": "Data Layer", "attributes": {"bold": true}});
    ops.add({"insert": ": PostgreSQL for relational data, Redis for caching.\n"});

    // Code Example
    ops.add({"insert": "\nConfiguration Snippet\n", "attributes": {"header": 3}});
    ops.add({
      "insert": "server:\n  port: 8080\n  host: 0.0.0.0\ndatabase:\n  user: admin\n  password: secret\n",
      "attributes": {"code-block": true}
    });
    
    // Performance Considerations
    ops.add({"insert": "\nPerformance Considerations\n", "attributes": {"header": 2}});
    ops.add({"insert": "All endpoints must respond within 200ms at 95th percentile. Database queries should be optimized using appropriate indexing strategies.\n"});
  }

  void _addSpecificationDetails(List<Map<String, dynamic>> ops) {
    // API Spec
    ops.add({"insert": "\nEndpoint Specifications\n", "attributes": {"header": 2}});
    
    ops.add({"insert": "\nGET /api/v1/resources\n", "attributes": {"header": 3}});
    ops.add({"insert": "Retrieves a paginated list of resources.\n"});
    ops.add({"insert": "Parameters:\n", "attributes": {"bold": true}});
    ops.add({"insert": "• page (int): Page number\n• limit (int): Items per page\n"});
    
    ops.add({"insert": "\nResponse Format:\n", "attributes": {"italic": true}});
    ops.add({
      "insert": "{\n  \"data\": [],\n  \"meta\": {\n    \"total\": 100\n  }\n}\n",
      "attributes": {"code-block": true}
    });

    // Security
    ops.add({"insert": "\nSecurity Protocols\n", "attributes": {"header": 2}});
    ops.add({"insert": "All data in transit is encrypted via TLS 1.3. At rest, sensitive fields are hashed using Argon2id.\n"});
  }

  void _addGeneralDocumentation(List<Map<String, dynamic>> ops) {
    ops.add({"insert": "\nBest Practices\n", "attributes": {"header": 2}});
    ops.add({"insert": "Maintenance\n", "attributes": {"header": 3}});
    ops.add({"insert": "Regular updates should be applied during the scheduled maintenance window (Sundays 02:00 UTC).\n"});
    
    ops.add({"insert": "\nTroubleshooting\n", "attributes": {"header": 2}});
    ops.add({"insert": "Common Issues\n", "attributes": {"header": 3}});
    ops.add({"insert": "• Connection Timeouts: Check firewall settings.\n"});
    ops.add({"insert": "• Auth Failures: Verify token expiration.\n"});
  }

  void _addAppendices(List<Map<String, dynamic>> ops) {
    ops.add({"insert": "\nAppendix A: Glossary\n", "attributes": {"header": 2}});
    ops.add({"insert": "• SaaS: Software as a Service\n"});
    ops.add({"insert": "• API: Application Programming Interface\n"});
    ops.add({"insert": "• CI/CD: Continuous Integration / Continuous Deployment\n"});

    ops.add({"insert": "\nAppendix B: Revision History\n", "attributes": {"header": 2}});
    ops.add({"insert": "v1.0 - Initial Draft - " + DateTime.now().subtract(Duration(days: 10)).toString().split(' ')[0] + "\n"});
    ops.add({"insert": "v1.1 - Added Security Section - " + DateTime.now().subtract(Duration(days: 2)).toString().split(' ')[0] + "\n"});
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

  // Note: Skipping pod.start() to avoid port conflicts if server is running
  // try { await pod.start(); } catch (e) { ... }

  try {
    print('Creating session...');
    final session = await pod.createSession();
    print('Session created successfully.');
    
    final random = Random(42); // Seeded for consistency
    final generator = DocGenerator(random);

    print('\n--- Document Seeder (Refined) ---');

    // 1. Fetch Projects (PlannerApps)
    final apps = await PlannerApp.db.find(session);
    if (apps.isEmpty) {
      print('No projects (PlannerApps) found. Run ticket_seeder first or create a project.');
      await session.close();
      await pod.shutdown();
      return;
    }
    print('Found ${apps.length} projects.');

    final docNames = [
      'Project Requirements Specification',
      'System Architecture & Infrastructure',
      'API Reference & Integration Guide',
      'Frontend Component Library',
      'Security & Compliance Policy',
      'Database Schema & Migrations',
      'Release Notes & Changelog',
      'User Manual & onboarding',
      'Testing Strategy & QA Protocols',
      'Internal Meeting Minutes'
    ];

    for (var app in apps) {
      // REQUIREMENT: Exactly 4 documents per project
      final numDocs = 4;
      print('Seeding $numDocs detailed documents for project: ${app.appName}...');

      // Shuffle names to get random but unique ones per app
      final shuffledNames = List.from(docNames)..shuffle(random);

      for (int i = 0; i < numDocs && i < shuffledNames.length; i++) {
        final name = shuffledNames[i];
        
        // Check if doc exists to avoid duplicates if re-running without clean
        final existing = await Doc.db.findFirstRow(
          session, 
          where: (t) => t.appId.equals(app.id!) & t.name.equals(name)
        );

        if (existing != null) {
          print('  Skipping existing document: $name');
          // Optionally update content:
          // existing.doc = generator.generateDeltaJson(name);
          // await Doc.db.updateRow(session, existing);
          continue;
        }

        final doc = Doc(
          appId: app.id!,
          name: name,
          doc: generator.generateDeltaJson(name),
          lastUpdated: DateTime.now(),
        );

        await Doc.db.insertRow(session, doc);
        print('  Created detailed document: $name');
      }
    }

    print('\nSuccessfully seeded refined documents.');
    await session.close();
  } catch (e) {
    print('Error seeding documents: $e');
  } finally {
    await pod.shutdown();
  }
}
