import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/backend/event_server.dart';
import 'package:frontend/screens/chats/emoji.dart';
import 'package:frontend/screens/chats/rooms_controller.dart';
import 'package:frontend/screens/chats/messages_controller.dart';
import 'package:frontend/widgets/glass_morph.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:frontend/globals.dart' as g;
import 'package:frontend/screens/chats/chat_widgets.dart';
import 'package:frontend/screens/sidebar.dart';
import 'package:frontend/widgets/user_profile.dart';
import 'package:get/get.dart';
// import 'package:frontend/widgets/glass_morph.dart';
import 'package:frontend/backend/server.dart';
import 'package:frontend/services/arri_client.rpc.dart';
import 'package:frontend/services/local_storage_service.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:frontend/backend/media_server.dart';

// Import globals for missing variables
import 'package:frontend/globals.dart';

class TypingUser {
  Timer timer;
  String user;
  Color color;
  String? image;
  TypingUser({
    required this.timer,
    required this.user,
    required this.color,
    this.image,
  });
}

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<TypingUser> typingUsers = [];

  @override
  void initState() {
    super.initState();
    EventServer.listen(
      topic: "typing",
      onData: (data) {
        print("Typing event received: $data");
        // Handle typing event: add user to typingUsers list
        setState(() {
          // Assuming data contains user info, e.g., {"user": "username", "color": "#ff000000"}
          typingUsers.add(
            TypingUser(
              timer: Timer(Duration(seconds: 3), () {
                setState(() {
                  typingUsers.removeWhere((u) => u.user == data['user']);
                });
              }),
              user: data['user'] ?? 'Unknown',
              color: Color(int.parse(data['color'] ?? '0xff000000')),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SideBar(
          children: [
            const SizedBox(height: 10),
            Bot(
              name: "planner",
              image: "assets/bot.jpg",
              page: "planner",
              count: plannerCount,
            ),
            const SizedBox(height: 5),
            const Bot(
              name: "memory bank",
              image: "assets/bot.jpg",
              page: "memory",
              count: 0,
            ),
            const SizedBox(height: 5),
            const Expanded(child: Rooms()),
            // if (incoming["roomId"] != null)
            //   Container(
            //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            //     decoration: BoxDecoration(
            //       color: Pallet.inside2,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.end,
            //       children: [
            //         Expanded(
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 "incoming call",
            //                 style: TextStyle(fontSize: 12, color: Pallet.font3),
            //               ),
            //               const SizedBox(height: 8),
            //               Row(
            //                 children: [
            //                   ProfileIcon(
            //                     size: 25,
            //                     name: "J",
            //                     color: Colors.red,
            //                   ),
            //                   SizedBox(width: 8),
            //                   Text("Jerin"),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () {
            //             // Window.page.value = CurrentPage.chat;
            //             // signaling.joinRoom(incoming["roomId"]);
            //           },
            //           child: Container(
            //             width: 30,
            //             height: 30,
            //             decoration: BoxDecoration(
            //               color: Colors.green,
            //               borderRadius: BorderRadius.circular(30),
            //             ),
            //             child: Icon(Icons.call, size: 18),
            //           ),
            //         ),
            //         const SizedBox(width: 10),
            //         InkWell(
            //           onTap: () {
            //             incoming = {};
            //             refreshSink.add("");
            //           },
            //           child: Container(
            //             width: 30,
            //             height: 30,
            //             decoration: BoxDecoration(
            //               color: Colors.red,
            //               borderRadius: BorderRadius.circular(30),
            //             ),
            //             child: Icon(Icons.call_end, size: 18),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
          ],
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(child: Messages()),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // if (emojis.isNotEmpty)
                  //   Focus(
                  //     focusNode: chat.emojiFocus,
                  //     onKey: (node, event) {
                  //       if (event.runtimeType == RawKeyUpEvent &&
                  //           event.logicalKey == LogicalKeyboardKey.arrowDown) {
                  //         chat.messageFocus.requestFocus();
                  //         chat.message.selection =
                  //             TextSelection.fromPosition(TextPosition(offset: chat.message.text.length));
                  //       }
                  //       if (event.runtimeType == RawKeyUpEvent &&
                  //           event.logicalKey == LogicalKeyboardKey.arrowRight) {
                  //         print("right");
                  //         if (selectedEmojiIdx < emojis.length) {
                  //           selectedEmojiIdx++;
                  //           refreshSink.add("");
                  //         }
                  //       }
                  //       if (event.runtimeType == RawKeyUpEvent &&
                  //           event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                  //         print("right");
                  //         if (selectedEmojiIdx >= 0) {
                  //           selectedEmojiIdx--;
                  //           refreshSink.add("");
                  //         }
                  //       }
                  //       if (event.runtimeType == RawKeyUpEvent &&
                  //           (event.logicalKey == LogicalKeyboardKey.enter ||
                  //               event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
                  //         print("enter");
                  //         List<String> temp = chat.message.text.split(":");
                  //         temp.removeLast();
                  //         chat.message.text = "";
                  //         for (var text in temp) {
                  //           chat.message.text += text;
                  //         }
                  //         ;
                  //         chat.message.text += emojis[selectedEmojiIdx].emoji;

                  //         chat.messageFocus.requestFocus();
                  //         chat.message.selection =
                  //             TextSelection.fromPosition(TextPosition(offset: chat.message.text.length));
                  //         refreshSink.add("");
                  //       }
                  //       return KeyEventResult.handled;
                  //     },
                  //     child: Container(
                  //       // width: 200,
                  //       height: 38,
                  //       constraints: BoxConstraints(maxWidth: 200),
                  //       padding:
                  //           (emojis.isEmpty) ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Pallet.inside2),
                  //       child: ListView(shrinkWrap: true, scrollDirection: Axis.horizontal, children: [
                  //         for (var i = 0; i < emojis.length; i++)
                  //           Container(
                  //             decoration: (selectedEmojiIdx == i && chat.emojiFocus.hasFocus)
                  //                 ? BoxDecoration(
                  //                     border: Border.all(color: Colors.blue),
                  //                     borderRadius: BorderRadius.circular(5),
                  //                     color: Pallet.inside1)
                  //                 : BoxDecoration(),
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(5),
                  //               child: Emoji(size: 20, animate: false, data: emojis[i]),
                  //             ),
                  //           )
                  //       ]),
                  //     ),
                  //   ),
                ],
              ),
              Column(
                children: [
                  for (var user in typingUsers)
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          ProfileIcon(
                            size: 25,
                            name: user.user,
                            color: user.color,
                          ),
                          SizedBox(width: 5),
                          const SizedBox(width: 40, height: 40),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Keyboard(),
              const SizedBox(height: 10),
            ],
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}

class Keyboard extends StatefulWidget {
  const Keyboard({super.key});

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  Timer? _typingTimer;
  bool _isTyping = false;
  // bool _dragging = false;
  // List<PlatformFile> _pendingFiles = [];
  OverlayEntry? _filePreviewOverlay;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _filePreviewOverlay?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassMorph(
      borderRadius: 18,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Obx(() {
        final hasController = Get.isRegistered<RoomsController>();
        if (!hasController) return SizedBox.shrink();
        final selected = Get.find<RoomsController>().selectedRoom.value;
        if (selected == null) return SizedBox.shrink();
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: EmojiButton(),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(),
                  child: Column(
                    children: [
                      if (Get.find<MessagesController>().reply != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: Pallet.inside1,
                                border: Border(
                                  left: BorderSide(color: Colors.red, width: 3),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (Get.find<MessagesController>()
                                                  .reply!
                                                  .isMe)
                                              ? "you"
                                              : '''Get.find<MessagesController>()
                                                      .reply!
                                                      .userName''',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.red,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        TextPreview(
                                          message: jsonDecode(
                                            Get.find<MessagesController>()
                                                .reply!
                                                .message,
                                          ),
                                        ),
                                        // Text(
                                        //   "sample text message",
                                        //   style: TextStyle(fontSize: 14),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: InkWell(
                                      onTap: () {
                                        Get.find<MessagesController>().reply =
                                            null;
                                        refreshSink.add("");
                                      },
                                      child: const Icon(Icons.close, size: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      RawKeyboardListener(
                        focusNode: FocusNode(),
                        onKey: (RawKeyEvent event) {
                          // print("called");
                          // if (event.runtimeType == RawKeyUpEvent &&
                          //     (event.logicalKey.keyId == 4294968068)) {
                          //   // up
                          //   chat.messageFocus.unfocus();
                          //   chat.emojiFocus.requestFocus();
                          //   refreshSink.add("");
                          // }
                        },
                        child: TextField(
                          controller:
                              Get.find<MessagesController>().messageController,
                          style: TextStyle(color: Colors.white),
                          onSubmitted: (value) {
                            // Call sendTextMessage instead, since sendMessage is undefined in _KeyboardState
                            Get.find<MessagesController>().sendMessage(
                              message: value,
                              messageType: MessageType.text,
                            );
                          },
                          onChanged: (value) async {
                            // Handle typing indicator
                            if (value.isNotEmpty && !_isTyping) {
                              _isTyping = true;
                              final hasController =
                                  Get.isRegistered<RoomsController>();
                              if (hasController) {
                                final selected = Get.find<RoomsController>()
                                    .selectedRoom
                                    .value;
                                if (selected != null) {
                                  try {
                                    print("sending");
                                    await server.chats.typing(
                                      TypingParams(roomId: selected.roomId),
                                    );
                                  } catch (e) {
                                    print('Error sending typing indicator: $e');
                                  }
                                }
                              }
                            }

                            // Reset typing timeout
                            _typingTimer?.cancel();
                            _typingTimer = Timer(Duration(seconds: 2), () {
                              _isTyping = false;
                            });

                            // print(value.split(":"));
                            // if (value.split(":").length == 2) {
                            //   for (var emoji in value.split(":")) {
                            //     await searchEmojis(emoji);
                            //   }
                            // }

                            // server.get(data: {
                            //   "0": "typing",
                            //   "1": chat.selectedRoom["roomId"],
                            //   "2": userId,
                            //   "3": "typing"
                            // }, func: (data) {});
                          },
                          decoration: InputDecoration(
                            fillColor: Pallet.inside1,
                            filled: true,
                            hintText: 'Message',
                            hintStyle: TextStyle(color: Pallet.font3),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
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
                    ],
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
                child: GestureDetector(
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(allowMultiple: true, type: FileType.any);
                    if (result != null && result.files.isNotEmpty) {
                      // Find the Messages widget and call its showFilePreview method
                      final messagesState = context
                          .findAncestorStateOfType<_MessagesState>();
                      if (messagesState != null) {
                        messagesState.showFilePreview(result.files);
                      }
                    }
                  },
                  child: Icon(Icons.attach_file, color: Pallet.font3),
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: GestureDetector(
                  onTap: () async {
                    Get.find<MessagesController>().sendMessage(
                      message:
                          Get.find<MessagesController>().messageController.text,
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
      }),
    );
  }
}

class Rooms extends StatefulWidget {
  const Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  // ValueNotifier<List> result = ValueNotifier<List>([]);
  final RoomsController roomsController = Get.put(RoomsController());
  final MessagesController messagesController = Get.put(MessagesController());
  bool search = false;
  String? userId;

  @override
  void initState() {
    super.initState();
    // Explicitly trigger load to ensure API call
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
                  Expanded(child: SizedBox()),
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
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
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
                      child: Icon(Icons.close, color: Pallet.font1, size: 18),
                    ),
                  ],
                ),
              ),
            ),

          Expanded(
            child: ListView(
              children: [
                for (var room in rooms)
                  InkWell(
                    onTap: () {
                      room = room.copyWith(messageCount: 0);
                      roomsController.rooms.refresh();
                      Window.subPage.value = "messages";
                      roomsController.selectRoom(room);

                      // Load messages for selected room via provider
                      messagesController.loadInitialMessages(
                        roomId: room.roomId,
                      );
                      refreshSink.add("");
                    },
                    child: Container(
                      color:
                          (roomsController.selectedRoom.value?.roomId ==
                              room.roomId)
                          ? Pallet.inside1
                          : Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Room(
                            name: room.roomName ?? "",
                            color: Colors.red,
                            // color: Color(int.parse(room.roomColor)),
                            message: room.message != null
                                ? (room.message as Map<dynamic, dynamic>)
                                : {},
                            userId: userId,
                            messageCount: 0,
                            // messageCount: room.messageCount ?? 0,
                          ),
                          // Divider removed per recent change
                        ],
                      ),
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
    userId = await LocalStorageService.getUserId();
    setState(() {});
  }
}

class Room extends StatelessWidget {
  const Room({
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
  final String? userId;

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
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 14)),
                SizedBox(height: 6),
                if (message["messageType"] == "text")
                  Text.rich(
                    TextSpan(
                      text: '',
                      children: [
                        for (var text in jsonDecode(message["message"]))
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
                  )
                else if (message["messageType"] != null)
                  Text(
                    (message["messageType"] == userId)
                        ? "you send a "
                        : "send you a " + message["messageType"].toString(),
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
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> with WidgetsBindingObserver {
  final MessagesController messagesController =
      Get.isRegistered<MessagesController>()
      ? Get.find<MessagesController>()
      : Get.put(MessagesController());
  final RoomsController roomsController = Get.find<RoomsController>();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    // chat events
    server.registerListeners(
      event: "chat_events",
      func: (data) async {
        if (data["event"] == "seen") {
          // Database.updateMessageSeen(data["messageId"], data["roomId"]);
          print("object");
        }
        if (data["event"] == "last_seen") {
          if (roomsController.selectedRoom.value?.roomId == data["roomId"]) {
            // for (var room in chat.rooms.value) {
            //   if (room["roomId"] == data["roomId"]) {
            //     room["lastSeenMessage"] = data["messageId"];
            //     messageSink.add("");
            //   }
            // }
          }
        }
      },
    );

    // on message

    // on reach bottom or top
    messagesController.itemPositionsListener.itemPositions.addListener(() {
      final msgs = messagesController.messages.value;
      if (messagesController
              .itemPositionsListener
              .itemPositions
              .value
              .isNotEmpty &&
          (msgs.length - 1) >= messagesController.limit) {
        if (messagesController
                .itemPositionsListener
                .itemPositions
                .value
                .last
                .index ==
            (msgs.length - 1)) {
          print("At the top " + msgs.last.messageId.toString());
          // chat.getTopMessages();
        } else if (messagesController
                .itemPositionsListener
                .itemPositions
                .value
                .first
                .index ==
            0) {
          print("at bottom " + msgs.first.messageId.toString());
          // chat.getBottomMessages();
        }
      }
    });
    // get initial messages
    // chat.getMessages();
    // get messsages on request
    requestStream.listen((event) async {
      if (event == "get_messages") {}
    });

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void showFilePreview(List<PlatformFile> files) {
    print("Showing file preview for ${files.length} files");
    messagesController.pendingFiles.assignAll(files);
    messagesController.showFilePreview.value = true;
  }

  void _hideFilePreview() {
    messagesController.showFilePreview.value = false;
    messagesController.pendingFiles.clear();
  }

  Widget _buildFilePreviewItem(PlatformFile file) {
    bool isImage =
        file.extension != null &&
        [
          'jpg',
          'jpeg',
          'png',
          'gif',
          'webp',
        ].contains(file.extension!.toLowerCase());

    if (isImage && file.bytes != null) {
      return Image.memory(
        file.bytes!,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(_getFileIcon(file.extension), size: 55, color: Pallet.font3),
        SizedBox(height: 15),
        Text(
          file.name,
          style: TextStyle(color: Pallet.font1, fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        Text(
          _formatFileSize(file.size),
          style: TextStyle(color: Pallet.font3, fontSize: 10),
        ),
      ],
    );
  }

  IconData _getFileIcon(String? extension) {
    if (extension == null) return Icons.insert_drive_file;

    switch (extension.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow;
      case 'txt':
        return Icons.text_fields;
      case 'zip':
      case 'rar':
        return Icons.archive;
      case 'mp3':
      case 'wav':
      case 'aac':
        return Icons.music_note;
      case 'mp4':
      case 'avi':
      case 'mov':
        return Icons.video_file;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("hereee");
    switch (state) {
      case AppLifecycleState.resumed:
        Window.active = true;
        final msgs = messagesController.messages.value;
        if (msgs.isNotEmpty &&
            roomsController.selectedRoom.value?.roomId != null) {
          final userId = await LocalStorageService.getUserId();
          if (userId != null) {
            server.seenMessage(
              roomId: roomsController.selectedRoom.value!.roomId,
              userId: userId,
              messageId: msgs.first.messageId,
            );
          }
        }

        print("RESUMED");
        break;
      case AppLifecycleState.inactive:
        Window.active = false;

        print("INACTIVE");
        break;
      case AppLifecycleState.paused:
        Window.active = false;

        print("PAUSED");
        break;
      case AppLifecycleState.detached:
        Window.active = false;

        print("DETACHED");
        break;
      case AppLifecycleState.hidden:
        Window.active = false;

        print("HIDDEN");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (detail) async {
        print("Messages: Drag done - detail type: ${detail.runtimeType}");
        print("Messages: Drag done - detail: $detail");
        print(
          "Messages: Drag done - has files property: ${detail.files != null}",
        );
        if (detail.files != null) {
          print("Messages: Drag done with ${detail.files.length} files");
        } else {
          print("Messages: Drag done but detail.files is null");
        }

        // Try alternative approach for Windows
        if (detail.files.isNotEmpty) {
          try {
            List<PlatformFile> platformFiles = [];
            for (var file in detail.files) {
              print(
                "Messages: Processing file: ${file.name}, path: ${file.path}",
              );
              final bytes = await file.readAsBytes();
              print("Messages: Read ${bytes.length} bytes for ${file.name}");
              platformFiles.add(
                PlatformFile(
                  name: file.name,
                  size: bytes.length,
                  bytes: bytes,
                  path: file.path,
                ),
              );
            }
            print(
              "Messages: Showing preview for ${platformFiles.length} files",
            );

            // Show file preview overlay directly in Messages widget
            showFilePreview(platformFiles);
          } catch (e) {
            print("Messages: Error processing dropped files: $e");
          }
        } else {
          print(
            "Messages: No files in detail.files, trying alternative approach",
          );
        }
      },
      onDragEntered: (detail) {
        print("Messages: Drag entered");
      },
      onDragExited: (detail) {
        print("Messages: Drag exited");
      },
      child: Stack(
        children: [
          GlassMorph(
            borderRadius: 24,
            padding: EdgeInsets.symmetric(vertical: 10),
            margin: EdgeInsets.only(top: 10),
            child: Obx(() {
              final msgs = messagesController.messages;
              if (msgs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      Text("no messages found", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  if (roomsController.selectedRoom.value?.roomId != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 15,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        children: [
                          // ProfileIcon(
                          //   name: roomsController.selectedRoom.value?.roomName,
                          //   size: 35,
                          //   fontSize: 16,
                          //   color: Color(int.parse(roomsController.selectedRoom.value?.])),
                          // ),
                          const SizedBox(width: 10),
                          Text(
                            roomsController.selectedRoom.value?.roomName ?? "",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: 16),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          SvgPicture.asset(
                            width: 25,
                            "assets/icons/video_call.svg",
                            color: Pallet.font3,
                          ),
                          const SizedBox(width: 15),
                          SvgPicture.asset(
                            width: 25,
                            "assets/icons/phone.svg",
                            color: Pallet.font3,
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              // openEndDrawer("audio");
                            },
                            child: SvgPicture.asset(
                              width: 25,
                              "assets/icons/audio.svg",
                              color: Pallet.font3,
                            ),
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              // openEndDrawer("image");
                            },
                            child: SvgPicture.asset(
                              width: 25,
                              "assets/icons/image.svg",
                              color: Pallet.font3,
                            ),
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              // openEndDrawer("file");
                            },
                            child: SvgPicture.asset(
                              width: 25,
                              "assets/icons/file.svg",
                              color: Pallet.font3,
                            ),
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () {
                              // openEndDrawer("search");
                            },
                            child: SvgPicture.asset(
                              width: 25,
                              "assets/icons/search.svg",
                              color: Pallet.font3,
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                  Expanded(
                    child: ScrollablePositionedList.builder(
                      itemPositionsListener:
                          messagesController.itemPositionsListener,
                      itemScrollController: messagesController.controller,
                      scrollOffsetListener:
                          messagesController.scrollOffsetListener,
                      reverse: true,
                      itemCount: msgs.length,
                      itemBuilder: (context, index) {
                        return mes(
                          msgs[index],
                          roomsController.selectedRoom.value!.getUser(
                            msgs[index].userId,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
          Obx(
            () => messagesController.showFilePreview.value
                ? GestureDetector(
                    onTap: () {
                      print("Tapped outside, hiding preview");
                      _hideFilePreview();
                    },
                    child: Container(
                      width: Window.width,
                      height: Window.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Send Files",
                                style: TextStyle(
                                  color: Pallet.font1,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  print("Close pressed");
                                  _hideFilePreview();
                                },
                                icon: Icon(Icons.close, color: Pallet.font3),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            child: _buildFilePreviewItem(
                              messagesController.pendingFiles.first,
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  mes(Message message, RoomProfile user) {
    if (message.messageType == MessageType.text) {
      // print(roomsController.selectedRoom.value?.lastSeenMessage);
      return TextMessage(
        user: user,
        message: message,
        // selected: message.messageId == messagesController.edit?.messageId,
        // lastSeen:
        //     message.messageId ==
        //     roomsController.selectedRoom.value?.lastSeenMessage,
      );
      // } else if (message.messageType == "reply") {
      //   return InkWell(
      //     onTap: () async {
      //       // await chat.getMessagesTill(message.parentMessage!["messageId"]);
      //       await Future.delayed(const Duration(milliseconds: 100));
      //       final msgs = messagesController.messages.value;
      //       for (var i = 0; i < msgs.length; i++) {
      //         if (msgs[i].messageId == message.parentMessage!["messageId"]) {
      //           messagesController.controller.scrollTo(
      //             index: i,
      //             duration: const Duration(seconds: 1),
      //             curve: Curves.easeInOutCubic,
      //           );
      //         }
      //       }
      //     },
      //     child: ReplyMessage(message: message),
      //   );
    } else if (message.messageType == MessageType.gif) {
      return GifMessage(user: user, message: message);
    } else if (message.messageType == MessageType.file) {
      return FileMessage(user: user, message: message);
    } else if (message.messageType == MessageType.image) {
      return ImageMessage(user: user, message: message);
      // } else if (message.messageType == "audio") {
      //   return AudioMessage(
      //     showUser: message.sameUser,
      //     url: message.message,
      //     user: message.userName,
      //     userColor: Color(int.parse(message.color)),
      //   );
    } else if (message.messageType == MessageType.video) {
      return VideoMessage(user: user, message: message);
    }
    return Container();
  }
}
