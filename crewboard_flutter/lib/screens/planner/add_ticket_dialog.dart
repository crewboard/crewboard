import 'dart:ui';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/planner_controller.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';
import '../../widgets/glass_morph.dart';

class AddTicketDialog extends StatelessWidget {
  const AddTicketDialog({super.key, required this.initialBucketId});
  final UuidValue initialBucketId;

  @override
  Widget build(BuildContext context) {
    final PlannerController controller = Get.find<PlannerController>();
    controller.getAddTicketDataForNew();

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: Obx(() {
          return GlassMorph(
            borderRadius: 15,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            width: 700,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "title",
                              style: TextStyle(
                                color: Pallet.font3,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 5),
                            SmallTextBox(
                              controller: controller.title.value,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "body",
                              style: TextStyle(
                                color: Pallet.font3,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 5),
                            SmallTextBox(
                              controller: controller.body.value,
                              maxLines: 8,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                ChipButton(
                                  name: "add attachments",
                                  onPress: () {
                                    // File implementation later if needed
                                  },
                                ),
                                const SizedBox(width: 10),
                                ChipButton(
                                  name: "add checklist",
                                  onPress: () {
                                    controller.mode.value = "checklist";
                                  },
                                ),
                                const SizedBox(width: 10),
                                ChipButton(
                                  name: "add flow",
                                  onPress: () {
                                    controller.mode.value = "flow";
                                  },
                                ),
                              ],
                            ),
                            if (controller.mode.value == "checklist")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15),
                                  Text(
                                    "to do",
                                    style: TextStyle(
                                      color: Pallet.font3,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SmallTextBox(
                                          controller:
                                              controller.controller.value,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      AddButton(
                                        onPress: () {
                                          if (controller
                                              .controller
                                              .value
                                              .text
                                              .isNotEmpty) {
                                            controller.addCheckItem(
                                              controller.controller.value.text,
                                            );
                                            controller.controller.value.clear();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            if (controller.checklist.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    "check list",
                                    style: TextStyle(
                                      color: Pallet.font3,
                                      fontSize: 13,
                                    ),
                                  ),
                                  for (var item in controller.checklist)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          RadialCheckBox(
                                            selected: item.selected,
                                            onSelect: () {
                                              item.selected = !item.selected;
                                              controller.checklist.refresh();
                                            },
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            item.label,
                                            style: TextStyle(
                                              color: Pallet.font1,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 25),
                      // Right Sidebar
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Assignees Icons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: Stack(
                                    children: [
                                      for (
                                        var i = 0;
                                        i < controller.selectedUsers.length;
                                        i++
                                      )
                                        Positioned(
                                          left: i * 20.0,
                                          child: ProfileIcon(
                                            name: controller
                                                .selectedUsers[i]
                                                .userName,
                                            color: Color(
                                              int.parse(
                                                controller
                                                    .selectedUsers[i]
                                                    .color
                                                    .replaceAll("#", "0xFF"),
                                              ),
                                            ),
                                            size: 30,
                                            fontSize: 12,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            MultiSelect(
                              items: controller.users,
                              selected: controller.selectedUsers,
                            ),
                            const SizedBox(height: 10),
                            Options(
                              selected: controller.status.value,
                              items: controller.statuses,
                              onSelect: (val) {
                                controller.status.value = val;
                              },
                            ),
                            const SizedBox(height: 10),
                            Options(
                              selected: controller.type.value,
                              items: controller.types,
                              onSelect: (val) {
                                controller.type.value = val;
                              },
                            ),
                            const SizedBox(height: 10),
                            Options(
                              selected: controller.priority.value,
                              items: controller.priorities,
                              onSelect: (val) {
                                controller.priority.value = val;
                              },
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(DateTime.now().year + 5),
                                );
                                if (date != null) {
                                  controller.deadline.value = DateFormat(
                                    'dd-MM-yyyy',
                                  ).format(date);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Pallet.inside1,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        controller.deadline.value ?? "Deadline",
                                        style: TextStyle(
                                          color: Pallet.font1,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    if (controller.deadline.value != null)
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "creds",
                                        style: TextStyle(
                                          color: Pallet.font1,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "(performance)",
                                        style: TextStyle(
                                          color: Pallet.font3,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 60,
                                  child: SmallTextBox(
                                    controller: controller.creds.value,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SmallButton(
                        label: "cancel",
                        onPress: () => Get.back(),
                      ),
                      const SizedBox(width: 15),
                      SmallButton(
                        label: "done",
                        onPress: () async {
                          await controller.save(initialBucketId);
                          if (controller.error.value.isEmpty) {
                            Get.back();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
