import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../../config/palette.dart';
import '../../../widgets/widgets.dart';
import '../../../controllers/attendance_controller.dart';

Future<void> viewLeaveConfig(
  BuildContext context,
  WidgetRef ref,
  LeaveConfig? data,
  bool showEdit,
) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return _LeaveConfigDialog(data: data, showEdit: showEdit);
    },
  );
}

class _LeaveConfigDialog extends ConsumerStatefulWidget {
  final LeaveConfig? data;
  final bool showEdit;

  const _LeaveConfigDialog({this.data, required this.showEdit});

  @override
  ConsumerState<_LeaveConfigDialog> createState() => _LeaveConfigDialogState();
}

class _LeaveConfigDialogState extends ConsumerState<_LeaveConfigDialog> {
  late TextEditingController nameController;
  late TextEditingController fullDayController;
  late TextEditingController halfDayController;
  late bool isEditing;
  late Map<String, dynamic> days;

  final dayNames = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.data?.configName ?? "");
    fullDayController = TextEditingController(
      text: widget.data?.fullDay.toString() ?? "8",
    );
    halfDayController = TextEditingController(
      text: widget.data?.halfDay.toString() ?? "4",
    );
    isEditing = widget.data == null;

    if (widget.data == null || widget.data!.config == null || widget.data!.config == "{}") {
      days = {};
      for (var day in dayNames) {
        days[day] = {
          "in": "09:00",
          "inType": "am",
          "out": "05:00",
          "outType": "pm",
          "buffer": "15",
          "bufferType": "min",
          "leave": day == "Sunday",
        };
      }
    } else {
      days = Map<String, dynamic>.from(jsonDecode(widget.data!.config!));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    fullDayController.dispose();
    halfDayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        backgroundColor: Pallet.inside2,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "config name",
                      style: TextStyle(fontSize: 14),
                    ),
                    if (widget.data != null && !isEditing)
                      InkWell(
                        onTap: () => setState(() => isEditing = true),
                        child: const Text(
                          "edit",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                if (isEditing)
                  SmallTextBox(controller: nameController)
                else
                  _buildDisabledField(nameController.text),

                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "full day (hrs)",
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 8),
                          if (isEditing)
                            SmallTextBox(controller: fullDayController)
                          else
                            _buildDisabledField(fullDayController.text),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "half day (hrs)",
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: 8),
                          if (isEditing)
                            SmallTextBox(controller: halfDayController)
                          else
                            _buildDisabledField(halfDayController.text),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildDayHeader(),
                const Divider(color: Colors.white24),
                for (var dayName in dayNames)
                  _buildDayRow(dayName),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SmallButton(
                      label: "cancel",
                      onPress: () => Navigator.pop(context),
                    ),
                    if (isEditing) ...[
                      const SizedBox(width: 10),
                      SmallButton(
                        label: "done",
                        onPress: () async {
                          final config = LeaveConfig(
                            id: widget.data?.id,
                            configName: nameController.text,
                            fullDay:
                                int.tryParse(fullDayController.text) ?? 8,
                            halfDay:
                                int.tryParse(halfDayController.text) ?? 4,
                            config: jsonEncode(days),
                          );
                          await ref.read(attendanceProvider.notifier)
                              .saveLeaveConfig(config);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDisabledField(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Pallet.inside3,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }

  Widget _buildDayHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text("day", style: TextStyle(fontSize: 13))),
          Expanded(flex: 3, child: Text("in", style: TextStyle(fontSize: 13))),
          Expanded(flex: 3, child: Text("out", style: TextStyle(fontSize: 13))),
          Expanded(
            flex: 3,
            child: Text("buffer/type", style: TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildDayRow(String dayName) {
    final dayData = days[dayName];
    bool isLeave = dayData["leave"] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                if (isEditing)
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: !isLeave,
                      onChanged: (val) {
                        setState(() {
                          days[dayName] = {...dayData, "leave": !(val ?? true)};
                        });
                      },
                      activeColor: Colors.blue,
                    ),
                  ),
                const SizedBox(width: 5),
                Text(dayName, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),

          if (isLeave)
            Expanded(
              flex: 9,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Pallet.inside3,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text(
                    "leave",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ),
            )
          else ...[
            Expanded(
              flex: 3,
              child: isEditing
                  ? _buildTimeField(
                      dayData,
                      "in",
                      (val) => setState(() => days[dayName] = {...dayData, "in": val}),
                    )
                  : Text(
                      "${dayData["in"]} ${dayData["inType"]}",
                      style: const TextStyle(fontSize: 11),
                    ),
            ),
            Expanded(
              flex: 3,
              child: isEditing
                  ? _buildTimeField(
                      dayData,
                      "out",
                      (val) => setState(() => days[dayName] = {...dayData, "out": val}),
                    )
                  : Text(
                      "${dayData["out"]} ${dayData["outType"]}",
                      style: const TextStyle(fontSize: 11),
                    ),
            ),
            Expanded(
              flex: 3,
              child: isEditing
                  ? _buildBufferField(
                      dayData,
                      (val) => setState(() => days[dayName] = {...dayData, "buffer": val}),
                    )
                  : Text(
                      "${dayData["buffer"]} ${dayData["bufferType"]}",
                      style: const TextStyle(fontSize: 11),
                    ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeField(Map dayData, String key, Function(String) onChanged) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 30,
            child: TextField(
              controller: TextEditingController(text: dayData[key]),
              style: const TextStyle(fontSize: 11),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
              ),
              onChanged: onChanged,
            ),
          ),
        ),
        const SizedBox(width: 2),
        Text(
          dayData["${key}Type"],
          style: const TextStyle(fontSize: 9, color: Colors.blue),
        ),
      ],
    );
  }

  Widget _buildBufferField(Map dayData, Function(String) onChanged) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 30,
            child: TextField(
              controller: TextEditingController(text: dayData["buffer"]),
              style: const TextStyle(fontSize: 11),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
              ),
              onChanged: onChanged,
            ),
          ),
        ),
        const SizedBox(width: 2),
        Text(
          dayData["bufferType"],
          style: const TextStyle(fontSize: 9, color: Colors.blue),
        ),
      ],
    );
  }
}
