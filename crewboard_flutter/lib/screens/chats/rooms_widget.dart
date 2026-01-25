import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:get/get.dart';
import '../../config/palette.dart';
import '../../controllers/rooms_controller.dart';
import '../../controllers/messages_controller.dart';
import '../../controllers/auth_controller.dart';
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

  @override
  void initState() {
    super.initState();
    roomsController.loadRooms();
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
                if (!search && roomsController.rooms.isNotEmpty) ...[
                  for (var room in rooms) _buildRoomItem(room),
                ],
                if (search && roomsController.searchQuery.isNotEmpty) ...[
                  for (var room in rooms) _buildRoomItem(room),
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
                                roomsController.selectedRoom.value?.roomName ==
                                    user.userName
                                ? Pallet.inside1
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: RoomItem(
                            name: user.userName,
                            color: Pallet.getUserColor(user),
                            message: const {},
                            userId: authController.currentUserId.value,
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

  Widget _buildRoomItem(ChatRoom room) {
    return Padding(
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
            color: roomsController.selectedRoom.value?.id == room.id
                ? Pallet.inside1
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoomItem(
                name: room.roomName ?? "",
                color: Pallet.getRoomColor(
                  room,
                  authController.currentUserId.value,
                ),
                message: room.lastMessage?.toJson() ?? {},
                userId: authController.currentUserId.value,
                messageCount: room.messageCount,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final AuthController authController = Get.find<AuthController>();
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
      padding: const EdgeInsets.only(left: 10, right: 10, top: 11, bottom: 11),
      child: Row(
        children: [
          ProfileIcon(
            size: 42,
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
                const SizedBox(height: 4),
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
                                      fontSize: 11,
                                    ),
                                  )
                                else
                                  TextSpan(
                                    text: text["value"]["emoji"],
                                    style: TextStyle(
                                      color: Pallet.font3,
                                      fontSize: 11,
                                    ),
                                  ),
                            ],
                          ),
                        );
                      }
                    } catch (_) {}
                    return Text(
                      message["message"] ?? "",
                      style: TextStyle(color: Pallet.font3, fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  }()
                else if (message["messageType"] != null)
                  Text(
                    (UuidValue.fromString(message["userId"]) == userId)
                        ? "you sent a ${message["messageType"]}"
                        : "sent you a ${message["messageType"]}",
                    style: TextStyle(color: Pallet.font3, fontSize: 11),
                  )
                else
                  Text(
                    "no messages yet",
                    style: TextStyle(color: Pallet.font3, fontSize: 11),
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
