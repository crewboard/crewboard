

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/textbox.dart';
import '../../../backend/server.dart';
import '../../../globals.dart';
import '../../../widgets/widgets.dart';
import '../../../widgets/dropdown.dart' as dropdown;

Future<void> viewLeaveConfig(context, Map? data, bool showEdit) async {
  TextEditingController name = TextEditingController(text: data?["configName"]);
  TextEditingController fullDay = TextEditingController(text: data?["fullDay"].toString());
  TextEditingController halfDay = TextEditingController(text: data?["halfDay"].toString());
  bool edit = false;
  List<Map> leaveConfigs = [];
  Map? config = data?["config"];
  List<Map> days = [];
  if (data == null) {
    days = [
      {"name": "Monday", "inType": "am", "outType": "am", "bufferType": "min", "leave": false},
      {"name": "Tuesday", "inType": "am", "outType": "am", "bufferType": "min", "leave": false},
      {"name": "Wednesday", "inType": "am", "outType": "am", "bufferType": "min", "leave": false},
      {"name": "Thursday", "inType": "am", "outType": "am", "bufferType": "min", "leave": false},
      {"name": "Friday", "inType": "am", "outType": "am", "bufferType": "min", "leave": false},
      {"name": "Saturday", "inType": "am", "outType": "am", "bufferType": "min", "leave": false},
      {"name": "Sunday", "inType": "am", "outType": "am", "bufferType": "min", "leave": false},
    ];
  } else {
    for (var day in config!.keys) {
      Map temp = {
        "name": day,
        "in": config[day]["in"],
        "inType": config[day]["inType"],
        "out": config[day]["out"],
        "outType": config[day]["outType"],
        "buffer": config[day]["buffer"],
        "bufferType": config[day]["bufferType"],
        "leave": config[day]["leave"],
      };
      print(temp);
      days.add(temp);
    }
  }

  // TODO: Fix server methods - get, lock, release don't exist in ArriClient
  // server.get(
  //     lock: true,
  //     data: {"0": "get_leave_configs"},
  //     func: (data) {
  //       leaveConfigs = data;
  //     });

  // await server.lock();
  // server.release();

  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            backgroundColor: Pallet.inside2,
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            content: StreamBuilder<Object>(
                stream: refreshStream,
                builder: (context, snapshot) {
                  return SizedBox(
                    width: 450,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "config name",
                              style: TextStyle(fontSize: 14),
                            ),
                            if (data != null && showEdit)
                              InkWell(
                                  onTap: () {
                                    edit = !edit;
                                    refreshSink.add("");
                                  },
                                  child: Text(
                                    "edit",
                                    style: TextStyle(color: Colors.blue, fontSize: 14),
                                  ))
                            else if (data != null)
                              SizedBox(
                                width: 100,
                                child: dropdown.DropDown(
                                  label: "change",
                                  onPress: (leaveConfig) {
                                    Navigator.pop(context);
                                    // refreshSink.add("");
                                  },
                                  itemKey: "configName",
                                  items: leaveConfigs,
                                  menuDecoration: BoxDecoration(
                                    color: Pallet.inside3,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            // InkWell(
                            //     onTap: () {
                            //       edit = !edit;
                            //       refreshSink.add("");
                            //     },
                            //     child: Text(
                            //       "change",
                            //       style: TextStyle(color: Colors.blue, fontSize: 14),
                            //     ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (data == null || edit)
 SizedBox(width: 300, child: TextBox(controller: name))
                        else
                          Container(
                            width: 300,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: Pallet.inside3,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  name.text,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 300,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "full day (hrs)",
                                    style: TextStyle(fontSize: 13.8),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (data == null || edit)
 SmallTextBox(type: "int", controller: fullDay)
                                  else
                                    Container(
                                      width: 300,
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Pallet.inside3,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            fullDay.text,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "half day (hrs)",
                                    style: TextStyle(fontSize: 13.8),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (data == null || edit)
 SmallTextBox(type: "int", controller: halfDay)
                                  else
                                    Container(
                                      width: 300,
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Pallet.inside3,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            halfDay.text,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "day",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            if (data == null || edit)
                              SizedBox(
                                width: 30,
                              ),
                            Expanded(
                                flex: 6,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "in",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        "out",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        "buffer",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ))
                            // SizedBox(width: 5),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        for (var day in days)
                          Row(
                            children: [
                              if (data == null || edit)
                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: Checkbox(
                                      value: !day["leave"],
                                      activeColor: Pallet.inside3,
                                      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      onChanged: (value) {
                                        day["leave"] = value;
                                        day["leave"] = !day["leave"];
                                        refreshSink.add("");
                                      }),
                                ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  day["name"],
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              SizedBox(width: 5),
                              if (day["leave"])
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    height: 35,
                                    decoration: BoxDecoration(color: Pallet.inside3, borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text(
                                        "leave",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Expanded(
                                  flex: 6,
                                  child: Row(
                                    children: [
                                      if (data == null || edit)
                                        Expanded(
                                            child: Row(
                                          children: [
 Expanded(
                                                child: TextBox(
                                              // type: "time",
                                              controller: TextEditingController(text: day["in"] ?? ""),
                                              onType: (value) {
                                                day["in"] = value;
                                              },
                                            )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            DropdownButton<String>(
                                                value: day["inType"],
                                                elevation: 16,
                                                style: const TextStyle(color: Colors.deepPurple),
                                                underline: Container(
                                                  height: 2,
                                                  color: Colors.deepPurpleAccent,
                                                ),
                                                onChanged: (String? value) {
                                                  day["inType"] = value!;
                                                  refreshSink.add("");
                                                },
                                                dropdownColor: Pallet.inside1,
                                                borderRadius: BorderRadius.circular(5),
                                                items: [
                                                  DropdownMenuItem<String>(
                                                    value: "am",
                                                    child: Text("am"),
                                                  ),
                                                  DropdownMenuItem<String>(
                                                    value: "pm",
                                                    child: Text("pm"),
                                                  )
                                                ]),
                                          ],
                                        ))
                                      else
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                day["in"] + " ",
                                                style: TextStyle(fontSize: 14, color: Pallet.font3),
                                              ),
                                              Text(
                                                day["inType"] ?? "",
                                                style: TextStyle(fontSize: 14, color: Colors.deepPurple),
                                              ),
                                            ],
                                          ),
                                        )),
                                      SizedBox(width: 5),
                                      if (data == null || edit)
                                        Expanded(
                                            child: Row(
                                          children: [
 Expanded(
                                                child: TextBox(
                                              // type: "time",
                                              controller: TextEditingController(text: day["out"] ?? ""),
                                              onType: (value) {
                                                day["out"] = value;
                                              },
                                            )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            DropdownButton<String>(
                                                value: day["outType"],
                                                elevation: 16,
                                                style: const TextStyle(color: Colors.deepPurple),
                                                underline: Container(
                                                  height: 2,
                                                  color: Colors.deepPurpleAccent,
                                                ),
                                                onChanged: (String? value) {
                                                  day["outType"] = value!;
                                                  refreshSink.add("");
                                                },
                                                dropdownColor: Pallet.inside1,
                                                borderRadius: BorderRadius.circular(5),
                                                items: [
                                                  DropdownMenuItem<String>(
                                                    value: "am",
                                                    child: Text("am"),
                                                  ),
                                                  DropdownMenuItem<String>(
                                                    value: "pm",
                                                    child: Text("pm"),
                                                  )
                                                ]),
                                          ],
                                        ))
                                      else
                                        Expanded(
                                            child: Row(
                                          children: [
                                            Text(
                                              day["out"] + " ",
                                              style: TextStyle(fontSize: 14, color: Pallet.font3),
                                            ),
                                            Text(
                                              day["outType"] ?? "",
                                              style: TextStyle(fontSize: 14, color: Colors.deepPurple),
                                            ),
                                          ],
                                        )),
                                      SizedBox(width: 5),
                                      if (data == null || edit)
                                        Expanded(
                                            child: Row(
                                          children: [
 Expanded(
                                                child: TextBox(
                                              // type: "int",
                                              controller: TextEditingController(text: day["buffer"] ?? ""),
                                              onType: (value) {
                                                day["buffer"] = value;
                                              },
                                            )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            DropdownButton<String>(
                                                value: day["bufferType"],
                                                elevation: 16,
                                                style: const TextStyle(color: Colors.deepPurple),
                                                underline: Container(
                                                  height: 2,
                                                  color: Colors.deepPurpleAccent,
                                                ),
                                                onChanged: (String? value) {
                                                  day["bufferType"] = value!;
                                                  refreshSink.add("");
                                                },
                                                dropdownColor: Pallet.inside1,
                                                borderRadius: BorderRadius.circular(5),
                                                items: [
                                                  DropdownMenuItem<String>(
                                                    value: "min",
                                                    child: Text("min"),
                                                  ),
                                                  DropdownMenuItem<String>(
                                                    value: "hr",
                                                    child: Text("hr"),
                                                  )
                                                ]),
                                          ],
                                        ))
                                      else
                                        Expanded(
                                            child: Row(
                                          children: [
                                            Text(
                                              day["buffer"] + " ",
                                              style: TextStyle(fontSize: 14, color: Pallet.font3),
                                            ),
                                            Text(
                                              day["bufferType"] ?? "",
                                              style: TextStyle(fontSize: 14, color: Colors.deepPurple),
                                            ),
                                          ],
                                        ))
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SmallButton(label: "cancel", onPress: () {}),
                            SizedBox(width: 10),
                            SmallButton(
                                label: "done",
                                onPress: () {
                                  bool hasError = false;
                                  Map<String, Map> config = {};
                                  if (name.text.isEmpty) {
                                    hasError = true;
                                  }
                                  if (fullDay.text.isEmpty) {
                                    hasError = true;
                                  }
                                  if (halfDay.text.isEmpty) {
                                    hasError = true;
                                  }
                                  for (var day in days) {
                                    Map temp = {};
                                    if (!day["leave"]) {
                                      if (day["in"].toString().isEmpty || !RegExp(r'^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$').hasMatch(day["in"])) {
                                        hasError = true;
                                      }
                                      if (day["out"].toString().isEmpty || !RegExp(r'^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$').hasMatch(day["out"])) {
                                        hasError = true;
                                      }
                                    }

                                    if (day["buffer"].toString().isEmpty) {
                                      day["buffer"] = 0;
                                    }
                                  }
                                  if (data == null && !hasError) {
                                    for (var day in days) {
                                      Map temp = {};
                                      temp["in"] = day["in"];
                                      temp["inType"] = day["inType"];
                                      temp["inType"] = day["inType"];
                                      temp["out"] = day["out"];
                                      temp["outType"] = day["outType"];
                                      temp["buffer"] = day["buffer"];
                                      temp["bufferType"] = day["bufferType"];
                                      temp["leave"] = day["leave"];
                                      config[day["name"]] = temp;
                                    }
                                    // TODO: Fix server.get method
                                    // server.get(
                                    //     data: {"0": "add_leave_config", "1": "null", "2": fullDay.text, "3": halfDay.text, "4": name.text, "5": jsonEncode(config)},
                                    //     func: (data) {
                                    //       Navigator.pop(context);
                                    //       requestSink.add("get_attendance_data");
                                    //     });
                                  } else if (!hasError) {
                                    for (var day in days) {
                                      Map temp = {};
                                      temp["in"] = day["in"];
                                      temp["inType"] = day["inType"];
                                      temp["inType"] = day["inType"];
                                      temp["out"] = day["out"];
                                      temp["outType"] = day["outType"];
                                      temp["buffer"] = day["buffer"];
                                      temp["bufferType"] = day["bufferType"];
                                      temp["leave"] = day["leave"];
                                      config[day["name"]] = temp;
                                    }
                                    // TODO: Fix server.get method
                                    // server.get(
                                    //     data: {"0": "add_leave_config", "1": data?["configId"], "2": name.text, "3": jsonEncode(config)},
                                    //     func: (data) {
                                    //       Navigator.pop(context);
                                    //       requestSink.add("get_attendance_data");
                                    //     });
                                  }

                                  print(config);
                                })
                          ],
                        )
                      ],
                    ),
                  );
                })),
      );
    },
  );
}

Future<void> viewUserAttendance(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
            backgroundColor: Pallet.inside2,
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            content: StreamBuilder<Object>(
                stream: refreshStream,
                builder: (context, snapshot) {
                  return SizedBox(
                    width: 380,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "attendance stats",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 200,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: Pallet.background, borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "working hours",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(height: 5),
                                        Divider(), // TODO: Replace with proper bar() function
                                        SizedBox(height: 5),
                                        Text(
                                          "break hours",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(height: 5),
                                        Divider(), // TODO: Replace with proper bar() function
                                        SizedBox(height: 5),
                                        Text(
                                          "late hours",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(height: 5),
                                        Divider(), // TODO: Replace with proper bar() function
                                        SizedBox(height: 5),
                                        Text(
                                          "overtime hours",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        SizedBox(height: 5),
                                        Divider(), // TODO: Replace with proper bar() function
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 210,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        right: 90,
                                        top: 25,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(50)),
                                            ),
                                            Text(
                                              "late (days)",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        )),
                                    Positioned(
                                        right: 10,
                                        top: 65,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(50)),
                                            ),
                                            Text(
                                              "leaves",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        )),
                                    Positioned(
                                        right: 85,
                                        top: 120,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(50)),
                                            ),
                                            Text(
                                              "leaves",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              "(accepted)",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                })),
      );
    },
  );
}


bar() {
  return Container(
    height: 15,
    width: 150,
    decoration: BoxDecoration(
      color: Pallet.inside1,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(children: [
      Container(
        height: 15,
        width: 100,
        decoration: BoxDecoration(
          color: Color(0xFF1c738c),
          borderRadius: BorderRadius.circular(10),
        ),
      )
    ]),
  );
}