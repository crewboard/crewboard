import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/router_controller.dart';
import '../controllers/sidebar_controller.dart';
import '../widgets/moving_background.dart';
import 'sidebar.dart';
import '../config/palette.dart';

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          MinimizeWindowButton(colors: Pallet.windowButtonColors),
          MaximizeWindowButton(colors: Pallet.windowButtonColors),
          CloseWindowButton(colors: Pallet.closeWindowButtonColors),
        ],
      ),
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
      body: Obx(
        () => WindowBorder(
          color: Pallet
              .divider, // Using dynamic divider color instead of hardcoded amber
          width: 1,
          child: Stack(
            children: [
              const Positioned.fill(child: MovingBackground()),
              Column(
                children: [
                  WindowTitleBarBox(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/logo.png',
                                height: 18,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  "crewboard",
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Pallet.font1,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
