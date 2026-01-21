import 'dart:io';
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

  await pod.start();

  try {
    final session = await pod.createSession();
    final random = Random();

    print('\n--- Ticket Seeder ---');

    // 0. Fetch Users
    final users = await User.db.find(session);
    if (users.isEmpty) {
      print('No users found. Run user seeders first.');
      exit(1);
    }
    print('Found ${users.length} users.');

    // 1. Ensure Planner App
    var app = await PlannerApp.db.findFirstRow(
      session,
      where: (t) => t.appName.equals('Planner'),
    );
    
    if (app == null) {
      // Create Default Color for app
      var defaultColor = await SystemColor.db.findFirstRow(
        session,
        where: (t) => t.color.equals('#000000'),
      );
      if (defaultColor == null) {
          defaultColor = await SystemColor.db.insertRow(
              session, 
              SystemColor(colorName: 'Black', color: '#000000', isDefault: true)
          );
      }

      print('Creating Planner App...');
      app = await PlannerApp.db.insertRow(
        session,
        PlannerApp(
          appName: 'Planner',
          colorId: defaultColor.id!,
        ),
      );
    }

    // 2. Ensure Statuses
    final statusNames = ['To Do', 'In Progress', 'Done'];
    final statuses = <String, Status>{};
    
    for (var name in statusNames) {
      var status = await Status.db.findFirstRow(session, where: (t) => t.statusName.equals(name));
      if (status == null) {
        print('Creating Status: $name');
        status = await Status.db.insertRow(session, Status(statusName: name));
      }
      statuses[name] = status;
    }

    // 3. Ensure Priorities
    final priorityNames = ['Low', 'Medium', 'High'];
    final priorities = <String, Priority>{};
    for (var i = 0; i < priorityNames.length; i++) {
        var name = priorityNames[i];
        var p = await Priority.db.findFirstRow(session, where: (t) => t.priorityName.equals(name));
        if (p == null) {
            print('Creating Priority: $name');
            p = await Priority.db.insertRow(
                session, 
                Priority(priorityName: name, priority: i)
            );
        }
        priorities[name] = p;
    }

    // 4. Ensure Ticket Types
    final typeData = {
        'Task': '#3B82F6', // Blue
        'Bug': '#EF4444', // Red
        'Story': '#10B981', // Green
    };
    final ticketTypes = <String, TicketType>{};

    for (var entry in typeData.entries) {
        final name = entry.key;
        final colorHex = entry.value;

        // Ensure Color
        var color = await SystemColor.db.findFirstRow(session, where: (t) => t.color.equals(colorHex));
        if (color == null) {
             print('Creating Color: $name ($colorHex)');
             color = await SystemColor.db.insertRow(session, SystemColor(colorName: name, color: colorHex, isDefault: false));
        }

        var type = await TicketType.db.findFirstRow(session, where: (t) => t.typeName.equals(name));
        if (type == null) {
             print('Creating TicketType: $name');
             type = await TicketType.db.insertRow(session, TicketType(typeName: name, colorId: color.id!));
        }
        ticketTypes[name] = type;
    }

    // 5. Ensure Buckets for the App
    final buckets = <String, Bucket>{};
    for (var name in statusNames) {
        var bucket = await Bucket.db.findFirstRow(
            session, 
            where: (t) => t.bucketName.equals(name) & t.appId.equals(app!.id!)
        );
        if (bucket == null) {
            print('Creating Bucket: $name');
            bucket = await Bucket.db.insertRow(
                session,
                Bucket(
                    userId: users.first.id!, // Buckets need a creator/owner? or just linked to existing user
                    appId: app!.id!,
                    bucketName: name,
                    isDefault: name == 'To Do',
                )
            );
        }
        buckets[name] = bucket;
    }

    // 6. Seed Tickets
    print('Seeding 50 Tickets...');
    
    final verbs = ['Fix', 'Implement', 'Design', 'Refactor', 'Debug', 'Test', 'Deploy', 'Review'];
    final nouns = ['Login', 'Dashboard', 'Sidebar', 'API', 'Database', 'Cache', 'Footer', 'Header'];

    for (var i = 1; i <= 50; i++) {
        final user = users[random.nextInt(users.length)];
        
        final typeName = typeData.keys.elementAt(random.nextInt(typeData.length));
        final type = ticketTypes[typeName]!;

        final priorityName = priorityNames[random.nextInt(priorityNames.length)];
        final priority = priorities[priorityName]!;

        final statusName = statusNames[random.nextInt(statusNames.length)];
        final status = statuses[statusName]!;
        final bucket = buckets[statusName]!;

        final ticketName = '$typeName: ${verbs[random.nextInt(verbs.length)]} the ${nouns[random.nextInt(nouns.length)]}';

        final ticket = await Ticket.db.insertRow(
            session,
            Ticket(
                userId: user.id!,
                appId: app!.id!,
                ticketName: ticketName,
                ticketBody: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                statusId: status.id!,
                priorityId: priority.id!,
                typeId: type.id!,
                flows: '',
                creds: 0,
                createdAt: DateTime.now().subtract(Duration(days: random.nextInt(30))),
                deadline: DateTime.now().add(Duration(days: random.nextInt(30))),
            )
        );

        // Link to Bucket
        await BucketTicketMap.db.insertRow(
            session,
            BucketTicketMap(
                bucketId: bucket.id!,
                ticketId: ticket.id!,
                order: i,
            )
        );
    }
    print('Successfully created 50 tickets.');

    await session.close();
  } catch (e) {
    print('Error seeding tickets: $e');
  } finally {
    await pod.shutdown();
  }
}
