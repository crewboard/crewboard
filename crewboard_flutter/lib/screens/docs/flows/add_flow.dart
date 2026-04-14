import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crewboard_flutter/config/palette.dart';
import 'package:crewboard_flutter/widgets/glass_morph.dart';

import 'types.dart';
import 'flows_controller.dart';

class AddFlow extends ConsumerWidget {
  const AddFlow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(flowsProvider.notifier);

    return SizedBox(
      width: 200,
      child: GlassMorph(
        borderRadius: 10,
        child: Container(
          margin: const EdgeInsets.only(top: 10, right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Button(
                label: "Add Terminal",
                onPress: () {
                  notifier.addFlow(FlowType.terminal);
                },
              ),
              const SizedBox(height: 10),
              _Button(
                label: "Add Process",
                onPress: () {
                  notifier.addFlow(FlowType.process);
                },
              ),
              const SizedBox(height: 10),
              _Button(
                label: "Add Condition",
                onPress: () {
                  notifier.addFlow(FlowType.condition);
                },
              ),
              const SizedBox(height: 10),
              _Button(
                label: "Add Loop",
                onPress: () {
                  notifier.startLoopSelection(true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({required this.label, required this.onPress});
  final String label;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: label.toLowerCase().contains("loop") ? 8 : 10,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Pallet.inside2,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 12, color: Pallet.font1),
              ),
            ),
            if (label.toLowerCase().contains("condition"))
              Transform.rotate(
                angle: 40 * (math.pi / 180), // Correct angle in radians
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellow, width: 2.5),
                  ),
                ),
              )
            else if (label.toLowerCase().contains("process"))
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.5),
                ),
              )
            else if (label.toLowerCase().contains("terminal"))
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.red, width: 2.5),
                ),
              )
            else
              const SizedBox(
                width: 18,
                height: 18,
                child: Icon(
                  Icons.loop,
                  size: 20,
                  color: Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class math {
  static const double pi = 3.1415926535897932;
}
