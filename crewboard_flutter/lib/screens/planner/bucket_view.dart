import 'package:intl/intl.dart';
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
              if (bucket.isDefault == true)
                AddButton(
                  onPress: () {
                    Get.dialog(
                      AddTicketDialog(initialBucketId: bucket.bucketId),
                    );
                  },
                ),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: DragTarget<PlannerTicket>(
              onWillAccept: (data) {
                if (data != null) {
                  controller.onDragUpdated(
                    bucket.bucketId,
                    bucket.tickets.length,
                  );
                  return true;
                }
                return false;
              },
              onAcceptWithDetails: (details) {
                controller.onDrop(bucket.bucketId, bucket.tickets.length);
              },
              builder: (context, candidateData, rejectedData) {
                return ListView(
                  children: [
                    // Render tickets with drag logic
                    for (var i = 0; i < bucket.tickets.length; i++)
                      if (bucket.tickets[i].holder == 'true')
                        DragTarget<PlannerTicket>(
                          builder: (context, candidateData, rejectedData) {
                            return Container(
                              height: 100, // Placeholder height
                              margin: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          },
                          onWillAccept: (data) {
                            if (data != null) {
                              controller.onDragUpdated(bucket.bucketId, i);
                              return true;
                            }
                            return false;
                          },
                          onAcceptWithDetails: (details) {
                            controller.onDrop(bucket.bucketId, i);
                          },
                        )
                      else
                        DragTarget<PlannerTicket>(
                          builder: (context, candidateData, rejectedData) {
                            return DraggableCard(
                              ticket: bucket.tickets[i],
                              bucketId: bucket.bucketId,
                              onDragStart: () {
                                controller.onDragStarted(
                                  bucket.tickets[i],
                                  bucket.bucketId,
                                );
                              },
                            );
                          },
                          onWillAccept: (data) {
                            if (data != null &&
                                data.id != bucket.tickets[i].id) {
                              controller.onDragUpdated(bucket.bucketId, i);
                              return true;
                            }
                            return false;
                          },
                          onAcceptWithDetails: (details) {
                            // Acceptance logic mainly handled by placeholder drop
                          },
                        ),

                    // Extra space at bottom to ensure scrollability and visibility
                    const SizedBox(height: 100),
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
          CreateItemInlineButton(
            label: "Add Bucket",
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
    required this.onDragStart,
  });
  final PlannerTicket ticket;
  final UuidValue bucketId;
  final VoidCallback onDragStart;

  @override
  Widget build(BuildContext context) {
    return Draggable<PlannerTicket>(
      data: ticket,
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
      onDragStarted: onDragStart,
      onDraggableCanceled: (velocity, offset) {
        final PlannerController controller = Get.find<PlannerController>();
        controller.onDragCancelled();
      },
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
  final UuidValue bucketId;

  @override
  Widget build(BuildContext context) {
    // Check if it's a holder/placeholder ticket
    if (ticket.holder == 'true') {
      return Container(
        height: 100, // Approximate height or dynamic
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }

    return InkWell(
      onTap: () {
        Get.dialog(ViewTicketDialog(ticketId: ticket.id));
      },
      child: Container(
        width: 300,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                if (ticket.hasNewActivity)
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                const Expanded(child: SizedBox()),
                Icon(Icons.upload_outlined, color: Pallet.font3),
                Icon(Icons.download_outlined, color: Pallet.font3),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              ticket.ticketName,
              style: TextStyle(fontSize: 16, color: Pallet.font1),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                ticket.ticketBody,
                maxLines: 12,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13, color: Pallet.font3),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.alarm, color: Pallet.font3),
                const SizedBox(width: 5),
                Text(
                  _formatDeadline(ticket.deadline),
                  style: TextStyle(color: Pallet.font3, fontSize: 12),
                ),
                Expanded(child: Container()),
                SizedBox(
                  height: 30, // constrain height for stack
                  width: 30.0 * ticket.assignees.length + 10, // give width
                  child: Stack(
                    children: [
                      for (var i = 0; i < ticket.assignees.length; i++)
                        Positioned(
                          left: i * 20.0, // Overlap effect
                          child: ProfileIcon(
                            size: 30,
                            name: ticket.assignees[i].userName,
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
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDeadline(String? deadline) {
    if (deadline == null || deadline.isEmpty) return "No deadline";
    try {
      DateTime dt = DateTime.parse(deadline);
      return DateFormat('MMM d').format(dt);
    } catch (e) {
      return deadline;
    }
  }
}
