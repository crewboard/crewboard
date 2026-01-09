import 'package:crewboard_client/crewboard_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/palette.dart';
import '../../controllers/planner_controller.dart';
import '../../widgets/glass_morph.dart';
import 'chat_widgets.dart';

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
              Padding(
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
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: controller.allTickets.length,
                    itemBuilder: (context, index) {
                      final ticket = controller.allTickets[index];
                      return Obx(() {
                        final isSelected =
                            controller.selectedTicketId.value == ticket.id;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _TicketListTile(ticket: ticket),
                            if (isSelected)
                              SizedBox(
                                height: constraints.maxHeight * 0.75,
                                child: _ThreadContent(ticket: ticket),
                              ),
                          ],
                        );
                      });
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
            border: Border.all(
              color: isSelected
                  ? Colors.blue.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.1),
            ),
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
                ],
              ),
              const SizedBox(height: 4),
              Text(
                ticket.statusName,
                style: TextStyle(color: Pallet.font3, fontSize: 11),
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
      children: [
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
              padding: const EdgeInsets.all(20),
              reverse: true,
              itemCount: controller.ticketThread.length,
              itemBuilder: (context, index) {
                final item = controller.ticketThread.reversed.toList()[index];
                if (item.type == 'status_change') {
                  return StatusChangeItem(item: item);
                } else {
                  return ThreadCommentItem(item: item);
                }
              },
            );
          }),
        ),
        // Input Area
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    controller: messageController,
                    style: const TextStyle(fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: "Type a message or update...",
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    onSubmitted: (val) {
                      if (val.isNotEmpty) {
                        controller.addComment(
                          AddCommentRequest(ticketId: ticket.id, message: val),
                        );
                        messageController.clear();
                        controller.getTicketThread(ticket.id);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(width: 15),
              IconButton(
                onPressed: () {
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
                icon: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.orange, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 13, color: Colors.orange),
                children: [
                  TextSpan(
                    text: item.userName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (item.oldStatus == null) ...[
                    const TextSpan(text: " created this with status "),
                    TextSpan(
                      text: item.newStatus ?? 'Unknown',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ] else ...[
                    const TextSpan(text: " moved this from "),
                    TextSpan(
                      text: item.oldStatus!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: " to "),
                    TextSpan(
                      text: item.newStatus ?? 'Unknown',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Text(
            item.createdAt.length > 16
                ? item.createdAt.substring(11, 16)
                : item.createdAt,
            style: TextStyle(
              color: Colors.orange.withValues(alpha: 0.5),
              fontSize: 11,
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
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileIcon(
            name: item.userName,
            color: Color(
              int.parse(
                item.userColor?.replaceAll("#", "0xFF") ?? "0xFF2196F3",
              ),
            ),
            size: 40,
            fontSize: 14,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item.userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Pallet.font1,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      item.createdAt.length > 16
                          ? item.createdAt.substring(11, 16)
                          : item.createdAt,
                      style: TextStyle(color: Pallet.font3, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                  child: Text(
                    item.message ?? "",
                    style: TextStyle(fontSize: 14, color: Pallet.font2),
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
