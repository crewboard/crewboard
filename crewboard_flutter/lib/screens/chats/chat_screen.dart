import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/rooms_controller.dart';
import '../../controllers/messages_controller.dart';
import '../../config/palette.dart';
import 'chat_widgets.dart';
import 'rooms_widget.dart';
import '../sidebar.dart';
import 'package:crewboard_client/crewboard_client.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SideBar(
          children: [
            SizedBox(height: 10),
            Expanded(child: Rooms()),
          ],
        ),
        Expanded(
          child: Column(
            children: [
              const Expanded(child: Messages()),
              const SizedBox(height: 10),
              Keyboard(),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final messagesController = Get.find<MessagesController>();
    final roomsController = Get.find<RoomsController>();

    return Obx(() {
      final selectedRoom = roomsController.selectedRoom.value;
      if (selectedRoom == null) {
        return Center(
          child: Text(
            "Select a room to start chatting",
            style: TextStyle(color: Pallet.font3),
          ),
        );
      }

      return ListView.builder(
        reverse: true,
        itemCount: messagesController.messages.length,
        itemBuilder: (context, index) {
          final msg = messagesController.messages[index];
          return MessageBubble(
            message: msg.message,
            isMe: true, // TODO: Replace with actual logic
            createdAt: msg.createdAt,
          );
        },
      );
    });
  }
}

class Keyboard extends StatelessWidget {
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hasController = Get.isRegistered<RoomsController>();
      if (!hasController) return const SizedBox.shrink();
      final selected = Get.find<RoomsController>().selectedRoom.value;
      if (selected == null) return const SizedBox.shrink();

      final messagesController = Get.find<MessagesController>();

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Icon(Icons.emoji_emotions, color: Colors.grey),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: messagesController.messageController,
                  style: const TextStyle(color: Colors.white),
                  onSubmitted: (value) {
                    messagesController.sendMessage(
                      messageText: value,
                      messageType: MessageType.text,
                    );
                  },
                  decoration: InputDecoration(
                    fillColor: Pallet.inside1,
                    filled: true,
                    hintText: 'Message',
                    hintStyle: TextStyle(color: Pallet.font3),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Pallet.font3.withOpacity(0.25),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Pallet.font3.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Pallet.font3.withOpacity(0.25),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Icon(Icons.mic, color: Pallet.font3),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Icon(Icons.attach_file, color: Pallet.font3),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () {
                  messagesController.sendMessage(
                    messageText: messagesController.messageController.text,
                    messageType: MessageType.text,
                  );
                },
                child: Icon(Icons.send, color: Pallet.font3),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      );
    });
  }
}
