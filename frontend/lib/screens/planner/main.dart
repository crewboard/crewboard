import 'package:flutter/material.dart';
import 'package:frontend/screens/docs/flows/widgets.dart';
import 'package:get/get.dart';
import 'package:frontend/screens/planner/planner_controller.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/widgets/widgets.dart';
import 'package:frontend/backend/server.dart';
import 'package:frontend/services/arri_client.rpc.dart';
import '../sidebar.dart';
import 'buckets.dart';
import 'search.dart';
import '../../widgets/tabs.dart';
import 'types.dart';

class Planner extends StatelessWidget {
  const Planner({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the PlannerController
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
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Projects",
                              style: TextStyle(
                                fontSize: 17,
                                color: Pallet.font3,
                              ),
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            Obx(() {
                              final PlannerController plannerController = Get.find<PlannerController>();
                              return Tabs(
                                tabs: [
                                  TabItem(
                                    label: "Buckets",
                                    value: "buckets",
                                    isSelected: plannerController.currentSubPage.value == PlannerSubPage.bucket,
                                  ),
                                  TabItem(
                                    label: "Search",
                                    value: "search",
                                    isSelected: plannerController.currentSubPage.value == PlannerSubPage.search,
                                  ),
                                ],
                                onTabChanged: (value) => plannerController.changeSubPage(value),
                              );
                            }),
                            SizedBox(width: 10),
                            AddController(
                              showColor: true,
                              onSave: (name, color) async {
                                print('Adding app: $name, $color');
                                try {
                                  // Call the addApp API
                                  final response = await server.admin.addApp(
                                    AddAppParams(
                                      appId: null, // null for new app
                                      appName: name,
                                      colorId: color,
                                      action: "add",
                                    ),
                                  );

                                  if (response.status == 200) {
                                    // Refresh the apps list after successful addition
                                    plannerController.loadApps();
                                    print('App added successfully: $name');
                                  } else {
                                    print(
                                      'Failed to add app: ${response.status}',
                                    );
                                  }
                                } catch (e) {
                                  print('Error adding app: $e');
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      child: ListView(
                        children: [
                          for (var app in apps)
                            AppListItem(
                              app: app,
                              isSelected:
                                  app.id ==
                                  plannerController.selectedAppId.value,
                              onTap: () => plannerController.selectApp(app.id),
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
          if (plannerController.selectedAppId.value.isEmpty) {
            return Expanded(child: Container());
          }
          final currentPage = plannerController.currentSubPage.value;
          if (currentPage == PlannerSubPage.search) {
            return Expanded(child: SearchView());
          } else {
            return Expanded(child: BucketView());
          }
        }),
      ],
    );
  }
}
