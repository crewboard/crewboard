import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'flows/flows_controller.dart';
import '../../../config/palette.dart';
import 'document_editor_provider.dart';
import '../../widgets/widgets.dart';
import '../../widgets/tabs.dart';
import '../planner/widgets/app_list_item.dart';

enum SidebarMode { apps, flows }

enum FlowSubPage { docs, flows }

class DocsSidebar extends StatelessWidget {
  const DocsSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<FlowsController>()) {
      Get.put(FlowsController());
    }
    final FlowsController controller = Get.find<FlowsController>();

    return Obx(() {
      if (controller.sidebarMode.value == SidebarMode.apps) {
        // Apps section - select a project
        return _buildAppsSection(controller);
      } else {
        // Flows/Docs section - show tabs and list
        return _buildFlowsSection(controller);
      }
    });
  }

  Widget _buildAppsSection(FlowsController controller) {
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
              if (Get.find<FlowsController>().systemVariables.value?.showEdit ?? true)
                CreateItemOverlayButton(
                  showColor: true,
                  onSave: (name, colorId) async {
                    if (colorId != null) {
                      await controller.addApp(name, colorId);
                    }
                  },
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Obx(() {
            if (controller.isLoadingApps.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.apps.isEmpty) {
              return Center(
                child: Text(
                  "No projects",
                  style: TextStyle(color: Pallet.font3, fontSize: 12),
                ),
              );
            }
            return ListView.builder(
              itemCount: controller.apps.length,
              itemBuilder: (context, index) {
                final app = controller.apps[index];
                return Obx(
                  () => AppListItem(
                    app: app,
                    isSelected: app.id == controller.selectedAppId.value,
                    onTap: () => controller.selectApp(app.id!),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildFlowsSection(FlowsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        // Header with back button and tabs
        Row(
          children: [
            SizedBox(width: 5),
            IconButton(
              onPressed: controller.backToApps,
              icon: Icon(CupertinoIcons.back, color: Pallet.font3, size: 20),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Obx(() {
                final heading =
                    controller.currentSubPage.value == FlowSubPage.docs
                    ? "Docs"
                    : "Flows";
                return Text(
                  heading,
                  style: TextStyle(
                    fontSize: 17,
                    color: Pallet.font3,
                  ),
                );
              }),
            ),
            // Tabs
            Obx(() {
              return _buildTabs(controller);
            }),
            const SizedBox(width: 10),
            // Add button
            if (controller.systemVariables.value?.showEdit ?? true)
              CreateItemOverlayButton(
                onSave: (name, _) {
                  if (name.isNotEmpty) {
                    if (controller.currentSubPage.value == FlowSubPage.flows) {
                      controller.createNewFlow(name);
                    } else {
                      if (!Get.isRegistered<DocumentEditorProvider>()) {
                        Get.put(DocumentEditorProvider());
                      }
                      final docProvider = Get.find<DocumentEditorProvider>();
                      if (controller.selectedAppId.value != null) {
                        docProvider.addDoc(
                          controller.selectedAppId.value!,
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
          child: Obx(() {
            if (controller.currentSubPage.value == FlowSubPage.flows) {
              return _buildFlowsList(controller);
            } else {
              return _buildDocsList(controller);
            }
          }),
        ),
      ],
    );
  }

  Widget _buildTabs(FlowsController controller) {
    return Tabs(
      tabs: [
        TabItem(
          label: "Docs",
          value: "docs",
          isSelected: controller.currentSubPage.value == FlowSubPage.docs,
        ),
        TabItem(
          label: "Flows",
          value: "flows",
          isSelected: controller.currentSubPage.value == FlowSubPage.flows,
        ),
      ],
      onTabChanged: (value) => controller.changeSubPage(value),
    );
  }

  Widget _buildFlowsList(FlowsController controller) {
    return Obx(() {
      if (controller.isLoadingFlows.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.savedFlows.isEmpty) {
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
        itemCount: controller.savedFlows.length,
        itemBuilder: (context, index) {
          final flow = controller.savedFlows[index];
          return Obx(() {
            final isSelected = controller.currentFlowId.value == flow.id;
            return InkWell(
              onTap: () => controller.loadFlow(flow.id!),
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
          });
        },
      );
    });
  }

  Widget _buildDocsList(FlowsController controller) {
    if (!Get.isRegistered<DocumentEditorProvider>()) {
      Get.put(DocumentEditorProvider());
    }
    final DocumentEditorProvider docProvider =
        Get.find<DocumentEditorProvider>();

    return Obx(() {
      if (docProvider.isLoadingDocs.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (docProvider.savedDocs.isEmpty) {
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
        itemCount: docProvider.savedDocs.length,
        itemBuilder: (context, index) {
          final doc = docProvider.savedDocs[index];
          return Obx(() {
            final isSelected = docProvider.selectedDocId.value == doc.id;
            return InkWell(
              onTap: () => docProvider.loadDoc(doc),
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
          });
        },
      );
    });
  }
}
