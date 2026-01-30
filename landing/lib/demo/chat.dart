import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:landing/demo/animation.dart';
import 'package:lottie/lottie.dart';

import 'package:rive/rive.dart' hide LinearGradient;
import 'package:visibility_detector/visibility_detector.dart';

import '../types.dart';
import '../widgets.dart';

// DemoPallet has been moved to types.dart

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
            curve: Curves.fastOutSlowIn,
          );

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
          messages.add({
            "user": "deepak",
            "same": false,
            "message": "that looks cool!",
            "messageType": "text",
          });
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
            curve: Curves.fastOutSlowIn,
          );

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          messages.add({
            "user": "deepak",
            "same": true,
            "message": "😎",
            "animation": coolAnimated,
            "messageType": "emoji",
          });
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
            curve: Curves.fastOutSlowIn,
          );

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
          'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible',
        );
      },
      child: SizedBox(
        width: Window.fullWidth,
        height: Window.fullHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (Window.isMobile)
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: FittedBox(
                            child: Animate(
                              controller: _controller,
                              effects: [
                                ScaleEffect(
                                  duration: Duration(milliseconds: 1000),
                                ),
                                FadeEffect(
                                  duration: Duration(milliseconds: 1000),
                                ),
                              ],
                              child: DeskTopToPhone(
                                height: Window.fullHeight * 0.85,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: Window.fullWidth * 0.9,
                        child: Animate(
                          controller: _controller,
                          effects: const [
                            SlideEffect(duration: Duration(milliseconds: 1000)),
                            FadeEffect(duration: Duration(milliseconds: 1000)),
                          ],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Seamless chatting with team mates",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "responsive design",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
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
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      // decoration:
                                      //     BoxDecoration(borderRadius: BorderRadius.circular(10), color: Pallet.inner2),
                                      child: Icon(
                                        Icons.desktop_mac_outlined,
                                        color: isPhone
                                            ? Pallet.font2
                                            : Colors.blue[100],
                                      ),
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
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
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
                              Text(
                                "supports all themes",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 10),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: AppTheme.values.map((theme) {
                                  return ThemePreview(
                                    theme: theme,
                                    isSelected:
                                        DemoPallet.currentTheme == theme,
                                    onTap: () {
                                      DemoPallet.setTheme(theme);
                                      setState(() {});
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            width: Window.fullWidth * 0.3,
                            child: Animate(
                              controller: _controller,
                              effects: const [
                                SlideEffect(
                                  duration: Duration(milliseconds: 1000),
                                ),
                                FadeEffect(
                                  duration: Duration(milliseconds: 1000),
                                ),
                              ],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Seamless chatting with team mates",
                                    style: TextStyle(
                                      fontSize: 50,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "responsive design",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
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
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            color: Colors.grey.withOpacity(0.2),
                                          ),
                                          // decoration:
                                          //     BoxDecoration(borderRadius: BorderRadius.circular(10), color: Pallet.inner2),
                                          child: Icon(
                                            Icons.desktop_mac_outlined,
                                            color: isPhone
                                                ? Pallet.font2
                                                : Colors.blue[100],
                                          ),
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
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            color: Colors.grey.withOpacity(0.2),
                                          ),
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
                                  Text(
                                    "supports all themes",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: AppTheme.values.map((theme) {
                                      return ThemePreview(
                                        theme: theme,
                                        isSelected:
                                            DemoPallet.currentTheme == theme,
                                        onTap: () {
                                          DemoPallet.setTheme(theme);
                                          setState(() {});
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Animate(
                            controller: _controller,
                            effects: [
                              ScaleEffect(
                                duration: Duration(milliseconds: 1000),
                              ),
                              FadeEffect(
                                duration: Duration(milliseconds: 1000),
                              ),
                            ],
                            child: DeskTopToPhone(
                              height: (isPhone)
                                  ? Window.fullHeight * 0.8
                                  : Window.fullHeight * 0.5,
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 50)
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class ThemePreview extends StatelessWidget {
  final AppTheme theme;
  final bool isSelected;
  final VoidCallback onTap;

  const ThemePreview({
    super.key,
    required this.theme,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color previewBg;
    Color previewAccent;
    bool isGlass;
    String name;

    switch (theme) {
      case AppTheme.glassDark:
        previewBg = Colors.black.withOpacity(0.3);
        previewAccent = Colors.white.withOpacity(0.2);
        isGlass = true;
        name = "Glass Dark";
        break;
      case AppTheme.glassLight:
        previewBg = Colors.white.withOpacity(0.3);
        previewAccent = Colors.black.withOpacity(0.1);
        isGlass = true;
        name = "Glass Light";
        break;
      case AppTheme.classicLight:
        previewBg = Colors.white;
        previewAccent = Colors.grey.shade200;
        isGlass = false;
        name = "Classic Light";
        break;
      case AppTheme.classicDark:
        previewBg = const Color(0xFF1E1E1E);
        previewAccent = const Color(0xFF2D2D2D);
        isGlass = false;
        name = "Classic Dark";
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 80,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected
                      ? Colors.blue
                      : Colors.grey.withOpacity(0.3),
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  if (isGlass) ...[
                    if (theme == AppTheme.glassLight)
                      Positioned.fill(child: Container(color: Colors.white)),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: theme == AppTheme.glassDark
                                ? [
                                    const Color(0xFF002772),
                                    const Color(0xFF5c0057),
                                  ]
                                : [
                                    const Color(0xFFb3d1ff),
                                    const Color(0xFFe6ccff),
                                  ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: theme == AppTheme.glassDark
                              ? Colors.black.withOpacity(0.5)
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ] else ...[
                    Positioned.fill(child: Container(color: previewBg)),
                  ],
                  Positioned(
                    top: 10,
                    left: 5,
                    child: Container(
                      width: 20,
                      height: 4,
                      decoration: BoxDecoration(
                        color: previewAccent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 18,
                    left: 5,
                    child: Container(
                      width: 30,
                      height: 4,
                      decoration: BoxDecoration(
                        color: previewAccent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? Colors.blue : Colors.black54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
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
      if (mounted) setState(() {});
    });
    events.registerEvent("show_desktop", () {
      mult = 1.5; // Increased from 1.25 for better widescreen
      borderRadius = 5;
      isPhone = false;
      if (mounted) setState(() {});
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
    } else {
      mult = 1.5; // Increased from 1.25
      borderRadius = 5;
      isPhone = false;
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
                      color: Colors.black,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius),
                        color: DemoPallet.background,
                      ),
                      child: DemoBackground(
                        borderRadius: borderRadius,
                        blurSigma: 25,
                        child: Column(
                          children: [
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
                                      color: Colors.black,
                                    ),
                                  ),
                              ],
                            ),
                            Expanded(child: Content()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (!isPhone)
                  Container(
                    height: 25, // Reduced from 40
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (!isPhone)
            Container(
              width: 80,
              height: 40, // Reduced from 60
              decoration: BoxDecoration(color: Colors.black),
            ),
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
  {"user": "me", "same": false, "message": "okay sir", "messageType": "text"},
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
  {"user": "me", "same": true, "message": "okay sir", "messageType": "text"},
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
  {"user": "me", "same": true, "message": "okay", "messageType": "text"},
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
                    color: DemoPallet.font1,
                    fontSize: (isPhone) ? 12 : 14,
                  ),
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
                    ),
                  )
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
                    ),
                  ),
                // ],)
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
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
                                SizedBox(width: 15),
                              SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (message["user"] != "me" &&
                                      message["same"] == false)
                                    Text(
                                      "deepak",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: DemoPallet.font1,
                                      ),
                                    ),
                                  SizedBox(height: 5),
                                  if (message["messageType"] == "text")
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: (isPhone) ? 100 : 200,
                                      ),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: DemoPallet.inner2,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        message["message"],
                                        style: TextStyle(
                                          color: DemoPallet.font1,
                                          fontSize: 10,
                                        ),
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
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
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
                      child: RiveAnimation.asset('assets/typing.riv'),
                    ),
                  ],
                ),
              ),
            // if (typing)
            //   Container(
            //     height: 10,
            //     color: Colors.red,
            //   ),
            Builder(
              builder: (context) {
                final bool isSmall = isPhone || Window.isMobile;
                return Container(
                  margin: (isSmall)
                      ? EdgeInsets.symmetric(horizontal: 10)
                      : EdgeInsets.symmetric(horizontal: 20),
                  // padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Icon(
                          Icons.emoji_emotions,
                          color: DemoPallet.font3,
                          size: isSmall ? 15 : 18,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: DemoPallet.inner2,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: [
                              TextField(
                                style: TextStyle(
                                  color: DemoPallet.font3,
                                  fontSize: isSmall ? 10 : 12,
                                ),
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
                                    color: DemoPallet.font3,
                                    fontSize: isSmall ? 10 : 12,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Message',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      if (!isSmall)
                        Row(
                          children: [
                            const SizedBox(width: 5),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Icon(
                                Icons.mic,
                                color: DemoPallet.font3,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Icon(
                                Icons.attach_file,
                                color: DemoPallet.font3,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: GestureDetector(
                          onTap: () async {
                            // chat.sendMessage(chat.message.text, "text");
                          },
                          child: Icon(
                            Icons.send,
                            color: DemoPallet.font3,
                            size: isSmall ? 15 : 18,
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   width: 10,
                      // ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 5),
          ],
        );
      },
    );
  }
}

class Emoji extends StatefulWidget {
  const Emoji({
    super.key,
    required this.animation,
    required this.emoji,
    required this.size,
  });
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

    _composition = await LottieComposition.fromByteData(
      ByteData.sublistView(byte),
    );
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
            child: Lottie(composition: _composition, controller: _controller),
          );
        } else {
          return MouseRegion(
            onEnter: (details) {
              _animate();
            },
            child: Text(
              widget.emoji,
              style: TextStyle(fontFamily: 'Noto', fontSize: widget.size),
            ),
          );
        }
      },
    );
  }
}
