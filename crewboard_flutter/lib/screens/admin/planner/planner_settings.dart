import 'package:flutter/material.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../../../main.dart'; // For client
import '../../../../config/palette.dart';
import '../../../../widgets/widgets.dart';
import 'admin_planner_widgets.dart'; // AddController

class PlannerSettings extends StatefulWidget {
  const PlannerSettings({super.key});

  @override
  State<PlannerSettings> createState() => _PlannerSettingsState();
}

class _PlannerSettingsState extends State<PlannerSettings> {
  GetAddTicketDataResponse? data;

  @override
  void initState() {
    super.initState();
    _fetchData();

    // Listen for refreshes
    refreshStream.listen((event) {
      if (event == "get_admin_planner_data") {
        _fetchData();
      }
    });
  }

  void _fetchData() {
    client.planner.getAddTicketData().then((response) {
      if (mounted) {
        setState(() {
          data = response;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Planner",
          style: TextStyle(fontSize: 16, color: Pallet.font3),
        ),
        const SizedBox(height: 10),

        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              runSpacing: 20,
              spacing: 20,
              children: [
                _buildPushPullContainer("pull"),
                _buildPushPullContainer("push"),
                StatusesSection(items: data!.statuses),
                TicketTypesSection(items: data!.types),
                PrioritiesSection(items: data!.priorities),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPushPullContainer(String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(type == "pull" ? "ticket push and pull" : ""),
        const SizedBox(height: 10),
        GlassMorph(
          width: 250,
          height: 250,
          padding: const EdgeInsets.all(10),
          borderRadius: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOsScriptRow("windows", type, null),
              const SizedBox(height: 10),
              _buildOsScriptRow(
                "ubuntu",
                type,
                type == "push" ? "push.bat" : null,
              ),
              const SizedBox(height: 10),
              _buildOsScriptRow("mac", type, null),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOsScriptRow(String os, String type, String? script) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(os, style: const TextStyle(fontSize: 13)),
            Text(
              type,
              style: TextStyle(
                color: Pallet.font3.withValues(alpha: 0.5),
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        if (script == null)
          SmallButton(label: "add", onPress: () {})
        else
          GlassMorph(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            borderRadius: 5,
            color: Pallet.inside1,
            child: Text(
              script,
              style: TextStyle(color: Pallet.font3, fontSize: 12),
            ),
          ),
      ],
    );
  }
}

class StatusesSection extends StatefulWidget {
  final List<StatusModel> items;
  const StatusesSection({super.key, required this.items});

  @override
  State<StatusesSection> createState() => _StatusesSectionState();
}

class _StatusesSectionState extends State<StatusesSection> {
  int? editIdx;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("status"),
        const SizedBox(height: 10),
        GlassMorph(
          width: 250,
          height: 250,
          padding: const EdgeInsets.all(10),
          borderRadius: 10,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("variables", style: TextStyle(fontSize: 13)),
                  const AddController(type: "status"),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.items.length,
                  itemBuilder: (context, i) {
                    final item = widget.items[i];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: GlassMorph(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        borderRadius: 5,
                        color: Pallet.inside1,
                        child: Row(
                          children: [
                            if (editIdx == i)
                              Expanded(
                                child: SmallTextBox(
                                  controller: TextEditingController(
                                    text: item.statusName,
                                  ),
                                  onEnter: (val) async {
                                    await client.planner.addStatus(
                                      item.statusId,
                                      val,
                                    );
                                    refreshSink.add("get_admin_planner_data");
                                    setState(() => editIdx = null);
                                  },
                                ),
                              )
                            else
                              Expanded(
                                child: Text(
                                  item.statusName,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),

                            InkWell(
                              onTap: () => setState(
                                () => editIdx = (editIdx == i ? null : i),
                              ),
                              child: const Icon(Icons.edit, size: 16),
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () async {
                                await client.planner.deletePlannerVariable(
                                  'status',
                                  item.statusId,
                                );
                                refreshSink.add("get_admin_planner_data");
                              },
                              child: const Icon(Icons.delete, size: 16),
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
      ],
    );
  }
}

class TicketTypesSection extends StatefulWidget {
  final List<TypeModel> items;
  const TicketTypesSection({super.key, required this.items});

  @override
  State<TicketTypesSection> createState() => _TicketTypesSectionState();
}

class _TicketTypesSectionState extends State<TicketTypesSection> {
  int? editIdx;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("ticket types"),
        const SizedBox(height: 10),
        GlassMorph(
          width: 250,
          height: 250,
          padding: const EdgeInsets.all(10),
          borderRadius: 10,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("variables", style: TextStyle(fontSize: 13)),
                  const AddController(type: "type"),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.items.length,
                  itemBuilder: (context, i) {
                    final item = widget.items[i];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: GlassMorph(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        borderRadius: 5,
                        color: Pallet.inside1,
                        child: Row(
                          children: [
                            if (editIdx == i)
                              Expanded(
                                child: SmallTextBox(
                                  controller: TextEditingController(
                                    text: item.typeName,
                                  ),
                                  onEnter: (val) async {
                                    await client.planner.addTicketType(
                                      item.typeId,
                                      val,
                                      item.colorId,
                                    );
                                    refreshSink.add("get_admin_planner_data");
                                    setState(() => editIdx = null);
                                  },
                                ),
                              )
                            else
                              Expanded(
                                child: Text(
                                  item.typeName,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),

                            const SizedBox(width: 5),
                            ColorPicker(
                              selectedColorId: item.colorId,
                              onColorSelected: (sysColor) async {
                                await client.planner.addTicketType(
                                  item.typeId,
                                  item.typeName,
                                  sysColor.id!,
                                );
                                refreshSink.add("get_admin_planner_data");
                              },
                            ),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () => setState(
                                () => editIdx = (editIdx == i ? null : i),
                              ),
                              child: const Icon(Icons.edit, size: 16),
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () async {
                                await client.planner.deletePlannerVariable(
                                  'type',
                                  item.typeId,
                                );
                                refreshSink.add("get_admin_planner_data");
                              },
                              child: const Icon(Icons.delete, size: 16),
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
      ],
    );
  }
}

class PrioritiesSection extends StatefulWidget {
  final List<PriorityModel> items;
  const PrioritiesSection({super.key, required this.items});

  @override
  State<PrioritiesSection> createState() => _PrioritiesSectionState();
}

class _PrioritiesSectionState extends State<PrioritiesSection> {
  int? editIdx;
  int? selectedIdx;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("priorities"),
        const SizedBox(height: 10),
        GlassMorph(
          width: 250,
          height: 250,
          padding: const EdgeInsets.all(10),
          borderRadius: 10,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("variables", style: TextStyle(fontSize: 13)),
                  const AddController(type: "priority"),
                ],
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.items.length,
                        itemBuilder: (context, i) {
                          final item = widget.items[i];
                          final isSelected = selectedIdx == i;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: InkWell(
                              onTap: () => setState(() => selectedIdx = i),
                              child: GlassMorph(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                borderRadius: 5,
                                color: isSelected
                                    ? Colors.white.withOpacity(0.15)
                                    : Pallet.inside1,
                                child: Row(
                                  children: [
                                    Text(
                                      "${item.priority}",
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    if (editIdx == i)
                                      Expanded(
                                        child: SmallTextBox(
                                          controller: TextEditingController(
                                            text: item.priorityName,
                                          ),
                                          onEnter: (val) async {
                                            await client.planner.addPriority(
                                              item.priorityId,
                                              val,
                                            );
                                            refreshSink.add(
                                              "get_admin_planner_data",
                                            );
                                            setState(() => editIdx = null);
                                          },
                                        ),
                                      )
                                    else
                                      Expanded(
                                        child: Text(
                                          item.priorityName,
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ),

                                    InkWell(
                                      onTap: () => setState(
                                        () =>
                                            editIdx = (editIdx == i ? null : i),
                                      ),
                                      child: const Icon(Icons.edit, size: 16),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: () async {
                                        await client.planner
                                            .deletePlannerVariable(
                                              'priority',
                                              item.priorityId,
                                            );
                                        refreshSink.add(
                                          "get_admin_planner_data",
                                        );
                                      },
                                      child: const Icon(Icons.delete, size: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildArrowButton(Icons.arrow_drop_up, () async {
                          if (selectedIdx != null && selectedIdx! > 0) {
                            final item = widget.items[selectedIdx!];
                            await client.planner.changePriority(
                              item.priorityId,
                              item.priority,
                              'up',
                            );
                            setState(() => selectedIdx = selectedIdx! - 1);
                            refreshSink.add("get_admin_planner_data");
                          }
                        }),
                        _buildArrowButton(Icons.arrow_drop_down, () async {
                          if (selectedIdx != null &&
                              selectedIdx! < widget.items.length - 1) {
                            final item = widget.items[selectedIdx!];
                            await client.planner.changePriority(
                              item.priorityId,
                              item.priority,
                              'down',
                            );
                            setState(() => selectedIdx = selectedIdx! + 1);
                            refreshSink.add("get_admin_planner_data");
                          }
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildArrowButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: GlassMorph(
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.symmetric(vertical: 2),
        borderRadius: 4,
        color: Pallet.inside1,
        child: Icon(icon, size: 20),
      ),
    );
  }
}
