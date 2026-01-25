import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Adjusted imports for crewboard_flutter structure
import '../../../../widgets/glass_morph.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/text_box.dart';
import '../../../../config/palette.dart'; 

import 'types.dart';
import 'flows_controller.dart';

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

  void _recalculateSizeForFlow(
    FlowClass flow,
    String text,
    FlowsController controller,
  ) {
    if (controller.selectedType.value != FlowType.condition) {
      final double contentMaxWidth = (flow.width - 40).clamp(
        0,
        double.infinity,
      );
      final textPainter = TextPainter(
        text: TextSpan(text: text, style: TextStyle(fontSize: 13)),
        textDirection: TextDirection.ltr,
        maxLines: null,
      );
      textPainter.layout(minWidth: 0, maxWidth: contentMaxWidth);
      final double computedHeight = textPainter.size.height.ceilToDouble() + 40;
      flow.height = computedHeight < 40.0 ? 40.0 : computedHeight;
    } else {
      final textPainter = TextPainter(
        text: TextSpan(text: text, style: TextStyle(fontSize: 13)),
        textDirection: TextDirection.ltr,
        maxLines: null,
      );
      final double contentMaxWidth = (flow.width - 40).clamp(
        0,
        double.infinity,
      );
      textPainter.layout(minWidth: 0, maxWidth: contentMaxWidth);
      final double contentW = textPainter.size.width;
      final double contentH = textPainter.size.height;
      const double padding = 42;
      double requiredSide = max(contentW, contentH) + padding;
      if (requiredSide < Defaults.flowWidth) {
        requiredSide = Defaults.flowWidth;
      }
      if (flow.width < requiredSide) {
        flow.width = requiredSide.ceilToDouble();
        controller.widthText.value = flow.width.toString();
        _widthController.text = flow.width.toString();
      }
      flow.height = flow.width; // keep diamond square
    }
  }

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
    // Attempt to find controller, handle if not registered yet safely? 
    // Usually Get.find throws if not found, but assuming usage within context where it exists.
    final FlowsController controller = Get.find<FlowsController>();

    return Obx(() {
      if (controller.selectedId.value < 0 ||
          controller.selectedId.value >= controller.flows.length) {
        return SizedBox.shrink();
      }

      final selectedFlow = controller.flows[controller.selectedId.value];
      if (_lastSelectedId != controller.selectedId.value) {
        // Update controllers only when selection changes to avoid cursor jumps during typing
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
          margin: EdgeInsets.only(top: 10, right: 10),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Obx(() {
            final bool showLoopControls =
                controller.isSelectingLoop.value ||
                controller.loopFrom.value >= 0 ||
                controller.loopTo.value >= 0;
            if (showLoopControls) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("loop", style: TextStyle(fontSize: 12)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SmallButton(
                        label: controller.isPickingLoopFrom.value
                            ? "pick from (active)"
                            : (controller.loopFrom.value >= 0
                                  ? "change from"
                                  : "pick from"),
                        onPress: () {
                          controller.isPickingLoopFrom.value = true;
                          controller.isPickingLoopTo.value = false;
                        },
                      ),
                    ],
                  ),
                  if (controller.loopFrom.value >= 0)
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: _FlowPreview(
                        flow: controller.flows[controller.loopFrom.value],
                      ),
                    ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      SmallButton(
                        label: controller.isPickingLoopTo.value
                            ? "pick to (active)"
                            : (controller.loopTo.value >= 0
                                  ? "change to"
                                  : "pick to"),
                        onPress: () {
                          controller.isPickingLoopTo.value = true;
                          controller.isPickingLoopFrom.value = false;
                        },
                      ),
                    ],
                  ),
                  if (controller.loopTo.value >= 0)
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: _FlowPreview(
                        flow: controller.flows[controller.loopTo.value],
                      ),
                    ),
                  SizedBox(height: 6),
                  InkWell(
                    onTap: () {
                      controller.flipPendingLoop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Pallet.inside1,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("flip", style: TextStyle(fontSize: 12)),
                          SizedBox(width: 10),
                          Icon(Icons.swap_horiz, size: 18),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      if ((controller.isSelectingLoop.value ||
                              (controller.loopFrom.value >= 0 &&
                                  controller.loopTo.value >= 0)) &&
                          controller.loopFrom.value >= 0 &&
                          controller.loopTo.value >= 0) {
                        controller.deleteLoop(
                          controller.loopFrom.value,
                          controller.loopTo.value,
                        );
                        controller.loopFrom.value = -1;
                        controller.loopTo.value = -1;
                        controller.isPickingLoopFrom.value = false;
                        controller.isPickingLoopTo.value = false;
                        controller.window.value = "none";
                        controller.updateFlowsReactive();
                      } else {
                        controller.deleteFlow(controller.selectedId.value);
                        controller.window.value = "none";
                        controller.updateFlowsReactive();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Pallet.inside1,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("delete", style: TextStyle(fontSize: 12)),
                          SizedBox(width: 10),
                          Icon(Icons.delete, size: 18),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SmallButton(
                        label: "close",
                        onPress: () {
                          controller.isSelectingLoop.value = false;
                          controller.loopFrom.value = -1;
                          controller.loopTo.value = -1;
                          controller.isPickingLoopFrom.value = false;
                          controller.isPickingLoopTo.value = false;
                          controller.window.value = "none";
                          controller.updateFlowsReactive();
                        },
                      ),
                    ],
                  ),
                ],
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("width", style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                SmallTextBox(
                  controller: _widthController,
                  onType: (value) async {
                    if (!(controller.systemVariables.value?.allowEdit ?? true)) {
                      Get.snackbar("Permission Denied", "Editing is disabled in settings");
                      _widthController.text = selectedFlow.width.toString();
                      return;
                    }
                    if (double.tryParse(value) != null &&
                        double.parse(value) >= Defaults.flowWidth) {
                      selectedFlow.width = double.parse(value);
                      controller.widthText.value = value;
                      _recalculateSizeForFlow(
                        selectedFlow,
                        _valueController.text,
                        controller,
                      );
                      controller.updateFlowsReactive();
                      _saveDebounce?.cancel();
                      _saveDebounce = Timer(Duration(milliseconds: 500), () {
                        controller.save();
                      });
                    }
                  },
                ),
                SizedBox(height: 15),
                Text("value", style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                SmallTextBox(
                  controller: _valueController,
                  maxLines: 5,
                  onType: (value) {
                    if (!(controller.systemVariables.value?.allowEdit ?? true)) {
                      Get.snackbar("Permission Denied", "Editing is disabled in settings");
                      _valueController.text = selectedFlow.value;
                      return;
                    }
                    selectedFlow.value = value;
                    controller.valueText.value = value;
                    _recalculateSizeForFlow(selectedFlow, value, controller);
                    controller.updateFlowsReactive();
                    _saveDebounce?.cancel();
                    _saveDebounce = Timer(Duration(milliseconds: 500), () {
                      controller.save();
                    });
                  },
                ),

                if (selectedFlow.down.hasChild ||
                    selectedFlow.right.hasChild ||
                    selectedFlow.left.hasChild)
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text("line heights", style: TextStyle(fontSize: 12)),
                  ),
                SizedBox(height: 10),
                if (selectedFlow.down.hasChild)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 45,
                          child: Text("down", style: TextStyle(fontSize: 12)),
                        ),
                        Expanded(
                          child: SmallTextBox(
                            controller: _downController,
                            onType: (value) {
                              if (!(controller.systemVariables.value?.allowEdit ?? true)) {
                                Get.snackbar("Permission Denied", "Editing is disabled in settings");
                                _downController.text = selectedFlow.down.lineHeight.toString();
                                return;
                              }
                              if (value.isNotEmpty &&
                                  double.tryParse(value) != null) {
                                selectedFlow.down.lineHeight = double.parse(
                                  value,
                                );
                                controller.downText.value = value;
                                controller.forceRepositionAllFlows();
                                controller.save();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                if (selectedFlow.left.hasChild)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 45,
                          child: Text("left", style: TextStyle(fontSize: 12)),
                        ),
                        Expanded(
                          child: SmallTextBox(
                            controller: _leftController,
                            onType: (value) {
                              if (!(controller.systemVariables.value?.allowEdit ?? true)) {
                                Get.snackbar("Permission Denied", "Editing is disabled in settings");
                                _leftController.text = selectedFlow.left.lineHeight.toString();
                                return;
                              }
                              if (value.isNotEmpty &&
                                  double.tryParse(value) != null) {
                                selectedFlow.left.lineHeight = double.parse(
                                  value,
                                );
                                controller.leftText.value = value;
                                controller.forceRepositionAllFlows();
                                controller.save();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                if (selectedFlow.right.hasChild)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 45,
                          child: Text("right", style: TextStyle(fontSize: 12)),
                        ),
                        Expanded(
                          child: SmallTextBox(
                            controller: _rightController,
                            onType: (value) {
                              if (!(controller.systemVariables.value?.allowEdit ?? true)) {
                                Get.snackbar("Permission Denied", "Editing is disabled in settings");
                                _rightController.text = selectedFlow.right.lineHeight.toString();
                                return;
                              }
                              if (value.isNotEmpty &&
                                  double.tryParse(value) != null) {
                                selectedFlow.right.lineHeight = double.parse(
                                  value,
                                );
                                controller.rightText.value = value;
                                controller.forceRepositionAllFlows();
                                controller.save();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                if (controller.systemVariables.value?.showDelete ?? true)
                  InkWell(
                    onTap: () {
                      if (!(controller.systemVariables.value?.allowDelete ?? true)) {
                        Get.snackbar("Permission Denied", "Deleting is disabled in settings");
                        return;
                      }
                      if ((controller.isSelectingLoop.value ||
                              (controller.loopFrom.value >= 0 &&
                                  controller.loopTo.value >= 0)) &&
                          controller.loopFrom.value >= 0 &&
                          controller.loopTo.value >= 0) {
                        controller.deleteLoop(
                          controller.loopFrom.value,
                          controller.loopTo.value,
                        );
                        controller.loopFrom.value = -1;
                        controller.loopTo.value = -1;
                        controller.isPickingLoopFrom.value = false;
                        controller.isPickingLoopTo.value = false;
                        controller.window.value = "none";
                        controller.updateFlowsReactive();
                      } else {
                        controller.deleteFlow(controller.selectedId.value);
                        controller.window.value = "none";
                        controller.updateFlowsReactive();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Pallet.inside1,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("delete", style: TextStyle(fontSize: 12)),
                          SizedBox(width: 10),
                          Icon(Icons.delete, size: 18),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SmallButton(
                      label: "done",
                      onPress: () {
                        controller.save();
                        controller.window.value = "none";
                        controller.updateFlowsReactive();
                      },
                    ),
                    SizedBox(width: 5),
                    SmallButton(
                      label: "close",
                      onPress: () {
                        controller.window.value = "none";
                        controller.updateFlowsReactive();
                      },
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      );
    });
  }
}

class _FlowPreview extends StatelessWidget {
  const _FlowPreview({required this.flow});
  final FlowClass flow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Pallet.inside1,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "#${flow.id} • ${flow.type.name}",
            style: TextStyle(fontSize: 11, color: Pallet.font2),
          ),
          SizedBox(height: 4),
          Text(flow.value, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
