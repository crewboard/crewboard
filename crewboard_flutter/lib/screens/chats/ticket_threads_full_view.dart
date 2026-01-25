import 'package:crewboard_client/crewboard_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/palette.dart';
import '../../controllers/planner_controller.dart';
import '../../widgets/widgets.dart';
import '../../widgets/chat_input_keyboard.dart';

class TicketThreadsFullView extends StatelessWidget {
  const TicketThreadsFullView({super.key});

  @override
  Widget build(BuildContext context) {
    final PlannerController controller = Get.find<PlannerController>();

    return GlassMorph(
      borderRadius: 24,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => controller.selectedTicketId.value != null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Ticket Threads",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Pallet.font1,
                          ),
                        ),
                      ),
              ),
              Expanded(
                child: Obx(() {
                  final selectedId = controller.selectedTicketId.value;
                  if (selectedId != null) {
                    final ticket = controller.allTickets.firstWhereOrNull(
                      (t) => t.id == selectedId,
                    );
                    if (ticket != null) {
                      return _ThreadContent(ticket: ticket);
                    }
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: controller.allTickets.length,
                    itemBuilder: (context, index) {
                      final ticket = controller.allTickets[index];
                      return _TicketListTile(ticket: ticket);
                    },
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TicketListTile extends StatelessWidget {
  final PlannerTicket ticket;

  const _TicketListTile({required this.ticket});

  @override
  Widget build(BuildContext context) {
    final PlannerController controller = Get.find<PlannerController>();
    return Obx(() {
      final isSelected = controller.selectedTicketId.value == ticket.id;
      return InkWell(
        onTap: () {
          if (controller.selectedTicketId.value == ticket.id) {
            controller.selectedTicketId.value = null;
          } else {
            controller.selectedTicketId.value = ticket.id;
            controller.getTicketThread(ticket.id);
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.blue.withValues(alpha: 0.1)
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Color(
                        int.parse(ticket.typeColor.replaceAll("#", "0xFF")),
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            ticket.ticketName,
                            style: TextStyle(
                              color: Pallet.font1,
                              fontSize: 14,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        CustomBadge(
                          label: ticket.typeName,
                          color: Color(
                            int.parse(ticket.typeColor.replaceAll("#", "0xFF")),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    ticket.statusName,
                    style: TextStyle(color: Pallet.font3, fontSize: 11),
                  ),
                  if (ticket.latestActivity != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      "•",
                      style: TextStyle(color: Pallet.font3, fontSize: 11),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        ticket.latestActivity!,
                        style: TextStyle(color: Pallet.font3, fontSize: 11),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ] else
                    const Spacer(),
                  if (ticket.assignees.isNotEmpty)
                    SizedBox(
                      height: 24,
                      width:
                          18.0 *
                              (ticket.assignees.length > 4
                                  ? 4
                                  : ticket.assignees.length) +
                          10,
                      child: Stack(
                        children: [
                          for (
                            var i = 0;
                            i < ticket.assignees.length && i < 4;
                            i++
                          )
                            Positioned(
                              left: i * 14.0,
                              child: ProfileIcon(
                                size: 24,
                                fontSize: 10,
                                name: ticket.assignees[i].userName,
                                style: ProfileIconStyle.outlined,
                                useOpacity: false,
                                color: Color(
                                  int.parse(
                                    ticket.assignees[i].color.replaceAll(
                                      "#",
                                      "0xFF",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (ticket.assignees.length > 4)
                            Positioned(
                              left: 4 * 14.0,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Pallet.inside2,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Pallet.font3,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "+${ticket.assignees.length - 4}",
                                    style: TextStyle(
                                      color: Pallet.font3,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
      );
    });
  }
}

class _ThreadContent extends StatelessWidget {
  final PlannerTicket ticket;

  const _ThreadContent({required this.ticket});

  @override
  Widget build(BuildContext context) {
    final PlannerController controller = Get.find<PlannerController>();
    final messageController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              IconButton(
                onPressed: () => controller.selectedTicketId.value = null,
                icon: Icon(
                  Icons.arrow_back,
                  color: Pallet.font1,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  ticket.ticketName,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Pallet.font1,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Divider with label
        Stack(
          alignment: Alignment.center,
          children: [
            Divider(color: Colors.white.withValues(alpha: 0.1)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              color: const Color(
                0xff121212,
              ), // Matching typical glass backdrop or app background
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: Pallet.font3,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Messages in this thread",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Pallet.font3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // Thread Items
        Expanded(
          child: Obx(() {
            if (controller.ticketThread.isEmpty) {
              return Center(
                child: Text(
                  "No activity yet in this thread",
                  style: TextStyle(color: Pallet.font3),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              reverse: true,
              itemCount: controller.ticketThread.length,
              itemBuilder: (context, index) {
                final item = controller.ticketThread.reversed.toList()[index];
                if (item.type == 'status_change' || item.type == 'activity') {
                  return StatusChangeItem(item: item);
                } else {
                  return ThreadCommentItem(item: item);
                }
              },
            );
          }),
        ),
        // Input Area
        ChatInputKeyboard(
          controller: messageController,
          onSubmitted: (val) {
            if (val.isNotEmpty) {
              controller.addComment(
                AddCommentRequest(
                  ticketId: ticket.id,
                  message: val,
                ),
              );
              messageController.clear();
              controller.getTicketThread(ticket.id);
            }
          },
          onSendPressed: () {
            if (messageController.text.isNotEmpty) {
              controller.addComment(
                AddCommentRequest(
                  ticketId: ticket.id,
                  message: messageController.text,
                ),
              );
              messageController.clear();
              controller.getTicketThread(ticket.id);
            }
          },
        ),
      ],
    );
  }
}

class StatusChangeItem extends StatelessWidget {
  final ThreadItemModel item;

  const StatusChangeItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    String text = "${item.userName} ${item.action}";
    if (item.details != null && item.details!.isNotEmpty) {
      text += " ${item.details}";
    } else if (item.newStatus != null) {
      // Fallback for old status_change items locally if any
      text += " to ${item.newStatus}";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const SizedBox(width: 44), // Alignment with comment text
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Divider(color: Colors.white.withValues(alpha: 0.05)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: const Color(0xff121212),
                  child: Text(
                    text,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Pallet.font3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ThreadCommentItem extends StatelessWidget {
  final ThreadItemModel item;

  const ThreadCommentItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileIcon(
            name: item.userName,
            style: ProfileIconStyle.outlined,
            color: Color(
              int.parse(
                item.userColor?.replaceAll("#", "0xFF") ?? "0xFF2196F3",
              ),
            ),
            size: 32,
            fontSize: 12,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      item.userName,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Pallet.font1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.createdAt.length > 16
                          ? item.createdAt.substring(11, 16)
                          : item.createdAt,
                      style: GoogleFonts.poppins(
                        color: Pallet.font3,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.message ?? "",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Pallet.font2,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
