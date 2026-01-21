import 'package:flutter/material.dart';
import 'package:frontend/screens/planner/planner_controller.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/screens/planner/string_extensions.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/dropdown.dart';
import 'package:frontend/widgets/glass_morph.dart';
import 'package:frontend/widgets/widgets.dart';
import 'package:frontend/services/arri_client.rpc.dart';
import 'package:get/get.dart';
import 'types.dart';
import 'viewTicket.dart';

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
  List<Ticket> _applyTextSearch(List<Ticket> tickets, String searchText) {
    if (searchText.isEmpty) return tickets;

    return tickets.where((ticket) {
      final searchLower = searchText.toLowerCase();
      return ticket.ticketName.toLowerCase().contains(searchLower) ||
          ticket.ticketBody.toLowerCase().contains(searchLower) ||
          ticket.status.statusName.toLowerCase().contains(searchLower) ||
          ticket.type.typeName.toLowerCase().contains(searchLower) ||
          ticket.priority.priorityName.toLowerCase().contains(searchLower);
    }).toList();
  }

  // Method to apply filters
  List<Ticket> _applyFilters(List<Ticket> tickets) {
    List<Ticket> filteredTickets = List.from(tickets);

    for (var filter in selectedFilters) {
      if (filter.name == null) continue;
      print(filter.value);
      switch (filter.name) {
        case FilterName.status:
          if (filter.value != null) {
            filteredTickets = filteredTickets.where((ticket) {
              return ticket.status.statusId == filter.value!.statusId;
            }).toList();
          }
          break;

        case FilterName.type:
          if (filter.value != null) {
            filteredTickets = filteredTickets.where((ticket) {
              return ticket.type.typeId == filter.value!.typeId;
            }).toList();
          }
          break;

        case FilterName.priority:
          if (filter.value != null) {
            filteredTickets = filteredTickets.where((ticket) {
              return ticket.priority.priorityId == filter.value!.priorityId;
            }).toList();
          }
          break;
        default:
          break;
      }
    }

    print("filthered $filteredTickets");

    return filteredTickets;
  }

  // Method to apply sorting
  List<Ticket> _applySorting(List<Ticket> tickets) {
    List<Ticket> sortedTickets = List.from(tickets);

    for (var filter in selectedFilters) {
      if (filter.name == null || filter.value == null) continue;

      switch (filter.name) {
        case FilterName.priority:
          if (filter.value == SortOrder.ascending.name) {
            sortedTickets.sort((a, b) {
              // Sort by priority name alphabetically for now
              // You might want to add a priority level field to TicketModel
              return a.priority.priority.compareTo(b.priority.priority);
            });
          } else if (filter.value == SortOrder.descending.name) {
            sortedTickets.sort((a, b) {
              return b.priority.priority.compareTo(a.priority.priority);
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
  List<Ticket> _applyAllFilters() {
    // Get current tickets from planner controller
    final currentTickets = plannerController.allTickets;

    // Update backup
    backup = currentTickets.map((t) => t.toJson()).toList();

    List<Ticket> result = List.from(currentTickets);

    // Apply text search
    result = _applyTextSearch(result, searchText);

    // Apply filters
    result = _applyFilters(result);

    // Apply sorting
    result = _applySorting(result);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Get filtered tickets
      List<Ticket> displayTickets = _applyAllFilters();
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    width: 500,
                    // height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: Pallet.inside1,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                searchText = value;
                              });
                            },
                            // controller: controler,
                            style: TextStyle(fontSize: 12),
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
                        Icon(Icons.search, size: 18),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  for (var ticket in displayTickets)
                    InkWell(
                      onTap: () {
                        viewTicket(context, ticket.id);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.symmetric(
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
                                children: [
                                  Row(
                                    children: [
                                      Text(ticket.ticketName),
                                      SizedBox(width: 10),
                                      CustomBadge(
                                        label: ticket.type.typeName,
                                        color: Colors.red,
                                        // color: Color(
                                        //   int.parse(ticket.type.typeColor),
                                        // ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    ticket.ticketBody,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Pallet.font3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.alarm, color: Pallet.font3),
                                    SizedBox(width: 5),
                                    Text(
                                      (ticket.deadline == null)
                                          ? "None"
                                          : ticket.deadline!,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Stack(
                                  children: [
                                    for (
                                      var i = 0;
                                      i < ticket.assignees.length;
                                      i++
                                    )
                                      Padding(
                                        padding: EdgeInsets.only(left: i * 10),
                                        child: ProfileIcon(
                                          size: 30,
                                          name: ticket.assignees[i].userName,
                                          color: Color(
                                            int.parse(
                                              ticket.assignees[i].color,
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
                    ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 25, left: 10, right: 10),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  width: 0.5,
                  color: Pallet.font3.withOpacity(0.2),
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
                        Expanded(child: Text("filters")),
                        SmallButton(
                          label: "add",
                          onPress: () {
                            selectedFilters.add(Filter());
                            refreshSink.add("");
                          },
                        ),
                        SizedBox(width: 10),
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
                    SizedBox(height: 10),
                    for (var i = 0; i < selectedFilters.length; i++)
                      GlassMorph(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(10),
                        //   color: Pallet.inner2,
                        // ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "property",
                                  style: TextStyle(fontSize: 12),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedFilters.removeAt(i);
                                    });
                                    refreshSink.add("");
                                  },
                                  child: Icon(Icons.close, size: 14),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
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
                                print(plannerController.statuses);
                                refreshSink.add("");
                              },
                              menuDecoration: BoxDecoration(
                                color: Pallet.inside1,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(height: 10),
                            if (selectedFilters[i].name == FilterName.status)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("value", style: TextStyle(fontSize: 12)),
                                  SizedBox(height: 10),
                                  DropDown(
                                    label:
                                        selectedFilters[i].value?.statusName ??
                                        "Status",
                                    itemKey: "statusName",
                                    items: plannerController.statuses,
                                    menuDecoration: BoxDecoration(
                                      color: Pallet.inside1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPress: (data) {
                                      selectedFilters[i].value = data;
                                      displayTickets = _applyAllFilters();
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            if (selectedFilters[i].name == FilterName.type)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("value", style: TextStyle(fontSize: 12)),
                                  SizedBox(height: 10),
                                  DropDown(
                                    label:
                                        selectedFilters[i].value?.typeName ??
                                        "Type",
                                    itemKey: "typeName",
                                    items: plannerController.types,
                                    menuDecoration: BoxDecoration(
                                      color: Pallet.inside1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPress: (data) {
                                      selectedFilters[i].value = data;
                                      displayTickets = _applyAllFilters();
                                      setState(() {});
                                      //   plannerController.type.value = data;
                                      //   selectedFilters[i] = Filter(
                                      //     name: selectedFilters[i].name,
                                      //     type: selectedFilters[i].type,
                                      //     value: data["typeName"],
                                      //   );
                                      // });
                                      // refreshSink.add("");
                                    },
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            if (selectedFilters[i].type == FilterType.both)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("type", style: TextStyle(fontSize: 12)),
                                  SizedBox(height: 10),
                                  DropDown(
                                    label: selectedFilters[i].value ?? "Value",
                                    itemKey: "name",
                                    items: [
                                      Operation(
                                        name: "Ascending",
                                        operation: FilterOperation.ascending,
                                      ),
                                      Operation(
                                        name: "Descending",
                                        operation: FilterOperation.descending,
                                      ),
                                      Operation(
                                        name: "Value",
                                        operation: FilterOperation.value,
                                      ),
                                    ],
                                    menuDecoration: BoxDecoration(
                                      color: Pallet.inside1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPress: (data) {
                                      selectedFilters[i].operation =
                                          data.operation;
                                      setState(() {});
                                    },
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            if (selectedFilters[i].operation == FilterOperation.value)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("value", style: TextStyle(fontSize: 12)),
                                  SizedBox(height: 10),
                                  DropDown(
                                    label:
                                        selectedFilters[i].value?.priorityName ?? "Priority",
                                    itemKey: "priorityName",
                                    items: plannerController.priorities,
                                    menuDecoration: BoxDecoration(
                                      color: Pallet.inside1,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPress: (data) {
                                      selectedFilters[i].value = data;

                                      displayTickets = _applyAllFilters();
                                      refreshSink.add("");
                                    },
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            if (selectedFilters[i].name == "deadline")
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "type",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 10),
                                  DropDown(
                                    label:
                                        selectedFilters[i].value.name ?? "Value",
                                    itemKey: "name",
                                    items: [
                                      // FilterType(name: "ascending"),
                                      // FilterType(name: "descending"),
                                    ],
                                    menuDecoration: BoxDecoration(
                                      color: Pallet.inside1,
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                    ),
                                    onPress: (data) {
                                      // selectedFilters[i] = Filter(
                                      //   name: selectedFilters[i].name,
                                      //   column: selectedFilters[i].column,
                                      //   whereColumn: selectedFilters[i].whereColumn,
                                      //   orderColumn: selectedFilters[i].orderColumn,
                                      //   type: selectedFilters[i].type,
                                      //   value: data["name"],
                                      //   isValue: selectedFilters[i].isValue,
                                      // );
                                      _applyAllFilters();
                                      refreshSink.add("");
                                    },
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                          ],
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
