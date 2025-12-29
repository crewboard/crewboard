import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'flows/flows_controller.dart';
import 'flows/flows.dart';
import 'document_editor.dart';
import 'docs_sidebar.dart';

class DocsScreen extends StatelessWidget {
  const DocsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<FlowsController>()) {
      Get.put(FlowsController());
    }
    final FlowsController controller = Get.find<FlowsController>();

    return Obx(() {
      // Show Flows or DocumentEditor based on current subpage
      if (controller.currentSubPage.value == FlowSubPage.flows) {
        return const Flows();
      } else {
        return const DocumentEditor();
      }
    });
  }
}
