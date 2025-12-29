import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/palette.dart';
import '../../controllers/planner_controller.dart';
import '../../widgets/widgets.dart';
import '../../widgets/tabs.dart';

class AppsSidebar extends StatelessWidget {
  const AppsSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final PlannerController plannerController = Get.put(PlannerController());

    return Obx(() {
      final apps = plannerController.apps;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  "Projects",
                  style: TextStyle(
                    fontSize: 17,
                    color: Pallet.font3,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Obx(() {
                  return Tabs(
                    tabs: [
                      TabItem(
                        label: "Buckets",
                        value: PlannerSubPage.bucket,
                        isSelected:
                            plannerController.currentSubPage.value ==
                            PlannerSubPage.bucket,
                      ),
                      TabItem(
                        label: "Search",
                        value: PlannerSubPage.search,
                        isSelected:
                            plannerController.currentSubPage.value ==
                            PlannerSubPage.search,
                      ),
                    ],
                    onTabChanged: (value) =>
                        plannerController.changeSubPage(value),
                  );
                }),
                const SizedBox(width: 5),
                AddController(
                  showColor: true,
                  onSave: (name, colorId) async {
                    if (colorId != null) {
                      await plannerController.addApp(name, colorId);
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                for (var app in apps)
                  AppListItem(
                    app: app,
                    isSelected: app.id == plannerController.selectedAppId.value,
                    onTap: () => plannerController.selectApp(app.id!),
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
