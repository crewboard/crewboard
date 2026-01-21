import 'package:flutter/material.dart';
import 'package:frontend/screens/docs/flows/flows.dart';
import 'package:frontend/screens/docs/main.dart';
import 'package:frontend/screens/planner/main.dart';
import 'package:get/get.dart';
import '../../globals.dart';
import 'sidebar_controller.dart';
import 'package:frontend/screens/chats/main.dart';
import 'package:frontend/screens/admin/main.dart';

class RouterController extends GetxController {
  final SidebarController sidebarController = Get.find();

  Rx<Widget> currentPage = Rx<Widget>(Chat());

  @override
  void onInit() {
    super.onInit();
    sidebarController.currentPage.listen((page) {
      switch (page) {
        case CurrentPage.chat:
          currentPage.value = Chat();
          break;
        case CurrentPage.settings:
          currentPage.value = Admin();
          break;
        case CurrentPage.planner:
          currentPage.value = Planner();
          break;
        case CurrentPage.flowie:
          currentPage.value = FlowEditor();
          break;
        default:
          currentPage.value = Chat();
          break;
      }
    });
  }
}
