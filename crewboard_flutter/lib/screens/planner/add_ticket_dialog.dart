import 'dart:ui';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/planner_controller.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';

class AddTicketDialog extends StatelessWidget {
  const AddTicketDialog({super.key, required this.initialBucketId});
  final UuidValue initialBucketId;

  @override
  Widget build(BuildContext context) {
    final PlannerController controller = Get.find<PlannerController>();

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: Obx(() {
          return GlassMorph(
            borderRadius: 15,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            width: 500,
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
                                fontSize: 14,
                                color: Pallet.font3,
                              ),
                            ),
                            const SizedBox(height: 5),
                            SmallTextBox(
                              controller: controller.title.value,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "body",
                              style: TextStyle(
                                fontSize: 14,
                                color: Pallet.font3,
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
                                  onPress: () async {
                                    FilePickerResult? result = await FilePicker
                                        .platform
                                        .pickFiles(
                                          allowMultiple: true,
                                        );
                                    if (result != null) {
                                      for (var file in result.files) {
                                        controller.attachments.add(
                                          AttachmentModel(
                                            id: UuidValue.fromString(
                                              '00000000-0000-4000-8000-000000000000',
                                            ),
                                            name: file.name,
                                            size: file.size.toDouble(),
                                            url: "",
                                            type: file.extension ?? "",
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                                const SizedBox(width: 10),
                                ChipButton(
                                  name: "add checklist",
                                  onPress: () {
                                    controller.mode.value = "checklist";
                                    controller.controller.value.clear();
                                  },
                                ),
                                const SizedBox(width: 10),
                                ChipButton(
                                  name: "add flow",
                                  onPress: () {
                                    controller.mode.value = "flow";
                                    controller.controller.value.clear();
                                  },
                                ),
                              ],
                            ),
                            if (controller.mode.value == "checklist")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    "to do",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Pallet.font3,
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
                            if (controller.mode.value == "flow")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    "flow name",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Pallet.font3,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DropDown(
                                          label: "",
                                          itemKey: "name",
                                          items: controller.allFlows,
                                          menuDecoration: BoxDecoration(
                                            color: Pallet.inside3,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          onPress: (val) {
                                            controller.flows.add(val);
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      AddButton(
                                        onPress: () {
                                          controller.controller.value.clear();
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            // Display selected FLOWS
                            if (controller.flows.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    "flows",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Pallet.font3,
                                    ),
                                  ),
                                  for (
                                    var i = 0;
                                    i < controller.flows.length;
                                    i++
                                  )
                                    InkWell(
                                      onTap: () {
                                        controller.flows.removeAt(i);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        color: Pallet.inside1,
                                        child: Row(
                                          children: [
                                            const Icon(Icons.link, size: 18),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                controller.flows[i].name,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Pallet.font2,
                                                ),
                                              ),
                                            ),
                                            const Icon(Icons.close, size: 18),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                            // ATTACHMENTS display
                            if (controller.attachments.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  for (
                                    var i = 0;
                                    i < controller.attachments.length;
                                    i++
                                  )
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: Stack(
                                        children: [
                                          FilePreview(
                                            name:
                                                controller.attachments[i].name,
                                            size: controller.attachments[i].size
                                                .toInt(),
                                          ),
                                          Positioned(
                                            right: 5,
                                            top: 5,
                                            child: InkWell(
                                              onTap: () => controller
                                                  .attachments
                                                  .removeAt(i),
                                              child: const Icon(
                                                Icons.close,
                                                size: 16,
                                                color: Colors.white54,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),

                            // CHECKLIST display
                            if (controller.checklist.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    "check list",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Pallet.font3,
                                    ),
                                  ),
                                  for (var point in controller.checklist)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        children: [
                                          RadialCheckBox(
                                            selected: point.selected,
                                            onSelect: () {
                                              point.selected = !point.selected;
                                              controller.checklist.refresh();
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            point.label,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Pallet.font1,
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
                      const SizedBox(width: 15),
                      // Right Column
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: i * 15,
                                          ),
                                          child: ProfileIcon(
                                            size: 30,
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
                                            fontSize: 10,
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
                            DropDown(
                              label: (controller.status.value == null)
                                  ? "Status"
                                  : controller.status.value!.statusName,
                              itemKey: "statusName",
                              items: controller.statuses,
                              onPress: (data) {
                                controller.status.value = data;
                              },
                            ),
                            const SizedBox(height: 10),
                            DropDown(
                              label: (controller.type.value == null)
                                  ? "Type"
                                  : controller.type.value!.typeName,
                              itemKey: "typeName",
                              items: controller.types,
                              onPress: (data) {
                                controller.type.value = data;
                              },
                            ),
                            const SizedBox(height: 10),
                            DropDown(
                              label: (controller.priority.value == null)
                                  ? "Priority"
                                  : controller.priority.value!.priorityName,
                              itemKey: "priorityName",
                              items: controller.priorities,
                              onPress: (data) {
                                controller.priority.value = data;
                              },
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(DateTime.now().year + 2),
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
                                          fontSize: 12,
                                          color: Pallet.font1,
                                        ),
                                      ),
                                    ),
                                    if (controller.deadline.value != null)
                                      const Icon(
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
                                          fontSize: 12,
                                          color: Pallet.font1,
                                        ),
                                      ),
                                      Text(
                                        "(performance)",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Pallet.font3,
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
                            if (controller.error.value.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                ),
                                child: Center(
                                  child: Text(
                                    "error: ${controller.error.value}",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
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
