import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/router_controller.dart';
import '../controllers/sidebar_controller.dart';
import '../widgets/moving_background.dart';
import 'sidebar.dart';
import '../config/palette.dart';

class WindowButtons extends ConsumerWidget {
  const WindowButtons({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We watch the theme to rebuild when it changes
    ref.watch(sidebarProvider);
    return Row(
      children: [
        MinimizeWindowButton(colors: Pallet.windowButtonColors),
        MaximizeWindowButton(colors: Pallet.windowButtonColors),
        CloseWindowButton(colors: Pallet.closeWindowButtonColors),
      ],
    );
  }
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageWidget = ref.watch(currentPageWidgetProvider);

    return Scaffold(
      body: WindowBorder(
        color: Pallet.divider,
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
                          child: currentPageWidget,
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
    );
  }
}
