import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/palette.dart';
import '../../controllers/planner_controller.dart';
import '../../widgets/widgets.dart';
import '../../widgets/tabs.dart';
import 'widgets/app_list_item.dart';

class AppsSidebar extends ConsumerWidget {
  const AppsSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(plannerProvider);
    final notifier = ref.read(plannerProvider.notifier);
    final apps = state.apps;

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
              Tabs(
                tabs: [
                  TabItem(
                    label: "Buckets",
                    value: PlannerSubPage.bucket,
                    isSelected: state.currentSubPage == PlannerSubPage.bucket,
                  ),
                  TabItem(
                    label: "Search",
                    value: PlannerSubPage.search,
                    isSelected: state.currentSubPage == PlannerSubPage.search,
                  ),
                ],
                onTabChanged: (value) => notifier.changeSubPage(value),
              ),
              const SizedBox(width: 5),
              CreateItemOverlayButton(
                showColor: true,
                onSave: (name, colorId) async {
                  if (colorId != null) {
                    await notifier.addApp(name, colorId);
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
                  isSelected: app.id == state.selectedAppId,
                  onTap: () => notifier.selectApp(app.id!),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
