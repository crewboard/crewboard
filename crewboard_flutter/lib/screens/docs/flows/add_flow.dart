import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewboard_flutter/config/palette.dart';
import 'package:crewboard_flutter/widgets/glass_morph.dart';

import 'types.dart';
import 'flows_controller.dart';

class AddFlow extends StatelessWidget {
  const AddFlow({super.key});

  @override
  Widget build(BuildContext context) {
    final FlowsController controller = Get.find<FlowsController>();

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
              Button(
                label: "Add Terminal",
                onPress: () {
                  controller.addFlow(FlowType.terminal);
                },
              ),
              const SizedBox(height: 10),
              Button(
                label: "Add Process",
                onPress: () {
                  controller.addFlow(FlowType.process);
                },
              ),
              const SizedBox(height: 10),
              Button(
                label: "Add Condition",
                onPress: () {
                  controller.addFlow(FlowType.condition);
                },
              ),
              const SizedBox(height: 10),
              Button(
                label: "Add Loop",
                onPress: () {
                  controller.startLoopSelection();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({super.key, required this.label, required this.onPress});
  final String label;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
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
                angle: 40,
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
