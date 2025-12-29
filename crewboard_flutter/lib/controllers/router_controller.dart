import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/palette.dart';
import '../screens/chats/chat_screen.dart';
import '../screens/planner/planner_screen.dart';
import '../screens/admin/admin_screen.dart';
import 'sidebar_controller.dart';
import '../screens/docs/docs_screen.dart';

class RouterController extends GetxController {
  final SidebarController sidebarController = Get.find();

  Rx<Widget> currentPageWidget = Rx<Widget>(const PlannerScreen());

  @override
  void onInit() {
    super.onInit();
    sidebarController.currentPage.listen((page) {
      switch (page) {
        case CurrentPage.chat:
          currentPageWidget.value = const ChatScreen();
          break;
        case CurrentPage.settings:
          currentPageWidget.value = const AdminScreen();
          break;
        case CurrentPage.planner:
          currentPageWidget.value = const PlannerScreen();
          break;
        case CurrentPage.flowie:
          currentPageWidget.value = const DocsScreen();
          break;
      }
    });
  }
}
