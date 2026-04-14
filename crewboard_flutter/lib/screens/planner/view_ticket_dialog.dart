import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../controllers/planner_controller.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';
import '../../widgets/glass_morph.dart';
import '../../widgets/mention_text_box.dart';
import 'package:flutter/gestures.dart';

class ViewTicketDialog extends ConsumerStatefulWidget {
  const ViewTicketDialog({super.key, required this.ticketId});
  final UuidValue ticketId;

  @override
  ConsumerState<ViewTicketDialog> createState() => _ViewTicketDialogState();
}

class _ViewTicketDialogState extends ConsumerState<ViewTicketDialog> {
  String page = "view";
  String editType = "none";
  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = ref.read(plannerProvider.notifier).getTicketDataFull(widget.ticketId);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(plannerProvider);
    final notifier = ref.read(plannerProvider.notifier);

    return FutureBuilder(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: GlassMorph(
              borderRadius: 15,
              padding: const EdgeInsets.all(30),
              width: 100,
              height: 100,
              child: CircularProgressIndicator(color: Pallet.font3),
            ),
          );
        }

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            content: Builder(builder: (context) {
              if (page == "comments") {
                return _buildCommentsView(state, notifier);
              }
              return _buildTicketView(state, notifier);
            }),
          ),
        );
      },
    );
  }

  Widget _buildTicketView(PlannerState state, PlannerNotifier notifier) {
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
                          controller: notifier.title,
                          onType: (val) =>
                              notifier.addToEditStack("ticketName", val),
                        )
                      else
                        Text(
                          (state.type != null && notifier.title.text.startsWith('${state.type!.typeName}: '))
                              ? notifier.title.text.substring('${state.type!.typeName}: '.length)
                              : notifier.title.text,
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
                          controller: notifier.body,
                          maxLines: 8,
                          onSearch: notifier.searchMentionable,
                          onType: (val) =>
                              notifier.addToEditStack("ticketBody", val),
                        )
                      else
                        SelectableText.rich(
                          TextSpan(
                            children: _parseBody(notifier.body.text),
                            style: TextStyle(color: Pallet.font1, fontSize: 13),
                          ),
                          contextMenuBuilder: (context, editableTextState) => const SizedBox.shrink(),
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
                            onPress: () => notifier.copyWithMode("checklist"),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      if (state.mode == "checklist")
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: SmallTextBox(
                                  controller: notifier.commentController,
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
                        ),
                      if (state.checklist.isNotEmpty)
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
                            for (var item in state.checklist)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    RadialCheckBox(
                                      selected: item.selected,
                                      onSelect: () {
                                          // Toggle in state if needed
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
                      // EXISTING ATTACHMENTS display
                      if (state.attachments.isNotEmpty)
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
                            for (final attachment in state.attachments)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: InkWell(
                                  onTap: () async {
                                    final uri = Uri.parse(attachment.url);
                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(uri);
                                    }
                                  },
                                  child: FilePreview(
                                    name: attachment.name,
                                    size: attachment.size.toInt(),
                                    url: attachment.url,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      // PENDING ATTACHMENTS display
                      if (state.pendingFiles.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              "new attachments (pending)",
                              style: TextStyle(
                                color: Pallet.font3,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
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
                                        onTap: () =>
                                            notifier.removeAttachedFile(file),
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
                                  i < state.selectedUsers.length;
                                  i++
                                )
                                  Padding(
                                    padding: EdgeInsets.only(left: i * 15.0),
                                    child: ProfileIcon(
                                      name:
                                          state.selectedUsers[i].userName,
                                      color: Color(
                                        int.parse(
                                          state.selectedUsers[i].color
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
                        items: state.users,
                        selected: state.selectedUsers,
                        onSelected: (users) {
                           notifier.setSelectedUsers(List<UserModel>.from(users));
                           notifier.addToEditStack(
                              "assignees",
                              users.length.toString(),
                            );
                        },
                      ),
                      const SizedBox(height: 10),
                      DropDown(
                        label: (state.status == null)
                            ? "Status"
                            : state.status!.statusName,
                        itemKey: "statusName",
                        items: state.statuses,
                        onPress: (val) {
                          notifier.setStatus(val as StatusModel);
                          notifier.addToEditStack(
                            "statusId",
                            val.statusId.toString(),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      DropDown(
                        label: (state.type == null)
                            ? "Type"
                            : state.type!.typeName,
                        itemKey: "typeName",
                        items: state.types,
                        onPress: (val) {
                          notifier.setType(val as TypeModel);
                          notifier.addToEditStack(
                            "typeId",
                            val.typeId.toString(),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      DropDown(
                        label: (state.priority == null)
                            ? "Priority"
                            : state.priority!.priorityName,
                        itemKey: "priorityName",
                        items: state.priorities,
                        onPress: (val) {
                          notifier.setPriority(val as PriorityModel);
                          notifier.addToEditStack(
                            "priorityId",
                            val.priorityId.toString(),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      DatePicker(
                        value: state.deadline,
                        label: "Deadline",
                        showCheck: true,
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (context) => WheelDatePicker(
                              initialDate: state.deadline == null
                                  ? DateTime.now()
                                  : DateTime.parse(state.deadline!),
                              minDate: state.currentTicketCreatedAt,
                              onDateSelected: (date) {
                                final d = DateFormat(
                                  'yyyy-MM-dd',
                                ).format(date);
                                notifier.setDeadline(d);
                                notifier.addToEditStack(
                                  "deadline",
                                  d,
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
                          notifier.getTicketThread(widget.ticketId);
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
                              controller: notifier.creds,
                              onType: (val) =>
                                  notifier.addToEditStack("creds", val),
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
                  onPress: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 15),
                SmallButton(
                  label: "done",
                  onPress: () async {
                    // Update ticket if there are edits OR pending files to upload
                    if (state.editStack.isNotEmpty ||
                        state.pendingFiles.isNotEmpty) {
                      await notifier.updateTicket(widget.ticketId);
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentsView(PlannerState state, PlannerNotifier notifier) {
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
              itemCount: state.ticketThread.length,
              itemBuilder: (context, index) {
                final item = state.ticketThread[index];
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
                  controller: notifier.commentController,
                  hintText: "message",
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.send, color: Pallet.font1),
                onPressed: () async {
                  if (notifier.commentController.text.isNotEmpty) {
                    final success = await notifier.addComment(
                      AddCommentRequest(
                        ticketId: widget.ticketId,
                        message: notifier.commentController.text,
                      ),
                    );
                    if (success) {
                      notifier.commentController.clear();
                      notifier.getTicketThread(widget.ticketId);
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
                ref.read(plannerProvider.notifier).openLinkedFlow(flowName);
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
