import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' as an;
// import 'package:flutter_animate/flutter_animate.dart';
import 'package:landing/main.dart';
import 'package:lottie/lottie.dart';
import 'package:touchable/touchable.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'types.dart';
import '../types.dart';
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

    events.registerEvent("show_flowie", () async {
      if (!playing) {
        playing = true;
        while (playing) {
          print("started");
          await Future.delayed(const Duration(milliseconds: 200));
          RenderBox renderBox =
              screenKey.currentContext!.findRenderObject() as RenderBox;
          Window.stageWidth = renderBox.size.width;

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
    mouseX = flowie.flows[idx].x +
        flowie.flows[idx].width +
        flowie.flows[idx].right.lineHeight;
    mouseY = flowie.flows[idx].y + flowie.flows[idx].height / 2;
    mouseX -= 23;
    mouseY -= 8;
    animationSink.add("");
  }

  selectBottomNode() async {
    mouseY = 0;
    for (var flow in flowie.flows) {
      if ((flow.y + flow.height + flow.down.lineHeight) > mouseY) {
        mouseX = flow.x + flow.width / 2;
        mouseY = (flow.y + flow.height + flow.down.lineHeight);
      }
    }
    mouseY -= 8;
    mouseX -= 25;
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
    mouseX = Window.stageWidth - 120;
    mouseY = 20 + adder;
    animationSink.add("");
    await Future.delayed(const Duration(milliseconds: 500));
    animationSink.add("");
  }

  selectText() async {
    mouseX = Window.stageWidth - 165;
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
            'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
      },
      child: SizedBox(
        width: Window.fullWidth,
        height: Window.fullHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
              SizedBox(
                width: Window.fullWidth * 0.1,
              ),
              Expanded(
                child: StreamBuilder<Object>(
                    stream: animationStream,
                    builder: (context, snapshot) {
                      return an.Animate(
                        controller: _controller,
                        effects: const [
                          an.ScaleEffect(
                              duration: Duration(milliseconds: 1000)),
                          an.FadeEffect(duration: Duration(milliseconds: 1000))
                        ],
                        child: Container(
                          key: screenKey,
                          decoration: BoxDecoration(
                              color: Pallet.background,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Pallet.font1)),
                          height: Window.fullHeight * 0.6,
                          // width: 691.2,
                          child: Stack(
                            children: [
                              Lines(),
                              for (var flow in flowie.flows)
                                if (flow.type == FlowType.terminal)
                                  Positioned(
                                      left: flow.x,
                                      top: flow.y,
                                      child: InkWell(
                                        onTap: () {
                                          // selectFlow(flow.id, flow.direction!, flow.type);
                                        },
                                        child: Terminal(
                                          width: flow.width,
                                          height: flow.height,
                                          label: flow.value,
                                        ),
                                      ))
                                else if (flow.type == FlowType.process)
                                  Positioned(
                                      left: flow.x,
                                      top: flow.y,
                                      child: InkWell(
                                        onTap: () {
                                          // selectFlow(flow.id, flow.direction!, flow.type);
                                        },
                                        child: Process(
                                          width: flow.width,
                                          height: flow.height,
                                          label: flow.value,
                                        ),
                                      ))
                                else if (flow.type == FlowType.condition)
                                  Positioned(
                                      left: flow.x,
                                      top: flow.y,
                                      child: InkWell(
                                        onTap: () {
                                          // selectFlow(flow.id, flow.direction!, flow.type);
                                        },
                                        child: Condition(
                                          width: flow.width,
                                          height: flow.width,
                                          label: flow.value,
                                        ),
                                      )),
                              if (Window.mode == "edit")
                                Positioned(right: 5, top: 5, child: EditFlow())
                              else
                                Positioned(right: 5, top: 5, child: AddFlow()),
                              AnimatedPositioned(
                                  duration: const Duration(milliseconds: 200),
                                  top: mouseY,
                                  left: mouseX,
                                  child: SizedBox(
                                      width: 50,
                                      height: 30,
                                      // color: Colors.red,
                                      child: Lottie.asset(
                                          'assets/white_select.json')))
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: Window.fullWidth * 0.3,
                    child: an.Animate(
                      controller: _controller,
                      effects: const [
                        an.SlideEffect(duration: Duration(milliseconds: 1500)),
                        an.FadeEffect(duration: Duration(milliseconds: 1500))
                      ],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Make sure no flow is left untouched with flowie",
                            style: TextStyle(fontSize: 45, color: Pallet.font1),
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
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: Colors.red, width: 3)),
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.yellow, width: 3)),
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blue, width: 3)),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "terminal",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 8),
                                  Text("condition",
                                      style: TextStyle(fontSize: 16)),
                                  SizedBox(height: 8),
                                  Text("process",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
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
      ..color = (Pallet.light) ? Colors.black : Colors.white
      ..strokeWidth = 1;

    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 11,
    );
    final yesp = TextPainter(
      text: TextSpan(
        text: 'yes',
        style: textStyle,
      ),
      textDirection: TextDirection.ltr,
    );
    yesp.layout(
      minWidth: 0,
      maxWidth: 20,
    );
    final nop = TextPainter(
      text: TextSpan(
        text: 'no',
        style: textStyle,
      ),
      textDirection: TextDirection.ltr,
    );
    nop.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
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
        start = Offset(flow.x + flow.width / 2, flow.y + flow.height);
        end = Offset(flow.x + flow.width / 2,
            flow.y + flow.height + flow.down.lineHeight);
        canvas.drawLine(start, end, paint);
        if (!flow.down.hasChild) {
          myCanvas.drawCircle(end, 3, paint, onTapDown: (tapdetail) {
            Window.mode = "add";
            Ram.selectedId = flow.id;
            Ram.selectedDirection = Direction.down;
            flowie.save();
            refreshSink.add("");
          });
        }
      }

      if (flow.type == FlowType.condition) {
        // right

        if (flow.direction != Direction.left &&
            !(flow.down.hasChild && flow.left.hasChild)) {
          start = Offset(flow.x + flow.width, flow.y + flow.height / 2);
          end = Offset(flow.x + flow.width + flow.right.lineHeight,
              flow.y + flow.height / 2);
          canvas.drawLine(start, end, paint);
          if (!flow.right.hasChild) {
            myCanvas.drawCircle(end, 3, paint, onTapDown: (tapdetail) {
              Window.mode = "add";
              Ram.selectedId = flow.id;
              Ram.selectedDirection = Direction.right;
              flowie.save();
              refreshSink.add("");
            });
          }
        }

        // left
        if (flow.direction != Direction.right &&
            !(flow.down.hasChild && flow.right.hasChild)) {
          start = Offset(flow.x, flow.y + flow.height / 2);
          end = Offset(flow.x - flow.left.lineHeight, flow.y + flow.height / 2);
          canvas.drawLine(start, end, paint);
          if (!flow.left.hasChild) {
            myCanvas.drawCircle(end, 3, paint, onTapDown: (tapdetail) {
              Window.mode = "add";
              Ram.selectedId = flow.id;
              Ram.selectedDirection = Direction.left;
              flowie.save();
              refreshSink.add("");
            });
          }
        }
        Offset down = Offset((flow.x + flow.width / 2) + 20,
            (flow.y + flow.height + flow.down.lineHeight / 2) - 10);
        Offset left = Offset((flow.x - flow.left.lineHeight / 2) - 2,
            (flow.y + flow.height / 2) - 20);
        Offset right = Offset(
            (flow.x + flow.width + flow.right.lineHeight / 2) - 10,
            (flow.y + flow.height / 2) - 20);
        // yes
        if (flow.yes == Direction.down) {
          paintText('yes', down, true);
          // right
          if (flow.right.hasChild) {
            start = Offset(
                (flow.x + flow.width + flow.right.lineHeight / 2) - 10,
                (flow.y + flow.height / 2) - 20);
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
  const Condition(
      {super.key,
      required this.label,
      required this.width,
      required this.height});
  final String label;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        padding: EdgeInsets.all(width / 4),
        width: width,
        height: width,
        child: Center(child: Text(label, style: TextStyle(fontSize: 10))),
      ),
      foregroundPainter: LinePainter(),
    );
  }
}

class Terminal extends StatelessWidget {
  const Terminal(
      {super.key,
      required this.label,
      required this.width,
      required this.height});
  final String label;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(40)),
      child: Center(child: Text(label, style: TextStyle(fontSize: 10))),
    );
  }
}

class Process extends StatelessWidget {
  const Process(
      {super.key,
      required this.label,
      required this.width,
      required this.height});
  final String label;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      child: Center(child: Text(label, style: TextStyle(fontSize: 10))),
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
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: 150,
        decoration: BoxDecoration(
            color: Pallet.inner2, borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "width",
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(
              height: 5,
            ),
            TextBox(
              controller: TextEditingController(
                text: flowie.flows[Ram.selectedId!].width.toString(),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "value",
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(
              height: 5,
            ),
            TextBox(
              controller: TextEditingController(
                text: flowie.flows[Ram.selectedId!].value.toString(),
              ),
              maxLines: 5,
            ),
            SizedBox(
              height: 8,
            ),
            if (flowie.flows[Ram.selectedId!].down.hasChild ||
                flowie.flows[Ram.selectedId!].right.hasChild ||
                flowie.flows[Ram.selectedId!].left.hasChild)
              Column(
                children: [
                  Text(
                    "line heights",
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),

            if (flowie.flows[Ram.selectedId!].down.hasChild)
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    SizedBox(
                      width: 45,
                      child: Text(
                        "down",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Expanded(
                      child: TextBox(),
                    ),
                  ],
                ),
              ),
            if (Ram.selectedType == FlowType.condition)
              if (flowie.flows[Ram.selectedId!].left.hasChild)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 45,
                        child: Text(
                          "left",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Expanded(
                        child: TextBox(),
                      ),
                    ],
                  ),
                ),
            if (Ram.selectedType == FlowType.condition)
              if (flowie.flows[Ram.selectedId!].right.hasChild)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 45,
                        child: Text(
                          "right",
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Expanded(
                        child: TextBox(),
                      ),
                    ],
                  ),
                ),

            // InkWell(
            //   onTap: () {},
            //   child: Container(
            //     decoration: BoxDecoration(color: Pallet.inner1, borderRadius: BorderRadius.circular(5)),
            //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text("delete", style: TextStyle(fontSize: 10)),
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Icon(
            //           Icons.delete,
            //           size: 14,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
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
                SizedBox(
                  width: 5,
                ),
                SmallButton(
                  label: "close",
                  onPress: () {
                    // Window.mode = "none";
                    // refreshSink.add("");
                  },
                ),
              ],
            )
          ],
        ));
    ;
  }
}

class SmallButton extends StatelessWidget {
  const SmallButton({super.key, required this.label, required this.onPress});
  final String label;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
        minimumSize: Size(30, 30),
      ),
      onPressed: () {
        onPress();
      },
      child: Container(
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
                style: TextStyle(color: Pallet.font3, fontSize: 9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  const TextBox(
      {super.key,
      this.controller,
      this.maxLines,
      this.onType,
      this.onEnter,
      this.hintText,
      this.focus,
      this.radius});
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
          style: TextStyle(fontSize: 10),
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 12, color: Pallet.font3),
            isDense: true,
            border: InputBorder.none,
          )),
    );
  }
}

class AddFlow extends StatelessWidget {
  const AddFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.only(top: 10, right: 10),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: 150,
        decoration: BoxDecoration(
            color: Pallet.inner1, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Button(
              label: "Add Terminal",
              onPress: () {},
            ),
            SizedBox(height: 10),
            Button(
              label: "Add Process",
              onPress: () {},
            ),
            SizedBox(height: 10),
            Button(
              label: "Add Condition",
              onPress: () {},
            ),
            SizedBox(height: 10),
            Button(
              label: "Add Loop",
              onPress: () {},
            ),
          ],
        ));
  }
}

class Button extends StatelessWidget {
  const Button({super.key, required this.label, required this.onPress});
  final String label;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: label.toLowerCase().contains("loop") ? 5 : 8,
          horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Pallet.inner2,
      ),
      child: Row(
        children: [
          Expanded(
              child: Text(
            label,
            style: TextStyle(fontSize: 10),
          )),
          if (label.toLowerCase().contains("condition"))
            Transform.rotate(
              angle: 40,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow, width: 2)),
              ),
            )
          else if (label.toLowerCase().contains("process"))
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2)),
            )
          else if (label.toLowerCase().contains("terminal"))
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.red, width: 2)),
            )
          else
            SizedBox(
              width: 16,
              height: 16,
              child: Icon(
                Icons.loop,
                // opticalSize: 5,
                size: 18,
                // weight: 6,
                color: Colors.green,
              ),
            )
        ],
      ),
    );
  }
}
