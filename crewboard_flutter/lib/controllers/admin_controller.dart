import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screens/admin/general_settings.dart';
import '../screens/admin/users_settings.dart';
import '../screens/admin/attendance/attendance.dart';
import '../screens/admin/planner/planner_settings.dart';
import '../screens/admin/docs/documentation_settings.dart';

enum AdminPage {
  general,
  users,
  attendance,
  planner,
  documentation,
}

final adminProvider = NotifierProvider<AdminNotifier, AdminPage>(AdminNotifier.new);

class AdminNotifier extends Notifier<AdminPage> {
  @override
  AdminPage build() {
    return AdminPage.general;
  }

  void navigateTo(AdminPage page) {
    state = page;
  }
}

final adminPageWidgetProvider = Provider<Widget>((ref) {
  final currentPage = ref.watch(adminProvider);
  switch (currentPage) {
    case AdminPage.general:
      return const GeneralSettings();
    case AdminPage.users:
      return const UsersSettings();
    case AdminPage.attendance:
      return const AttendanceScreen();
    case AdminPage.planner:
      return const PlannerSettings();
    case AdminPage.documentation:
      return const DocumentationSettings();
  }
});
