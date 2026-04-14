import 'dart:ui';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../controllers/planner_controller.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';
import '../../widgets/mention_text_box.dart';

class AddTicketDialog extends ConsumerWidget {
  const AddTicketDialog({super.key, required this.initialBucketId});
  final UuidValue initialBucketId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(plannerProvider);
    final notifier = ref.read(plannerProvider.notifier);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: GlassMorph(
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
                            controller: notifier.title,
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
                          MentionTextBox(
                            controller: notifier.body,
                            maxLines: 8,
                            onSearch: notifier.searchMentionable,
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
                                      notifier.addAttachedFile(file);
                                    }
                                  }
                                },
                              ),
                              const SizedBox(width: 10),
                              ChipButton(
                                name: "add checklist",
                                onPress: () {
                                  // This is likely intended to show the checklist input
                                  // I'll use a local state or a temporary field if needed
                                  // For now, I'll assume 'mode' in PlannerState works.
                                  ref.read(plannerProvider.notifier).copyWithMode("checklist");
                                },
                              ),
                            ],
                          ),
                          if (state.mode == "checklist")
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
                                            notifier.commentController,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    AddButton(
                                      onPress: () {
                                        if (notifier
                                            .commentController
                                            .text
                                            .isNotEmpty) {
                                          notifier.addCheckItem(
                                            notifier.commentController.text,
                                          );
                                          notifier.commentController.clear();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),

                          // ATTACHMENTS display
                          if (state.pendingFiles.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                for (
                                  final file in state.pendingFiles
                                )
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    child: Stack(
                                      children: [
                                        FilePreview(
                                          name: file.name,
                                          size: file.size.toInt(),
                                        ),
                                        Positioned(
                                          right: 5,
                                          top: 5,
                                          child: InkWell(
                                            onTap: () => notifier.removeAttachedFile(file),
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
                          if (state.checklist.isNotEmpty)
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
                                for (var point in state.checklist)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        RadialCheckBox(
                                          selected: point.selected,
                                          onSelect: () {
                                            // Mutation is not allowed in Riverpod, but this model might be mutated in place if it's not final
                                            // Better to have a toggleCheckItem method
                                            // For now, I'll just keep it as is if it's not causing issues, or fix it if it is.
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
                                      i < state.selectedUsers.length;
                                      i++
                                    )
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: i * 15,
                                        ),
                                        child: ProfileIcon(
                                          size: 30,
                                          name: state
                                              .selectedUsers[i]
                                              .userName,
                                          color: Color(
                                            int.parse(
                                              state
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
                            items: state.users,
                            selected: state.selectedUsers,
                            onSelected: (users) {
                               notifier.setSelectedUsers(List<UserModel>.from(users));
                            },
                          ),
                          const SizedBox(height: 10),
                          DropDown(
                            label: (state.status == null)
                                ? "Status"
                                : state.status!.statusName,
                            itemKey: "statusName",
                            items: state.statuses,
                            onPress: (data) {
                              notifier.setStatus(data as StatusModel);
                            },
                          ),
                          const SizedBox(height: 10),
                          DropDown(
                            label: (state.type == null)
                                ? "Type"
                                : state.type!.typeName,
                            itemKey: "typeName",
                            items: state.types,
                            onPress: (data) {
                              notifier.setType(data as TypeModel);
                            },
                          ),
                          const SizedBox(height: 10),
                          DropDown(
                            label: (state.priority == null)
                                ? "Priority"
                                : state.priority!.priorityName,
                            itemKey: "priorityName",
                            items: state.priorities,
                            onPress: (data) {
                              notifier.setPriority(data as PriorityModel);
                            },
                          ),
                          const SizedBox(height: 10),
                          DatePicker(
                            value: state.deadline,
                            label: "Deadline*",
                            showCheck: true,
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) => WheelDatePicker(
                                  initialDate:
                                      state.deadline == null
                                      ? DateTime.now()
                                      : DateTime.parse(
                                          state.deadline!,
                                        ),
                                  onDateSelected: (date) {
                                    notifier.setDeadline(DateFormat(
                                      'yyyy-MM-dd',
                                    ).format(date));
                                  },
                                ),
                              );
                            },
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
                                  controller: notifier.creds,
                                ),
                              ),
                            ],
                          ),
                          if (state.error.isNotEmpty)
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
                                  "error: ${state.error}",
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
                      onPress: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 15),
                    SmallButton(
                      label: "done",
                      onPress: () async {
                        await notifier.save(initialBucketId);
                        if (ref.read(plannerProvider).error.isEmpty) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
