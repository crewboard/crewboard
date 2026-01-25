// ignore_for_file: avoid_print
import 'dart:io';
import 'dart:math';

import 'package:crewboard_server/src/generated/endpoints.dart';
import 'package:crewboard_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

// Copy of configuration from lib/server.dart
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
  // Initialize Serverpod
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  // Initialize Auth Services
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

  // Start Serverpod (connects to DB)
  print('Starting Serverpod...');
  try {
    await pod.start();
    print('Serverpod started.');
  } catch (e, stack) {
    print('Failed to start Serverpod: $e');
    print(stack);
    exit(1);
  }

  try {
    final session = await pod.createSession();
    final random = Random();

    print('\n--- Message Seeder ---');

    // 1. Fetch Users
    final users = await User.db.find(session);
    if (users.isEmpty) {
      print('No users found. Run user_seeder or batch_user_seeder first.');
      exit(1);
    }
    print('Found ${users.length} users.');

    // 2. Create Rooms with 2 Users Each
    print('Creating rooms with 2 users each...');
    final roomsWithUsers = <ChatRoom, List<User>>{};

    // Shuffle users to create random pairs
    final shuffledUsers = List<User>.from(users)..shuffle(random);

    // Create pairs of users (if odd number, last user will be in a room with first user)
    for (int i = 0; i < shuffledUsers.length; i += 2) {
      final user1 = shuffledUsers[i];
      final user2 =
          shuffledUsers[(i + 1) %
              shuffledUsers.length]; // Wrap around if odd number

      // Create room name based on both users
      final roomName = '${user1.userName} & ${user2.userName}';

      // Look for existing room
      var room = await ChatRoom.db.findFirstRow(
        session,
        where: (t) => t.roomName.equals(roomName) & t.roomType.equals('direct'),
      );

      if (room == null) {
        print('Creating room: $roomName');
        room = await ChatRoom.db.insertRow(
          session,
          ChatRoom(
            roomName: roomName,
            roomType: 'direct',
            messageCount: 0,
          ),
        );

        // Map both users to the room
        await UserRoomMap.db.insertRow(
          session,
          UserRoomMap(roomId: room.id!, userId: user1.id!, unreadCount: 0),
        );
        await UserRoomMap.db.insertRow(
          session,
          UserRoomMap(roomId: room.id!, userId: user2.id!, unreadCount: 0),
        );
      }

      roomsWithUsers[room] = [user1, user2];
    }

    // 3. Prepare Files
    final seedfilesDir = Directory('bin/seeders/files');
    final uploadsDir = Directory('web/public/uploads');

    if (!uploadsDir.existsSync()) {
      uploadsDir.createSync(recursive: true);
    }

    Map<String, List<File>> fileCache = {
      'images': [],
      'videos': [],
      'audios': [],
      'docs': [],
    };

    if (seedfilesDir.existsSync()) {
      for (var type in fileCache.keys) {
        final dir = Directory('${seedfilesDir.path}/$type');
        if (dir.existsSync()) {
          fileCache[type] = dir.listSync().whereType<File>().toList();

          // Ensure target directory exists
          final targetSubDir = Directory('${uploadsDir.path}/$type');
          if (!targetSubDir.existsSync()) {
            targetSubDir.createSync(recursive: true);
          }
        }
      }
    } else {
      print(
        'Warning: bin/seeders/files directory not found. File messages will be skipped.',
      );
    }

    // Canned Text Messages - Expanded for huge conversations
    final cannedMessages = [
      "Hello everyone! Excited to be here.",
      "Has anyone seen the new design specs?",
      "I'll be taking a look at the bug report shortly.",
      "Great job on the presentation yesterday!",
      "Can someone help me with this error?",
      "Lunch sounds good, user_X?",
      "Setting up the new environment now.",
      "Deploying to staging in 5 minutes.",
      "Who is on call this weekend?",
      "Just pushed a fix for the login issue.",
      "Remember to update your dependencies.",
      "The client loved the demo!",
      "Does this look right to you?",
      "I'm heading out for the day, see you all tomorrow.",
      "Good morning team!",
      "Is there a meeting today?",
      "Reviewing pull requests now.",
      "Coffee break?",
      "Documentation has been updated.",
      "Please check your emails for the latest update.",
      "Working on the new feature implementation.",
      "The database migration completed successfully.",
      "Can we schedule a quick sync meeting?",
      "I found an interesting article about our tech stack.",
      "The performance improvements are looking great!",
      "Don't forget about the deadline next week.",
      "I'll be working from home tomorrow.",
      "The test suite is passing now.",
      "Let me know if you need any help with that.",
      "The client feedback was very positive.",
      "I'm investigating the reported issue.",
      "The new UI mockups look fantastic.",
      "We should consider refactoring this module.",
      "The deployment went smoothly.",
      "I'll update the documentation later today.",
      "Great catch on that bug!",
      "The code review comments have been addressed.",
      "I'm running some performance tests.",
      "The integration is working as expected.",
      "We might need to optimize this query.",
      "The user feedback has been incorporated.",
      "I'm setting up the development environment.",
      "The API endpoints are ready for testing.",
      "We should discuss the architecture changes.",
      "The security audit results look good.",
      "I'm working on the mobile responsiveness.",
      "The backup process completed successfully.",
      "We need to update the third-party libraries.",
      "The monitoring dashboard is now live.",
      "I'm preparing the release notes.",
      "The load testing results are impressive.",
    ];

    print('Seeding huge conversations in rooms with 2 users each...');

    int totalMessagesAdded = 0;

    // 4. Iterate All Rooms and Create Messages from Both Users
    for (final entry in roomsWithUsers.entries) {
      final room = entry.key;
      final roomUsers = entry.value;
      final user1 = roomUsers[0];
      final user2 = roomUsers[1];

      print('Seeding messages for room: ${room.roomName}');

      // Create a huge conversation (50-100 messages per room)
      int messageCount = 50 + random.nextInt(51); // 50 to 100 messages

      // Track conversation state for realistic flow
      User currentSender = random.nextBool() ? user1 : user2;
      // 1 to 3 messages per burst
      int burstRemaining = random.nextInt(3) + 1;
      int user1MessageCount = 0;
      int user2MessageCount = 0;

      // Start conversation 30 days ago
      var conversationTime = DateTime.now().subtract(Duration(days: 30));

      for (var i = 0; i < messageCount; i++) {
        // Increment time by 2-60 minutes for each message to keep order
        conversationTime = conversationTime.add(
          Duration(minutes: 2 + random.nextInt(58)),
        );

        // Use the sequential time
        final createdAt = conversationTime;

        // Switch user if burst is finished
        if (burstRemaining <= 0) {
          currentSender = currentSender == user1 ? user2 : user1;
          burstRemaining =
              random.nextInt(3) + 1; // Start new burst of 1-3 messages
        }

        // Decrement burst counter for the message we are about to send
        burstRemaining--;

        final sender = currentSender;

        // Update message counts
        if (sender == user1) {
          user1MessageCount++;
        } else {
          user2MessageCount++;
        }

        // Mix of different message types
        if (i % 10 == 0 && fileCache['images']!.isNotEmpty) {
          // Image message every 10th message
          await _sendFileMessage(
            session,
            room,
            sender,
            fileCache['images']!,
            'images',
            MessageType.image,
            createdAt,
            random,
          );
        } else if (i % 15 == 0 && fileCache['videos']!.isNotEmpty) {
          // Video message every 15th message
          await _sendFileMessage(
            session,
            room,
            sender,
            fileCache['videos']!,
            'videos',
            MessageType.video,
            createdAt,
            random,
          );
        } else if (i % 20 == 0 && fileCache['audios']!.isNotEmpty) {
          // Audio message every 20th message
          await _sendFileMessage(
            session,
            room,
            sender,
            fileCache['audios']!,
            'audios',
            MessageType.audio,
            createdAt,
            random,
          );
        } else if (i % 25 == 0 && fileCache['docs']!.isNotEmpty) {
          // Document message every 25th message
          await _sendFileMessage(
            session,
            room,
            sender,
            fileCache['docs']!,
            'docs',
            MessageType.file,
            createdAt,
            random,
          );
        } else {
          // Text message
          final text = cannedMessages[random.nextInt(cannedMessages.length)];

          final msg = await ChatMessage.db.insertRow(
            session,
            ChatMessage(
              roomId: room.id!,
              userId: sender.id!,
              message: text,
              messageType: MessageType.text,
              seenUserList: [],
              sameUser: false,
              deleted: false,
              createdAt: createdAt,
            ),
          );
          room.lastMessageId = msg.id;
        }

        totalMessagesAdded++;
      }

      // Update room stats
      room.messageCount = messageCount;
      await ChatRoom.db.updateRow(session, room);

      print(' - Added $messageCount messages to room: ${room.roomName}');
      print(
        '   └─ ${user1.userName}: $user1MessageCount messages, ${user2.userName}: $user2MessageCount messages',
      );
    }

    print(' - Total messages added across all rooms: $totalMessagesAdded');
    print(
      '\nMessage seeding completed. Each room now has exactly 2 users with huge conversations.',
    );

    await session.close();
  } catch (e) {
    print('\nError during message seeding: $e');
  } finally {
    await pod.shutdown();
  }
}

// Helper function to send file messages
Future<void> _sendFileMessage(
  Session session,
  ChatRoom room,
  User user,
  List<File> files,
  String type,
  MessageType msgType,
  DateTime createdAt,
  Random random,
) async {
  if (files.isEmpty) return;

  final file = files[random.nextInt(files.length)];
  final fileName = file.uri.pathSegments.last;
  final uploadsDir = Directory('web/public/uploads');
  final targetSubDir = Directory('${uploadsDir.path}/$type');
  final targetFile = File('${targetSubDir.path}/$fileName');

  // Copy file if it doesn't exist
  if (!targetFile.existsSync()) {
    file.copySync(targetFile.path);
  }

  final url = 'http://localhost:8082/uploads/$type/$fileName';

  final msg = await ChatMessage.db.insertRow(
    session,
    ChatMessage(
      roomId: room.id!,
      userId: user.id!,
      message: url,
      messageType: msgType,
      seenUserList: [],
      sameUser: false,
      deleted: false,
      createdAt: createdAt,
    ),
  );
  room.lastMessageId = msg.id;
}
