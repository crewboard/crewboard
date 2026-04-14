import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Adjusted imports for crewboard_flutter structure
import '../../../../widgets/glass_morph.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/text_box.dart';
import '../../../../config/palette.dart';

import 'types.dart';
import 'flows_controller.dart';

class EditFlow extends ConsumerStatefulWidget {
  const EditFlow({super.key});

  @override
  ConsumerState<EditFlow> createState() => _EditFlowState();
}

class _EditFlowState extends ConsumerState<EditFlow> {
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
    FlowsNotifier notifier,
    FlowType selectedType,
  ) {
    if (selectedType != FlowType.condition) {
      final double contentMaxWidth = (flow.width - 40).clamp(
        0,
        double.infinity,
      );
      final textPainter = TextPainter(
        text: TextSpan(text: text, style: const TextStyle(fontSize: 13)),
        textDirection: TextDirection.ltr,
        maxLines: null,
      );
      textPainter.layout(minWidth: 0, maxWidth: contentMaxWidth);
      final double computedHeight = textPainter.size.height.ceilToDouble() + 40;
      flow.height = computedHeight < 40.0 ? 40.0 : computedHeight;
    } else {
      final textPainter = TextPainter(
        text: TextSpan(text: text, style: const TextStyle(fontSize: 13)),
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
    final flowsState = ref.watch(flowsProvider);
    final flowsNotifier = ref.read(flowsProvider.notifier);

    final flowIdx = flowsState.flows.indexWhere((f) => f.id == flowsState.selectedId);
    if (flowIdx == -1) {
      return const SizedBox.shrink();
    }

    final selectedFlow = flowsState.flows[flowIdx];
    if (_lastSelectedId != flowsState.selectedId) {
      // Update controllers only when selection changes to avoid cursor jumps during typing
      _widthController.text = selectedFlow.width.toString();
      _valueController.text = selectedFlow.value;
      _downController.text = selectedFlow.down.lineHeight.toString();
      _leftController.text = selectedFlow.left.lineHeight.toString();
      _rightController.text = selectedFlow.right.lineHeight.toString();
      _lastSelectedId = flowsState.selectedId;
    }

    return SizedBox(
      width: 200,
      child: GlassMorph(
        borderRadius: 10,
        margin: const EdgeInsets.only(top: 10, right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: () {
          final bool showLoopControls =
              flowsState.isSelectingLoop ||
              flowsState.loopFrom >= 0 ||
              flowsState.loopTo >= 0;
          if (showLoopControls) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("loop", style: TextStyle(fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SmallButton(
                      label: flowsState.isPickingLoopFrom
                          ? "pick from (active)"
                          : (flowsState.loopFrom >= 0
                                ? "change from"
                                : "pick from"),
                      onPress: () {
                        flowsNotifier.startLoopSelection(true);
                      },
                    ),
                  ],
                ),
                if (flowsState.loopFrom >= 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Builder(
                      builder: (context) {
                        final idx = flowsState.flows.indexWhere((f) => f.id == flowsState.loopFrom);
                        if (idx == -1) return const SizedBox.shrink();
                        return _FlowPreview(
                          flow: flowsState.flows[idx],
                        );
                      }
                    ),
                  ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    SmallButton(
                      label: flowsState.isPickingLoopTo
                          ? "pick to (active)"
                          : (flowsState.loopTo >= 0
                                ? "change to"
                                : "pick to"),
                      onPress: () {
                        flowsNotifier.startLoopSelection(false);
                      },
                    ),
                  ],
                ),
                if (flowsState.loopTo >= 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Builder(
                      builder: (context) {
                        final idx = flowsState.flows.indexWhere((f) => f.id == flowsState.loopTo);
                        if (idx == -1) return const SizedBox.shrink();
                        return _FlowPreview(
                          flow: flowsState.flows[idx],
                        );
                      }
                    ),
                  ),
                const SizedBox(height: 6),
                InkWell(
                  onTap: () {
                    flowsNotifier.flipPendingLoop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Pallet.inside1,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("flip", style: TextStyle(fontSize: 12)),
                        SizedBox(width: 10),
                        Icon(Icons.swap_horiz, size: 18),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    if ((flowsState.isSelectingLoop ||
                            (flowsState.loopFrom >= 0 &&
                                flowsState.loopTo >= 0)) &&
                        flowsState.loopFrom >= 0 &&
                        flowsState.loopTo >= 0) {
                      flowsNotifier.deleteLoop(
                        flowsState.loopFrom,
                        flowsState.loopTo,
                      );
                      flowsNotifier.cancelLoopSelection();
                    } else {
                      flowsNotifier.deleteFlow(flowsState.selectedId);
                      flowsNotifier.cancelLoopSelection(); // Handles closing window
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Pallet.inside1,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("delete", style: TextStyle(fontSize: 12)),
                        SizedBox(width: 10),
                        Icon(Icons.delete, size: 18),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SmallButton(
                      label: "close",
                      onPress: () {
                        flowsNotifier.cancelLoopSelection();
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
              const Text("width", style: TextStyle(fontSize: 12)),
              const SizedBox(height: 10),
              SmallTextBox(
                controller: _widthController,
                onType: (value) async {
                  if (!(flowsState.systemVariables?.allowEdit ??
                      true)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Editing is disabled in settings")),
                    );
                    _widthController.text = selectedFlow.width.toString();
                    return;
                  }
                  if (double.tryParse(value) != null &&
                      double.parse(value) >= Defaults.flowWidth) {
                    selectedFlow.width = double.parse(value);
                    _recalculateSizeForFlow(
                      selectedFlow,
                      _valueController.text,
                      flowsNotifier,
                      selectedFlow.type,
                    );
                    _saveDebounce?.cancel();
                    _saveDebounce = Timer(const Duration(milliseconds: 500), () {
                      flowsNotifier.save();
                    });
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
                  if (!(flowsState.systemVariables?.allowEdit ??
                      true)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Editing is disabled in settings")),
                    );
                    _valueController.text = selectedFlow.value;
                    return;
                  }
                  selectedFlow.value = value;
                  _recalculateSizeForFlow(selectedFlow, value, flowsNotifier, selectedFlow.type);
                  _saveDebounce?.cancel();
                  _saveDebounce = Timer(const Duration(milliseconds: 500), () {
                    flowsNotifier.save();
                  });
                },
              ),

              if (selectedFlow.down.hasChild ||
                  selectedFlow.right.hasChild ||
                  selectedFlow.left.hasChild)
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text("line heights", style: TextStyle(fontSize: 12)),
                ),
              const SizedBox(height: 10),
              if (selectedFlow.down.hasChild)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 45,
                        child: Text("down", style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        child: SmallTextBox(
                          controller: _downController,
                          onType: (value) {
                            if (!(flowsState.systemVariables?.allowEdit ??
                                true)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Editing is disabled in settings")),
                              );
                              _downController.text = selectedFlow
                                  .down
                                  .lineHeight
                                  .toString();
                              return;
                            }
                            if (value.isNotEmpty &&
                                double.tryParse(value) != null) {
                              selectedFlow.down.lineHeight = double.parse(
                                value,
                              );
                              flowsNotifier.forceRepositionAllFlows();
                              flowsNotifier.save();
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
                      const SizedBox(
                        width: 45,
                        child: Text("left", style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        child: SmallTextBox(
                          controller: _leftController,
                          onType: (value) {
                            if (!(flowsState.systemVariables?.allowEdit ??
                                true)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Editing is disabled in settings")),
                              );
                              _leftController.text = selectedFlow
                                  .left
                                  .lineHeight
                                  .toString();
                              return;
                            }
                            if (value.isNotEmpty &&
                                double.tryParse(value) != null) {
                              selectedFlow.left.lineHeight = double.parse(
                                value,
                              );
                              flowsNotifier.forceRepositionAllFlows();
                              flowsNotifier.save();
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
                      const SizedBox(
                        width: 45,
                        child: Text("right", style: TextStyle(fontSize: 12)),
                      ),
                      Expanded(
                        child: SmallTextBox(
                          controller: _rightController,
                          onType: (value) {
                            if (!(flowsState.systemVariables?.allowEdit ??
                                true)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Editing is disabled in settings")),
                              );
                              _rightController.text = selectedFlow
                                  .right
                                  .lineHeight
                                  .toString();
                              return;
                            }
                            if (value.isNotEmpty &&
                                double.tryParse(value) != null) {
                              selectedFlow.right.lineHeight = double.parse(
                                value,
                              );
                              flowsNotifier.forceRepositionAllFlows();
                              flowsNotifier.save();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              if (flowsState.systemVariables?.showDelete ?? true)
                InkWell(
                  onTap: () {
                    if (!(flowsState.systemVariables?.allowDelete ??
                        true)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Deleting is disabled in settings")),
                      );
                      return;
                    }
                    if ((flowsState.isSelectingLoop ||
                            (flowsState.loopFrom >= 0 &&
                                flowsState.loopTo >= 0)) &&
                        flowsState.loopFrom >= 0 &&
                        flowsState.loopTo >= 0) {
                      flowsNotifier.deleteLoop(
                        flowsState.loopFrom,
                        flowsState.loopTo,
                      );
                      flowsNotifier.cancelLoopSelection();
                    } else {
                      flowsNotifier.deleteFlow(flowsState.selectedId);
                      flowsNotifier.cancelLoopSelection();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Pallet.inside1,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("delete", style: TextStyle(fontSize: 12)),
                        SizedBox(width: 10),
                        Icon(Icons.delete, size: 18),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SmallButton(
                    label: "done",
                    onPress: () {
                      flowsNotifier.save();
                      flowsNotifier.closeWindow();
                    },
                  ),
                  const SizedBox(width: 5),
                  SmallButton(
                    label: "close",
                    onPress: () {
                      flowsNotifier.closeWindow();
                    },
                  ),
                ],
              ),
            ],
          );
        }(),
      ),
    );
  }
}

class _FlowPreview extends StatelessWidget {
  const _FlowPreview({required this.flow});
  final FlowClass flow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
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
          const SizedBox(height: 4),
          Text(flow.value, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
