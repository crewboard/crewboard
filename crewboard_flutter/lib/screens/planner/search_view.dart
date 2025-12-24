import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../controllers/planner_controller.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';
import 'view_ticket_dialog.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final PlannerController plannerController = Get.find<PlannerController>();
  final TextEditingController search = TextEditingController();

  String? selectedStatus;
  String? selectedPriority;
  String? selectedType;

  @override
  void initState() {
    super.initState();
    plannerController.loadAllTickets();
  }

  List<PlannerTicket> _applyFilters(List<PlannerTicket> tickets) {
    var filtered = tickets;
    if (search.text.isNotEmpty) {
      filtered = filtered
          .where(
            (t) =>
                t.ticketName.toLowerCase().contains(
                  search.text.toLowerCase(),
                ) ||
                t.ticketBody.toLowerCase().contains(search.text.toLowerCase()),
          )
          .toList();
    }
    if (selectedStatus != null) {
      filtered = filtered.where((t) => t.statusName == selectedStatus).toList();
    }
    if (selectedPriority != null) {
      filtered = filtered
          .where((t) => t.priorityName == selectedPriority)
          .toList();
    }
    if (selectedType != null) {
      filtered = filtered.where((t) => t.typeName == selectedType).toList();
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: SmallTextBox(
                  controller: search,
                  hintText: "Search tickets...",
                  onType: (value) {
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: Obx(() {
                  final tickets = _applyFilters(plannerController.allTickets);
                  if (tickets.isEmpty) {
                    return const Center(
                      child: Text(
                        "No tickets found",
                        style: TextStyle(color: Colors.white54),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = tickets[index];
                      return _buildTicketRow(ticket);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
        _buildFilterSidebar(),
      ],
    );
  }

  Widget _buildTicketRow(PlannerTicket ticket) {
    return InkWell(
      onTap: () {
        Get.dialog(ViewTicketDialog(ticketId: ticket.id));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Pallet.inside2,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CustomBadge(
              label: ticket.typeName,
              color: Color(int.parse(ticket.typeColor.replaceAll("#", "0xFF"))),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.ticketName,
                    style: TextStyle(
                      color: Pallet.font1,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ticket.ticketBody,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Pallet.font3, fontSize: 11.8),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            if (ticket.priorityName.isNotEmpty)
              Icon(
                Icons.keyboard_arrow_up,
                size: 14,
                color: _getPriorityColor(ticket.priorityName),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSidebar() {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Pallet.inside1,
        border: Border(
          left: BorderSide(color: Pallet.font3.withValues(alpha: 0.1)),
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filters",
            style: TextStyle(
              color: Pallet.font1,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildFilterSection(
            "Status",
            plannerController.statuses,
            (val) => setState(() => selectedStatus = val),
            selectedStatus,
          ),
          const SizedBox(height: 20),
          _buildFilterSection(
            "Priority",
            plannerController.priorities,
            (val) => setState(() => selectedPriority = val),
            selectedPriority,
          ),
          const SizedBox(height: 20),
          _buildFilterSection(
            "Type",
            plannerController.types,
            (val) => setState(() => selectedType = val),
            selectedType,
          ),
          const Spacer(),
          SmallButton(
            label: "Clear Filters",
            onPress: () {
              setState(() {
                selectedStatus = null;
                selectedPriority = null;
                selectedType = null;
                search.clear();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    RxList<dynamic> items,
    Function(String?) onSelect,
    String? current,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Pallet.font3, fontSize: 12),
        ),
        const SizedBox(height: 10),
        Obx(() {
          return Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              for (var item in items)
                InkWell(
                  onTap: () => onSelect(
                    current == _getItemName(item) ? null : _getItemName(item),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: current == _getItemName(item)
                          ? Pallet.font1.withValues(alpha: 0.1)
                          : Pallet.inside2,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: current == _getItemName(item)
                            ? Pallet.font1
                            : Colors.transparent,
                      ),
                    ),
                    child: Text(
                      _getItemName(item),
                      style: TextStyle(
                        color: current == _getItemName(item)
                            ? Pallet.font1
                            : Pallet.font3,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ],
    );
  }

  String _getItemName(dynamic item) {
    if (item is StatusModel) return item.statusName;
    if (item is PriorityModel) return item.priorityName;
    if (item is TypeModel) return item.typeName;
    return "";
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
}
