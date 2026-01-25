import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../controllers/planner_controller.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';
import 'add_ticket_dialog.dart';
import 'view_ticket_dialog.dart';

import 'package:flutter/gestures.dart';


class BucketView extends StatelessWidget {
  const BucketView({super.key});

  @override
  Widget build(BuildContext context) {
    final PlannerController controller = Get.find<PlannerController>();

    return Obx(() {
      if (controller.isLoadingPlanner.value && controller.buckets.isEmpty) {
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
      width: 280,
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
          width: 260,
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
          color: Pallet.inside1,
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
                child: Text.rich(
                  TextSpan(
                    children: _parseBody(ticket.ticketBody),
                    style: TextStyle(fontSize: 13, color: Pallet.font3),
                  ),
                  maxLines: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            const SizedBox(height: 5),
            // Display image attachments
            if (ticket.attachments != null && ticket.attachments!.isNotEmpty)
              Builder(
                builder: (context) {
                    // Filter for image attachments only with valid URLs
                    final imageAttachments = ticket.attachments!.where((attachment) {
                      final ext = attachment.type.toLowerCase();
                      final isImage = ext == 'jpg' || 
                             ext == 'jpeg' || 
                             ext == 'png' || 
                             ext == 'gif' || 
                             ext == 'webp';
                      final hasValidUrl = attachment.url.isNotEmpty;
                      
                      return isImage && hasValidUrl;
                    }).toList();

                  if (imageAttachments.isEmpty) return const SizedBox.shrink();
                  
                  return Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageAttachments.first.url,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 120,
                            color: Pallet.inside1,
                            child: Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Pallet.font3,
                                size: 30,
                              ),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 120,
                            color: Pallet.inside1,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                                color: Pallet.font3,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.alarm, color: Pallet.font3, size: 20),
                const SizedBox(width: 5),
                Text(
                  _formatDeadline(ticket.deadline),
                  style: TextStyle(color: Pallet.font3, fontSize: 12),
                ),
                Expanded(child: Container()),
                SizedBox(
                  height: 28, // constrain height for stack
                  width: ticket.assignees.isEmpty ? 0 : 12.0 * ticket.assignees.length + 16, // adjusted width for overlap
                  child: Stack(
                    children: [
                      for (var i = 0; i < ticket.assignees.length; i++)
                        Positioned(
                          left: i * 12.0, // Overlap effect
                          child: ProfileIcon(
                            size: 28,
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
      DateTime now = DateTime.now();
      
      // Calculate difference in days
      Duration diff = dt.difference(now);
      int days = diff.inDays;

      if (days < 0) {
        return "Overdue";
      } else if (days == 0) {
        return "Ends today";
      } else if (days < 30) {
        return "$days ${days == 1 ? 'day' : 'days'} left";
      } else {
        // Show months with one decimal point
        double months = days / 30.0;
        return "${months.toStringAsFixed(1)} months left";
      }
    } catch (e) {
      return deadline;
    }
  }

  List<TextSpan> _parseBody(String text) {
    if (text.isEmpty) return [];
    final List<TextSpan> spans = [];
    
    final PlannerController controller = Get.find<PlannerController>();
    final List<String> names = [
      ...controller.allFlows.map((f) => f.name),
      ...controller.allDocs.map((d) => d.name),
    ];

    // Create a regex that matches either valid names (prioritized) or standard hashtags
    final uniqueNames = names.where((n) => n.isNotEmpty).toSet().toList();
    uniqueNames.sort((a, b) => b.length.compareTo(a.length));
    
    final escapedNames = uniqueNames.map(RegExp.escape).join('|');
    final pattern = escapedNames.isNotEmpty 
        ? "#($escapedNames|\\w+)" 
        : r"#(\w+)";
    final RegExp exp = RegExp(pattern, caseSensitive: false);

    text.splitMapJoin(
      exp,
      onMatch: (Match m) {
        final String match = m[0]!;
        final String flowName = m[1] ?? match.substring(1);
        spans.add(
          TextSpan(
            text: match,
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
            recognizer:
                TapGestureRecognizer()
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
