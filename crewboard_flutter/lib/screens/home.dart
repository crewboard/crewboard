import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import '../config/palette.dart';
import '../controllers/router_controller.dart';
import '../controllers/sidebar_controller.dart';
import 'sidebar.dart';

final buttonColors = WindowButtonColors(
  iconNormal: const Color(0xFF805306),
  mouseOver: const Color(0xFFF6A00C),
  mouseDown: const Color(0xFF805306),
  iconMouseOver: const Color(0xFF805306),
  iconMouseDown: const Color(0xFFFFD500),
);

final closeButtonColors = WindowButtonColors(
  mouseOver: const Color(0xFFD32F2F),
  mouseDown: const Color(0xFFB71C1C),
  iconNormal: const Color(0xFF805306),
  iconMouseOver: Colors.white,
);

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers if not already
    Get.put(SidebarController());
    final RouterController routerController = Get.put(RouterController());

    return Scaffold(
      body: WindowBorder(
        color: const Color(0xFF805306),
        width: 1,
        child: DecoratedBox(
          decoration: BoxDecoration(gradient: Pallet.backgroundGradient),
          child: Column(
            children: [
              WindowTitleBarBox(
                child: Row(
                  children: [
                    Expanded(child: MoveWindow()),
                    const WindowButtons(),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const SideBar(children: []),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Obx(
                          () => routerController.currentPageWidget.value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
