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

  // Skip starting listeners to avoid port conflicts with the main server

  try {
    final session = await pod.createSession();
    final random = Random();

    // Track statistics per user to guarantee the 80% on-time ratio
    final userStats = <UuidValue, _UserDoneStats>{};

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
      'Bug': '#EF4444', // Red
      'Feature': '#10B981', // Green
      'Task': '#3B82F6', // Blue
    };
    final ticketTypes = <String, TicketType>{};

    for (var entry in typeData.entries) {
      final name = entry.key;
      final colorHex = entry.value;

      var color = await SystemColor.db.findFirstRow(
        session,
        where: (t) => t.color.equals(colorHex),
      );
      color ??= await SystemColor.db.insertRow(
        session,
        SystemColor(colorName: name, color: colorHex, isDefault: false),
      );

      var type = await TicketType.db.findFirstRow(
        session,
        where: (t) => t.typeName.equals(name),
      );
      type ??= await TicketType.db.insertRow(
        session,
        TicketType(typeName: name, colorId: color.id!),
      );
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

      // Ensure Buckets for ALL Users in this App
      final userBuckets = <UuidValue, Map<String, Bucket>>{};
      for (var user in users) {
        userBuckets[user.id!] = {};
        for (var name in statuses.keys) {
          var bucket = await Bucket.db.findFirstRow(
            session,
            where: (t) => t.bucketName.equals(name) & t.appId.equals(app.id!) & t.userId.equals(user.id!),
          );
          if (bucket == null) {
            print('  Creating Bucket: $name for user: ${user.userName}');
            bucket = await Bucket.db.insertRow(
              session,
              Bucket(
                userId: user.id!,
                appId: app.id!,
                bucketName: name,
                isDefault: name == 'To Do',
              ),
            );
          }
          userBuckets[user.id!]![name] = bucket;
        }

        // Initialize user stats by checking existing Done tickets in DB
        final doneStatus = allStatuses.firstWhere((s) => s.completed, orElse: () => allStatuses.last);
        final userDoneTickets = await BucketTicketMap.db.find(
          session,
          where: (t) => t.bucketId.equals(userBuckets[user.id!]![doneStatus.statusName]!.id!),
          include: BucketTicketMap.include(ticket: Ticket.include()),
        );
        
        int userOnTime = 0;
        for (var map in userDoneTickets) {
          final ticket = map.ticket;
          if (ticket == null || ticket.deadline == null) continue;
          final lastChange = await TicketStatusChange.db.findFirstRow(
            session,
            where: (t) => t.ticketId.equals(ticket.id!) & t.newStatusId.equals(doneStatus.id!),
            orderBy: (t) => t.changedAt,
            orderDescending: true,
          );
          if (lastChange != null && lastChange.changedAt != null && lastChange.changedAt!.isBefore(ticket.deadline!)) {
            userOnTime++;
          }
        }
        userStats[user.id!] = _UserDoneStats(done: userDoneTickets.length, onTime: userOnTime);
      }

      // Seed Tickets - Randomly 2 or 3 per status
      print(
        '  Seeding tickets (randomly 2 or 3 per status) for ${app.appName}...',
      );
      final verbs = [
        'Fix', 'Implement', 'Design', 'Refactor', 'Debug', 'Test', 'Deploy', 'Review',
      ];
      final nouns = [
        'Login', 'Dashboard', 'Sidebar', 'API', 'Database', 'Cache', 'Footer', 'Header',
      ];

      for (var statusName in statuses.keys) {
        final status = statuses[statusName]!;

        // Identify which users need a ticket in this status to ensure no empty buckets
        final usersNeedsTicket = <User>[];
        for (var user in users) {
          final bucket = userBuckets[user.id!]![statusName]!;
          final count = await BucketTicketMap.db.count(
            session,
            where: (t) => t.bucketId.equals(bucket.id!),
          );
          if (count == 0) {
            usersNeedsTicket.add(user);
          }
        }

        if (usersNeedsTicket.isEmpty) {
          print('  Status "$statusName": All users already have tickets. Adding 1-2 random ones for density.');
        } else {
          print('  Status "$statusName": ${usersNeedsTicket.length} users have empty buckets. Filling gaps...');
        }

        // We will create tickets until everyone who needs one is covered,
        // or at least a minimum number of tickets are created for this status.
        // For 'Done' status, we increase density to ensure statistical convergence (ratio 80%).
        final isDoneStatus = status.completed;
        final baseDensity = isDoneStatus ? (usersNeedsTicket.length / 1).ceil() : (usersNeedsTicket.length / 3).ceil();
        final minTickets = usersNeedsTicket.isEmpty ? (isDoneStatus ? 4 : 1 + random.nextInt(2)) : (isDoneStatus ? 4 : 0);
        final ticketsToCreate = max(minTickets, baseDensity);

        final remainingToCover = List<User>.from(usersNeedsTicket)..shuffle(random);

        for (var i = 0; i < ticketsToCreate; i++) {
          // Selector creator (random user from the project)
          final creator = users[random.nextInt(users.length)];

          final typeName = typeData.keys.elementAt(
            random.nextInt(typeData.length),
          );
          final type = ticketTypes[typeName]!;

          final priorityName = priorities.keys.elementAt(
            random.nextInt(priorities.length),
          );
          final priority = priorities[priorityName]!;

          final ticketName =
              '$typeName: ${verbs[random.nextInt(verbs.length)]} the ${nouns[random.nextInt(nouns.length)]}';

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
          final ticketBody = List.generate(
            ticketBodyLength,
            (_) => sentences[random.nextInt(sentences.length)],
          ).join(' ');

          // --- TIMELINE GENERATION (For Gantt Chart) ---
          // createdAt: 15-40 days ago
          final createdAt = DateTime.now().subtract(
            Duration(days: 15 + random.nextInt(25)),
          );
          
          // deadline: 40-70 days AFTER createdAt (Mostly in the future)
          final durationDays = 40 + random.nextInt(30);
          final deadline = createdAt.add(Duration(days: durationDays));

          final ticket = await Ticket.db.insertRow(
            session,
            Ticket(
              userId: creator.id!,
              appId: app.id!,
              ticketName: ticketName,
              ticketBody: ticketBody,
              statusId: status.id!,
              priorityId: priority.id!,
              typeId: type.id!,
              flows: '',
              creds: 0,
              createdAt: createdAt,
              deadline: deadline,
            ),
          );

          // Assignees: 
          // 1. Take up to 3 users who still need a ticket in this bucket
          final assignees = <User>[];
          if (remainingToCover.isNotEmpty) {
            final count = min(3, remainingToCover.length);
            for (int k = 0; k < count; k++) {
              assignees.add(remainingToCover.removeLast());
            }
          }
          
          // 2. Add some random users who already have tickets for extra overlap (if batch is small)
          if (assignees.length < 3 && users.length > assignees.length) {
            final shuffledAll = List<User>.from(users)..shuffle(random);
            for (var u in shuffledAll) {
              if (assignees.length >= 3) break;
              if (!assignees.any((a) => a.id == u.id)) {
                assignees.add(u);
              }
            }
          }

          for (final assignee in assignees) {
            final assigneeBucket = userBuckets[assignee.id!]![statusName]!;
            
            // Duplicate check: ensure we don't assign the same user to the same ticket twice
            final existingMap = await BucketTicketMap.db.findFirstRow(
              session,
              where: (t) => t.bucketId.equals(assigneeBucket.id!) & t.ticketId.equals(ticket.id!),
            );

            if (existingMap == null) {
              // Find max order in this bucket to place it at the end
              final currentMaps = await BucketTicketMap.db.find(
                session,
                where: (t) => t.bucketId.equals(assigneeBucket.id!),
              );
              int nextOrder = 1;
              if (currentMaps.isNotEmpty) {
                nextOrder = currentMaps.map((m) => m.order).reduce(max) + 1;
              }

              await BucketTicketMap.db.insertRow(
                session,
                BucketTicketMap(
                  bucketId: assigneeBucket.id!,
                  ticketId: ticket.id!,
                  order: nextOrder,
                ),
              );
            }
          }

          // --- SEED STATUS HISTORY & ACTIVITIES ---
          
          // 1. Initial Creation
          await TicketStatusChange.db.insertRow(
            session,
            TicketStatusChange(
              ticketId: ticket.id!,
              userId: creator.id!,
              oldStatusId: null,
              newStatusId: status.id!,
              changedAt: createdAt,
            ),
          );

          await PlannerActivity.db.insertRow(
            session,
            PlannerActivity(
              ticketId: ticket.id!,
              ticketName: ticket.ticketName,
              userName: creator.userName,
              userColor: (await SystemColor.db.findById(session, creator.colorId))?.color ?? '#000000',
              action: 'created ticket',
              details: 'Initial status: ${status.statusName}',
              createdAt: createdAt,
            ),
          );

          // 2. If Working or Completed, add transitions lifecycle
          if (status.working || status.completed) {
            // Find a status that is 'Working' to use as the intermediate step
            final workingStatus = allStatuses.firstWhere(
              (s) => s.working,
              orElse: () => status,
            );

            // Find a status that is 'Initial' (neither working nor completed)
            final initialStatus = allStatuses.firstWhere(
              (s) => !s.working && !s.completed,
              orElse: () => allStatuses.first,
            );

            // Transition: Created -> Working (occurs 1-2 days after creation)
            final workStartedAt = createdAt.add(Duration(days: 1 + random.nextInt(2)));
            
            if (workStartedAt.isBefore(DateTime.now())) {
              await TicketStatusChange.db.insertRow(
                session,
                TicketStatusChange(
                  ticketId: ticket.id!,
                  userId: creator.id!,
                  oldStatusId: initialStatus.id!,
                  newStatusId: workingStatus.id!,
                  changedAt: workStartedAt,
                ),
              );

              await PlannerActivity.db.insertRow(
                session,
                PlannerActivity(
                  ticketId: ticket.id!,
                  ticketName: ticket.ticketName,
                  userName: creator.userName,
                  userColor: (await SystemColor.db.findById(session, creator.colorId))?.color ?? '#000000',
                  action: 'changed status',
                  details: 'from ${initialStatus.statusName} to ${workingStatus.statusName}',
                  createdAt: workStartedAt,
                ),
              );

              // Transition: Working -> Completed
              if (status.completed) {
                // Determine if it should be "on time" based on avg of assignees
                double totalDone = 0;
                double totalOnTime = 0;
                for (var assignee in assignees) {
                  final stats = userStats[assignee.id!]!;
                  totalDone += stats.done;
                  totalOnTime += stats.onTime;
                }

                bool isOnTime;
                if (totalDone == 0) {
                  isOnTime = random.nextDouble() < 0.8;
                } else {
                  final currentRatio = totalOnTime / totalDone;
                  if (currentRatio < 0.8) {
                    isOnTime = true;
                  } else if (currentRatio > 0.85) {
                    isOnTime = false;
                  } else {
                    isOnTime = random.nextDouble() < 0.8;
                  }
                }
                
                DateTime completedAt;
                if (isOnTime) {
                  // Must be between workStartedAt and deadline
                  final diff = deadline.difference(workStartedAt).inDays;
                  final maxDays = max(1, diff);
                  completedAt = workStartedAt.add(Duration(days: random.nextInt(maxDays)));
                } else {
                  // After deadline
                  completedAt = deadline.add(Duration(days: 1 + random.nextInt(5)));
                }

                // IMPORTANT: Ensure Done tickets are actually in the past
                if (completedAt.isAfter(DateTime.now())) {
                  completedAt = DateTime.now().subtract(Duration(minutes: 5 + random.nextInt(60)));
                }

                if (completedAt.isBefore(DateTime.now())) {
                  // Update stats for all assignees
                  for (var assignee in assignees) {
                    final stats = userStats[assignee.id!]!;
                    stats.done++;
                    if (isOnTime) stats.onTime++;
                  }

                  await TicketStatusChange.db.insertRow(
                    session,
                    TicketStatusChange(
                      ticketId: ticket.id!,
                      userId: creator.id!,
                      oldStatusId: workingStatus.id!,
                      newStatusId: status.id!,
                      changedAt: completedAt,
                    ),
                  );

                  await PlannerActivity.db.insertRow(
                    session,
                    PlannerActivity(
                      ticketId: ticket.id!,
                      ticketName: ticket.ticketName,
                      userName: creator.userName,
                      userColor: (await SystemColor.db.findById(session, creator.colorId))?.color ?? '#000000',
                      action: 'changed status',
                      details: 'from ${workingStatus.statusName} to ${status.statusName}',
                      createdAt: completedAt,
                    ),
                  );
                }
              }
            }
          }

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

class _UserDoneStats {
  int done;
  int onTime;
  _UserDoneStats({required this.done, required this.onTime});
}
