import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/palette.dart';

import 'flows_controller.dart';
import '../../../widgets/widgets.dart';

// Minimal Button
class SmallButton extends StatelessWidget {
  final String label;
  final VoidCallback onPress;
  const SmallButton({super.key, required this.label, required this.onPress});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        minimumSize: Size(0, 30),
      ),
      onPressed: onPress,
      child: Text(label, style: TextStyle(fontSize: 12)),
    );
  }
}

class EditFlow extends StatefulWidget {
  const EditFlow({super.key});

  @override
  State<EditFlow> createState() => _EditFlowState();
}

class _EditFlowState extends State<EditFlow> {
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _downController = TextEditingController();
  final TextEditingController _leftController = TextEditingController();
  final TextEditingController _rightController = TextEditingController();

  int? _lastSelectedId;
  Timer? _saveDebounce;

  @override
  void dispose() {
    _widthController.dispose();
    _valueController.dispose();
    _downController.dispose();
    _leftController.dispose();
    _rightController.dispose();
    _saveDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FlowsController controller = Get.find<FlowsController>();

    return Obx(() {
      if (controller.selectedId.value < 0 ||
          controller.selectedId.value >= controller.flows.length) {
        return const SizedBox.shrink();
      }

      final selectedFlow = controller.flows[controller.selectedId.value];
      if (_lastSelectedId != controller.selectedId.value) {
        _widthController.text = selectedFlow.width.toString();
        _valueController.text = selectedFlow.value;
        _downController.text = selectedFlow.down.lineHeight.toString();
        _leftController.text = selectedFlow.left.lineHeight.toString();
        _rightController.text = selectedFlow.right.lineHeight.toString();
        _lastSelectedId = controller.selectedId.value;
      }

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
              const Text("width", style: TextStyle(fontSize: 12)),
              const SizedBox(height: 10),
              SmallTextBox(
                controller: _widthController,
                onType: (value) {
                  if (double.tryParse(value) != null) {
                    selectedFlow.width = double.parse(value);
                    controller.widthText.value = value;
                    controller.updateFlowsReactive();
                    controller.save();
                  }
                },
              ),
              const SizedBox(height: 15),
              const Text("value", style: TextStyle(fontSize: 12)),
              const SizedBox(height: 10),
              SmallTextBox(
                controller: _valueController,
                maxLines: 5,
                onType: (value) {
                  selectedFlow.value = value;
                  controller.valueText.value = value;
                  controller.updateFlowsReactive();
                  controller.save();
                },
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SmallButton(
                    label: "close",
                    onPress: () {
                      controller.window.value = "none";
                      controller.refreshUI();
                    },
                  ),
                  const SizedBox(width: 5),
                  SmallButton(
                    label: "delete",
                    onPress: () {
                      controller.deleteFlow(controller.selectedId.value);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
