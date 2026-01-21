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
  await pod.start();

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

    // 2. Public Chat (General)
    var generalRoom = await ChatRoom.db.findFirstRow(
      session,
      where: (t) => t.roomName.equals('General'),
    );

    if (generalRoom == null) {
       print('Creating General room...');
       generalRoom = await ChatRoom.db.insertRow(
         session,
         ChatRoom(roomName: 'General', roomType: 'public', messageCount: 0),
       );
    }

    print('Seeding Public Chat (General)...');
    final cannedMessages = [
        "Hello everyone!",
        "How is the project going?",
        "Did anyone check the latest designs?",
        "I'm stuck on a bug.",
        "Lunch time?",
        "Great work today!",
        "Can we reschedule the meeting?",
        "Welcome to the team!",
        "Check this out.",
        "Testing...",
    ];

    for (var i = 0; i < 20; i++) {
        final user = users[random.nextInt(users.length)];
        final text = cannedMessages[random.nextInt(cannedMessages.length)];
        final createdAt = DateTime.now().subtract(Duration(minutes: random.nextInt(1000)));

        final msg = await ChatMessage.db.insertRow(
            session,
            ChatMessage(
                roomId: generalRoom!.id!,
                userId: user.id!,
                message: text,
                messageType: MessageType.text,
                seenUserList: [],
                sameUser: false,
                deleted: false,
                createdAt: createdAt,
            ),
        );
        
        // Update room stats
        // Note: In real app, messageCount is per user in UserRoomMap, but we'll specific update lastMessageId here
        generalRoom.lastMessageId = msg.id;
        await ChatRoom.db.updateRow(session, generalRoom);
    }
    print(' - Added 20 public messages.');


    // 3. Direct Messages
    print('Seeding Direct Messages...');
    
    for (var i = 0; i < 50; i++) {
        // Pick two different users
        final userA = users[random.nextInt(users.length)];
        var userB = users[random.nextInt(users.length)];
        while (userA.id == userB.id) {
            userB = users[random.nextInt(users.length)];
        }

        // Check/Create DM Room
        ChatRoom? dmRoom;
        
        // Find existing room logic (simplified from chat_endpoint)
        // We look for a room where both are members
        // Efficient way: Find UserRoomMaps for User A
        final mapsA = await UserRoomMap.db.find(session, where: (t) => t.userId.equals(userA.id!));
        final roomIdsA = mapsA.map((m) => m.roomId).toSet();
        
        if (roomIdsA.isNotEmpty) {
             final mapB = await UserRoomMap.db.findFirstRow(
                 session,
                 where: (t) => t.userId.equals(userB.id!) & t.roomId.inSet(roomIdsA),
             );
             if (mapB != null) {
                  dmRoom = await ChatRoom.db.findById(session, mapB.roomId);
             }
        }

        if (dmRoom == null) {
            // Create new DM room
             dmRoom = await ChatRoom.db.insertRow(
                session,
                ChatRoom(
                    // roomName is ambiguous for DMs, usually the "other person", but here we leave it or generic
                    // chat_endpoint sets it to 'Direct Message', so we follow suit
                    // getRooms will dynamically rename it for the client. 
                    roomName: 'Direct Message', 
                    roomType: 'direct',
                    messageCount: 0,
                ),
            );
            
            // Map users
            await UserRoomMap.db.insertRow(session, UserRoomMap(roomId: dmRoom.id!, userId: userA.id!, unreadCount: 0));
            await UserRoomMap.db.insertRow(session, UserRoomMap(roomId: dmRoom.id!, userId: userB.id!, unreadCount: 0));
            // print('   Created DM: ${userA.userName} <-> ${userB.userName}');
        } else {
             if (dmRoom.roomType != 'direct') continue; // Should not happen if logic matches endpoint
        }

        // Send Message
        final text = cannedMessages[random.nextInt(cannedMessages.length)];
        final createdAt = DateTime.now().subtract(Duration(minutes: random.nextInt(1000)));
        
        final msg = await ChatMessage.db.insertRow(
            session,
            ChatMessage(
                roomId: dmRoom.id!,
                userId: userA.id!,
                message: text,
                messageType: MessageType.text,
                seenUserList: [],
                sameUser: false,
                deleted: false,
                createdAt: createdAt,
            ),
        );

        dmRoom.lastMessageId = msg.id;
        await ChatRoom.db.updateRow(session, dmRoom);

        // Update unread for receiver
        final receiverMap = await UserRoomMap.db.findFirstRow(
            session,
            where: (t) => t.roomId.equals(dmRoom!.id!) & t.userId.equals(userB.id!),
        );
        if (receiverMap != null) {
            receiverMap.unreadCount += 1;
            await UserRoomMap.db.updateRow(session, receiverMap);
        }
    }
    print(' - Added 50 DM messages.');

    print('\nMessage seeding completed.');

    await session.close();
  } catch (e) {
    print('\nError during message seeding: $e');
  } finally {
    await pod.shutdown();
  }
}
