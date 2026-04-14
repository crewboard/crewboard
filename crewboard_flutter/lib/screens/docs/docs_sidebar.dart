import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'flows/flows_controller.dart';
import '../../../config/palette.dart';
import 'document_editor_provider.dart';
import '../../widgets/widgets.dart';
import '../../widgets/tabs.dart';
import '../planner/widgets/app_list_item.dart';

enum SidebarMode { apps, flows }

enum FlowSubPage { docs, flows }

class DocsSidebar extends ConsumerWidget {
  const DocsSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowsState = ref.watch(flowsProvider);
    final flowsNotifier = ref.read(flowsProvider.notifier);

    if (flowsState.sidebarMode == SidebarMode.apps) {
      // Apps section - select a project
      return _buildAppsSection(flowsState, flowsNotifier);
    } else {
      // Flows/Docs section - show tabs and list
      return _buildFlowsSection(ref, flowsState, flowsNotifier);
    }
  }

  Widget _buildAppsSection(FlowsState state, FlowsNotifier notifier) {
    return Column(
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
              if (state.systemVariables?.showEdit ?? true)
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
          child: state.isLoadingApps
              ? const Center(child: CircularProgressIndicator())
              : state.apps.isEmpty
              ? Center(
                  child: Text(
                    "No projects",
                    style: TextStyle(color: Pallet.font3, fontSize: 12),
                  ),
                )
              : ListView.builder(
                  itemCount: state.apps.length,
                  itemBuilder: (context, index) {
                    final app = state.apps[index];
                    return AppListItem(
                      app: app,
                      isSelected: app.id == state.selectedAppId,
                      onTap: () => notifier.selectApp(app.id!),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFlowsSection(
    WidgetRef ref,
    FlowsState state,
    FlowsNotifier notifier,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        // Header with back button and tabs
        Row(
          children: [
            const SizedBox(width: 5),
            IconButton(
              onPressed: notifier.backToApps,
              icon: Icon(CupertinoIcons.back, color: Pallet.font3, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                state.currentSubPage == FlowSubPage.docs ? "Docs" : "Flows",
                style: TextStyle(
                  fontSize: 17,
                  color: Pallet.font3,
                ),
              ),
            ),
            // Tabs
            _buildTabs(state, notifier),
            const SizedBox(width: 10),
            // Add button
            if (state.systemVariables?.showEdit ?? true)
              CreateItemOverlayButton(
                onSave: (name, _) {
                  if (name.isNotEmpty) {
                    if (state.currentSubPage == FlowSubPage.flows) {
                      notifier.createNewFlow(name);
                    } else {
                      if (state.selectedAppId != null) {
                        ref
                            .read(documentEditorProvider.notifier)
                            .addDoc(
                              state.selectedAppId!,
                              name,
                            );
                      }
                    }
                  }
                },
              ),
          ],
        ),
        const SizedBox(height: 10),
        // List of flows or docs
        Expanded(
          child: state.currentSubPage == FlowSubPage.flows
              ? _buildFlowsList(state, notifier)
              : _buildDocsList(ref),
        ),
      ],
    );
  }

  Widget _buildTabs(FlowsState state, FlowsNotifier notifier) {
    return Tabs(
      tabs: [
        TabItem(
          label: "Docs",
          value: "docs",
          isSelected: state.currentSubPage == FlowSubPage.docs,
        ),
        TabItem(
          label: "Flows",
          value: "flows",
          isSelected: state.currentSubPage == FlowSubPage.flows,
        ),
      ],
      onTabChanged: (value) => notifier.changeSubPage(value),
    );
  }

  Widget _buildFlowsList(FlowsState state, FlowsNotifier notifier) {
    if (state.isLoadingFlows) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.savedFlows.isEmpty) {
      return Center(
        child: Text(
          "No saved flows",
          style: TextStyle(
            color: Pallet.font3,
            fontSize: 12,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: state.savedFlows.length,
      itemBuilder: (context, index) {
        final flow = state.savedFlows[index];
        final isSelected = state.currentFlowId == flow.id;
        return InkWell(
          onTap: () => notifier.loadFlow(flow.id!),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: isSelected ? Pallet.inside2 : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? Pallet.inside3 : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    flow.name,
                    style: TextStyle(
                      color: Pallet.font2,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Pallet.font3,
                  size: 12,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDocsList(WidgetRef ref) {
    final docState = ref.watch(documentEditorProvider);
    final docNotifier = ref.read(documentEditorProvider.notifier);

    if (docState.isLoadingDocs) {
      return const Center(child: CircularProgressIndicator());
    }
    if (docState.savedDocs.isEmpty) {
      return Center(
        child: Text(
          "No saved docs",
          style: TextStyle(
            color: Pallet.font3,
            fontSize: 12,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: docState.savedDocs.length,
      itemBuilder: (context, index) {
        final doc = docState.savedDocs[index];
        final isSelected = docState.selectedDocId == doc.id;
        return InkWell(
          onTap: () => docNotifier.loadDoc(doc),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: isSelected ? Pallet.inside2 : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? Pallet.inside3 : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    doc.name,
                    style: TextStyle(
                      color: Pallet.font2,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Pallet.font3,
                  size: 12,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
