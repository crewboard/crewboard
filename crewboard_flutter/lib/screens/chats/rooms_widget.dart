import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../config/palette.dart';
import '../../controllers/rooms_controller.dart';
import '../../controllers/messages_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/sidebar_controller.dart'; // For Window helpers if needed
import '../../widgets/widgets.dart';

class Rooms extends ConsumerStatefulWidget {
  const Rooms({super.key});

  @override
  ConsumerState<Rooms> createState() => _RoomsState();
}

class _RoomsState extends ConsumerState<Rooms> {
  bool search = false;

  @override
  void initState() {
    super.initState();
    // Load rooms on init - using ref.read is safe in initState for one-off calls
    Future.microtask(() => ref.read(roomsProvider.notifier).loadRooms());
  }

  @override
  Widget build(BuildContext context) {
    final roomsState = ref.watch(roomsProvider);
    final rooms = roomsState.rooms;
    final messagesNotifier = ref.read(messagesProvider.notifier);
    final roomsNotifier = ref.read(roomsProvider.notifier);
    final authState = ref.watch(authProvider);
    final sidebarNotifier = ref.read(sidebarProvider.notifier);

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
                    setState(() {
                      search = true;
                    });
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
                          setState(() {
                            search = false;
                          });
                          roomsNotifier.resetSearch();
                        }
                      },
                      onChanged: (value) {
                        roomsNotifier.searchRooms(value);
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
                      setState(() {
                        search = false;
                      });
                      roomsNotifier.resetSearch();
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
              if (!search && rooms.isNotEmpty) ...[
                for (var room in rooms)
                  _buildRoomItem(context, ref, room, roomsState, authState),
              ],
              if (search && roomsState.searchQuery.isNotEmpty) ...[
                for (var room in rooms)
                  _buildRoomItem(context, ref, room, roomsState, authState),
                for (var user in roomsState.users)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () async {
                        await roomsNotifier.startDirectChat(user);
                        // In Riverpod version, we should probably update a subpage provider
                        // and load messages for the new room.
                        final selectedRoom = ref
                            .read(roomsProvider)
                            .selectedRoom;
                        if (selectedRoom != null) {
                          messagesNotifier.loadInitialMessages(
                            roomId: selectedRoom.id!,
                          );
                        }
                        sidebarNotifier.setSubPage('');
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              roomsState.selectedRoom?.roomName == user.userName
                              ? Pallet.inside1
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: RoomItem(
                          name: user.userName,
                          color: Pallet.getUserColor(user),
                          message: const {},
                          userId: authState.currentUserId,
                          messageCount: 0,
                        ),
                      ),
                    ),
                  ),
              ],
              if (search && rooms.isEmpty && roomsState.users.isEmpty)
                if (!roomsState.isSearchingUsers)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        "No results found",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
              if (roomsState.isSearchingUsers)
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
  }

  Widget _buildRoomItem(
    BuildContext context,
    WidgetRef ref,
    ChatRoom room,
    RoomsState roomsState,
    AuthState authState,
  ) {
    final roomsNotifier = ref.read(roomsProvider.notifier);
    final messagesNotifier = ref.read(messagesProvider.notifier);
    final sidebarNotifier = ref.read(sidebarProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () {
          roomsNotifier.markAsRead(room);
          roomsNotifier.selectRoom(room);
          messagesNotifier.loadInitialMessages(roomId: room.id!);
          sidebarNotifier.setSubPage('');
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: roomsState.selectedRoom?.id == room.id
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
                  authState.currentUserId,
                ),
                message: room.lastMessage?.toJson() ?? {},
                userId: authState.currentUserId,
                messageCount: room.messageCount,
              ),
            ],
          ),
        ),
      ),
    );
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
      padding: const EdgeInsets.only(left: 10, right: 10, top: 11, bottom: 11),
      child: Row(
        children: [
          ProfileIcon(
            size: 42,
            fontSize: 18,
            name: name,
            color: color,
            image: image,
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
