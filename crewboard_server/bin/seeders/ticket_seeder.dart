// ignore_for_file: avoid_print
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

  try {
    await pod.start();
  } catch (e) {
    print('Warning: Failed to start server listeners: $e');
  }

  try {
    final session = await pod.createSession();
    final random = Random();

    print('\n--- Ticket Seeder (Existing Projects) ---');

    // 1. Fetch all existing PlannerApps
    print('Fetching existing projects...');
    final apps = await PlannerApp.db.find(session);
    
    if (apps.isEmpty) {
      print('No projects found. Please create a project first.');
      exit(1);
    }
    print('Found ${apps.length} project(s).');

    // 2. Fetch Global Data (Statuses/Priorities)
    print('Fetching global statuses and priorities...');
    final allStatuses = await Status.db.find(session);
    final allPriorities = await Priority.db.find(session);
    
    if (allStatuses.isEmpty || allPriorities.isEmpty) {
        print('Error: Missing statuses or priorities. Seed them first.');
        exit(1);
    }
    
    final statuses = {for (var s in allStatuses) s.statusName: s};
    final priorities = {for (var p in allPriorities) p.priorityName: p};

    // 3. Ensure Global Ticket Types
    final typeData = {
        'Task': '#3B82F6', // Blue
        'Bug': '#EF4444', // Red
        'Story': '#10B981', // Green
    };
    final ticketTypes = <String, TicketType>{};

    for (var entry in typeData.entries) {
        final name = entry.key;
        final colorHex = entry.value;

        var color = await SystemColor.db.findFirstRow(session, where: (t) => t.color.equals(colorHex));
        color ??= await SystemColor.db.insertRow(session, SystemColor(colorName: name, color: colorHex, isDefault: false));

        var type = await TicketType.db.findFirstRow(session, where: (t) => t.typeName.equals(name));
        type ??= await TicketType.db.insertRow(session, TicketType(typeName: name, colorId: color.id!));
        ticketTypes[name] = type;
    }

    // 4. Loop through existing projects
    for (var app in apps) {
        print('\nProcessing Project: ${app.appName} (ID: ${app.id})');

        // Fetch users for this app's organization
        final users = await User.db.find(
            session,
            where: (t) => t.organizationId.equals(app.organizationId),
        );
        
        if (users.isEmpty) {
            print('  Skipping: No users found for this project\'s organization.');
            continue;
        }
        print('  Found ${users.length} users.');

        // Ensure Buckets for this App
        final buckets = <String, Bucket>{};
        for (var name in statuses.keys) {
            var bucket = await Bucket.db.findFirstRow(
                session,
                where: (t) => t.bucketName.equals(name) & t.appId.equals(app.id!)
            );
            if (bucket == null) {
                print('  Creating Bucket: $name');
                bucket = await Bucket.db.insertRow(
                    session,
                    Bucket(
                        userId: users.first.id!,
                        appId: app.id!,
                        bucketName: name,
                        isDefault: name == 'To Do',
                    )
                );
            }
            buckets[name] = bucket;
        }

        // Seed Tickets - Randomly 2 or 3 per bucket
        print('  Seeding tickets (randomly 2 or 3 per bucket) for ${app.appName}...');
        final verbs = ['Fix', 'Implement', 'Design', 'Refactor', 'Debug', 'Test', 'Deploy', 'Review'];
        final nouns = ['Login', 'Dashboard', 'Sidebar', 'API', 'Database', 'Cache', 'Footer', 'Header'];

        for (var bucketEntry in buckets.entries) {
            final statusName = bucketEntry.key;
            final bucket = bucketEntry.value;
            final status = statuses[statusName]!;

            // Create 2 or 3 tickets for this bucket
            final ticketCount = 2 + random.nextInt(2);
            for (var i = 0; i < ticketCount; i++) {
                final user = users[random.nextInt(users.length)];
                
                final typeName = typeData.keys.elementAt(random.nextInt(typeData.length));
                final type = ticketTypes[typeName]!;

                final priorityName = priorities.keys.elementAt(random.nextInt(priorities.length));
                final priority = priorities[priorityName]!;

                final ticketName = '$typeName: ${verbs[random.nextInt(verbs.length)]} the ${nouns[random.nextInt(nouns.length)]}';

                final sentences = [
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
                    'Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante.',
                    'Donec eu libero sit amet quam egestas semper.',
                    'Aenean ultricies mi vitae est.',
                    'Mauris placerat eleifend leo.',
                    'Quisque sit amet est et sapien ullamcorper pharetra.',
                    'Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi.',
                ];
                final ticketBodyLength = 1 + random.nextInt(5);
                final ticketBody = List.generate(ticketBodyLength, (_) => sentences[random.nextInt(sentences.length)]).join(' ');

                final ticket = await Ticket.db.insertRow(
                    session,
                    Ticket(
                        userId: user.id!,
                        appId: app.id!,
                        ticketName: ticketName,
                        ticketBody: ticketBody,
                        statusId: status.id!,
                        priorityId: priority.id!,
                        typeId: type.id!,
                        flows: '',
                        creds: 0,
                        createdAt: DateTime.now().subtract(Duration(days: random.nextInt(30))),
                        deadline: DateTime.now().add(Duration(days: random.nextInt(30))),
                    )
                );

                await BucketTicketMap.db.insertRow(
                    session,
                    BucketTicketMap(
                        bucketId: bucket.id!,
                        ticketId: ticket.id!,
                        order: i + 1,
                    )
                );

                // Add random image attachment (50% chance)
                if (random.nextBool()) {
                    final imageId = random.nextInt(1000);
                    final imageUrl = 'https://picsum.photos/id/$imageId/800/600';
                    
                    await TicketAttachment.db.insertRow(
                        session,
                        TicketAttachment(
                            ticketId: ticket.id!,
                            attachmentName: 'Random Image $imageId.jpg',
                            attachmentSize: (500 + random.nextInt(1500)).toDouble() * 1024,
                            attachmentUrl: imageUrl,
                            attachmentType: 'jpg',
                        ),
                    );
                    print('    Added image attachment to ticket: $ticketName');
                }
            }
        }
        print('  Successfully seeded tickets for ${app.appName}.');
    }

    print('\nSeeding Complete!');
    await session.close();
  } catch (e, stack) {
    print('Error during seeding: $e');
    print(stack);
  } finally {
    await pod.shutdown();
  }
}
