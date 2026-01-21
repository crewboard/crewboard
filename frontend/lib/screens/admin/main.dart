import 'package:flutter/material.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/backend/types.dart';
import 'package:frontend/screens/admin/admin_widgets.dart';
import 'package:frontend/screens/sidebar.dart';
import 'package:frontend/screens/admin/admin_router_controller.dart';
import 'package:frontend/backend/server.dart';
import 'package:get/get.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final AdminRouterController adminRouter = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SideBar(
          children: [
            const SizedBox(height: 10),
            if (Permissions.users ||
                Permissions.chat ||
                Permissions.planner ||
                Permissions.flowie)
              Column(
                children: [
                  Obx(
                    () => SideBarButton(
                      isActive:
                          adminRouter.currentPage.value == AdminPage.general,
                      label: "general",
                      onPress: () {
                        adminRouter.navigateTo(AdminPage.general);
                      },
                    ),
                  ),
                  if (Permissions.users)
                    Obx(
                      () => SideBarButton(
                        isActive:
                            adminRouter.currentPage.value == AdminPage.users,
                        label: "users",
                        onPress: () {
                          adminRouter.navigateTo(AdminPage.users);
                        },
                      ),
                    ),
                  if (Permissions.users)
                    Obx(
                      () => SideBarButton(
                        isActive:
                            adminRouter.currentPage.value ==
                            AdminPage.attendance,
                        label: "attendance",
                        onPress: () {
                          adminRouter.navigateTo(AdminPage.attendance);
                        },
                      ),
                    ),
                  if (Permissions.users)
                    Obx(
                      () => SideBarButton(
                        isActive:
                            adminRouter.currentPage.value ==
                            AdminPage.performance,
                        label: "performance",
                        onPress: () {
                          adminRouter.navigateTo(AdminPage.performance);
                        },
                      ),
                    ),
                  if (Permissions.planner)
                    Obx(
                      () => SideBarButton(
                        isActive:
                            adminRouter.currentPage.value == AdminPage.planner,
                        label: "planner",
                        onPress: () {
                          adminRouter.navigateTo(AdminPage.planner);
                        },
                      ),
                    ),
                  if (Permissions.chat || Permissions.flowie)
                    Obx(
                      () => SideBarButton(
                        isActive:
                            adminRouter.currentPage.value == AdminPage.system,
                        label: "system",
                        onPress: () {
                          adminRouter.navigateTo(AdminPage.system);
                        },
                      ),
                    ),
                ],
              ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),

            child: Obx(() => adminRouter.currentAdminPageWidget),
          ),
        ),
      ],
    );
  }
}
