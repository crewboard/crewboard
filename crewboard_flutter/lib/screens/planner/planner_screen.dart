import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/planner_controller.dart';

import 'bucket_view.dart';
import 'search_view.dart';

class PlannerScreen extends StatelessWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PlannerController plannerController = Get.put(PlannerController());

    return Obx(() {
      if (plannerController.selectedAppId.value == null) {
        return const Center(
          child: Text(
            "Select a project to view planner",
            style: TextStyle(color: Colors.white54),
          ),
        );
      }
      final currentPage = plannerController.currentSubPage.value;
      if (currentPage == PlannerSubPage.search) {
        return const SearchView();
      } else {
        return const BucketView();
      }
    });
  }
}
