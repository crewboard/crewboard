import 'dart:convert';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';

import '../../config/palette.dart';
import '../../main.dart'; // For sessionManager
import '../../widgets/widgets.dart';
import '../../widgets/button.dart' as frontend_button;
import '../../widgets/emoji.dart';
import '../../controllers/messages_controller.dart';
import '../../controllers/rooms_controller.dart';
import '../../widgets/video_preview.dart';
import '../../widgets/audio_preview.dart';
import '../../widgets/full_screen_image_preview.dart';

// Placeholder for RoomProfile if not defined elsewhere
class RoomProfile {
  final String userName;
  final Color color;
  const RoomProfile({required this.userName, required this.color});
}

// Extension to match frontend usage
extension ChatMessageUI on ChatMessage {
  // Check if the message was sent by the currently authenticated user
  bool get isMe {
    final currentUserId = sessionManager.authInfo?.authUserId;
    if (currentUserId == null) return false;
    return userId == currentUserId;
  }
  bool get selected => false; // Placeholder for selection state
}

addMemory(context, {String? text}) async {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  if (text != null) {
    body.text = text;
  }
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(10),
        backgroundColor: Pallet.inside2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Pallet.inside3,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    child: TextField(
                      controller: title,
                      style: TextStyle(fontSize: 12, color: Pallet.font3),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Pallet.font3,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        hintText: 'title',
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: Pallet.inside3,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    child: TextField(
                      maxLines: 5,
                      controller: body,
                      style: TextStyle(fontSize: 12, color: Pallet.font3),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        hintStyle: TextStyle(
                          fontSize: 12,
                          color: Pallet.font3,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        hintText: 'body',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              frontend_button.SmallButton(
                label: "cancel",
                onPress: () async {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(width: 10),
              frontend_button.SmallButton(
                label: "save",
                onPress: () async {
                  // TODO: Implement save logic
                   Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final UuidValue userId;
  final bool sameUser;
  final DateTime createdAt;
  final MessageType? type;
  // Temporary: reconstruct a ChatMessage or modify calling code to pass ChatMessage
  // For now, I will use this widget as a dispatcher to new widgets

  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe, // This might be overridden by internal check if I create ChatMessage
    required this.userId,
    required this.sameUser,
    required this.createdAt,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    // Reconstruct a temporary ChatMessage object to work with new widgets
    // This is a bridge. ideally ChatScreen should pass ChatMessage object.
    final msgObj = ChatMessage(
        roomId: UuidValue.fromString('00000000-0000-0000-0000-000000000000'),
        userId: userId,
        message: message,
        messageType: type ?? MessageType.text,
        seenUserList: [],
        sameUser: sameUser, // Passed from parent list
        deleted: false,
        createdAt: createdAt,
    );
    
    // Lookup user profile from RoomsController
    String senderName = isMe ? "Me" : "Other";
    Color senderColor = isMe ? Colors.blue : Colors.grey;
    
    if (!isMe) {
      final roomsController = Get.find<RoomsController>();
      final room = roomsController.selectedRoom.value;
      if (room != null && room.roomUsers != null) {
        try {
          final user = room.roomUsers!.firstWhere((u) => u.id == userId);
          senderName = user.userName;
          senderColor = Pallet.getUserColor(user);
        } catch (_) {}
      }
    } else {
      // For "Me", try to get current user color from RoomsController users list
      final roomsController = Get.find<RoomsController>();
      final currentUserId = sessionManager.authInfo?.authUserId;
      if (currentUserId != null) {
        try {
          // Try to find in the users list (search results or loaded users)
          final me = roomsController.users.firstWhereOrNull((u) => u.id == currentUserId);
          if (me != null) {
            senderColor = Pallet.getUserColor(me);
          } else {
            // Also check room users of all rooms
            for (var room in roomsController.rooms) {
              final meInRoom = room.roomUsers?.firstWhereOrNull((u) => u.id == currentUserId);
              if (meInRoom != null) {
                senderColor = Pallet.getUserColor(meInRoom);
                break;
              }
            }
          }
        } catch (_) {}
      }
    }

    final userProfile = RoomProfile(
      userName: senderName,
      color: senderColor,
    );

    if (type == MessageType.image) {
      return ImageMessage(message: msgObj, user: userProfile);
    } else if (type == MessageType.video) {
      return VideoMessage(message: msgObj, user: userProfile);
    } else if (type == MessageType.audio) {
      return AudioMessage(message: msgObj, user: userProfile);
    } else {
      return TextMessage(message: msgObj, user: userProfile);
    }
  }
}


class MessageWidget extends StatefulWidget {
  const MessageWidget({
    super.key,
    required this.user,
    required this.child,
    required this.message,
  });
  final RoomProfile user;
  final Widget child;
  // final bool selected;
  final ChatMessage message;

  @override
  State<MessageWidget> createState() => _MessageState();
}

class _MessageState extends State<MessageWidget> {
  GlobalKey actionKey = GlobalKey();
  double height = 0, width = 0, initX = 0, initY = 0, parentWidth = 0;

  OverlayEntry? dropdown;
  bool isOpen = false;
  final ValueNotifier<int?> hoveredIdx = ValueNotifier<int?>(null);
  
  void getDropDownData() {
    RenderBox renderBox =
        actionKey.currentContext!.findRenderObject() as RenderBox;
    parentWidth = renderBox.size.width;
    if (widget.message.sameUser == true) {
      height = 190;
    } else {
      height = 135;
    }
    width = 120;
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
            width: Window.width, // From Palette
            height: Window.height, // From Palette
            child: Stack(
              children: [
                Positioned(
                  top: initY,
                  left: widget.message.isMe
                      ? initX - width - 10
                      : initX + parentWidth + 10,
                  width: width,
                  height: height,
                  child: Material(
                    color: Colors.transparent,
                    elevation: 10,
                    child: GestureDetector(
                      onTap: () {},
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: Pallet.inside2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: width,
                        height: height,
                        child: ValueListenableBuilder<int?>(
                          valueListenable: hoveredIdx,
                          builder: (BuildContext context, int? _hoveredIdx, Widget? child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MouseRegion(
                                  onEnter: (details) {
                                    hoveredIdx.value = 0;
                                  },
                                  onExit: (details) {
                                    hoveredIdx.value = null;
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      Get.find<MessagesController>().reply.value =
                                          widget.message;
                                      close();
                                    },
                                    child: Container(
                                      color: (_hoveredIdx == 0)
                                          ? Pallet.inside1
                                          : Colors.transparent,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("reply", style: TextStyle(color: Pallet.font1, fontSize: 12)),
                                          Icon(Icons.reply, size: 18, color: Pallet.font1),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                MouseRegion(
                                  onEnter: (details) {
                                    hoveredIdx.value = 1;
                                  },
                                  onExit: (details) {
                                    hoveredIdx.value = null;
                                  },
                                  child: InkWell(
                                    onTap: () async {
                                      // await forwardMessage(
                                      //   context,
                                      //   widget.message!,
                                      // );
                                      close();
                                    },
                                    child: Container(
                                      color: (_hoveredIdx == 1)
                                          ? Pallet.inside1
                                          : Colors.transparent,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("forward", style: TextStyle(color: Pallet.font1, fontSize: 12)),
                                          Icon(
                                            Icons.forward_to_inbox,
                                            size: 18,
                                            color: Pallet.font1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                MouseRegion(
                                  onEnter: (details) {
                                    hoveredIdx.value = 2;
                                  },
                                  onExit: (details) {
                                    hoveredIdx.value = null;
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      // Logic to extract text and add memory
                                      String copy = _extractTextFromMessage(widget.message.message);
                                      addMemory(context, text: copy);
                                      close();
                                    },
                                    child: Container(
                                      color: (_hoveredIdx == 2)
                                          ? Pallet.inside1
                                          : Colors.transparent,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("remember", style: TextStyle(color: Pallet.font1, fontSize: 12)),
                                          Icon(Icons.lightbulb, size: 18, color: Pallet.font1),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                MouseRegion(
                                  onEnter: (details) {
                                    hoveredIdx.value = 3;
                                  },
                                  onExit: (details) {
                                    hoveredIdx.value = null;
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      String copy = _extractTextFromMessage(widget.message.message);
                                      Clipboard.setData(
                                        ClipboardData(text: copy),
                                      );
                                      close();
                                    },
                                    child: Container(
                                      color: (_hoveredIdx == 3)
                                          ? Pallet.inside1
                                          : Colors.transparent,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("copy", style: TextStyle(color: Pallet.font1, fontSize: 12)),
                                          Icon(Icons.copy, size: 18, color: Pallet.font1),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (widget.message.sameUser == true)
                                  MouseRegion(
                                    onEnter: (details) {
                                      hoveredIdx.value = 4;
                                    },
                                    onExit: (details) {
                                      hoveredIdx.value = null;
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        Get.find<MessagesController>().edit.value =
                                            widget.message;
                                            close();
                                      },
                                      child: Container(
                                        color: (_hoveredIdx == 4)
                                            ? Pallet.inside1
                                            : Colors.transparent,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("edit", style: TextStyle(color: Pallet.font1, fontSize: 12)),
                                            Icon(Icons.edit, size: 18, color: Pallet.font1),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                if (widget.message.sameUser == true)
                                  MouseRegion(
                                    onEnter: (details) {
                                      hoveredIdx.value = 5;
                                    },
                                    onExit: (details) {
                                      hoveredIdx.value = null;
                                    },
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        color: (_hoveredIdx == 5)
                                            ? Pallet.inside1
                                            : Colors.transparent,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("delete", style: TextStyle(color: Pallet.font1, fontSize: 12)),
                                            Icon(Icons.delete, size: 18, color: Pallet.font1),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _extractTextFromMessage(String message) {
     try {
        dynamic decoded = jsonDecode(message);
        if (decoded is List) {
          String copy = "";
          for (var text in decoded) {
            if (text["type"] == "text") {
              copy += text["value"];
            } else {
              copy += text["value"]["emoji"];
            }
          }
          return copy;
        }
      } catch (e) {
        // Not JSON or List
      }
      return message;
  }

  void close() {
    if (isOpen) {
      dropdown!.remove();
      isOpen = false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: (widget.message.selected)
          ? Pallet.inside3.withOpacity(0.5)
          : Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(
          top: (widget.message.isMe && widget.message.sameUser == false)
              ? 5
              : 0,
        ),
        child: Row(
          mainAxisAlignment: (widget.message.isMe)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.message.isMe)
              if (widget.message.sameUser == false)
                ProfileIcon(
                  size: 30,
                  fontSize: 12,
                  name: widget.user.userName,
                  color: widget.user.color,
                  borderRadius: 10,
                  style: ProfileIconStyle.outlined,
                )
              else
                SizedBox(height: 30, width: 30),
            SizedBox(width: 2),
            Column(
              crossAxisAlignment: (widget.message.isMe)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!widget.message.isMe && widget.message.sameUser == false)
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      widget.user.userName,
                      style: TextStyle(fontSize: 12, color: Pallet.font3),
                    ),
                  ),
                const SizedBox(height: 5),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  key: actionKey,
                  onLongPress: () {
                     // Platform check simulation
                      openMenu();
                  },
                  onSecondaryTap: () {
                    openMenu();
                  },
                  child: widget.child,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  openMenu() {
    getDropDownData();
    dropdown = _createDropDown();
    Overlay.of(context).insert(dropdown!);
    isOpen = true;
    setState(() {});
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({super.key, required this.message, required this.user});
  final ChatMessage message;
  final RoomProfile user;
  @override
  Widget build(BuildContext context) {
    return MessageWidget(
      user: user,
      message: message,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: Pallet.inside2,
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: BoxConstraints(maxWidth: Window.width * 0.5),
        child: TextPreview(message: message.message),
      ),
    );
  }
}

class ImageMessage extends StatelessWidget {
  const ImageMessage({super.key, required this.message, required this.user});
  final ChatMessage message;
  final RoomProfile user;

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = [];
    try {
      dynamic decoded = jsonDecode(message.message);
      if (decoded is List) {
        images = decoded;
      } else {
        // Handle non-list JSON (single object?) or primitives
        images = [{"value": message.message}];
      }
    } catch (e) {
      // Fallback if not JSON or generic error
      images = [{"value": message.message}];
    }

    return MessageWidget(
      user: user,
      message: message,
      child: Column(
        children: [
          if (images.length < 4)
            Column(
              children: [
                for (var image in images)
                  Padding(
                    padding: const EdgeInsets.only(top: 4), // Small padding between images
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenImagePreview(
                                imageUrl: image["value"] ?? "",
                              ),
                            ),
                          );
                        },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          image["value"] ?? "",
                          width: 280,
                          height: 187, // 3:2 ratio (280 * 2/3)
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                              return Container(
                                width: 280,
                                height: 187,
                                color: Pallet.inside2,
                                child: Center(child: CircularProgressIndicator(color: Pallet.font1)));
                          },
                           errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 280,
                              height: 187,
                              color: Pallet.inside2,
                              child: Center(child: Icon(Icons.broken_image, color: Pallet.font3)),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            )
          else
            InkWell(
               onTap: () {
                // For the grid view, we might want to open a gallery view
                // For now, let's open the first image or do nothing?
                // Or maybe the user tapped a specific one in the grid?
                // The wrap children don't have individual tap handlers in current code.
                // Let's make individual children tappable.
              },
              child: SizedBox(
                width: 280,
                height: 280,
                child: Wrap(
                  spacing: 2,
                  runSpacing: 2,
                  children: [
                    for (var i = 0; i < 4; i++)
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenImagePreview(
                                imageUrl: images[i]["value"] ?? "",
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                             images[i]["value"] ?? "",
                            width: 139,
                            height: 139,
                            fit: BoxFit.cover,
                             loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                                return Container(
                                  width: 139,
                                  height: 139,
                                  color: Pallet.inside2,
                                  child: Center(child: CircularProgressIndicator(strokeWidth: 2, color: Pallet.font1)));
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 139,
                                height: 139,
                                color: Pallet.inside2,
                                child: Center(child: Icon(Icons.broken_image, size: 20, color: Pallet.font3)),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class VideoMessage extends StatelessWidget {
  const VideoMessage({super.key, required this.message, required this.user});
  final ChatMessage message;
  final RoomProfile user;

  @override
  Widget build(BuildContext context) {
    String url = message.message;
    try {
      final decoded = jsonDecode(url);
      if (decoded is List && decoded.isNotEmpty) {
        url = decoded[0]["value"] ?? url;
      } else if (decoded is Map) {
        url = decoded["value"] ?? url;
      }
    } catch (_) {}

    return MessageWidget(
      user: user,
      message: message,
      child: VideoPreview(
        url: url,
        height: 240,
      ),
    );
  }
}

class AudioMessage extends StatelessWidget {
  const AudioMessage({super.key, required this.message, required this.user});
  final ChatMessage message;
  final RoomProfile user;
  @override
  Widget build(BuildContext context) {
     return MessageWidget(
      user: user,
      message: message,
      child: AudioPreview(
        url: message.message, // Assuming message content is URL
        color: Pallet.inside2,
        waveform: message.waveform,
      ),
     );
  }
}


class TextPreview extends StatelessWidget {
  const TextPreview({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    dynamic parsedMessage; // Changed to dynamic
    try {
      parsedMessage = jsonDecode(message);
    } catch (e) {
      // Not JSON, treat as single text block
      parsedMessage = [{"type": "text", "value": message}];
    }
    
    // Ensure it's a list
    if (parsedMessage is! List) {
       parsedMessage = [{"type": "text", "value": message}];
    }

    return SelectionArea(
      child: Text.rich(
        TextSpan(
          text: '',
          children: [
            for (var text in parsedMessage)
              if (text is Map && text["type"] == "text")
                TextSpan(
                  text: text["value"],
                  style: TextStyle(color: Pallet.font1),
                )
              else if (text is Map)
                WidgetSpan(
                  child: EmojiText(
                    size: (double.tryParse(
                      (text["size"] ?? '18').toString(),
                    ) ?? 18.0),
                    emoji: text["value"] ?? "",
                  ),
                )
               else 
                 TextSpan(text: text.toString())
          ],
        ),
      ),
    );
  }
}
