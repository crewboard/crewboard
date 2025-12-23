import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/palette.dart';
import '../screens/chats/chat_screen.dart';
import '../screens/planner/planner_screen.dart';
import 'sidebar_controller.dart';

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
          currentPageWidget.value = Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade900, Colors.grey.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.settings, size: 80, color: Colors.white70),
                  SizedBox(height: 20),
                  Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Admin settings and configuration",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          );
          break;
        case CurrentPage.planner:
          currentPageWidget.value = const PlannerScreen();
          break;
        case CurrentPage.flowie:
          currentPageWidget.value = Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFBC02D), Color(0xFFF9A825)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_tree, size: 80, color: Colors.white),
                  SizedBox(height: 20),
                  Text(
                    "Flowie",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Workflow and process management",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          );
          break;
      }
    });
  }
}
