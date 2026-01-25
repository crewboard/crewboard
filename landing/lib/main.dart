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
import 'package:particles_flutter/particles_flutter.dart';
import 'package:rive/rive.dart';

import 'demo/chat.dart';
import 'package:flutter/rendering.dart';
import 'types.dart';

class Event {
  String name;
  Function func;
  Event({required this.name, required this.func});
}

class Events {
  List<Event> registeredEvents = [];
  registerEvent(eventName, func) {
    bool exists = false;
    for (var event in registeredEvents) {
      if (event.name == eventName) {
        exists = true;
      }
    }
    if (!exists) {
      print("registered " + eventName);
      registeredEvents.add(Event(name: eventName, func: func));
    }
  }

  Events() {
    animationStream.listen((eventName) async {
      for (var event in registeredEvents) {
        if (event.name == eventName) {
          print("playing " + event.name);
          event.func();
        }
      }
    });
  }
}

Events events = Events();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
    Window.stageWidth = Window.width - Window.sideBarWidth;

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
      backgroundColor: Colors.black,
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
              Center(
                child: CircularParticle(
                  key: UniqueKey(),
                  awayRadius: 120,
                  numberOfParticles: 10,
                  speedOfParticles: 3,
                  height: Window.fullHeight,
                  width: Window.fullWidth,
                  onTapAnimation: false,
                  maxParticleSize: 300,
                  isRandSize: true,
                  isRandomColor: true,
                  randColorList: const [Color(0xFF49b3a7), Color(0xFFd865d8), Color(0xFF4de436)],
                  enableHover: false,
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  tileMode: TileMode.repeated,
                  sigmaX: 80,
                  sigmaY: 80,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
// class ParalaxBlock extends StatelessWidget {
//   const ParalaxBlock({super.key, required this.child});
//   final Widget child;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: Window.fullWidth,
//       height: Window.fullHeight,
//       child: Stack(children: [_buildParallaxBackground(context), Intro()]),
//     );

//   }

//   Widget _buildParallaxBackground(context) {
//     return Flow(
//       delegate: ParallaxFlowDelegate(
//         scrollable: Scrollable.of(context),
//         listItemContext: context,
//         backgroundImageKey: GlobalKey(),
//       ),
//       children: [
//         // Image.asset(
//         //   "login.jpg",
//         //   fit: BoxFit.cover,
//         // )
//         SizedBox(
//           key: ,
//           height: Window.fullHeight * 2,
//           width: Window.fullWidth,
//           child: Stack(
//             children: [
//               Center(
//                 child: CircularParticle(
//                   key: UniqueKey(),
//                   awayRadius: 120,
//                   numberOfParticles: 3,
//                   speedOfParticles: 3,
//                   height: Window.fullHeight,
//                   width: Window.fullWidth,
//                   onTapAnimation: false,
//                   maxParticleSize: 200,
//                   isRandSize: true,
//                   isRandomColor: true,
//                   randColorList: [Colors.red, Colors.yellow, Colors.blue],
//                   enableHover: true,
//                 ),
//               ),
//               BackdropFilter(
//                 filter: ImageFilter.blur(
//                   tileMode: TileMode.repeated,
//                   sigmaX: 100,
//                   sigmaY: 100,
//                 ),
//                 child: Container(
//                   color: Colors.black.withOpacity(0.5),
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }

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
          SvgPicture.asset(
            width: 35,
            "assets/kolab.svg",
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "kolab",
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
              Row(
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
                                  style: TextStyle(fontSize: 50, color: Pallet.font1),
                                  children: const <TextSpan>[
                                    TextSpan(
                                        text: 'Kolab ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                    TextSpan(text: 'is currently in beta stage'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Kolab is designed to protect ur data, own your data in your own servers. get the installation files and instructions right now!",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Button(
                                label: "request beta",
                                onPress: () {},
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Maintaining this project is however difficult without funds, we appriciate ur contribution in advance",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Button(
                                label: "support",
                                onPress: () {},
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Kolab is an all in one solution for, planning, managing and coordinating. Befriend Kolab through out the whole process of project managment",
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Button(
                                label: "see whats kolab",
                                onPress: () async {
                                  await Future.delayed(const Duration(milliseconds: 500));
                                  eventSink.add("open_mail");
                                },
                              ),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                        constraints: BoxConstraints(maxHeight: Window.fullHeight * 0.8),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPage()));
            // } else if (name == "developer") {
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => Developer()));
            // }
          },
          child: Opacity(opacity: 0.5, child: Text(name))),
    ).animate().slideX(duration: Duration(seconds: 2), begin: 1, end: 0).fade(duration: Duration(seconds: 2));
  }
}

class Button extends StatelessWidget {
  const Button({super.key, required this.label, required this.onPress});
  final String label;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.25), borderRadius: BorderRadius.circular(15)),
        // decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(15)),
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
