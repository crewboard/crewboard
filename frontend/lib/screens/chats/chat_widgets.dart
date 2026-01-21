import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/screens/chats/emoji.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:frontend/screens/chats/rooms_controller.dart';
import 'package:frontend/screens/chats/messages_controller.dart';
import 'package:frontend/backend/server.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:frontend/services/arri_client.rpc.dart';

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

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
        content: StreamBuilder<Object>(
          stream: refreshStream,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: 10),
                  // decoration: BoxDecoration(color: Pallet.inside2, borderRadius: BorderRadius.circular(5)),
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
            );
          },
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SmallButton(
                label: "cancel",
                onPress: () async {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(width: 10),
              SmallButton(
                label: "save",
                onPress: () async {
                  // server.get(
                  //     data: {"0": "add_memory", "1": userId, "2": title.text, "3": body.text},
                  //     func: (data) {
                  //       requestSink.add("get_memories");
                  //       Navigator.of(context).pop();
                  //     });
                },
              ),
            ],
          ),
        ],
      );
    },
  );
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
  final Message message;

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
            width: Window.width,
            height: Window.height,
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
                                      Get.find<MessagesController>().reply =
                                          widget.message;
                                      print(
                                        Get.find<MessagesController>().reply
                                            .toString(),
                                      );
                                      refreshSink.add("");
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
                                          Text("reply"),
                                          Icon(Icons.reply, size: 18),
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
                                      await forwardMessage(
                                        context,
                                        widget.message!,
                                      );
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
                                          Text("forward"),
                                          Icon(
                                            Icons.forward_to_inbox,
                                            size: 18,
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
                                      String copy = "";
                                      for (var text in jsonDecode(
                                        widget.message!.message,
                                      )) {
                                        if (text["type"] == "text") {
                                          copy += text["value"];
                                        } else {
                                          copy += text["value"]["emoji"];
                                        }
                                      }
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
                                          Text("remember"),
                                          Icon(Icons.lightbulb, size: 18),
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
                                      String copy = "";
                                      for (var text in jsonDecode(
                                        widget.message!.message,
                                      )) {
                                        if (text["type"] == "text") {
                                          copy += text["value"];
                                        } else {
                                          copy += text["value"]["emoji"];
                                        }
                                      }

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
                                          Text("copy"),
                                          Icon(Icons.copy, size: 18),
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
                                        Get.find<MessagesController>().edit =
                                            widget.message;
                                        // chat.message?.clear();
                                        for (var message in jsonDecode(
                                          Get.find<MessagesController>()
                                              .edit!
                                              .message,
                                        )) {
                                          if (message["type"] == "text") {
                                            // chat.message?.text += message["value"];
                                          } else {
                                            // chat.message?.text += message["value"]["emoji"];
                                          }
                                          close();
                                          messageSink.add("");
                                          // FocusScope.of(context).requestFocus(new FocusNode());
                                        }
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
                                            Text("edit"),
                                            Icon(Icons.edit, size: 18),
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
                                            Text("delete"),
                                            Icon(Icons.delete, size: 18),
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

  void avoidNormalMenu() {
    // TODO: Implement context menu avoidance if needed
  }

  @override
  Widget build(BuildContext context) {
    print("is ${widget.message.isMe}");
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
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Color(int.parse(widget.user.color)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      widget.user.userName[0].toUpperCase(),
                      style: TextStyle(
                        color: Pallet.font1,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
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
                    if (server.deviceType == "android" ||
                        server.deviceType == "ios") {
                      openMenu();
                    }
                  },
                  onSecondaryTap: () {
                    openMenu();
                  },
                  child: widget.child,
                ),
                // if (widget.message.seenUserList.contain)
                //   Padding(
                //     padding: const EdgeInsets.only(right: 5),
                //     child: Text(
                //       "seen",
                //       style: TextStyle(fontSize: 12),
                //     ),
                //   ),
                // if (widget.lastSeen)
                //   SizedBox(
                //     width: (Window.stageWidth - 100),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Container(
                //           margin: EdgeInsets.symmetric(vertical: 5),
                //           padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                //           decoration: BoxDecoration(color: Pallet.inside3, borderRadius: BorderRadius.circular(10)),
                //           child: Text(
                //             "New Message",
                //             style: TextStyle(color: Pallet.font3, fontSize: 10),
                //           ),
                //         ),
                //       ],
                //     ),
                //   )
                // Column(
                //   children: [
                //     SizedBox(height: 5),
                //     Container(
                //       width: Window.stageWidth - 50,
                //       color: Colors.red,
                //       height: 1,
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(right: 5),
                //       child: Text(
                //         "last seen",
                //         style: TextStyle(
                //           fontSize: 12,
                //           color: Colors.red,
                //         ),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
            // if (widget.message.isMe && widget.message.sameUser == false)
            // Expanded(child: SizedBox()),
            // if (widget.message.isMe && widget.message.sameUser == false)
            // Text("3:30", style: TextStyle(fontSize: 10)),
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

// class ReplyMessage extends StatefulWidget {
//   const ReplyMessage({super.key, required this.message});
//   final Message message;

//   @override
//   State<ReplyMessage> createState() => _ReplyMessageState();
// }

// class _ReplyMessageState extends State<ReplyMessage> {
//   GlobalKey messageKey = GlobalKey();
//   GlobalKey replyeKey = GlobalKey();
//   double? width;
//   @override
//   void initState() {
//     setWidths();
//     super.initState();
//   }

//   setWidths() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       if (messageKey.currentContext?.size?.width != null &&
//           replyeKey.currentContext?.size?.height != null) {
//         if (messageKey.currentContext!.size!.width <
//             replyeKey.currentContext!.size!.width) {
//           width = null;
//         } else {
//           width = messageKey.currentContext?.size?.width;
//         }
//         setState(() {});
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MessageWidget(
//       userColor: Color(int.parse(widget.message.color)),
//       sameUser: widget.message.sameUser,
//       selected: false,
//       seen: false,
//       lastSeen: false,
//       user: widget.message.userName,
//       message: widget.message,
//       child: Container(
//         padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
//         decoration: BoxDecoration(
//           color: Pallet.inside2,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         constraints: BoxConstraints(maxWidth: Window.stageWidth * 0.5),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               key: replyeKey,
//               borderRadius: BorderRadius.circular(8.0),
//               child: Container(
//                 width: width,
//                 // height: (width != null) ? 0 : null,
//                 padding: EdgeInsets.only(left: 5, right: 5),
//                 decoration: BoxDecoration(
//                   color: Pallet.inside1,
//                   border: Border(
//                     left: BorderSide(
//                       color: Color(
//                         int.parse(widget.message.parentMessage!["color"]),
//                       ),
//                       width: 3,
//                     ),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 2),
//                     Text(
//                       widget.message.parentMessage!["userName"],
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Color(
//                           int.parse(widget.message.parentMessage!["color"]),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                     TextPreview(
//                       message: jsonDecode(
//                         widget.message.parentMessage!["message"],
//                       ),
//                     ),
//                     SizedBox(height: 5),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               key: messageKey,
//               padding: const EdgeInsets.all(8.0),
//               child: TextPreview(message: jsonDecode(widget.message.message)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class TextMessage extends StatelessWidget {
  const TextMessage({super.key, required this.message, required this.user});
  final Message message;
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
        child: TextPreview(message: jsonDecode(message.message)),
      ),
    );
  }
}

class TextPreview extends StatelessWidget {
  const TextPreview({super.key, required this.message});
  final List message;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '',
        children: [
          for (var text in message)
            if (text["type"] == "text")
              TextSpan(
                text: text["value"],
                style: TextStyle(color: Pallet.font1),
              )
            else
              WidgetSpan(
                child: EmojiText(
                  size: (double.parse(
                    (text["size"] ?? '18').toString(),
                  )),
                  // animate: true,
                  emoji: text["value"],
                ),
              ),
        ],
      ),
    );
  }
}

// class PreviewMessage extends StatefulWidget {
//   const PreviewMessage({super.key, required this.url, required this.type});
//   final String type;
//   final String url;
//   @override
//   State<PreviewMessage> createState() => _PreviewMessageState();
// }

// class _PreviewMessageState extends State<PreviewMessage> {
//   int selectedIdx = 0;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Pallet.background,
//         body: StreamBuilder<Object>(
//           stream: refreshStream,
//           builder: (context, snapshot) {
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: 5),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         String tempUrl = "";
//                         if (widget.type == "images") {
//                           tempUrl = server.getAsssetUrl(
//                             jsonDecode(widget.url)[selectedIdx]["url"],
//                           );
//                         } else {
//                           tempUrl = server.getAsssetUrl(widget.url);
//                         }
//                         downloadUrl(tempUrl);
//                         print(tempUrl);
//                       },
//                       child: Icon(Icons.download_rounded, size: 20),
//                     ),
//                     SizedBox(width: 5),
//                     InkWell(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Icon(Icons.close, size: 20),
//                     ),
//                     SizedBox(width: 5),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 if (widget.type == "video")
//                   VideoPreview(url: widget.url, height: Window.height * 0.65)
//                 else if (widget.type == "image")
//                   Center(
//                     child: Image.network(
//                       server.getAsssetUrl(widget.url),
//                       height: Window.height * 0.65,
//                       fit: BoxFit.fitHeight,
//                     ),
//                   )
//                 else if (widget.type == "images")
//                   Expanded(
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: Center(
//                             child: Image.network(
//                               server.getAsssetUrl(
//                                 jsonDecode(widget.url)[selectedIdx]["url"],
//                               ),
//                               width: Window.width,
//                               fit: BoxFit.fitWidth,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 10,
//                             horizontal: 10,
//                           ),
//                           child: SizedBox(
//                             height: 50,
//                             width:
//                                 jsonDecode(widget.url)[selectedIdx]["ratio"] *
//                                 Window.height *
//                                 0.65,
//                             child: ListView(
//                               shrinkWrap: true,
//                               scrollDirection: Axis.horizontal,
//                               children: [
//                                 for (
//                                   var i = 0;
//                                   i < jsonDecode(widget.url).length;
//                                   i++
//                                 )
//                                   // for (var image in )
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 5),
//                                     child: InkWell(
//                                       onTap: () {
//                                         selectedIdx = i;
//                                         refreshSink.add("");
//                                       },
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(5),
//                                         child: Image.network(
//                                           server.getAsssetUrl(
//                                             jsonDecode(widget.url)[i]["url"],
//                                           ),
//                                           width: 50,
//                                           height: 50,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // SizedBox(height: 10),
//                       ],
//                     ),
//                   ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// previewMessage(context, String url, String type, {Duration? duration}) async {
//   if (server.deviceType == "web") {
//     int selectedIdx = 0;
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           contentPadding: EdgeInsets.all(10),
//           backgroundColor: Pallet.inside2,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(15)),
//           ),
//           content: StreamBuilder<Object>(
//             stream: refreshStream,
//             builder: (context, snapshot) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           if (type == "images") {
//                             url = server.getAsssetUrl(
//                               jsonDecode(url)[selectedIdx]["url"],
//                             );
//                           } else {
//                             url = server.getAsssetUrl(url);
//                           }
//                           print(url);
//                           downloadUrl(url);
//                         },
//                         child: Icon(Icons.download_rounded, size: 20),
//                       ),
//                       SizedBox(width: 2),
//                       InkWell(
//                         onTap: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Icon(Icons.close, size: 20),
//                       ),
//                       SizedBox(width: 5),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   if (type == "video")
//                     VideoPreview(
//                       url: url,
//                       height: Window.height * 0.65,
//                       duration: duration,
//                     )
//                   else if (type == "image")
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: Image.network(
//                         server.getAsssetUrl(url),
//                         height: Window.height * 0.65,
//                         fit: BoxFit.fitHeight,
//                       ),
//                     )
//                   else if (type == "images")
//                     Column(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(15),
//                           child: Image.network(
//                             server.getAsssetUrl(
//                               jsonDecode(url)[selectedIdx]["url"],
//                             ),
//                             height: Window.height * 0.65,
//                             fit: BoxFit.fitHeight,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         SizedBox(
//                           height: 50,
//                           width:
//                               jsonDecode(url)[selectedIdx]["ratio"] *
//                               Window.height *
//                               0.65,
//                           child: ListView(
//                             shrinkWrap: true,
//                             scrollDirection: Axis.horizontal,
//                             children: [
//                               for (var i = 0; i < jsonDecode(url).length; i++)
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 5),
//                                   child: InkWell(
//                                     onTap: () {
//                                       selectedIdx = i;
//                                       refreshSink.add("");
//                                     },
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(5),
//                                       child: Image.network(
//                                         server.getAsssetUrl(
//                                           jsonDecode(url)[i]["url"],
//                                         ),
//                                         width: 50,
//                                         height: 50,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     );
//   } else {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => SafeArea(
//           child: PreviewMessage(url: url, type: type),
//         ),
//       ),
//     );
//   }
// }

class FileMessage extends StatelessWidget {
  const FileMessage({super.key, required this.user, required this.message});
  final RoomProfile user;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return MessageWidget(
      // userColor: Color(int.parse(message.color)),
      user: user,
      message: message,
      child: FilePreview(
        name: jsonDecode(message.message)[0]["name"],
        size: jsonDecode(message.message)[0]["size"],
        url: jsonDecode(message.message)[0]["value"],
      ),
    );
  }
}

class VideoMessage extends StatefulWidget {
  const VideoMessage({super.key, required this.user, required this.message});
  final RoomProfile user;
  final Message message;

  @override
  State<VideoMessage> createState() => _VideoMessageState();
}

class _VideoMessageState extends State<VideoMessage> {
  @override
  Widget build(BuildContext context) {
    return MessageWidget(
      user: widget.user,
      message: widget.message,
      child: VideoPreview(
        url: jsonDecode(widget.message.message)[0]["value"],
        height: 200,
      ),
    );
  }
}

class VideoPreview extends StatefulWidget {
  const VideoPreview({
    super.key,
    required this.url,
    required this.height,
    this.duration,
    this.isPreview = false,
  });
  final String url;
  final double height;
  final Duration? duration;
  final bool isPreview;
  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late final Player _player;
  late final VideoController _controller;
  double volume = 1;
  bool volumeOpen = false;

  @override
  void initState() {
    _player = Player();
    _controller = VideoController(_player);
    _player.open(Media(server.getAsssetUrl(widget.url)), play: false);
    // _player.play();
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(server.getAsssetUrl(widget.url));
    return SizedBox(
      width:
          widget.height *
          (_player.state.width != null && _player.state.height != null
              ? _player.state.width! / _player.state.height!
              : 16 / 9),
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Video(controller: _controller),
            Container(
              height: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
              // color: ,
            ),
            InkWell(
              onTap: () {
                if (volumeOpen) {
                  volumeOpen = false;
                } else {
                  if (_player.state.playing) {
                    _player.pause();
                  } else {
                    _player.play();
                  }
                }

                setState(() {});
              },
              child: SizedBox(
                width:
                    widget.height *
                    (_player.state.width != null && _player.state.height != null
                        ? _player.state.width! / _player.state.height!
                        : 16 / 9),
                height: widget.height,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 40,
                    height: 40,
                    child: Center(
                      child: Icon(
                        _player.state.playing ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (volumeOpen)
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 5),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: 80,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Pallet.background,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          overlayShape: SliderComponentShape.noOverlay,
                          // trackHeight: 28,
                          thumbColor: Colors.transparent,
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 0.0,
                          ),
                        ),
                        child: Slider(
                          thumbColor: Colors.transparent,
                          value: volume,
                          onChanged: (value) {
                            volume = value;
                            setState(() {});
                            _player.setVolume(volume * 100);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // _ControlsOverlay(controller: _controller),
            InkWell(
              child: Row(
                children: [
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      volumeOpen = !volumeOpen;
                      setState(() {});
                    },
                    child: Icon(Icons.volume_up, size: 18),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: StreamBuilder<Duration>(
                        stream: _player.stream.position,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          final duration = _player.state.duration;
                          if (duration.inMilliseconds > 0) {
                            return LinearProgressIndicator(
                              value:
                                  position.inMilliseconds /
                                  duration.inMilliseconds,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () async {
                      if (!widget.isPreview) {
                        if (volumeOpen) {
                          volumeOpen = false;
                        }
                        if (_player.state.playing) {
                          _player.pause();
                        }
                        // await previewMessage(
                        //   context,
                        //   widget.url,
                        //   "video",
                        //   duration: _player.state.position,
                        // );
                      }
                    },
                    child: Icon(Icons.fullscreen, size: 18),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GifMessage extends StatefulWidget {
  const GifMessage({super.key, required this.user, required this.message});
  final RoomProfile user;
  final Message message;
  @override
  State<GifMessage> createState() => _GifMessageState();
}

class _GifMessageState extends State<GifMessage> {
  late final Player _player;
  late final VideoController _controller;
  late Gif gif;
  @override
  void initState() {
    gif = Gif.fromJson(jsonDecode(widget.message.message));
    _player = Player();
    _controller = VideoController(_player);
    _player.open(Media(gif.mp4), play: false);
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MessageWidget(
      user: widget.user,
      message: widget.message,
      child: SizedBox(
        width:
            150 *
            (_player.state.width != null && _player.state.height != null
                ? _player.state.width! / _player.state.height!
                : 1.0),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Video(
                controller: _controller,
                controls:
                    null, // Removes default UI controls (including seek bar)
              ),
              if (!_player.state.playing)
                Center(
                  child: InkWell(
                    onTap: () async {
                      await _player.play();
                      setState(() {});
                      print(_player.state.duration.inSeconds);

                      await Future.delayed(_player.state.duration);
                      print("passed");
                      await _player.pause();
                      setState(() {});
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Pallet.inside1,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(Icons.gif),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// // class GifMessage extends StatelessWidget {
// //   const GifMessage({super.key, required this.gif, required this.user, required this.userColor, required this.showUser});
// //   final Map gif;
// //   final String user;
// //   final Color userColor;

// //   final bool showUser;

// //   @override
// //   Widget build(BuildContext context) {
// //     return MessageWidget(
// //       userColor: userColor,
// //       showUser: showUser,
// //       selected: false,
// //       user: user,
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(15),
// //         child: Image.network(
// //           gif["webp"].replaceAll('"', ''),
// //           width: double.parse(gif["width"]) * 1.2,
// //           height: double.parse(gif["height"]) * 1.2,
// //           fit: BoxFit.cover,
// //         ),
// //       ),
// //     );
// //   }
// // }

class ImageMessage extends StatelessWidget {
  const ImageMessage({super.key, required this.message, required this.user});
  final Message message;
  final RoomProfile user;

  @override
  Widget build(BuildContext context) {
    return MessageWidget(
      user: user,
      message: message,
      child: Column(
        children: [
          if (jsonDecode(message.message).length < 4)
            Column(
              children: [
                for (var image in jsonDecode(message.message))
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () {
                        // previewMessage(context, image["url"], "image");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          server.getAsssetUrl(image["value"]),
                          width: 280,
                          height: 280,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
              ],
            )
          else
            InkWell(
              onTap: () {
                // previewMessage(context, message.message, "images");
              },
              child: SizedBox(
                width: 280,
                height: 280,
                child: Wrap(
                  spacing: 2,
                  runSpacing: 2,
                  children: [
                    for (var i = 0; i < 4; i++)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          server.getAsssetUrl(
                            jsonDecode(message.message)[i]["value"],
                          ),
                          width: 139,
                          height: 139,
                          fit: BoxFit.cover,
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

// class AudioMessage extends StatefulWidget {
//   const AudioMessage({
//     super.key,
//     required this.url,
//     required this.user,
//     required this.userColor,
//     required this.showUser,
//   });
//   final String url;
//   final String user;
//   final Color userColor;
//   final bool showUser;

//   @override
//   State<AudioMessage> createState() => _AudioMessageState();
// }

// class _AudioMessageState extends State<AudioMessage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MessageWidget(
//       userColor: widget.userColor,
//       sameUser: widget.showUser,
//       seen: false,
//       selected: false,
//       lastSeen: false,
//       user: widget.user,
//       child: AudioPreview(url: widget.url, color: Pallet.inside2),
//     );
//   }
// }
