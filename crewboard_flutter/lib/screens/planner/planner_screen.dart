import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/palette.dart';
import '../../controllers/planner_controller.dart';
import '../../widgets/widgets.dart';
import '../../widgets/tabs.dart';
import '../sidebar.dart';
import 'bucket_view.dart';
import 'search_view.dart';

class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PlannerController plannerController = Get.put(PlannerController());

    return Row(
      children: [
        SideBar(
          children: [
            Obx(() {
              final apps = plannerController.apps;
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Projects",
                              style: TextStyle(
                                fontSize: 17,
                                color: Pallet.font3,
                              ),
                            ),
                          ),
                          AddController(
                            showColor: true,
                            onSave: (name, color) async {
                              if (color != null) {
                                await plannerController.addApp(
                                  name,
                                  int.parse(color),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Obx(() {
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
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView(
                        children: [
                          for (var app in apps)
                            AppListItem(
                              app: app,
                              isSelected:
                                  app.id ==
                                  plannerController.selectedAppId.value,
                              onTap: () => plannerController.selectApp(app.id!),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
        Obx(() {
          if (plannerController.selectedAppId.value == 0) {
            return const Expanded(
              child: Center(
                child: Text(
                  "Select a project to view planner",
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            );
          }
          final currentPage = plannerController.currentSubPage.value;
          if (currentPage == PlannerSubPage.search) {
            return const Expanded(child: SearchView());
          } else {
            return const Expanded(child: BucketView());
          }
        }),
      ],
    );
  }
}
