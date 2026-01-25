import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'types.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: Window.siderBarOpen,
        builder: (BuildContext context, bool isOpen, Widget? child) {
          if (isOpen) {
            return Animate(
              effects: [FadeEffect()],
              child: MouseRegion(
                onExit: (_) {
                  if (Window.closeOnExit) {
                    Window.closeOnExit = false;
                    Window.siderBarOpen.value = false;
                  }
                },
                child: Container(
                  width: Window.sideBarWidth,
                  height: Window.height,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        width: 0.5,
                        color: Pallet.font3.withOpacity(0.2),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              if (Window.siderBarOpen.value && Window.closeOnExit == false) {
                                Window.siderBarOpen.value = false;
                              }
                              Window.closeOnExit = !Window.closeOnExit;
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  width: 35,
                                  "assets/kolab.svg",
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  "KOLab",
                                ),
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(color: Pallet.inner1, borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            if (Window.page.value == "planner")
                              Column(
                                children: [
                                  MenuItem(
                                    name: "Chat",
                                    color: Color(0xFFF44336),
                                    onPress: () {
                                      // Window.navigate("chat");
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  MenuItem(
                                    name: "Flowie",
                                    color: Color.fromARGB(255, 228, 202, 5),
                                    onPress: () {
                                      // Window.navigate("flowie");
                                    },
                                  ),
                                ],
                              ),
                            if (Window.page.value == "flowie")
                              Column(
                                children: [
                                  MenuItem(
                                    name: "Chat",
                                    color: Color(0xFFF44336),
                                    onPress: () {
                                      // Window.navigate("chat");
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  MenuItem(
                                    name: "Planner",
                                    color: Color(0xFFF2196F3),
                                    onPress: () {
                                      // Window.navigate("planner");
                                    },
                                  ),
                                ],
                              ),
                            if (Window.page.value == "chat")
                              Column(
                                children: [
                                  MenuItem(
                                    name: "Planner",
                                    color: Color(0xFFF2196F3),
                                    onPress: () {
                                      // Window.navigate("planner");
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  MenuItem(
                                    name: "Flowie",
                                    color: Color.fromARGB(255, 228, 202, 5),
                                    onPress: () {
                                      // Window.navigate("flowie");
                                    },
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              color: Color(0xFF383a3e),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.settings,
                                    color: Pallet.font3,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "settings",
                                    style: TextStyle(color: Pallet.font3),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      for (var child in children) child,
                    ],
                  ),
                ),
              ),
            );
          } else {
            return MouseRegion(
              onEnter: (details) {
                Window.closeOnExit = true;
                Window.siderBarOpen.value = true;
              },
              onExit: (details) {
                // Window.siderBarOpen = true;
              },
              child: Container(
                // color: Colors.red,
                width: 5,
              ),
            );
          }
        });
  }

  button(String name) {
    return InkWell(
      onTap: () {
        // Window.subPage.value = name;
      },
      child: Container(
        decoration: BoxDecoration(
            color: Pallet.inner3,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 27, 27, 27),
                offset: Offset(-1, -1),
                blurRadius: 4,
                spreadRadius: 2,
              ),
              BoxShadow(
                color: Color.fromARGB(255, 63, 63, 63),
                offset: Offset(1, 1),
                blurRadius: 2,
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Center(
          child: Text(
            name,
            style: TextStyle(color: Pallet.font2, fontSize: 12),
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.name, required this.color, required this.onPress});
  final String name;
  final Color color;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                name[0],
                style: TextStyle(fontSize: 20, color: Pallet.insideFont),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              const SizedBox(height: 5),
              Text(
                "Chat",
                style: TextStyle(fontSize: 10, color: Pallet.font3),
              ),
            ],
          )
        ],
      ),
    );
  }
}
