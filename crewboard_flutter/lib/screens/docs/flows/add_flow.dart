import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'types.dart';
import 'flows_controller.dart';
import '../../../widgets/glass_morph.dart'; // Ensure this exists or use Container

// Minimal button replacement if Button widget is missing
class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPress;
  const Button({super.key, required this.label, required this.onPress});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      onPressed: onPress,
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}

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
              child: Button(
                label: "Terminal",
                onPress: () {
                  controller.addFlow(FlowType.terminal);
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Button(
                label: "Process",
                onPress: () {
                  controller.addFlow(FlowType.process);
                },
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Button(
                label: "Condition",
                onPress: () {
                  controller.addFlow(FlowType.condition);
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
