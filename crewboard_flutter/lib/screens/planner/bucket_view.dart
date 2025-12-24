import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../controllers/planner_controller.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';
import 'add_ticket_dialog.dart';
import 'view_ticket_dialog.dart';

class BucketView extends StatelessWidget {
  const BucketView({super.key});

  @override
  Widget build(BuildContext context) {
    final PlannerController controller = Get.find<PlannerController>();

    return Obx(() {
      if (controller.isLoadingPlanner.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Container(
        color: Colors.transparent,
        child: Scrollbar(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (var bucket in controller.buckets)
                _buildBucket(context, controller, bucket),
              _buildAddBucket(controller),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBucket(
    BuildContext context,
    PlannerController controller,
    BucketModel bucket,
  ) {
    return Container(
      width: 300,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                bucket.bucketName,
                style: TextStyle(
                  color: Pallet.font1,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              AddButton(
                onPress: () {
                  Get.dialog(AddTicketDialog(initialBucketId: bucket.bucketId));
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: DragTarget<Map<String, dynamic>>(
              onAcceptWithDetails: (details) {
                final data = details.data;
                if (data['bucketId'] != bucket.bucketId) {
                  controller.changeBucket(
                    ChangeBucketRequest(
                      ticketId: data['ticketId'],
                      oldBucketId: data['bucketId'],
                      newBucketId: bucket.bucketId,
                      newOrder: 1, // Defaulting to top for now
                    ),
                  );
                }
              },
              builder: (context, candidateData, rejectedData) {
                return ListView(
                  children: [
                    for (var ticket in bucket.tickets)
                      DraggableCard(
                        ticket: ticket,
                        bucketId: bucket.bucketId,
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddBucket(PlannerController controller) {
    return Container(
      width: 300,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          AddController(
            onSave: (name, color) async {
              await controller.addBucket(name);
            },
          ),
        ],
      ),
    );
  }
}

class DraggableCard extends StatelessWidget {
  const DraggableCard({
    super.key,
    required this.ticket,
    required this.bucketId,
  });
  final PlannerTicket ticket;
  final int bucketId;

  @override
  Widget build(BuildContext context) {
    return Draggable<Map<String, dynamic>>(
      data: {'ticketId': ticket.id, 'bucketId': bucketId},
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: 280,
          child: TicketWidget(ticket: ticket, bucketId: bucketId),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: TicketWidget(ticket: ticket, bucketId: bucketId),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TicketWidget(ticket: ticket, bucketId: bucketId),
      ),
    );
  }
}

class TicketWidget extends StatelessWidget {
  const TicketWidget({
    super.key,
    required this.ticket,
    required this.bucketId,
  });
  final PlannerTicket ticket;
  final int bucketId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.dialog(ViewTicketDialog(ticketId: ticket.id));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Pallet.inside2,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomBadge(
                  label: ticket.typeName,
                  color: Color(
                    int.parse(ticket.typeColor.replaceAll("#", "0xFF")),
                  ),
                ),
                const Spacer(),
                if (ticket.priorityName.isNotEmpty)
                  Icon(
                    Icons.keyboard_arrow_up,
                    size: 14,
                    color: _getPriorityColor(ticket.priorityName),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              ticket.ticketName,
              style: TextStyle(
                color: Pallet.font1,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              ticket.ticketBody,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Pallet.font3, fontSize: 11.8),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                if (ticket.deadline != null)
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, color: Pallet.font3, size: 12),
                      const SizedBox(width: 5),
                      Text(
                        ticket.deadline!,
                        style: TextStyle(color: Pallet.font3, fontSize: 11.5),
                      ),
                    ],
                  ),
                const Spacer(),
                Row(
                  children: [
                    for (var user in ticket.assignees)
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: ProfileIcon(
                          name: user.userName,
                          color: Color(
                            int.parse(user.color.replaceAll("#", "0xFF")),
                          ),
                          size: 20,
                          fontSize: 10,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Color _getPriorityColor(String priority) {
  switch (priority.toLowerCase()) {
    case 'high':
      return Colors.red;
    case 'medium':
      return Colors.orange;
    case 'low':
      return Colors.green;
    default:
      return Colors.blue;
  }
}
