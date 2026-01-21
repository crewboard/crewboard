import 'package:flutter/material.dart';
import 'package:frontend/screens/admin/attendance/attendance.dart';
import 'package:get/get.dart';
import 'package:frontend/screens/admin/users/users.dart';
import 'package:frontend/screens/admin/attendance/attendance_popup.dart';
import 'package:frontend/screens/admin/main.dart'; // For general admin page
import 'package:frontend/screens/admin/general.dart';

enum AdminPage {
  general,
  users,
  attendance,
  performance,
  planner,
  system,
}

class AdminRouterController extends GetxController {
  Rx<AdminPage> currentPage = Rx<AdminPage>(AdminPage.general);

  Widget get currentAdminPageWidget {
    switch (currentPage.value) {
      case AdminPage.general:
        return General();
      case AdminPage.users:
        return Users();
      case AdminPage.attendance:
        return Attendance();
      case AdminPage.performance:
        return Container(); // Placeholder for performance page
      case AdminPage.planner:
        return Container(); // Placeholder for planner page
      case AdminPage.system:
        return Container(); // Placeholder for other page
      default:
        return Container();
    }
  }

  void navigateTo(AdminPage page) {
    currentPage.value = page;
  }
}