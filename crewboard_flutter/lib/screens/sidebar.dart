import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../config/palette.dart';
import '../controllers/sidebar_controller.dart';
import '../controllers/auth_controller.dart';
import '../widgets/glass_morph.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SidebarController>();
    return Obx(() {
      if (controller.isOpen.value) {
        return Animate(
          effects: const [FadeEffect()],
          child: MouseRegion(
            onExit: (_) {
              if (controller.closeOnExit.value) {
                controller.closeOnExit.value = false;
                controller.closeSidebar();
              }
            },
            child: GlassMorph(
              borderRadius: 24,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: Window.sideBarWidth,
                height: Window.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        const Row(
                          children: [
                            SizedBox(width: 5),
                            Text(
                              "Crew Board",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () {
                            controller.closeOnExit.value =
                                !controller.closeOnExit.value;
                          },
                          child: Icon(
                            (controller.closeOnExit.value)
                                ? Icons.lock_open
                                : Icons.lock_outline,
                            size: 18,
                            color: Pallet.font3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Pallet.inside1,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          Obx(() {
                            if (controller.currentPage.value ==
                                CurrentPage.planner) {
                              return Column(
                                children: [
                                  MenuItem(
                                    name: "Chat",
                                    color: const Color(0xFFF44336),
                                    subtitle: "Chat",
                                    onPress: () {
                                      controller.navigate(CurrentPage.chat);
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  MenuItem(
                                    name: "Flowie",
                                    color: const Color.fromARGB(
                                      255,
                                      228,
                                      202,
                                      5,
                                    ),
                                    subtitle: "Flowie",
                                    onPress: () {
                                      controller.navigate(CurrentPage.flowie);
                                    },
                                  ),
                                ],
                              );
                            } else if (controller.currentPage.value ==
                                    CurrentPage.flowie ||
                                controller.currentPage.value ==
                                    CurrentPage.settings) {
                              return Column(
                                children: [
                                  MenuItem(
                                    name: "Chat",
                                    color: const Color(0xFFF44336),
                                    subtitle: "Chat",
                                    onPress: () {
                                      controller.navigate(CurrentPage.chat);
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  MenuItem(
                                    name: "Planner",
                                    color: const Color(0xFF2196F3),
                                    subtitle: "Planner",
                                    onPress: () {
                                      controller.navigate(CurrentPage.planner);
                                    },
                                  ),
                                ],
                              );
                            } else if (controller.currentPage.value ==
                                CurrentPage.chat) {
                              return Column(
                                children: [
                                  MenuItem(
                                    name: "Planner",
                                    color: const Color(0xFF2196F3),
                                    subtitle: "Planner",
                                    onPress: () {
                                      controller.navigate(CurrentPage.planner);
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  MenuItem(
                                    name: "Flowie",
                                    color: const Color.fromARGB(
                                      255,
                                      228,
                                      202,
                                      5,
                                    ),
                                    subtitle: "Flowie",
                                    onPress: () {
                                      controller.navigate(CurrentPage.flowie);
                                    },
                                  ),
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                          const SizedBox(height: 5),
                          Divider(color: Pallet.font3.withOpacity(0.5)),
                          InkWell(
                            onTap: () {
                              controller.navigate(CurrentPage.settings);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: Pallet.font3,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "settings",
                                  style: TextStyle(color: Pallet.font3),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              Get.find<AuthController>().logout();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Pallet.font3,
                                  size: 18,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "logout",
                                  style: TextStyle(color: Pallet.font3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    for (var child in children) child,
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return MouseRegion(
          onEnter: (details) {
            controller.closeOnExit.value = true;
            controller.openSidebar();
          },
          child: Container(width: 5, color: Colors.transparent),
        );
      }
    });
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.name,
    required this.color,
    required this.onPress,
    this.subtitle = "App",
  });
  final String name;
  final Color color;
  final Function onPress;
  final String subtitle;

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
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                name[0],
                style: TextStyle(fontSize: 20, color: color),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(color: Pallet.font1)),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(fontSize: 10, color: Pallet.font3),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
