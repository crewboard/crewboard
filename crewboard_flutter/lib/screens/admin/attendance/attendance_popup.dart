import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../../config/palette.dart';
import '../../../widgets/widgets.dart';
import '../../../controllers/attendance_controller.dart';

Future<void> viewLeaveConfig(
  BuildContext context,
  LeaveConfig? data,
  bool showEdit,
) async {
  final nameController = TextEditingController(text: data?.configName ?? "");
  final fullDayController = TextEditingController(
    text: data?.fullDay.toString() ?? "8",
  );
  final halfDayController = TextEditingController(
    text: data?.halfDay.toString() ?? "4",
  );

  final isEditing = (data == null).obs;

  final days = <String, dynamic>{}.obs;
  final dayNames = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  if (data == null || data.config == null || data.config == "{}") {
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
    days.value = Map<String, dynamic>.from(jsonDecode(data.config!));
  }

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
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
          content: Obx(
            () => SizedBox(
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
                        if (data != null && !isEditing.value)
                          InkWell(
                            onTap: () => isEditing.value = true,
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
                    if (isEditing.value)
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
                              if (isEditing.value)
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
                              if (isEditing.value)
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
                      _buildDayRow(dayName, days, isEditing.value),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SmallButton(
                          label: "cancel",
                          onPress: () => Navigator.pop(context),
                        ),
                        if (isEditing.value) ...[
                          const SizedBox(width: 10),
                          SmallButton(
                            label: "done",
                            onPress: () async {
                              final config = LeaveConfig(
                                id: data?.id,
                                configName: nameController.text,
                                fullDay:
                                    int.tryParse(fullDayController.text) ?? 8,
                                halfDay:
                                    int.tryParse(halfDayController.text) ?? 4,
                                config: jsonEncode(days),
                              );
                              await Get.find<AttendanceController>()
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
        ),
      );
    },
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

Widget _buildDayRow(String dayName, RxMap<String, dynamic> days, bool editing) {
  final dayData = days[dayName];
  bool isLeave = dayData["leave"] ?? false;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        // Day Name & Leave Toggle
        Expanded(
          flex: 3,
          child: Row(
            children: [
              if (editing)
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: !isLeave,
                    onChanged: (val) {
                      days[dayName] = {...dayData, "leave": !(val ?? true)};
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
          // In Time
          Expanded(
            flex: 3,
            child: editing
                ? _buildTimeField(
                    dayData,
                    "in",
                    (val) => days[dayName] = {...dayData, "in": val},
                  )
                : Text(
                    "${dayData["in"]} ${dayData["inType"]}",
                    style: const TextStyle(fontSize: 11),
                  ),
          ),
          // Out Time
          Expanded(
            flex: 3,
            child: editing
                ? _buildTimeField(
                    dayData,
                    "out",
                    (val) => days[dayName] = {...dayData, "out": val},
                  )
                : Text(
                    "${dayData["out"]} ${dayData["outType"]}",
                    style: const TextStyle(fontSize: 11),
                  ),
          ),
          // Buffer
          Expanded(
            flex: 3,
            child: editing
                ? _buildBufferField(
                    dayData,
                    (val) => days[dayName] = {...dayData, "buffer": val},
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
