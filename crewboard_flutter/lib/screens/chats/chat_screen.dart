import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/rooms_controller.dart';
import '../../controllers/messages_controller.dart';
import '../../config/palette.dart';
import 'chat_widgets.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/glass_morph.dart';

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
    final roomsController = Get.put(RoomsController());
    final messagesController = Get.put(MessagesController());

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

      return GlassMorph(
        borderRadius: 24,
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 15,
                left: 20,
                right: 20,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Text(
                    selectedRoom.roomName ?? "",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  SvgPicture.asset(
                    "assets/icons/video_call.svg",
                    width: 25,
                    colorFilter: ColorFilter.mode(Pallet.font3, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 15),
                  SvgPicture.asset(
                    "assets/icons/phone.svg",
                    width: 25,
                    colorFilter: ColorFilter.mode(Pallet.font3, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      // openEndDrawer("audio");
                    },
                    child: SvgPicture.asset(
                      "assets/icons/audio.svg",
                      width: 25,
                      colorFilter: ColorFilter.mode(
                        Pallet.font3,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      // openEndDrawer("image");
                    },
                    child: SvgPicture.asset(
                      "assets/icons/image.svg",
                      width: 25,
                      colorFilter: ColorFilter.mode(
                        Pallet.font3,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      // openEndDrawer("file");
                    },
                    child: SvgPicture.asset(
                      "assets/icons/file.svg",
                      width: 25,
                      colorFilter: ColorFilter.mode(
                        Pallet.font3,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      // openEndDrawer("search");
                    },
                    child: SvgPicture.asset(
                      "assets/icons/search.svg",
                      width: 25,
                      colorFilter: ColorFilter.mode(
                        Pallet.font3,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
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
              ),
            ),
          ],
        ),
      );
    });
  }
}

class Keyboard extends StatelessWidget {
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final roomsController = Get.put(RoomsController());
      final selected = roomsController.selectedRoom.value;
      if (selected == null) return const SizedBox.shrink();

      final messagesController = Get.put(MessagesController());

      return GlassMorph(
        borderRadius: 18,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
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
                          color: Pallet.font3.withValues(alpha: 0.25),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Pallet.font3.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Pallet.font3.withValues(alpha: 0.25),
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
        ),
      );
    });
  }
}
