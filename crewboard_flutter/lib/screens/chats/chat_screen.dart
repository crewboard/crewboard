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
import '../memory_bank/memory_bank_screen.dart';
import 'ticket_threads_full_view.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final subPage = Window.subPage.value;
      return Row(
        children: [
          Expanded(
            child: Column(
              children: [
                if (subPage == 'memory')
                  const Expanded(child: MemoryBankScreen())
                else if (subPage == 'planner')
                  const Expanded(child: TicketThreadsFullView())
                else
                  const Expanded(child: Messages()),
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
      );
    });
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
        margin: const EdgeInsets.only(top: 10, bottom: 10),
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
                  ProfileIcon(
                    name: selectedRoom.roomName ?? "",
                    size: 32,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 12),
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
                    colorFilter: ColorFilter.mode(
                      Pallet.font3,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 18),
                  SvgPicture.asset(
                    "assets/icons/phone.svg",
                    width: 25,
                    colorFilter: ColorFilter.mode(
                      Pallet.font3,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 18),
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
                  const SizedBox(width: 18),
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
                  const SizedBox(width: 18),
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
                  const SizedBox(width: 18),
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
            const Keyboard(),
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

      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 5,
              top: 10,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 8),
                Icon(
                  Icons.sentiment_satisfied_alt_outlined,
                  color: Pallet.font3,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: messagesController.messageController,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    onSubmitted: (value) {
                      messagesController.sendMessage(
                        messageText: value,
                        messageType: MessageType.text,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(
                        color: Pallet.font3.withValues(alpha: 0.7),
                        fontSize: 13,
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 10,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.mic_none, color: Pallet.font3, size: 22),
                const SizedBox(width: 15),
                Icon(Icons.attach_file, color: Pallet.font3, size: 22),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    messagesController.sendMessage(
                      messageText: messagesController.messageController.text,
                      messageType: MessageType.text,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0084FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
        ),
      );
    });
  }
}
