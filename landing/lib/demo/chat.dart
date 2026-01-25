import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:landing/demo/aimation.dart';
import 'package:landing/main.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../types.dart';
import '../widgets.dart';

class DemoPallet {
  // static Color background = Color(0xFF161819);
  // static Color font1 = Color(0xFFf9f9fb);
  // static Color font2 = Color(0xFFececed);
  // static Color font3 = Color(0xFFbebebe);
  // static Color inner1 = Color(0xFF323337);
  // static Color inner2 = Color(0xFF27292D);
  // static Color inner3 = Color(0xFF1d1f20);

  static bool light = false;

  static Color background = Color(0xFF161819);
  static Color insideFont = Colors.white;

  static Color font1 = Color(0xFFf9f9fb);
  static Color font2 = Color(0xFFececed);
  static Color font3 = Color(0xFFbebebe);

  static Color inner1 = Color(0xFF323337);
  static Color inner2 = Color(0xFF27292D);
  static Color inner3 = Color(0xFF1d1f20);
  static darkMode() {
    DemoPallet.light = false;
    DemoPallet.background = Color(0xFF161819);
    DemoPallet.insideFont = Colors.white;

    DemoPallet.font1 = Color(0xFFf9f9fb);
    DemoPallet.font2 = Color(0xFFececed);
    DemoPallet.font3 = Color(0xFFbebebe);

    DemoPallet.inner1 = Color(0xFF323337);
    DemoPallet.inner2 = Color(0xFF27292D);
    DemoPallet.inner3 = Color(0xFF1d1f20);
  }

  static lightMode() {
    DemoPallet.light = true;
    DemoPallet.background = Color(0xFFf5f7fb);
    DemoPallet.insideFont = Colors.white;

    DemoPallet.font1 = Color(0xFF464646);
    DemoPallet.font2 = Color(0xFF5c5c5c);
    DemoPallet.font3 = Color(0xFFa2a2a2);

    DemoPallet.inner1 = Color(0xFFffffff);
    DemoPallet.inner2 = Color(0xFFe3e3e5);
    DemoPallet.inner3 = Color(0xFFf5f7fb);
  }
}

ScrollController _scrollController = ScrollController();
bool typing = false;
TextEditingController message = TextEditingController();
bool isPhone = false;

class ChatDemo extends StatefulWidget {
  const ChatDemo({super.key});

  @override
  State<ChatDemo> createState() => _ChatDemoState();
}

class _ChatDemoState extends State<ChatDemo> with TickerProviderStateMixin {
  bool playing = false;
  bool played = false;
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    print("registered controler");

    events.registerEvent("show_chat", () async {
      if (!playing) {
        playing = true;
        while (playing) {
          if (!playing) {
            break;
          }
          await _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 800),
              curve: Curves.fastOutSlowIn);

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(seconds: 1));

          typing = true;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(seconds: 1));

          typing = false;
          animationSink.add("");
          messages.add(
            {
              "user": "deepak",
              "same": false,
              "message": "that looks cool!",
              "messageType": "text",
            },
          );
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 100));

          if (!playing) {
            break;
          }
          await _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.fastOutSlowIn);

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          messages.add(
            {
              "user": "deepak",
              "same": true,
              "message": "😎",
              "animation": coolAnimated,
              "messageType": "emoji",
            },
          );
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 100));

          if (!playing) {
            break;
          }
          await _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.fastOutSlowIn);

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(seconds: 2));
          messages.removeAt(messages.length - 1);
          messages.removeAt(messages.length - 1);
          animationSink.add("");
          _scrollController.jumpTo(_scrollController.position.minScrollExtent);

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(seconds: 1));
        }
      }
      print("stopped chat");
    });

    events.registerEvent("stop_chat", () async {
      playing = false;
    });

    super.initState();
  }

  // play() async {
  //   _controller.reset();
  // }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('chat'),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (!playing) {
          if (visiblePercentage > 5) {
            if (!played) {
              _controller.reset();
              _controller.forward();
              played = true;
            }
            print("asked to play");
          }

          if (visiblePercentage > 60) {
            animationSink.add("stop_planner");
            animationSink.add("stop_flowie");

            animationSink.add("show_chat");

            _controller.forward();
          }
        } else {
          if (visiblePercentage < 40) {
            print("requiested stop chat");
            animationSink.add("stop_chat");

            _controller.reset();
          }
        }

        debugPrint(
            'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
      },
      child: SizedBox(
        width: Window.fullWidth,
        height: Window.fullHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: Window.fullWidth * 0.3,
                    child: Animate(
                      controller: _controller,
                      effects: const [
                        SlideEffect(duration: Duration(milliseconds: 1000)),
                        FadeEffect(duration: Duration(milliseconds: 1000))
                      ],
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Seamless chatting with team mates",
                              style:
                                  TextStyle(fontSize: 50, color: Pallet.font1),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "responsive design",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    animationSink.add("show_desktop");
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(0.2)),
                                    // decoration:
                                    //     BoxDecoration(borderRadius: BorderRadius.circular(10), color: Pallet.inner2),
                                    child: Icon(Icons.desktop_mac_outlined,
                                        color: isPhone
                                            ? Pallet.font2
                                            : Colors.blue[100]),
                                  ),
                                ),
                                SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    animationSink.add("show_phone");
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(0.2)),
                                    child: Icon(
                                      Icons.phone_android_rounded,
                                      color: isPhone
                                          ? Colors.blue[100]
                                          : Pallet.font2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Text("supports all themes",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    DemoPallet.lightMode();
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(0.2)),
                                    child: Icon(
                                      Icons.light_mode,
                                      color: DemoPallet.light
                                          ? Colors.yellow
                                          : Pallet.font2,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    DemoPallet.darkMode();
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(0.2)),
                                    child: Icon(
                                      Icons.dark_mode,
                                      color: DemoPallet.light
                                          ? Pallet.font1
                                          : Colors.blue[800],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Animate(
                    controller: _controller,
                    effects: [
                      ScaleEffect(duration: Duration(milliseconds: 1000)),
                      FadeEffect(duration: Duration(milliseconds: 1000))
                    ],
                    child: DeskTopToPhone(
                      height: Window.fullHeight * 0.5,
                    ),
                  ),
                ),
              ),
              // SizedBox(width: 50)
            ]),
          ],
        ),
      ),
    );
  }
}

class DeskTopToPhone extends StatefulWidget {
  const DeskTopToPhone({super.key, required this.height});
  final double height;
  @override
  State<DeskTopToPhone> createState() => _DeskTopToPhoneState();
}

class _DeskTopToPhoneState extends State<DeskTopToPhone> {
  @override
  void initState() {
    events.registerEvent("show_phone", () {
      mult = 0.53;
      borderRadius = 10;
      isPhone = true;
      setState(() {});
      // refreshSink.add("");
    });
    events.registerEvent("show_desktop", () {
      mult = 1.25;
      borderRadius = 5;
      isPhone = false;
      setState(() {});
      // refreshSink.add("");
    });
    // animationStream.listen((event) {
    //   if (event == "show_phone") {
    //     mult = 0.53;
    //     borderRadius = 10;
    //     isPhone = true;
    //     // refreshSink.add("");
    //   } else if (event == "show_desktop") {
    //     mult = 1.25;
    //     borderRadius = 5;
    //     isPhone = false;
    //     // refreshSink.add("");
    //   }
    //   setState(() {});
    // });
    if (isPhone) {
      mult = 0.53;
      borderRadius = 10;
      isPhone = true;
      // refreshSink.add("");
    } else {
      mult = 1.25;
      borderRadius = 5;
      isPhone = false;
      // refreshSink.add("");
    }
    super.initState();
  }

  // bool isPhone = true;
  double borderRadius = 5;
  double mult = 1.25;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: widget.height * mult,
      height: widget.height,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    decoration: BoxDecoration(
                        borderRadius: (isPhone)
                            ? BorderRadius.circular(borderRadius)
                            : BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                        color: Colors.black),
                    padding: const EdgeInsets.all(5),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          color: DemoPallet.background),
                      child: Column(children: [
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isPhone)
                              Container(
                                width: 30,
                                height: 8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black),
                              ),
                          ],
                        ),
                        Expanded(child: Content())
                      ]),
                    ),
                  ),
                ),
                if (!isPhone)
                  Container(
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                  )
              ],
            ),
          ),
          if (!isPhone)
            Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(color: Colors.black),
            )
        ],
      ),
    );
  }
}

List<Map> messages = [
  {
    "user": "deepak",
    "same": false,
    "message": "hi, did u finish the project?",
    "messageType": "text",
  },
  {
    "user": "deepak",
    "same": true,
    "message":
        "please give me updates on daily basis i have to report accordingly to my authorities",
    "messageType": "text",
  },
  {
    "user": "me",
    "same": false,
    "message":
        "i have completed sir, but charles said that client shared new designs",
    "messageType": "text",
  },
  {
    "user": "deepak",
    "same": false,
    "message": "okay, thankyou.",
    "messageType": "text",
  },
  {
    "user": "me",
    "same": false,
    "message": "sir can u please share me the designs shared by the client",
    "messageType": "text",
  },
  {
    "user": "deepak",
    "same": false,
    "message": "il enquire and get u the designs by tommorow",
    "messageType": "text",
  },
  {
    "user": "me",
    "same": false,
    "message": "okay sir",
    "messageType": "text",
  },
  {
    "user": "deepak",
    "same": false,
    "message": "login.jpg",
    "messageType": "image",
  },
  {
    "user": "deepak",
    "same": true,
    "message": "here u go",
    "messageType": "text",
  },
  {
    "user": "deepak",
    "same": true,
    "message": "chris todays update?",
    "messageType": "text",
  },
  {
    "user": "me",
    "same": false,
    "message": "completed sir",
    "messageType": "text",
  },
  {
    "user": "deepak",
    "same": false,
    "message": "i have updates the errors in ticket please check",
    "messageType": "text",
  },
  {
    "user": "me",
    "same": true,
    "message": "okay sir",
    "messageType": "text",
  },
  {
    "user": "me",
    "same": true,
    "message": "okay sir, working on it.",
    "messageType": "text",
  },
  {
    "user": "me",
    "same": true,
    "message": "done sir can u check now",
    "messageType": "text",
  },
  {
    "user": "deepak",
    "same": false,
    "message": "sure will update u shorlty",
    "messageType": "text",
  },
  {
    "user": "me",
    "same": true,
    "message": "okay",
    "messageType": "text",
  },
];

class Content extends StatefulWidget {
  const Content({super.key});
  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: animationStream,
        builder: (context, snapshot) {
          return Column(
            children: [
              SizedBox(height: 2),
              Row(
                children: [
                  SizedBox(width: 10),
                  ProfileIcon(
                    size: (isPhone) ? 15 : 20,
                    fontSize: 10,
                    name: "j",
                    color: Colors.cyan,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "deepak",
                    style: TextStyle(
                        color: DemoPallet.font1, fontSize: (isPhone) ? 12 : 14),
                  ),
                  if (isPhone)
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(child: SizedBox()),
                        SvgPicture.asset(
                          width: 15,
                          "assets/video_call.svg",
                          color: DemoPallet.font3,
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          width: 15,
                          "assets/phone.svg",
                          color: DemoPallet.font3,
                        ),
                        const SizedBox(width: 10),
                      ],
                    ))
                  else
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(child: SizedBox()),
                        SvgPicture.asset(
                          width: 15,
                          "assets/video_call.svg",
                          color: DemoPallet.font3,
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          width: 15,
                          "assets/phone.svg",
                          color: DemoPallet.font3,
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          width: 15,
                          "assets/audio.svg",
                          color: DemoPallet.font3,
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          width: 15,
                          "assets/image.svg",
                          color: DemoPallet.font3,
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          width: 15,
                          "assets/file.svg",
                          color: DemoPallet.font3,
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          width: 15,
                          "assets/search.svg",
                          color: DemoPallet.font3,
                        ),
                        const SizedBox(width: 20),
                      ],
                    ))
                  // ],)
                ],
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      for (var message in messages)
                        Row(
                          mainAxisAlignment: (message["user"] == "me")
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (message["user"] != "me" &&
                                    message["same"] == false)
                                  ProfileIcon(
                                    size: 15,
                                    fontSize: 10,
                                    name: "j",
                                    color: Colors.cyan,
                                  )
                                else
                                  SizedBox(
                                    width: 15,
                                  ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (message["user"] != "me" &&
                                        message["same"] == false)
                                      Text(
                                        "deepak",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    if (message["messageType"] == "text")
                                      Container(
                                        constraints: BoxConstraints(
                                            maxWidth: (isPhone) ? 100 : 200),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: DemoPallet.inner2,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          message["message"],
                                          style: TextStyle(
                                              color: DemoPallet.font1,
                                              fontSize: 10),
                                        ),
                                      )
                                    else if (message["messageType"] == "image")
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                          message["message"],
                                          width: (isPhone) ? 100 : 150,
                                          height: (isPhone) ? 100 : 150,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    else if (message["messageType"] == "emoji")
                                      Container(
                                        child: Emoji(
                                          size: 18,
                                          animation: message["animation"],
                                          emoji: message["message"],
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                    ],
                  ),
                ),
              ),
              if (typing)
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5),
                  child: Row(
                    children: [
                      ProfileIcon(
                        size: 15,
                        name: "deepak",
                        color: Colors.cyan,
                        fontSize: 10,
                      ),
                      SizedBox(width: 5),
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: RiveAnimation.asset(
                          'assets/typing.riv',
                        ),
                      )
                    ],
                  ),
                ),
              // if (typing)
              //   Container(
              //     height: 10,
              //     color: Colors.red,
              //   ),
              Container(
                margin: (isPhone)
                    ? EdgeInsets.symmetric(horizontal: 10)
                    : EdgeInsets.symmetric(horizontal: 20),
                // padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Icon(
                        Icons.emoji_emotions,
                        color: DemoPallet.font3,
                        size: 18,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: DemoPallet.inner2,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            TextField(
                                style: TextStyle(
                                    color: DemoPallet.font3, fontSize: 12),
                                onSubmitted: (value) {
                                  // chat.sendMessage(chat.message.text, "text");
                                },
                                onChanged: (value) {
                                  // server.get(data: {"0": "typing", "1": chat.selectedRoom["roomId"], "2": userId, "3": "typing"}, func: (data) {});
                                },
                                controller: message,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintStyle: TextStyle(
                                      color: DemoPallet.font3, fontSize: 12),
                                  border: InputBorder.none,
                                  hintText: 'Message',
                                )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (!isPhone)
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Icon(
                              Icons.mic,
                              color: DemoPallet.font3,
                              size: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Icon(
                              Icons.attach_file,
                              color: DemoPallet.font3,
                              size: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: GestureDetector(
                        onTap: () async {
                          // chat.sendMessage(chat.message.text, "text");
                        },
                        child: Icon(
                          Icons.send,
                          color: DemoPallet.font3,
                          size: 18,
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 5)
            ],
          );
        });
  }
}

class Emoji extends StatefulWidget {
  const Emoji(
      {super.key,
      required this.animation,
      required this.emoji,
      required this.size});
  final Map animation;
  final String emoji;
  final double size;
  @override
  State<Emoji> createState() => _EmojiState();
}

class _EmojiState extends State<Emoji> with TickerProviderStateMixin {
  LottieComposition? _composition;
  late final AnimationController _controller;
  ValueNotifier<bool> animate = ValueNotifier<bool>(false);

  @override
  void initState() {
    _controller = AnimationController(vsync: this);

    // if (widget.animate == true) {
    //   _animate();
    // }
    _animate();

    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    // if (widget.animate == true) {
    // _animate();
    // }
    super.didUpdateWidget(oldWidget);
  }

  _animate() async {
    // var animation = await anumation;
    var assetData = utf8.encode(json.encode(widget.animation));
    Uint8List byte = Uint8List.fromList(assetData);

    _composition =
        await LottieComposition.fromByteData(ByteData.sublistView(byte));
    _controller.clearListeners();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animate.value = false;
        _controller.reset();
      }
    });
    animate.value = true;
    _controller
      ..duration = _composition?.duration
      ..forward();
    ;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: animate,
        builder: (BuildContext context, bool shouldAnimate, Widget? child) {
          if (shouldAnimate == true) {
            return SizedBox(
              width: widget.size + (widget.size * 0.2),
              height: widget.size + (widget.size * 0.2),
              child: Lottie(
                composition: _composition,
                controller: _controller,
              ),
            );
          } else {
            return MouseRegion(
              onEnter: (details) {
                _animate();
              },
              child: Text(widget.emoji,
                  style: TextStyle(fontFamily: 'Noto', fontSize: widget.size)),
            );
          }
        });
  }
}
