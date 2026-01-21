import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:frontend/backend/server.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/screens/chats/rooms_controller.dart';
import 'package:frontend/screens/chats/messages_controller.dart';
import 'package:frontend/services/arri_client.rpc.dart';
import 'package:frontend/services/emoji_database_service.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/glass_morph.dart';
import 'package:frontend/widgets/textbox.dart';
import 'package:frontend/widgets/user_profile.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

enum EmojiType { emoji, gifs, stickers }

class EmojiButton extends StatefulWidget {
  const EmojiButton({super.key});

  @override
  State<EmojiButton> createState() => _EmojiButtonState();
}

class _EmojiButtonState extends State<EmojiButton> {
  GlobalKey actionKey = GlobalKey();
  double height = 0, width = 0, initX = 0, initY = 0;
  OverlayEntry? dropdown;
  bool isOpen = false;
  @override
  void initState() {
    super.initState();
  }

  void getDropDownData() {
    RenderBox renderBox =
        actionKey.currentContext!.findRenderObject() as RenderBox;
    height = 350;
    width = 400;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    initX = offset.dx;
    initY = offset.dy;
  }

  OverlayEntry _createDropDown() {
    return OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            close();
          },
          child: Container(
            color: Colors.transparent,
            width: Window.width,
            height: Window.height,
            child: Stack(
              children: [
                Positioned(
                  left: initX - 120,
                  width: width,
                  top: initY - height - 20,
                  height: height,
                  child: Material(
                    color: Colors.transparent,
                    elevation: 0,
                    child: EmojiContainer(onGifSelected: close),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void close() {
    if (isOpen) {
      dropdown!.remove();
      isOpen = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // await db.saveEmojis(); // disabled
        if (!isOpen) {
          getDropDownData();
          dropdown = _createDropDown();
          Overlay.of(context).insert(dropdown!);
        } else {
          close();
        }
        isOpen = !isOpen;
        setState(() {});
      },
      child: Icon(key: actionKey, Icons.emoji_emotions, color: Pallet.font3),
    );
  }
}

class EmojiContainer extends StatefulWidget {
  final VoidCallback? onGifSelected;
  const EmojiContainer({super.key, this.onGifSelected});

  @override
  State<EmojiContainer> createState() => _EmojiContainerState();
}

class _EmojiContainerState extends State<EmojiContainer> {
  List<Emoji> emojis = [];
  List<Gif> gifs = [];
  List<Map> stickers = [];
  bool isLoadingEmojis = false;
  EmojiType selectedType = EmojiType.emoji;

  void _onGifSelected(Gif gif) {
    final messagesController = Get.find<MessagesController>();
    messagesController.sendMessage(
      message: gif.toJson(),
      messageType: MessageType.gif,
    );
    widget.onGifSelected?.call();
  }

  getData({String? group}) async {
    // simplified: no external requests
    emojis = [];
    var response = await server.giphy.getGifs(GetGifParams(limit: 100));
    gifs = response.data;

    // Load emojis from database
    await loadEmojisFromDatabase();

    setState(() {});
  }

  Future<void> loadEmojisFromDatabase() async {
    try {
      final emojiData = await emojiDatabaseService.getAllEmojis();
      emojis = emojiData.map((data) => Emoji.fromJson(data)).toList();
      print('Loaded ${emojis.length} emojis into UI');
    } catch (e) {
      print('Error loading emojis from database: $e');
    }
  }

  Future<void> syncEmojis() async {
    if (isLoadingEmojis) return;

    setState(() => isLoadingEmojis = true);
    try {
      await emojiDatabaseService.syncEmojis();
      await loadEmojisFromDatabase();
      setState(() {});
    } catch (e) {
      print('Error syncing emojis: $e');
    } finally {
      setState(() => isLoadingEmojis = false);
    }
  }

  search(String query) async {}

  @override
  void initState() {
    // Window.mode = "emoji"; // disabled
    getData();
    // Sync emojis in background
    syncEmojis();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlassMorph(
      width: 400,
      height: 350,
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          SmallTextBox(
            hintText: "search",
            onType: (value) {
              if (value.length != 1) {
                search(value);
              }
            },
          ),
          if (isLoadingEmojis)
            Expanded(child: Center(child: CircularProgressIndicator())),

          if (selectedType == EmojiType.emoji && emojis.isNotEmpty)
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 46,
                  childAspectRatio: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: emojis.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: InkWell(
                      onTap: () {
                        final messagesController =
                            Get.find<MessagesController>();
                        final currentText =
                            messagesController.messageController.text;
                        messagesController.messageController.text =
                            currentText + emojis[index].emoji;
                      },
                      child: EmojiText(emoji: emojis[index].emoji, size: 30),
                    ),
                  );
                },
              ),
            )
          else if (selectedType == EmojiType.gifs)
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: [
                          for (var gif in gifs)
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 5),
                              child: InkWell(
                                onTap: () => _onGifSelected(gif),
                                child: Image.network(
                                  gif.url,
                                  width: 125,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          else if (selectedType == EmojiType.stickers)
            Expanded(
              child: Center(
                child: Text(
                  "Stickers coming soon!",
                  style: TextStyle(
                    color: Pallet.font2,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() => selectedType = EmojiType.emoji);
                  },
                  child: Center(
                    child: Text(
                      "emoji",
                      style: TextStyle(
                        color: selectedType == EmojiType.emoji
                            ? Pallet.font1
                            : Pallet.font2,
                        fontWeight: selectedType == EmojiType.emoji
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() => selectedType = EmojiType.gifs);
                  },
                  child: Center(
                    child: Text(
                      "gif",
                      style: TextStyle(
                        color: selectedType == EmojiType.gifs
                            ? Pallet.font1
                            : Pallet.font2,
                        fontWeight: selectedType == EmojiType.gifs
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() => selectedType = EmojiType.stickers);
                  },
                  child: Center(
                    child: Text(
                      "stickers",
                      style: TextStyle(
                        color: selectedType == EmojiType.stickers
                            ? Pallet.font1
                            : Pallet.font2,
                        fontWeight: selectedType == EmojiType.stickers
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EmojiText extends StatelessWidget {
  final double size;
  final String emoji;

  const EmojiText({super.key, required this.size, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Text(
      emoji,
      style: TextStyle(fontSize: Platform.isWindows ? size - 5 : size),
    );
  }
}

// Download function

class Bot extends StatelessWidget {
  const Bot({
    super.key,
    required this.image,
    required this.name,
    required this.page,
    required this.count,
  });
  final String image;
  final String name;
  final String page;
  final int count;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Clear selected room via controller
        try {
          Get.find<RoomsController>().selectedRoom.value = null;
        } catch (_) {}
        Window.subPage.value = page;
        refreshSink.add("");
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Pallet.inside1,
        ),
        padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
        child: Row(
          children: [
            if (name == "planner")
              Icon(Icons.notifications, color: Pallet.inside1)
            else
              Icon(Icons.memory, color: Pallet.inside1),

            // ClipRRect(
            //   borderRadius: BorderRadius.circular(10),
            //   child: Image.asset(
            //     image,
            //     width: 20,
            //     height: 20,
            //   ),
            // ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 14)),
                  // Text(
                  //   "hey how are u doing",
                  //   style: TextStyle(color: Pallet.font3, fontSize: 12),
                  // ),
                ],
              ),
            ),
            if (count != 0)
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red,
                ),
                child: Center(
                  child: Text(
                    count.toString(),
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

forwardMessage(context, Message message) async {
  List<Map> rooms = [];
  bool selected = false;
  // server.get(
  //     lock: true,
  //     data: {"0": "get_rooms", "1": userId},
  //     func: (data) {
  //       rooms = data;
  //       // for (var room in rooms) {
  //       // room["selected"] = false;
  //       // }
  //       for (var i = 0; i < rooms.length; i++) {
  //         rooms[i]["selected"] = false;
  //         final controller = Get.isRegistered<RoomsController>() ? Get.find<RoomsController>() : null;
  //         final currentRoomId = controller?.selectedRoom.value?.roomId;
  //         if (rooms[i]["roomId"] == currentRoomId) {
  //           rooms.removeAt(i);
  //           i--;
  //         }
  //       }
  //     });
  await server.lock();
  server.release();
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(10),
        backgroundColor: Pallet.inside2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        content: StreamBuilder<Object>(
          stream: refreshStream,
          builder: (context, snapshot) {
            return Container(
              width: 200,
              constraints: BoxConstraints(maxHeight: Window.height * 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Forward Message to"),
                  SizedBox(height: 10),
                  Container(
                    constraints: BoxConstraints(maxHeight: Window.height * 0.6),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (var room in rooms)
                          InkWell(
                            onTap: () {
                              room["selected"] = !room["selected"];
                              selected = true;
                              for (var room in rooms) {
                                if (room["selected"]) {
                                  selected = true;
                                }
                              }
                              refreshSink.add("");
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Checkbox(
                                      activeColor: Pallet.inside3,
                                      value: room["selected"],
                                      onChanged: (value) {
                                        room["selected"] = !room["selected"];
                                        selected = true;
                                        for (var room in rooms) {
                                          if (room["selected"]) {
                                            selected = true;
                                          }
                                        }
                                        refreshSink.add("");
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  ProfileIcon(
                                    size: 30,
                                    name: room["roomName"],
                                    color: Color(int.parse(room["roomColor"])),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    room["roomName"],
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selected)
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SmallButton(
                            label: "cancel",
                            onPress: () async {
                              Navigator.of(context).pop();
                            },
                          ),
                          const SizedBox(width: 10),
                          SmallButton(
                            label: "send",
                            onPress: () async {
                              for (var room in rooms) {
                                // server.get(
                                //     lock: true,
                                //     data: {
                                //       "0": "send_message",
                                //       "1": room["roomId"],
                                //       "2": userId,
                                //       "3": 0,
                                //       "4": message.message,
                                //       "5": (message.messageType == "reply") ? "text" : message.messageType
                                //     },
                                //     func: (value) {});
                              }
                              await server.lock();
                              server.release();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
