import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/palette.dart';
import '../screens/chats/chat_screen.dart';
import '../screens/planner/planner_screen.dart';
import '../screens/admin/admin_screen.dart';
import 'sidebar_controller.dart';
import '../screens/docs/docs_screen.dart';

final currentPageWidgetProvider = Provider<Widget>((ref) {
  final sidebarState = ref.watch(sidebarProvider);
  switch (sidebarState.currentPage) {
    case CurrentPage.chat:
      return const ChatScreen();
    case CurrentPage.settings:
      return const AdminScreen();
    case CurrentPage.planner:
      return const PlannerScreen();
    case CurrentPage.documentation:
      return const DocsScreen();
  }
});

// Keeping the class for backward compatibility if needed, but it's now just a wrapper
// or we can remove it entirely if we update all usages.
// Let's keep it as an empty class that can be removed later to avoid breaking imports immediately.
class RouterController {}
