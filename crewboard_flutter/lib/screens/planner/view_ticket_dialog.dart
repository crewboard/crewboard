import 'dart:ui';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/planner_controller.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';
import '../../widgets/glass_morph.dart';
import '../../widgets/mention_text_box.dart';
import 'package:flutter/gestures.dart';

class ViewTicketDialog extends StatefulWidget {
  const ViewTicketDialog({super.key, required this.ticketId});
  final UuidValue ticketId;

  @override
  State<ViewTicketDialog> createState() => _ViewTicketDialogState();
}

class _ViewTicketDialogState extends State<ViewTicketDialog> {
  String page = "view";
  String editType = "none";

  @override
  Widget build(BuildContext context) {
    final PlannerController controller = Get.find<PlannerController>();

    return FutureBuilder(
      future: controller.getTicketDataFull(widget.ticketId),
      builder: (context, snapshot) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            content: Obx(() {
              if (page == "comments") {
                return _buildCommentsView(controller);
              }
              return _buildTicketView(controller);
            }),
          ),
        );
      },
    );
  }

  Widget _buildTicketView(PlannerController controller) {
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
                      Row(
                        children: [
                          Text(
                            "title",
                            style: TextStyle(color: Pallet.font3, fontSize: 14),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              setState(() {
                                editType = (editType == "title")
                                    ? "none"
                                    : "title";
                              });
                            },
                            child: Icon(
                              Icons.edit,
                              size: 14,
                              color: Pallet.font3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      if (editType == "title")
                        SmallTextBox(
                          controller: controller.title.value,
                          onType: (val) =>
                              controller.addToEditStack("ticketName", val),
                        )
                      else
                        Text(
                          controller.title.value.text,
                          style: TextStyle(
                            color: Pallet.font1,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            "body",
                            style: TextStyle(color: Pallet.font3, fontSize: 14),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              setState(() {
                                editType = (editType == "body")
                                    ? "none"
                                    : "body";
                              });
                            },
                            child: Icon(
                              Icons.edit,
                              size: 14,
                              color: Pallet.font3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      if (editType == "body")
                        MentionTextBox(
                          controller: controller.body.value,
                          maxLines: 8,
                          onSearch: controller.searchMentionable,
                          onType: (val) =>
                              controller.addToEditStack("ticketBody", val),
                        )
                      else
                        SelectableText.rich(
                          TextSpan(
                            children: _parseBody(controller.body.value.text),
                            style: TextStyle(color: Pallet.font1, fontSize: 13),
                          ),
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
                                  // Add to pendingFiles for upload
                                  controller.pendingFiles.add(file);

                                  // Add placeholder to attachments for UI display
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
                            onPress: () => controller.mode.value = "checklist",
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      if (controller.mode.value == "checklist")
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: SmallTextBox(
                                  controller: controller.controller.value,
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
                                fontSize: 14,
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
                      // ATTACHMENTS display
                      if (controller.attachments.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              "attachments",
                              style: TextStyle(
                                color: Pallet.font3,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
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
                                      name: controller.attachments[i].name,
                                      size: controller.attachments[i].size
                                          .toInt(),
                                    ),
                                    Positioned(
                                      right: 5,
                                      top: 5,
                                      child: InkWell(
                                        onTap: () =>
                                            controller.attachments.removeAt(i),
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
                                    padding: EdgeInsets.only(left: i * 15.0),
                                    child: ProfileIcon(
                                      name:
                                          controller.selectedUsers[i].userName,
                                      color: Color(
                                        int.parse(
                                          controller.selectedUsers[i].color
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
                        onChanged: () => controller.addToEditStack(
                          "assignees",
                          controller.selectedUsers.length.toString(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropDown(
                        label: (controller.status.value == null)
                            ? "Status"
                            : controller.status.value!.statusName,
                        itemKey: "statusName",
                        items: controller.statuses,
                        onPress: (val) {
                          controller.status.value = val;
                          controller.addToEditStack(
                            "statusId",
                            val.statusId.toString(),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      DropDown(
                        label: (controller.type.value == null)
                            ? "Type"
                            : controller.type.value!.typeName,
                        itemKey: "typeName",
                        items: controller.types,
                        onPress: (val) {
                          controller.type.value = val;
                          controller.addToEditStack(
                            "typeId",
                            val.typeId.toString(),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      DropDown(
                        label: (controller.priority.value == null)
                            ? "Priority"
                            : controller.priority.value!.priorityName,
                        itemKey: "priorityName",
                        items: controller.priorities,
                        onPress: (val) {
                          controller.priority.value = val;
                          controller.addToEditStack(
                            "priorityId",
                            val.priorityId.toString(),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      DatePicker(
                        value: controller.deadline.value,
                        label: "Deadline",
                        showCheck: true,
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (context) => WheelDatePicker(
                              initialDate: controller.deadline.value == null
                                  ? DateTime.now()
                                  : DateTime.parse(controller.deadline.value!),
                              onDateSelected: (date) {
                                controller.deadline.value = DateFormat(
                                  'yyyy-MM-dd',
                                ).format(date);
                                controller.addToEditStack(
                                  "deadline",
                                  controller.deadline.value!,
                                );
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          setState(() => page = "comments");
                          controller.getTicketThread(widget.ticketId);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Pallet.inside1,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Comments",
                                style: TextStyle(
                                  color: Pallet.font1,
                                  fontSize: 12,
                                ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                              onType: (val) =>
                                  controller.addToEditStack("creds", val),
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
                    // Update ticket if there are edits OR pending files to upload
                    if (controller.editStack.isNotEmpty ||
                        controller.pendingFiles.isNotEmpty) {
                      await controller.updateTicket(widget.ticketId);
                    }
                    Get.back();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentsView(PlannerController controller) {
    return GlassMorph(
      borderRadius: 15,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => setState(() => page = "view"),
                child: Icon(Icons.arrow_back, size: 18, color: Pallet.font1),
              ),
              const SizedBox(width: 15),
              Text(
                "Comments",
                style: TextStyle(
                  color: Pallet.font1,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 400,
            child: ListView.builder(
              reverse: true,
              itemCount: controller.ticketThread.length,
              itemBuilder: (context, index) {
                final item = controller.ticketThread[index];
                final isComment = item.type == 'comment';

                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileIcon(
                        name: item.userName,
                        color: Color(
                          int.parse(
                            (item.userColor ?? "#000000").replaceAll(
                              "#",
                              "0xFF",
                            ),
                          ),
                        ),
                        size: 30,
                        fontSize: 12,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  item.userName,
                                  style: TextStyle(
                                    color: Pallet.font2,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  DateFormat('hh:mm a').format(
                                    DateTime.parse(item.createdAt),
                                  ),
                                  style: TextStyle(
                                    color: Pallet.font3,
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            if (isComment)
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Pallet.inside1,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  item.message ?? '',
                                  style: TextStyle(
                                    color: Pallet.font1,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            else
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      item.action == 'created ticket'
                                          ? Icons.add_circle_outline
                                          : Icons.sync_alt,
                                      size: 14,
                                      color: Pallet.font3,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: Pallet.font3,
                                            fontSize: 12,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "${item.action}: ",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(text: item.details ?? ""),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: SmallTextBox(
                  controller: controller.controller.value,
                  hintText: "message",
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.send, color: Pallet.font1),
                onPressed: () async {
                  if (controller.controller.value.text.isNotEmpty) {
                    final success = await controller.addComment(
                      AddCommentRequest(
                        ticketId: widget.ticketId,
                        message: controller.controller.value.text,
                      ),
                    );
                    if (success) {
                      controller.controller.value.clear();
                      controller.getTicketThread(widget.ticketId);
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<TextSpan> _parseBody(String text) {
    if (text.isEmpty) return [];
    final List<TextSpan> spans = [];
    final RegExp exp = RegExp(r"(#\w+)");
    text.splitMapJoin(
      exp,
      onMatch: (Match m) {
        final String match = m[0]!;
        final String flowName = match.substring(1);
        spans.add(
          TextSpan(
            text: match,
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                final PlannerController controller =
                    Get.find<PlannerController>();
                controller.openLinkedFlow(flowName);
              },
          ),
        );
        return match;
      },
      onNonMatch: (String s) {
        spans.add(TextSpan(text: s));
        return s;
      },
    );
    return spans;
  }
}
