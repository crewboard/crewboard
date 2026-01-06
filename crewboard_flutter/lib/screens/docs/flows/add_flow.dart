import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'types.dart';
import 'flows_controller.dart';
import '../../../widgets/glass_morph.dart'; // Ensure this exists or use Container

import '../../../widgets/widgets.dart';

class AddFlow extends StatelessWidget {
  const AddFlow({super.key});

  @override
  Widget build(BuildContext context) {
    final FlowsController controller = Get.find<FlowsController>();

    return SizedBox(
      width: 200,
      child: GlassMorph(
        borderRadius: 10,
        margin: const EdgeInsets.only(top: 10, right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("add flow", style: TextStyle(fontSize: 12)),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: SmallButton(
                label: "Terminal",
                onPress: () {
                  controller.addFlow(FlowType.terminal);
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: SmallButton(
                label: "Process",
                onPress: () {
                  controller.addFlow(FlowType.process);
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: SmallButton(
                label: "Condition",
                onPress: () {
                  controller.addFlow(FlowType.condition);
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: SmallButton(
                label: "User",
                onPress: () {
                  controller.addFlow(FlowType.user);
                },
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    controller.window.value = "none";
                    controller.refreshUI();
                  },
                  child: const Text(
                    "close",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
