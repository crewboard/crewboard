import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:get/get.dart';
import '../../config/palette.dart';
import '../../controllers/rooms_controller.dart';
import '../../controllers/messages_controller.dart';
import '../../widgets/widgets.dart';

class Rooms extends StatefulWidget {
  const Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  final RoomsController roomsController = Get.put(RoomsController());
  final MessagesController messagesController = Get.put(MessagesController());
  bool search = false;
  UuidValue? userId;

  @override
  void initState() {
    super.initState();
    roomsController.loadRooms();
    _loadUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final rooms = roomsController.rooms;
      return Column(
        children: [
          if (!search)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Text(
                    "Messages",
                    style: TextStyle(fontSize: 17, color: Pallet.font3),
                  ),
                  const Expanded(child: SizedBox()),
                  InkWell(
                    onTap: () {
                      search = true;
                      setState(() {});
                    },
                    child: Icon(Icons.search, size: 20, color: Pallet.font3),
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Pallet.inside1,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Pallet.font3, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onSubmitted: (value) {
                          if (value.isEmpty) {
                            search = false;
                            roomsController.resetSearch();
                            setState(() {});
                          }
                        },
                        onChanged: (value) {
                          roomsController.searchRooms(value);
                        },
                        style: TextStyle(fontSize: 13, color: Pallet.font2),
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                            fontSize: 13,
                            color: Pallet.font1,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        search = false;
                        roomsController.resetSearch();
                        setState(() {});
                      },
                      child: Icon(Icons.close, color: Pallet.font3, size: 18),
                    ),
                  ],
                ),
              ),
            ),
          Expanded(
            child: ListView(
              children: [
                if (roomsController.rooms.isNotEmpty) ...[
                  for (var room in rooms)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () {
                          roomsController.markAsRead(room);
                          Window.subPage.value = "messages";
                          roomsController.selectRoom(room);

                          // Load messages for selected room
                          messagesController.loadInitialMessages(
                            roomId: room.id!,
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                (roomsController.selectedRoom.value?.id ==
                                    room.id)
                                ? Pallet.inside1
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RoomItem(
                                name: room.roomName ?? "",
                                color: _getRoomColor(room),
                                message: room.lastMessage?.toJson() ?? {},
                                userId: userId,
                                messageCount: room.messageCount,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
                if (search && roomsController.users.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Users",
                      style: TextStyle(
                        fontSize: 12,
                        color: Pallet.font1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  for (var user in roomsController.users)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () async {
                          await roomsController.startDirectChat(user);
                          Window.subPage.value = "messages";
                          // room controller handles selecting the room and resetting search
                          if (roomsController.selectedRoom.value != null) {
                            messagesController.loadInitialMessages(
                              roomId: roomsController.selectedRoom.value!.id!,
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                (roomsController.selectedRoom.value?.id ==
                                    roomsController.selectedRoom.value?.id)
                                ? Pallet.inside1
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: RoomItem(
                            name: user.userName,
                            color: _getUserColor(user),
                            message: const {},
                            userId: userId,
                            messageCount: 0,
                          ),
                        ),
                      ),
                    ),
                ],
                if (search &&
                    roomsController.rooms.isEmpty &&
                    roomsController.users.isEmpty)
                  if (!roomsController.isSearchingUsers.value)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "No results found",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                if (roomsController.isSearchingUsers.value)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }

  void _loadUserId() async {
    // TODO: Load user ID from local storage or auth controller
    setState(() {});
  }

  Color _getRoomColor(ChatRoom room) {
    // If room color is eventually added to the model, use it here.
    // For now, we can derive it from name or use a default that isn't hardcoded red.
    // Ideally, for direct chats, we'd fetch the other user's color.
    return Colors.blue; 
  }

  Color _getUserColor(User user) {
    if (user.color != null) {
      try {
        return Color(int.parse(user.color!.color.replaceAll("#", "0xFF")));
      } catch (e) {
        debugPrint("Error parsing user color: $e");
      }
    }
    return Colors.blue;
  }
}

class RoomItem extends StatelessWidget {
  const RoomItem({
    super.key,
    required this.name,
    required this.color,
    required this.message,
    required this.messageCount,
    required this.userId,
    this.image,
  });
  final String name;
  final Color color;
  final int messageCount;
  final String? image;
  final Map message;
  final UuidValue? userId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
      child: Row(
        children: [
          ProfileIcon(
            size: 45,
            fontSize: 18,
            name: name,
            color: color,
            image: image,
            style: ProfileIconStyle.outlined,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 6),
                if (message["messageType"] == "text")
                  () {
                    try {
                      final decoded = jsonDecode(message["message"]);
                      if (decoded is List) {
                        return Text.rich(
                          TextSpan(
                            text: '',
                            children: [
                              for (var text in decoded)
                                if (text["type"] == "text")
                                  TextSpan(
                                    text: text["value"],
                                    style: TextStyle(
                                      color: Pallet.font3,
                                      fontSize: 13,
                                    ),
                                  )
                                else
                                  TextSpan(
                                    text: text["value"]["emoji"],
                                    style: TextStyle(
                                      color: Pallet.font3,
                                      fontSize: 13,
                                    ),
                                  ),
                            ],
                          ),
                        );
                      }
                    } catch (_) {}
                    return Text(
                      message["message"] ?? "",
                      style: TextStyle(color: Pallet.font3, fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  }()
                else if (message["messageType"] != null)
                  Text(
                    (UuidValue.fromString(message["userId"]) == userId)
                        ? "you sent a ${message["messageType"]}"
                        : "sent you a ${message["messageType"]}",
                    style: TextStyle(color: Pallet.font3, fontSize: 13),
                  )
                else
                  Text(
                    "no messages yet",
                    style: TextStyle(color: Pallet.font3, fontSize: 13),
                  ),
              ],
            ),
          ),
          if (messageCount != 0)
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  messageCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
