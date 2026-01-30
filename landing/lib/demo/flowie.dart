import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' as an;
import 'package:landing/touchable/src/canvas_touch_detector.dart';
import 'package:landing/touchable/src/touchy_canvas.dart';
import 'package:lottie/lottie.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:math' as math;
import 'dart:math';

import 'types.dart';
import '../types.dart';
import '../widgets.dart';
import 'dart:math' as math;

GlobalKey screenKey = GlobalKey();
double mouseX = 0;
double mouseY = 0;

class FlowieDemo extends StatefulWidget {
  const FlowieDemo({super.key});

  @override
  State<FlowieDemo> createState() => _FlowieDemoState();
}

class _FlowieDemoState extends State<FlowieDemo> with TickerProviderStateMixin {
  bool playing = false;
  bool played = false;
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    themeChangeStream.listen((event) {
      if (mounted) setState(() {});
    });

    events.registerEvent("show_flowie", () async {
      if (!playing) {
        playing = true;
        while (playing) {
          print("started");
          await Future.delayed(const Duration(milliseconds: 200));
          RenderBox renderBox =
              screenKey.currentContext!.findRenderObject() as RenderBox;
          final double scale = Window.isMobile ? 0.5 : 1.0;
          Window.stageWidth = renderBox.size.width / scale;

          if (!playing) {
            break;
          }
          await selectFlowType(0);

          // lamp doesnt work
          flowie.addFlow(FlowType.terminal);
          flowie.flows[0].width = 120;
          flowie.flows[0].height = 30;
          flowie.update();
          Window.mode = "edit";
          animationSink.add("");
          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));
          if (!playing) {
            break;
          }
          await selectText();
          if (!playing) {
            break;
          }
          await typeValue("lamp doesn't work", 0);
          if (!playing) {
            break;
          }
          await selectBottomNode();
          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));
          Window.mode = "add";
          animationSink.add("");
          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));
          if (!playing) {
            break;
          }
          await selectFlowType(85);

          // lamp lamp pluged in?
          Ram.selectedId = 0;
          Ram.selectedDirection = Direction.down;

          flowie.addFlow(FlowType.condition);
          flowie.flows[1].width = 100;
          flowie.flows[1].height = 100;
          flowie.update();
          Window.mode = "edit";
          animationSink.add("");
          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));
          if (!playing) {
            break;
          }
          await selectText();
          if (!playing) {
            break;
          }
          await typeValue("lamp plugged in?", 1);
          if (!playing) {
            break;
          }

          await selectBottomNode();
          Window.mode = "add";
          animationSink.add("");

          await Future.delayed(const Duration(milliseconds: 500));
          if (!playing) {
            break;
          }
          await selectFlowType(85);
          if (!playing) {
            break;
          }
          // lamp lamp pluged in?
          Ram.selectedId = 1;
          Ram.selectedDirection = Direction.down;

          flowie.addFlow(FlowType.condition);
          flowie.flows[2].width = 100;
          flowie.flows[2].height = 100;
          flowie.update();
          Window.mode = "edit";
          animationSink.add("");
          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));
          if (!playing) {
            break;
          }
          await selectText();
          if (!playing) {
            break;
          }
          await typeValue("bulb burned out?", 2);
          if (!playing) {
            break;
          }
          await selectRightNode(1);

          await Future.delayed(const Duration(milliseconds: 500));
          Window.mode = "add";
          animationSink.add("");
          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));
          if (!playing) {
            break;
          }
          await selectFlowType(50);

          // plug in lamp
          Ram.selectedId = 1;
          Ram.selectedDirection = Direction.right;

          flowie.addFlow(FlowType.process);
          flowie.flows[2].width = 100;
          flowie.flows[3].height = 30;
          flowie.update();
          Window.mode = "edit";
          animationSink.add("");
          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          if (!playing) {
            break;
          }
          await selectText();
          if (!playing) {
            break;
          }
          await typeValue("plug in lamp", 3);
          if (!playing) {
            break;
          }

          await selectBottomNode();
          if (!playing) {
            break;
          }

          await Future.delayed(const Duration(milliseconds: 500));
          Window.mode = "add";
          animationSink.add("");
          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));
          if (!playing) {
            break;
          }
          await selectFlowType(50);

          // repair lamp
          Ram.selectedId = 2;
          Ram.selectedDirection = Direction.down;

          flowie.addFlow(FlowType.process);
          flowie.flows[4].width = 100;
          flowie.flows[4].height = 30;
          flowie.update();
          Window.mode = "edit";
          animationSink.add("");
          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));
          if (!playing) {
            break;
          }

          await selectText();
          if (!playing) {
            break;
          }
          await typeValue("repair lamp", 4);
          if (!playing) {
            break;
          }

          selectRightNode(2);
          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          Window.mode = "add";
          animationSink.add("");
          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));
          if (!playing) {
            break;
          }
          await selectFlowType(50);

          // replace bulb
          Ram.selectedId = 2;
          Ram.selectedDirection = Direction.right;

          flowie.addFlow(FlowType.process);
          flowie.flows[5].width = 100;
          flowie.flows[5].height = 30;
          flowie.update();
          Window.mode = "edit";
          animationSink.add("");
          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));
          if (!playing) {
            break;
          }
          await selectText();
          if (!playing) {
            break;
          }
          await typeValue("replace bulb", 5);
          if (!playing) {
            break;
          }

          await Future.delayed(const Duration(seconds: 2));
          if (!playing) {
            break;
          }
          flowie.flows.clear();
          Ram.selectedId = null;
          Ram.selectedDirection = null;
          Window.mode = "add";
          mouseX = 0;
          mouseY = 0;
          animationSink.add("");
        }
        print("stoped flowie");
      }
    });

    events.registerEvent("stop_flowie", () async {
      print("stopping");
      playing = false;
      flowie.flows.clear();
      Ram.selectedId = null;
      Ram.selectedDirection = null;
      Window.mode = "add";
      mouseX = 0;
      mouseY = 0;
      animationSink.add("");
      // setState(() {});
    });

    super.initState();
  }

  selectRightNode(int idx) {
    final double scale = Window.isMobile ? 0.5 : 1.0;
    mouseX =
        flowie.flows[idx].x +
        flowie.flows[idx].width +
        flowie.flows[idx].right.lineHeight;
    mouseY = flowie.flows[idx].y + flowie.flows[idx].height / 2;
    mouseX -= 23 / scale;
    mouseY -= 8 / scale;
    animationSink.add("");
  }

  selectBottomNode() async {
    final double scale = Window.isMobile ? 0.5 : 1.0;
    mouseY = 0;
    for (var flow in flowie.flows) {
      if ((flow.y + flow.height + flow.down.lineHeight) > mouseY) {
        mouseX = flow.x + flow.width / 2;
        mouseY = (flow.y + flow.height + flow.down.lineHeight);
      }
    }
    mouseY -= 8 / scale;
    mouseX -= 25 / scale;
    animationSink.add("");

    await Future.delayed(const Duration(milliseconds: 500));
  }

  typeValue(String value, int idx) async {
    flowie.flows[idx].value = "";

    for (var char in value.characters) {
      Random random = Random();

      await Future.delayed(Duration(milliseconds: random.nextInt(150)));
      flowie.flows[idx].value += char;
      animationSink.add("");
    }
    await Future.delayed(const Duration(milliseconds: 500));
  }

  selectFlowType(double adder) async {
    mouseX = Window.stageWidth - (Window.isMobile ? 140 : 120);
    mouseY = (Window.isMobile ? 30 : 20) + adder;
    animationSink.add("");
    await Future.delayed(const Duration(milliseconds: 500));
    animationSink.add("");
  }

  selectText() async {
    mouseX = Window.stageWidth - (Window.isMobile ? 180 : 165);
    mouseY = 90;
    animationSink.add("");
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('flowie'),
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
            animationSink.add("stop_chat");
            animationSink.add("stop_planner");

            animationSink.add("show_flowie");
            _controller.forward();
          }
        } else {
          if (visiblePercentage < 40) {
            print("requested stop flowie");
            animationSink.add("stop_flowie");

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
            Builder(
              builder: (context) {
                final double scale = Window.isMobile ? 0.5 : 1.0;
                return (Window.isMobile)
                    ? Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            width: Window.fullWidth,
                            constraints: BoxConstraints(
                              maxHeight: Window.fullHeight * 0.4,
                            ),
                            child: StreamBuilder<Object>(
                              stream: animationStream,
                              builder: (context, snapshot) {
                                return an.Animate(
                                  controller: _controller,
                                  effects: const [
                                    an.ScaleEffect(
                                      duration: Duration(milliseconds: 1000),
                                    ),
                                    an.FadeEffect(
                                      duration: Duration(milliseconds: 1000),
                                    ),
                                  ],
                                  child: Container(
                                    key: screenKey,
                                    decoration: BoxDecoration(
                                      color: DemoPallet.background,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: Window.fullHeight * 0.5,
                                    // width: 691.2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: DemoBackground(
                                        child: Stack(
                                          children: [
                                            Lines(),
                                            for (var flow in flowie.flows)
                                              if (flow.type ==
                                                  FlowType.terminal)
                                                Positioned(
                                                  left: flow.x * scale,
                                                  top: flow.y * scale,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // selectFlow(flow.id, flow.direction!, flow.type);
                                                    },
                                                    child: Terminal(
                                                      width: flow.width,
                                                      height: flow.height,
                                                      label: flow.value,
                                                    ),
                                                  ),
                                                )
                                              else if (flow.type ==
                                                  FlowType.process)
                                                Positioned(
                                                  left: flow.x * scale,
                                                  top: flow.y * scale,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // selectFlow(flow.id, flow.direction!, flow.type);
                                                    },
                                                    child: Process(
                                                      width: flow.width,
                                                      height: flow.height,
                                                      label: flow.value,
                                                    ),
                                                  ),
                                                )
                                              else if (flow.type ==
                                                  FlowType.condition)
                                                Positioned(
                                                  left: flow.x * scale,
                                                  top: flow.y * scale,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // selectFlow(flow.id, flow.direction!, flow.type);
                                                    },
                                                    child: Condition(
                                                      width: flow.width,
                                                      height: flow.width,
                                                      label: flow.value,
                                                    ),
                                                  ),
                                                ),
                                            if (Window.mode == "edit")
                                              Positioned(
                                                right: 5,
                                                top: 5,
                                                child: EditFlow(),
                                              )
                                            else
                                              Positioned(
                                                right: 5,
                                                top: 5,
                                                child: AddFlow(),
                                              ),
                                            AnimatedPositioned(
                                              duration: const Duration(
                                                milliseconds: 200,
                                              ),
                                              top: mouseY * scale,
                                              left: mouseX * scale,
                                              child: SizedBox(
                                                width: 50,
                                                height: 30,
                                                // color: Colors.red,
                                                child: Lottie.asset(
                                                  'assets/white_select.json',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: SizedBox(
                              width: Window.fullWidth * 0.9,
                              child: an.Animate(
                                controller: _controller,
                                effects: const [
                                  an.SlideEffect(
                                    duration: Duration(milliseconds: 1500),
                                  ),
                                  an.FadeEffect(
                                    duration: Duration(milliseconds: 1500),
                                  ),
                                ],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Make sure no flow is left untouched with flowie",
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              width: 15,
                                              height: 15,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                  color: Colors.red,
                                                  width: 3,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              width: 15,
                                              height: 15,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.yellow,
                                                  width: 3,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              width: 15,
                                              height: 15,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.blue,
                                                  width: 3,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "terminal",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                fontFamily:
                                                    DemoPallet.fontFamily,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "condition",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                fontFamily:
                                                    DemoPallet.fontFamily,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "process",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                fontFamily:
                                                    DemoPallet.fontFamily,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          SizedBox(width: Window.fullWidth * 0.1),
                          Expanded(
                            child: StreamBuilder<Object>(
                              stream: animationStream,
                              builder: (context, snapshot) {
                                return an.Animate(
                                  controller: _controller,
                                  effects: const [
                                    an.ScaleEffect(
                                      duration: Duration(milliseconds: 1000),
                                    ),
                                    an.FadeEffect(
                                      duration: Duration(milliseconds: 1000),
                                    ),
                                  ],
                                  child: Container(
                                    key: screenKey,
                                    decoration: BoxDecoration(
                                      color: DemoPallet.background,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: Window.fullHeight * 0.5,
                                    // width: 691.2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: DemoBackground(
                                        child: Stack(
                                          children: [
                                            Lines(),
                                            for (var flow in flowie.flows)
                                              if (flow.type ==
                                                  FlowType.terminal)
                                                Positioned(
                                                  left: flow.x * scale,
                                                  top: flow.y * scale,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // selectFlow(flow.id, flow.direction!, flow.type);
                                                    },
                                                    child: Terminal(
                                                      width: flow.width,
                                                      height: flow.height,
                                                      label: flow.value,
                                                    ),
                                                  ),
                                                )
                                              else if (flow.type ==
                                                  FlowType.process)
                                                Positioned(
                                                  left: flow.x * scale,
                                                  top: flow.y * scale,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // selectFlow(flow.id, flow.direction!, flow.type);
                                                    },
                                                    child: Process(
                                                      width: flow.width,
                                                      height: flow.height,
                                                      label: flow.value,
                                                    ),
                                                  ),
                                                )
                                              else if (flow.type ==
                                                  FlowType.condition)
                                                Positioned(
                                                  left: flow.x * scale,
                                                  top: flow.y * scale,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // selectFlow(flow.id, flow.direction!, flow.type);
                                                    },
                                                    child: Condition(
                                                      width: flow.width,
                                                      height: flow.width,
                                                      label: flow.value,
                                                    ),
                                                  ),
                                                ),
                                            if (Window.mode == "edit")
                                              Positioned(
                                                right: 5,
                                                top: 5,
                                                child: EditFlow(),
                                              )
                                            else
                                              Positioned(
                                                right: 5,
                                                top: 5,
                                                child: AddFlow(),
                                              ),
                                            AnimatedPositioned(
                                              duration: const Duration(
                                                milliseconds: 200,
                                              ),
                                              top: mouseY * scale,
                                              left: mouseX * scale,
                                              child: SizedBox(
                                                width: 50,
                                                height: 30,
                                                // color: Colors.red,
                                                child: Lottie.asset(
                                                  'assets/white_select.json',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: SizedBox(
                                width: Window.fullWidth * 0.3,
                                child: an.Animate(
                                  controller: _controller,
                                  effects: const [
                                    an.SlideEffect(
                                      duration: Duration(milliseconds: 1500),
                                    ),
                                    an.FadeEffect(
                                      duration: Duration(milliseconds: 1500),
                                    ),
                                  ],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Make sure no flow is left untouched with flowie",
                                        style: TextStyle(
                                          fontSize: 45,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                width: 15,
                                                height: 15,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                    color: Colors.red,
                                                    width: 3,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              Container(
                                                width: 15,
                                                height: 15,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.yellow,
                                                    width: 3,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              Container(
                                                width: 15,
                                                height: 15,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.blue,
                                                    width: 3,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "terminal",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54,
                                                  fontFamily:
                                                      DemoPallet.fontFamily,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                "condition",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54,
                                                  fontFamily:
                                                      DemoPallet.fontFamily,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                "process",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54,
                                                  fontFamily:
                                                      DemoPallet.fontFamily,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Lines extends StatefulWidget {
  const Lines({super.key});

  @override
  State<Lines> createState() => _LinesState();
}

class _LinesState extends State<Lines> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Window.stageWidth,
      height: Window.height,
      child: CanvasTouchDetector(
        builder: (context1) {
          return CustomPaint(painter: LinePainter2(context1));
        },
      ),
    );
  }
}

class LinePainter2 extends CustomPainter {
  final BuildContext context;
  LinePainter2(this.context); // context from CanvasTouchDetector

  @override
  void paint(Canvas canvas, Size size) {
    var myCanvas = TouchyCanvas(context, canvas);
    var paint = Paint()
      ..color = DemoPallet.font1
      ..strokeWidth = 1;

    final double scale = Window.isMobile ? 0.5 : 1.0;

    final textStyle = TextStyle(
      color: DemoPallet.font1,
      fontSize: 11 * scale,
      fontFamily: DemoPallet.fontFamily,
    );
    final yesp = TextPainter(
      text: TextSpan(text: 'yes', style: textStyle),
      textDirection: TextDirection.ltr,
    );
    yesp.layout(minWidth: 0, maxWidth: 20 * scale);
    final nop = TextPainter(
      text: TextSpan(text: 'no', style: textStyle),
      textDirection: TextDirection.ltr,
    );
    nop.layout(minWidth: 0, maxWidth: size.width);
    Offset start = Offset(0, 0);
    Offset end = Offset(0, 0);
    final paintText = (text, off, r) {
      if (r == true) {
        canvas.save();
        canvas.translate(off.dx, off.dy);
        canvas.rotate(90 * math.pi / 180);
        canvas.translate(-off.dx, -off.dy);
        if (text == 'yes') {
          yesp.paint(canvas, off);
        } else {
          nop.paint(canvas, off);
        }
        canvas.restore();
      } else {
        if (text == 'yes') {
          yesp.paint(canvas, off);
        } else {
          nop.paint(canvas, off);
        }
      }
    };
    flowie.update();

    for (var flow in flowie.flows) {
      if (!(flow.type == FlowType.condition &&
          flow.left.hasChild &&
          flow.right.hasChild)) {
        start = Offset(
          (flow.x * scale) + (flow.width * scale) / 2,
          (flow.y * scale) + (flow.height * scale),
        );
        end = Offset(
          (flow.x * scale) + (flow.width * scale) / 2,
          (flow.y * scale) +
              (flow.height * scale) +
              flow.down.lineHeight * scale,
        );
        canvas.drawLine(start, end, paint);
        if (!flow.down.hasChild) {
          myCanvas.drawCircle(
            end,
            3 * scale,
            paint,
            onTapDown: (tapdetail) {
              Window.mode = "add";
              Ram.selectedId = flow.id;
              Ram.selectedDirection = Direction.down;
              flowie.save();
              refreshSink.add("");
            },
          );
        }
      }

      if (flow.type == FlowType.condition) {
        // right

        if (flow.direction != Direction.left &&
            !(flow.down.hasChild && flow.left.hasChild)) {
          start = Offset(
            (flow.x * scale) + (flow.width * scale),
            (flow.y * scale) + (flow.height * scale) / 2,
          );
          end = Offset(
            (flow.x * scale) +
                (flow.width * scale) +
                flow.right.lineHeight * scale,
            (flow.y * scale) + (flow.height * scale) / 2,
          );
          canvas.drawLine(start, end, paint);
          if (!flow.right.hasChild) {
            myCanvas.drawCircle(
              end,
              3 * scale,
              paint,
              onTapDown: (tapdetail) {
                Window.mode = "add";
                Ram.selectedId = flow.id;
                Ram.selectedDirection = Direction.right;
                flowie.save();
                refreshSink.add("");
              },
            );
          }
        }

        // left
        if (flow.direction != Direction.right &&
            !(flow.down.hasChild && flow.right.hasChild)) {
          start = Offset(
            flow.x * scale,
            (flow.y * scale) + (flow.height * scale) / 2,
          );
          end = Offset(
            (flow.x * scale) - flow.left.lineHeight * scale,
            (flow.y * scale) + (flow.height * scale) / 2,
          );
          canvas.drawLine(start, end, paint);
          if (!flow.left.hasChild) {
            myCanvas.drawCircle(
              end,
              3 * scale,
              paint,
              onTapDown: (tapdetail) {
                Window.mode = "add";
                Ram.selectedId = flow.id;
                Ram.selectedDirection = Direction.left;
                flowie.save();
                refreshSink.add("");
              },
            );
          }
        }
        Offset down = Offset(
          ((flow.x * scale) + (flow.width * scale) / 2) + 20 * scale,
          ((flow.y * scale) +
                  (flow.height * scale) +
                  (flow.down.lineHeight * scale) / 2) -
              10 * scale,
        );
        Offset left = Offset(
          ((flow.x * scale) - (flow.left.lineHeight * scale) / 2) - 2 * scale,
          ((flow.y * scale) + (flow.height * scale) / 2) - 20 * scale,
        );
        Offset right = Offset(
          ((flow.x * scale) +
                  (flow.width * scale) +
                  (flow.right.lineHeight * scale) / 2) -
              10 * scale,
          ((flow.y * scale) + (flow.height * scale) / 2) - 20 * scale,
        );
        // yes
        if (flow.yes == Direction.down) {
          paintText('yes', down, true);
          // right
          if (flow.right.hasChild) {
            start = Offset(
              ((flow.x * scale) +
                      (flow.width * scale) +
                      (flow.right.lineHeight * scale) / 2) -
                  10 * scale,
              ((flow.y * scale) + (flow.height * scale) / 2) - 20 * scale,
            );
            paintText('no', right, false);
          }
          // left
          if (flow.left.hasChild) {
            paintText('no', left, false);
          }
        } else if (flow.yes == Direction.right) {
          paintText('yes', right, false);
          // down
          if (flow.down.hasChild) {
            paintText('no', down, true);
          }
          // left
          if (flow.left.hasChild) {
            paintText('no', left, false);
          }
        } else if (flow.yes == Direction.left) {
          paintText('yes', left, false);
          // down
          if (flow.down.hasChild) {
            paintText('no', down, true);
          }
          // right
          if (flow.right.hasChild) {
            paintText('no', right, false);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

bool hasChildren(id) {
  for (var flow in flowie.flows) {
    if (flow.pid == id) {
      return true;
    }
  }
  return false;
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.amber
      ..strokeWidth = 0;

    Offset start = Offset(size.width / 2, 0);
    Offset end = Offset(size.width, size.height / 2);

    canvas.drawLine(start, end, paint);

    start = Offset(size.width, size.height / 2);
    end = Offset(size.width / 2, size.height);

    canvas.drawLine(start, end, paint);

    start = Offset(size.width / 2, size.height);
    end = Offset(0, size.height / 2);

    canvas.drawLine(start, end, paint);

    start = Offset(0, size.height / 2);
    end = Offset(size.width / 2, 0);

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Condition extends StatelessWidget {
  const Condition({
    super.key,
    required this.label,
    required this.width,
    required this.height,
  });
  final String label;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    final double scale = Window.isMobile ? 0.5 : 1.0;
    return CustomPaint(
      child: Container(
        padding: EdgeInsets.all(width * scale / 4),
        width: width * scale,
        height: width * scale,
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10 * scale,
              color: DemoPallet.font1,
              fontFamily: DemoPallet.fontFamily,
            ),
          ),
        ),
      ),
      foregroundPainter: LinePainter(),
    );
  }
}

class Terminal extends StatelessWidget {
  const Terminal({
    super.key,
    required this.label,
    required this.width,
    required this.height,
  });
  final String label;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final double scale = Window.isMobile ? 0.5 : 1.0;
    return Container(
      width: width * scale,
      height: height * scale,
      padding: EdgeInsets.symmetric(
        horizontal: 10 * scale,
        vertical: 5 * scale,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(40 * scale),
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10 * scale,
            color: DemoPallet.font1,
            fontFamily: DemoPallet.fontFamily,
          ),
        ),
      ),
    );
  }
}

class Process extends StatelessWidget {
  const Process({
    super.key,
    required this.label,
    required this.width,
    required this.height,
  });
  final String label;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final double scale = Window.isMobile ? 0.5 : 1.0;
    return Container(
      width: width * scale,
      height: height * scale,
      padding: EdgeInsets.symmetric(
        horizontal: 10 * scale,
        vertical: 5 * scale,
      ),
      decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10 * scale,
            color: DemoPallet.font1,
            fontFamily: DemoPallet.fontFamily,
          ),
        ),
      ),
    );
  }
}

class EditFlow extends StatefulWidget {
  const EditFlow({super.key});

  @override
  State<EditFlow> createState() => _EditFlowState();
}

class _EditFlowState extends State<EditFlow> {
  @override
  Widget build(BuildContext context) {
    final double scale = Window.isMobile ? 0.6 : 1.0;
    return GlassMorph(
      padding: EdgeInsets.symmetric(
        horizontal: 10 * scale,
        vertical: 5 * scale,
      ),
      width: 150 * scale,
      borderRadius: 5 * scale,
      sigmaX: 5,
      sigmaY: 5,
      color: DemoPallet.isGlass
          ? (DemoPallet.light
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1))
          : Pallet.inner2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "width",
            style: TextStyle(
              fontSize: 10 * scale,
              color: DemoPallet.font1,
              fontFamily: DemoPallet.fontFamily,
            ),
          ),
          SizedBox(height: 5 * scale),
          TextBox(
            controller: TextEditingController(
              text: flowie.flows[Ram.selectedId!].width.toString(),
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            "value",
            style: TextStyle(
              fontSize: 10 * scale,
              color: DemoPallet.font1,
              fontFamily: DemoPallet.fontFamily,
            ),
          ),
          SizedBox(height: 5 * scale),
          TextBox(
            controller: TextEditingController(
              text: flowie.flows[Ram.selectedId!].value.toString(),
            ),
            maxLines: Window.isMobile ? 3 : 5,
          ),
          SizedBox(height: 10 * scale),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SmallButton(
                label: "done",
                onPress: () {
                  // flowie.save();
                  // Window.mode = "none";
                  // refreshSink.add("");
                },
              ),
              SizedBox(width: 5),
              SmallButton(
                label: "close",
                onPress: () {
                  // Window.mode = "none";
                  // refreshSink.add("");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  const SmallButton({super.key, required this.label, required this.onPress});
  final String label;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Pallet.inner1,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: DemoPallet.font3,
                fontSize: 9 * (Window.isMobile ? 0.6 : 1.0),
                fontFamily: DemoPallet.fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  const TextBox({
    super.key,
    this.controller,
    this.maxLines,
    this.onType,
    this.onEnter,
    this.hintText,
    this.focus,
    this.radius,
  });
  final TextEditingController? controller;
  final int? maxLines;
  final Function(String)? onType;
  final Function(String)? onEnter;
  final String? hintText;
  final FocusNode? focus;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: Pallet.inner3,
        borderRadius: BorderRadius.circular(radius ?? 5),
      ),
      child: TextField(
        focusNode: focus,
        onSubmitted: onEnter,
        onChanged: onType,
        controller: controller,
        style: TextStyle(
          fontSize: 10 * (Window.isMobile ? 0.6 : 1.0),
          color: DemoPallet.font1,
          fontFamily: DemoPallet.fontFamily,
        ),
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 12 * (Window.isMobile ? 0.6 : 1.0),
            color: Pallet.font3,
          ),
          isDense: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class AddFlow extends StatelessWidget {
  const AddFlow({super.key});

  @override
  Widget build(BuildContext context) {
    final double scale = Window.isMobile ? 0.6 : 1.0;
    return GlassMorph(
      // margin: EdgeInsets.only(top: 10, right: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 10 * scale,
        vertical: 10 * scale,
      ),
      width: 150 * scale,
      borderRadius: 10 * scale,
      sigmaX: 5,
      sigmaY: 5,
      color: DemoPallet.isGlass
          ? (DemoPallet.light
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1))
          : Pallet.inner1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Button(label: "Add Terminal", onPress: () {}),
          SizedBox(height: 10),
          Button(label: "Add Process", onPress: () {}),
          SizedBox(height: 10),
          Button(label: "Add Condition", onPress: () {}),
          SizedBox(height: 10),
          Button(label: "Add Loop", onPress: () {}),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({super.key, required this.label, required this.onPress});
  final String label;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    final double scale = Window.isMobile ? 0.6 : 1.0;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: label.toLowerCase().contains("loop") ? 5 * scale : 8 * scale,
        horizontal: 10 * scale,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15 * scale),
        color: Pallet.inner2,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10 * scale,
                color: DemoPallet.font1,
                fontFamily: DemoPallet.fontFamily,
              ),
            ),
          ),
          if (label.toLowerCase().contains("condition"))
            Transform.rotate(
              angle: 40,
              child: Container(
                width: 10 * scale,
                height: 10 * scale,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow, width: 2 * scale),
                ),
              ),
            )
          else if (label.toLowerCase().contains("process"))
            Container(
              width: 12 * scale,
              height: 12 * scale,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2 * scale),
              ),
            )
          else if (label.toLowerCase().contains("terminal"))
            Container(
              width: 12 * scale,
              height: 12 * scale,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15 * scale),
                border: Border.all(color: Colors.red, width: 2 * scale),
              ),
            )
          else
            SizedBox(
              width: 16 * scale,
              height: 16 * scale,
              child: Icon(
                Icons.loop,
                // opticalSize: 5,
                size: 18 * scale,
                // weight: 6,
                color: Colors.green,
              ),
            ),
        ],
      ),
    );
  }
}
