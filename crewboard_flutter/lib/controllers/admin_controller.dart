import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../screens/admin/general_settings.dart';
import '../screens/admin/users_settings.dart';
import '../screens/admin/attendance/attendance.dart';

enum AdminPage {
  general,
  users,
  attendance,
}

class AdminController extends GetxController {
  Rx<AdminPage> currentPage = AdminPage.general.obs;

  Widget get currentPageWidget {
    switch (currentPage.value) {
      case AdminPage.general:
        return const GeneralSettings();
      case AdminPage.users:
        return const UsersSettings();
      case AdminPage.attendance:
        return const AttendanceScreen();
    }
  }

  void navigateTo(AdminPage page) {
    currentPage.value = page;
  }
}
