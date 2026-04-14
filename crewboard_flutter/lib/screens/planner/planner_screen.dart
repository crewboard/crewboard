import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/planner_controller.dart';

import 'bucket_view.dart';
import 'search_view.dart';

class PlannerScreen extends ConsumerWidget {
  const PlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plannerState = ref.watch(plannerProvider);

    if (plannerState.selectedAppId == null) {
      return const Center(
        child: Text(
          "Select a project to view planner",
          style: TextStyle(color: Colors.white54),
        ),
      );
    }
    
    final currentPage = plannerState.currentSubPage;
    if (currentPage == PlannerSubPage.search) {
      return const SearchView();
    } else {
      return const BucketView();
    }
  }
}
