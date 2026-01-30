import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:landing/demo/demo.dart';
import 'package:landing/demo/flowie.dart';
import 'package:landing/demo/planner.dart';
import 'package:landing/payments.dart';
// import 'package:landing/planner/main.dart';
// import 'package:landing/chat/main.dart';
import 'package:landing/widgets.dart';
// import 'package:visibility_detector/visibility_detector.dart';
import 'package:lottie/lottie.dart';

import 'package:rive/rive.dart';

import 'demo/chat.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'types.dart';

void main() {
  Pallet.lightMode();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crewboard',
      theme: ThemeData(
        textTheme: GoogleFonts.ubuntuTextTheme(TextTheme(
          displayMedium: TextStyle(color: Pallet.font1),
          displayLarge: TextStyle(color: Pallet.font1),
          bodyMedium: TextStyle(color: Pallet.font1),
          bodyLarge: TextStyle(color: Pallet.font1),
          titleMedium: TextStyle(color: Pallet.font1),
        )),
        iconTheme: IconThemeData(color: Pallet.font2),
      ),
      home: const MyHomePage(title: 'Crewboard Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Window.fullWidth = MediaQuery.of(context).size.width;
    Window.fullHeight = MediaQuery.of(context).size.height;

    Window.width = Window.fullWidth * 0.9;
    Window.height = Window.fullHeight * 0.9;
    Window.stageWidth =
        Window.isMobile ? Window.width : Window.width - Window.sideBarWidth;

    return LandingPage();
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  double lastOffset = 0;
  bool scrolled = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ParalaxBlock(child: Intro()),
          ],
        ),
      ),
    );
  }
}

class ParalaxBlock extends StatefulWidget {
  const ParalaxBlock({super.key, required this.child});
  final Widget child;

  @override
  State<ParalaxBlock> createState() => _ParalaxBlockState();
}

class _ParalaxBlockState extends State<ParalaxBlock> {
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Window.fullWidth,
      height: Window.fullHeight * 4,
      child: Stack(children: [
        _buildParallaxBackground(context),
        Column(
          children: [
            Intro(),
            ChatDemo(),
            FlowieDemo(),
            PlannerDemo(),
          ],
        )
      ]),
    );
  }

  Widget _buildParallaxBackground(context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        SizedBox(
          key: _backgroundImageKey,
          height: Window.fullHeight * 8,
          width: Window.fullWidth,
          child: Stack(
            children: [
              Container(
                color: Colors.white,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Image.asset(
            width: 35,
            "assets/logo.png",
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Crewboard",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: SizedBox(),
          ),
          // Link(
          //   name: "home",
          // ),
          // Link(
          //   name: "developer",
          // ),
          // Link(
          //   name: "download",
          // ),
          SizedBox(width: 15)
        ],
      ),
    );
  }
}

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TopBar(),
        SizedBox(
          // color: Pallet.background,
          height: Window.fullHeight - 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (Window.isMobile)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              maxHeight: Window.fullHeight * 0.4),
                          child: Image.asset("assets/kollab_landing.png"),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: Window.fullWidth * 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: '',
                                  style: TextStyle(
                                      fontSize: 30, color: Pallet.font1),
                                  children: const <TextSpan>[
                                    TextSpan(
                                        text: 'Crewboard ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                    TextSpan(
                                        text: 'is currently in beta stage'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Crewboard is opensource, which means you own your data in your own servers. start contributing to or using crewboard now!",
                                style: GoogleFonts.openSans(
                                    textStyle:
                                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Button(
                                label: "go to github",
                                icon: SvgPicture.string(
                                  '<svg height="20" width="20" viewBox="0 0 16 16"><path fill="white" d="M8 0c4.42 0 8 3.58 8 8a8.013 8.013 0 0 1-5.45 7.59c-.4.08-.55-.17-.55-.38 0-.27.01-1.13.01-2.2 0-.75-.25-1.23-.54-1.48 1.78-.2 3.65-.88 3.65-3.95 0-.88-.31-1.59-.82-2.15.08-.2.36-1.02-.08-2.12 0 0-.67-.22-2.2.82-.64-.18-1.32-.27-2-.27-.68 0-1.36.09-2 .27-1.53-1.03-2.2-.82-2.2-.82-.44 1.1-.16 1.92-.08 2.12-.51.56-.82 1.28-.82 2.15 0 3.06 1.86 3.75 3.64 3.95-.23.2-.44.55-.51 1.07-.46.21-1.61.55-2.33-.66-.15-.24-.6-.83-1.23-.82-.67.01-.27.38.01.53.34.19.73.9.82 1.13.16.45.68 1.31 2.69.94 0 .67.01 1.3.01 1.49 0 .21-.15.45-.55.38A7.995 7.995 0 0 1 0 8c0-4.42 3.58-8 8-8Z"/></svg>',
                                  width: 18,
                                  height: 18,
                                ),
                                onPress: () async {
                                  final Uri url = Uri.parse(
                                      'https://github.com/crewboard/crewboard');
                                  if (!await launchUrl(url)) {
                                    throw Exception('Could not launch $url');
                                  }
                                },
                                color: Color(0xFF24292F),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: SizedBox(
                                width: Window.fullWidth * 0.3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: '',
                                        style: TextStyle(
                                            fontSize: 45, color: Pallet.font1),
                                        children: const <TextSpan>[
                                          TextSpan(
                                              text: 'Crewboard ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              )),
                                          TextSpan(
                                              text: 'is currently in beta stage'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 80,
                                    ),
                                    Text(
                                      "Crewboard is opensource, which means you own your data in your own servers. start contributing to or using crewboard now!",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Button(
                                      label: "go to github",
                                      icon: SvgPicture.string(
                                        '<svg height="20" width="20" viewBox="0 0 16 16"><path fill="white" d="M8 0c4.42 0 8 3.58 8 8a8.013 8.013 0 0 1-5.45 7.59c-.4.08-.55-.17-.55-.38 0-.27.01-1.13.01-2.2 0-.75-.25-1.23-.54-1.48 1.78-.2 3.65-.88 3.65-3.95 0-.88-.31-1.59-.82-2.15.08-.2.36-1.02-.08-2.12 0 0-.67-.22-2.2.82-.64-.18-1.32-.27-2-.27-.68 0-1.36.09-2 .27-1.53-1.03-2.2-.82-2.2-.82-.44 1.1-.16 1.92-.08 2.12-.51.56-.82 1.28-.82 2.15 0 3.06 1.86 3.75 3.64 3.95-.23.2-.44.55-.51 1.07-.46.21-1.61.55-2.33-.66-.15-.24-.6-.83-1.23-.82-.67.01-.27.38.01.53.34.19.73.9.82 1.13.16.45.68 1.31 2.69.94 0 .67.01 1.3.01 1.49 0 .21-.15.45-.55.38A7.995 7.995 0 0 1 0 8c0-4.42 3.58-8 8-8Z"/></svg>',
                                        width: 18,
                                        height: 18,
                                      ),
                                      onPress: () async {
                                        final Uri url = Uri.parse(
                                            'https://github.com/crewboard/crewboard');
                                        if (!await launchUrl(url)) {
                                          throw Exception('Could not launch $url');
                                        }
                                      },
                                      color: Color(0xFF24292F),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Container(
                              constraints: BoxConstraints(
                                  maxHeight: Window.fullHeight * 0.8),
                              child: Image.asset("assets/kollab_landing.png"),
                            )),
                      ],
                    ),
            ],
          ),
        ),
      ],
    );
  }
}

class Link extends StatelessWidget {
  const Link({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
          onTap: () {
            // if (name == "home") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LandingPage()));
            // } else if (name == "developer") {
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Developer()));
            // }
          },
          child: Opacity(opacity: 0.5, child: Text(name))),
    )
        .animate()
        .slideX(duration: Duration(seconds: 2), begin: 1, end: 0)
        .fade(duration: Duration(seconds: 2));
  }
}

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.label,
      required this.onPress,
      this.color,
      this.icon,
      this.textColor});
  final String label;
  final Function onPress;
  final Color? color;
  final Color? textColor;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        decoration: BoxDecoration(
            color: color ?? Color(0xFF2196F3),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 10),
            ],
            Text(
              label,
              style: TextStyle(color: textColor ?? Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
