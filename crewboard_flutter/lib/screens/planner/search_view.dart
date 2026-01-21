import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../controllers/planner_controller.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'types.dart';
import 'string_extensions.dart';
import 'view_ticket_dialog.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final PlannerController plannerController = Get.find<PlannerController>();
  List backup = [];
  String searchText = '';

  @override
  void initState() {
    plannerController.getAddTicketData();
    super.initState();
  }

  List<Filter> filters = [
    Filter(name: FilterName.status, type: FilterType.where),
    Filter(name: FilterName.priority, type: FilterType.both),
    Filter(name: FilterName.type, type: FilterType.where),
    Filter(name: FilterName.deadline, type: FilterType.order),
  ];
  List<Filter> selectedFilters = [];

  // Method to apply text search across multiple fields
  List<PlannerTicket> _applyTextSearch(
    List<PlannerTicket> tickets,
    String searchText,
  ) {
    if (searchText.isEmpty) return tickets;

    return tickets.where((ticket) {
      final searchLower = searchText.toLowerCase();
      return ticket.ticketName.toLowerCase().contains(searchLower) ||
          ticket.ticketBody.toLowerCase().contains(searchLower) ||
          ticket.statusName.toLowerCase().contains(searchLower) ||
          ticket.typeName.toLowerCase().contains(searchLower) ||
          ticket.priorityName.toLowerCase().contains(searchLower);
    }).toList();
  }

  // Method to apply filters
  List<PlannerTicket> _applyFilters(List<PlannerTicket> tickets) {
    List<PlannerTicket> filteredTickets = List.from(tickets);

    for (var filter in selectedFilters) {
      if (filter.name == null) continue;
      switch (filter.name) {
        case FilterName.status:
          if (filter.value != null) {
            filteredTickets = filteredTickets.where((ticket) {
              return ticket.statusName ==
                  (filter.value as StatusModel).statusName;
            }).toList();
          }
          break;

        case FilterName.type:
          if (filter.value != null) {
            filteredTickets = filteredTickets.where((ticket) {
              return ticket.typeName == (filter.value as TypeModel).typeName;
            }).toList();
          }
          break;

        case FilterName.priority:
          if (filter.value != null &&
              filter.operation == FilterOperation.value) {
            filteredTickets = filteredTickets.where((ticket) {
              return ticket.priorityName ==
                  (filter.value as PriorityModel).priorityName;
            }).toList();
          }
          break;
        default:
          break;
      }
    }

    return filteredTickets;
  }

  // Method to apply sorting
  List<PlannerTicket> _applySorting(List<PlannerTicket> tickets) {
    List<PlannerTicket> sortedTickets = List.from(tickets);

    for (var filter in selectedFilters) {
      if (filter.name == null || filter.value == null) continue;

      switch (filter.name) {
        case FilterName.priority:
          if (filter.operation == FilterOperation.ascending) {
            sortedTickets.sort((a, b) {
              return a.priorityName.compareTo(b.priorityName);
            });
          } else if (filter.operation == FilterOperation.descending) {
            sortedTickets.sort((a, b) {
              return b.priorityName.compareTo(a.priorityName);
            });
          }
          break;

        case FilterName.deadline:
          if (filter.value == SortOrder.ascending.name) {
            sortedTickets.sort((a, b) {
              final deadlineA = a.deadline;
              final deadlineB = b.deadline;
              if (deadlineA == null && deadlineB == null) return 0;
              if (deadlineA == null) return 1;
              if (deadlineB == null) return -1;
              return deadlineA.compareTo(deadlineB);
            });
          } else if (filter.value == SortOrder.descending.name) {
            sortedTickets.sort((a, b) {
              final deadlineA = a.deadline;
              final deadlineB = b.deadline;
              if (deadlineA == null && deadlineB == null) return 0;
              if (deadlineA == null) return 1;
              if (deadlineB == null) return -1;
              return deadlineB.compareTo(deadlineA);
            });
          }
          break;
        default:
          break;
      }
    }

    return sortedTickets;
  }

  // Method to apply all filtering and sorting
  List<PlannerTicket> _applyAllFilters() {
    // Get current tickets from planner controller
    final currentTickets = plannerController.allTickets;

    List<PlannerTicket> result = List.from(currentTickets);

    // Apply text search
    result = _applyTextSearch(result, searchText);

    // Apply filters
    result = _applyFilters(result);

    // Apply sorting
    result = _applySorting(result);

    return result;
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

    final List<String> names = [
      ...plannerController.allFlows.map((f) => f.name),
      ...plannerController.allDocs.map((d) => d.name),
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
                    plannerController.openLinkedFlow(flowName);
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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Get filtered tickets
      List<PlannerTicket> displayTickets = _applyAllFilters();
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    width: 500,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Pallet.inside1,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                searchText = value;
                              });
                            },
                            style: TextStyle(
                              fontSize: 12,
                              color: Pallet.font1,
                            ),
                            decoration: InputDecoration(
                              hintText: "search",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Pallet.font3,
                              ),
                              isDense: true,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.search, size: 18, color: Pallet.font1),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: displayTickets.length,
                      itemBuilder: (context, index) {
                        final ticket = displayTickets[index];
                        return InkWell(
                          onTap: () {
                            Get.dialog(ViewTicketDialog(ticketId: ticket.id));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            height: 105,
                            decoration: BoxDecoration(
                              color: Pallet.inside1,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            ticket.ticketName,
                                            style: TextStyle(
                                              color: Pallet.font1,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          CustomBadge(
                                            label: ticket.typeName,
                                            color: Color(
                                              int.parse(
                                                ticket.typeColor.replaceAll(
                                                  "#",
                                                  "0xFF",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text.rich(
                                        TextSpan(
                                          children: _parseBody(ticket.ticketBody),
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Pallet.font3,
                                          ),
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.alarm,
                                          color: Pallet.font3,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          _formatDeadline(ticket.deadline),
                                          style: TextStyle(
                                            color: Pallet.font3,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Stack(
                                      children: [
                                        for (
                                          var i = 0;
                                          i < ticket.assignees.length;
                                          i++
                                        )
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: i * 15.0,
                                            ),
                                            child: ProfileIcon(
                                              size: 30,
                                              name:
                                                  ticket.assignees[i].userName,
                                              color: Color(
                                                int.parse(
                                                  ticket.assignees[i].color
                                                      .replaceAll("#", "0xFF"),
                                                ),
                                              ),
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
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  width: 0.5,
                  color: Pallet.font3.withValues(alpha: 0.2),
                ),
              ),
            ),
            width: 250,
            child: StreamBuilder<Object>(
              stream: refreshStream,
              builder: (context, snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            "filters",
                            style: TextStyle(color: Pallet.font1),
                          ),
                        ),
                        SmallButton(
                          label: "add",
                          onPress: () {
                            selectedFilters.add(Filter());
                            refreshSink.add("");
                          },
                        ),
                        const SizedBox(width: 10),
                        SmallButton(
                          label: "apply",
                          onPress: () {
                            setState(() {
                              // Remove empty filters
                              selectedFilters.removeWhere(
                                (filter) => filter.name == null,
                              );
                            });
                            refreshSink.add("");
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: selectedFilters.length,
                        itemBuilder: (context, i) {
                          return GlassMorph(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("property", style: TextStyle(
                                        fontSize: 12,
                                        color: Pallet.font1,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedFilters.removeAt(i);
                                        });
                                        refreshSink.add("");
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: 14,
                                        color: Pallet.font1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                DropDown(
                                  label:
                                      selectedFilters[i].name?.name
                                          .toCapitalized() ??
                                      "Select",
                                  itemKey: "name",
                                  items: filters,
                                  onPress: (value) {
                                    selectedFilters[i] = Filter(
                                      name: value.name,
                                      type: value.type,
                                    );
                                    refreshSink.add("");
                                  },
                                ),
                                const SizedBox(height: 10),
                                if (selectedFilters[i].name ==
                                    FilterName.status)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("value", style: TextStyle(
                                          fontSize: 12,
                                          color: Pallet.font1,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      DropDown(
                                        label:
                                            (selectedFilters[i].value
                                                    as StatusModel?)
                                                ?.statusName ??
                                            "Status",
                                        itemKey: "statusName",
                                        items: plannerController.statuses,
                                        onPress: (data) {
                                          selectedFilters[i].value = data;
                                          setState(() {});
                                          refreshSink.add("");
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                if (selectedFilters[i].name == FilterName.type)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("value", style: TextStyle(
                                          fontSize: 12,
                                          color: Pallet.font1,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      DropDown(
                                        label:
                                            (selectedFilters[i].value
                                                    as TypeModel?)
                                                ?.typeName ??
                                            "Type",
                                        itemKey: "typeName",
                                        items: plannerController.types,
                                        onPress: (data) {
                                          selectedFilters[i].value = data;
                                          setState(() {});
                                          refreshSink.add("");
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                if (selectedFilters[i].type == FilterType.both)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("type", style: TextStyle(
                                          fontSize: 12,
                                          color: Pallet.font1,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      DropDown(
                                        label:
                                            selectedFilters[i].operation?.name
                                                .toCapitalized() ??
                                            "Value",
                                        itemKey: "name",
                                        items: [
                                          Operation(
                                            name: "Ascending",
                                            operation:
                                                FilterOperation.ascending,
                                          ),
                                          Operation(
                                            name: "Descending",
                                            operation:
                                                FilterOperation.descending,
                                          ),
                                          Operation(
                                            name: "Value",
                                            operation: FilterOperation.value,
                                          ),
                                        ],
                                        onPress: (data) {
                                          selectedFilters[i].operation =
                                              data.operation;
                                          setState(() {});
                                          refreshSink.add("");
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                if (selectedFilters[i].operation ==
                                    FilterOperation.value)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("value", style: TextStyle(
                                          fontSize: 12,
                                          color: Pallet.font1,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      DropDown(
                                        label:
                                            (selectedFilters[i].value
                                                    as PriorityModel?)
                                                ?.priorityName ??
                                            "Priority",
                                        itemKey: "priorityName",
                                        items: plannerController.priorities,
                                        onPress: (data) {
                                          selectedFilters[i].value = data;
                                          setState(() {});
                                          refreshSink.add("");
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                if (selectedFilters[i].name ==
                                    FilterName.deadline)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("type", style: TextStyle(
                                          fontSize: 12,
                                          color: Pallet.font1,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      DropDown(
                                        label:
                                            selectedFilters[i].value ?? "Value",
                                        itemKey: "name",
                                        items: [
                                          {"name": SortOrder.ascending.name},
                                          {"name": SortOrder.descending.name},
                                        ],
                                        onPress: (data) {
                                          selectedFilters[i].value =
                                              data["name"];
                                          setState(() {});
                                          refreshSink.add("");
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    });
  }
}


