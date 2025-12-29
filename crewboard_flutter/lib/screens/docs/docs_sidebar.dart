import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'flows/flows_controller.dart';
import '../../../config/palette.dart';
import 'document_editor_provider.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:serverpod_client/serverpod_client.dart';
import '../../widgets/widgets.dart';

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
              AddController(
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
                final isSelected = app.id == controller.selectedAppId.value;
                return InkWell(
                  onTap: () => controller.selectApp(app.id!),
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
                    child: Text(
                      app.appName,
                      style: TextStyle(
                        color: Pallet.font2,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
            IconButton(
              onPressed: controller.backToApps,
              icon: Icon(Icons.arrow_back, color: Pallet.font3),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 10),
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
            IconButton(
              onPressed: () => _showAddDialog(controller),
              icon: Icon(Icons.add, color: Pallet.font3),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
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
    return Container(
      decoration: BoxDecoration(
        color: Pallet.inside1,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTab(
            label: "Docs",
            isSelected: controller.currentSubPage.value == FlowSubPage.docs,
            onTap: () => controller.changeSubPage("docs"),
          ),
          _buildTab(
            label: "Flows",
            isSelected: controller.currentSubPage.value == FlowSubPage.flows,
            onTap: () => controller.changeSubPage("flows"),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Pallet.inside2 : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Pallet.font1 : Pallet.font3,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
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
        },
      );
    });
  }

  void _showAddDialog(FlowsController controller) {
    final TextEditingController textController = TextEditingController();
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.currentSubPage.value == FlowSubPage.flows
                    ? "Create New Flow"
                    : "Create New Doc",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text("Cancel"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        if (controller.currentSubPage.value ==
                            FlowSubPage.flows) {
                          controller.createNewFlow(textController.text);
                        } else {
                          // Create doc
                          if (!Get.isRegistered<DocumentEditorProvider>()) {
                            Get.put(DocumentEditorProvider());
                          }
                          final docProvider =
                              Get.find<DocumentEditorProvider>();
                          docProvider.addDoc(
                            controller.selectedAppId.value!,
                            textController.text,
                          );
                        }
                        Get.back();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "Create",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
