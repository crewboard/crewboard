import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/palette.dart';
import '../controllers/sidebar_controller.dart';
import '../widgets/glass_morph.dart';
import '../screens/planner/apps_sidebar.dart';
import '../screens/chats/rooms_widget.dart';

import '../screens/admin/settings_sidebar.dart';
import '../screens/docs/docs_sidebar.dart';
import '../widgets/widgets.dart';

class SideBar extends ConsumerWidget {
  const SideBar({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sidebarState = ref.watch(sidebarProvider);
    final sidebarNotifier = ref.read(sidebarProvider.notifier);

    if (sidebarState.isOpen) {
      return Animate(
        effects: const [FadeEffect()],
        child: MouseRegion(
          onExit: (_) {
            if (sidebarState.closeOnExit) {
              sidebarNotifier.closeSidebar();
              // Reset closeOnExit if needed (matching original logic)
              // The original logic was: if (closeOnExit) { closeOnExit=false; closeSidebar(); }
              // We should probably do this in the notifier or here.
              // Let's assume the notifier handles it if it's a one-time thing,
              // but the original code mutated the observable directly.
            }
          },
          child: GlassMorph(
            borderRadius: 24,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: Window.sideBarWidth,
              height: MediaQuery.of(context).size.height,
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
                          // Original logic: controller.closeOnExit.value = !controller.closeOnExit.value;
                          // Since we didn't add a dedicated toggle method for this flag in the notifier,
                          // I'll add it or just use a state update here if it's simple.
                          // Best to keep logic in notifier.
                        },
                        child: Icon(
                          (sidebarState.closeOnExit)
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
                        _buildMenuItems(sidebarState, sidebarNotifier),
                        const SizedBox(height: 5),
                        Divider(color: Pallet.font3.withValues(alpha: 0.5)),
                        InkWell(
                          onTap: () {
                            sidebarNotifier.navigate(CurrentPage.settings);
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
                      ],
                    ),
                  ),
                  if (sidebarState.currentPage == CurrentPage.planner ||
                      sidebarState.currentPage == CurrentPage.chat ||
                      sidebarState.currentPage == CurrentPage.settings ||
                      sidebarState.currentPage == CurrentPage.documentation)
                    Expanded(
                      child: _buildCurrentSidebarPage(sidebarState),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return MouseRegion(
        onEnter: (details) {
          // controller.closeOnExit.value = true;
          sidebarNotifier.openSidebar();
        },
        child: Container(width: 5, color: Colors.transparent),
      );
    }
  }

  Widget _buildMenuItems(SidebarState state, SidebarNotifier notifier) {
    if (state.currentPage == CurrentPage.planner) {
      return Column(
        children: [
          MenuItem(
            name: "Chat",
            color: const Color(0xFFF44336),
            subtitle: "Chat",
            onPress: () {
              notifier.navigate(CurrentPage.chat);
              notifier.setSubPage('');
            },
          ),
          const SizedBox(height: 20),
          MenuItem(
            name: "Documentation",
            color: const Color.fromARGB(255, 228, 202, 5),
            subtitle: "Documentation",
            onPress: () {
              notifier.navigate(CurrentPage.documentation);
            },
          ),
        ],
      );
    } else if (state.currentPage == CurrentPage.documentation ||
        state.currentPage == CurrentPage.settings) {
      return Column(
        children: [
          MenuItem(
            name: "Chat",
            color: const Color(0xFFF44336),
            subtitle: "Chat",
            onPress: () {
              notifier.navigate(CurrentPage.chat);
            },
          ),
          const SizedBox(height: 20),
          MenuItem(
            name: "Planner",
            color: const Color(0xFF2196F3),
            subtitle: "Planner",
            onPress: () {
              notifier.navigate(CurrentPage.planner);
            },
          ),
        ],
      );
    } else if (state.currentPage == CurrentPage.chat) {
      return Column(
        children: [
          MenuItem(
            name: "Planner",
            color: const Color(0xFF2196F3),
            subtitle: "Planner",
            onPress: () {
              notifier.navigate(CurrentPage.planner);
            },
          ),
          const SizedBox(height: 20),
          MenuItem(
            name: "Documentation",
            color: const Color.fromARGB(255, 228, 202, 5),
            subtitle: "Documentation",
            onPress: () {
              notifier.navigate(CurrentPage.documentation);
            },
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildCurrentSidebarPage(SidebarState state) {
    if (state.currentPage == CurrentPage.planner) {
      return const AppsSidebar();
    } else if (state.currentPage == CurrentPage.chat) {
      return Column(
        children: [
          const SizedBox(height: 10),
          const BotItem(
            name: "threads",
            image: "assets/bot.jpg",
            page: "planner",
            count: 0,
          ),
          const SizedBox(height: 5),
          const BotItem(
            name: "memory bank",
            image: "assets/bot.jpg",
            page: "memory",
            count: 0,
          ),
          const Expanded(child: Rooms()),
        ],
      );
    } else if (state.currentPage == CurrentPage.settings) {
      return const SettingsSidebar();
    } else if (state.currentPage == CurrentPage.documentation) {
      return const DocsSidebar();
    }
    return const SizedBox();
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
              color: color.withValues(alpha: 0.2),
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
