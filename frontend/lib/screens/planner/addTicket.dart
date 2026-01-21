import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/backend/server.dart';
import 'package:frontend/services/arri_client.rpc.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/glass_morph.dart';
import 'package:frontend/widgets/widgets.dart';
import 'package:frontend/widgets/textbox.dart';
import 'package:frontend/widgets/dropdown.dart';
import 'package:get/get.dart';
import 'planner_controller.dart';
import 'package:intl/intl.dart';

import 'types.dart';

Future<void> addTicket(context, String bucketId) async {
  final plannerController = Get.find<PlannerController>();
  plannerController.mode.value = "none";

  ValueNotifier<bool> notifier = ValueNotifier<bool>(true);
  plannerController.getAddTicketData();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          content: StreamBuilder<Object>(
            stream: refreshStream,
            builder: (context, snapshot) {
              return GlassMorph(
                borderRadius: 15,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: 500,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("title", style: TextStyle(fontSize: 14)),
                                SizedBox(height: 5),
                                SmallTextBox(
                                  controller: plannerController.title.value,
                                ),
                                SizedBox(height: 10),
                                Text("body", style: TextStyle(fontSize: 14)),
                                SizedBox(height: 5),
                                SmallTextBox(
                                  controller: plannerController.body.value,
                                  maxLines: 8,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    ChipButton(
                                      name: "add attachments",
                                      onPress: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                              withReadStream: true,
                                            );

                                        if (result != null) {
                                          // result.files.first.name;
                                          // result.files.first.bytes;
                                          // plannerController.attachments.add(AttachmentLocal(
                                          //     name: result.files.first.name,
                                          //     size: result.files.first.size,
                                          //     stream: result.files.first.readStream!));
                                          refreshSink.add("");
                                        }
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    ChipButton(
                                      name: "add checklist",
                                      onPress: () {
                                        plannerController.mode.value = "checklist";
                                        plannerController.controller.value
                                            .clear();
                                        refreshSink.add("");
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    ChipButton(
                                      name: "add flow",
                                      onPress: () {
                                        plannerController.mode.value = "flow";
                                        plannerController.controller.value
                                            .clear();
                                        refreshSink.add("");
                                      },
                                    ),
                                  ],
                                ),
                                if (plannerController.mode.value == "checklist")
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        "to do",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 5),
                                      // if (plannerController.mode.value == "checklist")
                                      Row(
                                        children: [
                                          Expanded(
                                            child: SmallTextBox(
                                              controller: plannerController
                                                  .controller
                                                  .value,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          AddButton(
                                            onPress: () {
                                              // plannerController.checklist.add({
                                              //   "label": plannerController
                                              //       .controller
                                              //       .value
                                              //       .text,
                                              //   "selected": false,
                                              // });
                                              plannerController.checklist.add(
                                                Check(
                                                  label: plannerController
                                                      .controller
                                                      .value
                                                      .text,
                                                  selected: false,
                                                ),
                                              );
                                              plannerController.controller.value
                                                  .clear();
                                              refreshSink.add("");
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                if (plannerController.mode.value == "flow")
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        "flow name",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: DropDown(
                                              label: "",
                                              onPress: (val) {},
                                              // controller: ticket.controller,
                                              // onSelect: (flow) {
                                              //   ticket.flows.add(flow);
                                              //   refreshSink.add("");
                                              //   // error = "";
                                              //   // setState(() {});
                                              // },
                                              itemKey: "flowName",
                                              items: plannerController.allFlows,
                                              menuDecoration: BoxDecoration(
                                                color: Pallet.inside3,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              // decoration: BoxDecoration(
                                              //   color: Pallet.inside3,
                                              //   borderRadius: BorderRadius.circular(5),
                                              // ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          AddButton(
                                            onPress: () {
                                              // Do nothing or handle flow addition if needed
                                              plannerController.controller.value
                                                  .clear();
                                              refreshSink.add("");
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                if (plannerController.flows.isNotEmpty)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        "flows",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      // SizedBox(
                                      //   height: 10,
                                      // ),
                                      for (
                                        var i = 0;
                                        i < plannerController.flows.length;
                                        i++
                                      )
                                        InkWell(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            color: Pallet.inside1,
                                            child: Row(
                                              children: [
                                                Icon(Icons.link, size: 18),
                                                SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    plannerController
                                                        .flows[i].toJson()["flowName"],
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Pallet.font2,
                                                    ),
                                                  ),
                                                ),
                                                Icon(Icons.close, size: 18),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                if (plannerController.attachments.isNotEmpty)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 20),
                                      for (var attachment
                                          in plannerController.attachments)
                                        FilePreview(
                                          name: attachment.name,
                                          size: attachment.size.toInt(),
                                        ),
                                    ],
                                  ),
                                if (plannerController.checklist.isNotEmpty)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        "check list",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      for (var point
                                          in plannerController.checklist)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              RadialCheckBox(
                                                selected: point.selected,
                                                onSelect: () {
                                                  point = point.copyWith(
                                                    selected: !point.selected,
                                                  );
                                                  refreshSink.add("");
                                                },
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                point.label,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Stack(
                                    children: [
                                      for (
                                        var i = 0;
                                        i <
                                            plannerController
                                                .selectedUsers
                                                .length;
                                        i++
                                      )
                                        // for (var user in ticket.selectedUsers)
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: i * 10,
                                          ),
                                          child: ProfileIcon(
                                            size: 30,
                                            name: plannerController
                                                .selectedUsers[i]
                                                .userName,
                                            color: Color(
                                              int.parse(
                                                plannerController
                                                    .selectedUsers[i]
                                                    .color,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              ValueListenableBuilder<bool>(
                                valueListenable: notifier,
                                builder:
                                    (
                                      BuildContext context,
                                      bool _,
                                      Widget? child,
                                    ) {
                                      return MultiSelect(
                                        label: "Assignee",
                                        itemKey: "userName",
                                        items: plannerController.users,
                                        menuDecoration: BoxDecoration(
                                          color: Pallet.inside1,
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        onChanged: (item) {
                                          if (item.selected) {
                                            plannerController.selectedUsers.add(
                                              item,
                                            );
                                          } else {
                                            for (
                                              var i = 0;
                                              i <
                                                  plannerController
                                                      .selectedUsers
                                                      .length;
                                              i++
                                            ) {
                                              if (item.userId ==
                                                  plannerController
                                                      .selectedUsers[i]
                                                      .userId) {
                                                plannerController.selectedUsers
                                                    .removeAt(i);
                                              }
                                            }
                                          }
                                          refreshSink.add("");
                                        },
                                      );
                                    },
                              ),
                              SizedBox(height: 10),
                              DropDown(
                                label: (plannerController.status.value == null)
                                    ? "Status"
                                    : plannerController
                                          .status
                                          .value!
                                          .statusName,
                                itemKey: "statusName",
                                items: plannerController.statuses,
                                menuDecoration: BoxDecoration(
                                  color: Pallet.inside1,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onPress: (data) {
                                  plannerController.status.value = data;
                                },
                              ),
                              SizedBox(height: 10),
                              DropDown(
                                label: (plannerController.type.value == null)
                                    ? "Type"
                                    : plannerController.type.value!.typeName,
                                itemKey: "typeName",
                                items: plannerController.types,
                                menuDecoration: BoxDecoration(
                                  color: Pallet.inside1,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onPress: (data) {
                                  plannerController.type.value = data;
                                  refreshSink.add("");
                                },
                              ),
                              SizedBox(height: 10),
                              DropDown(
                                label:
                                    (plannerController.priority.value == null)
                                    ? "Priority"
                                    : plannerController
                                              .priority
                                              .value
                                              ?.priorityName ??
                                          "Priority",
                                itemKey: "priorityName",
                                items: plannerController.priorities,
                                menuDecoration: BoxDecoration(
                                  color: Pallet.inside1,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onPress: (data) {
                                  plannerController.priority.value = data;
                                  // refreshSink.add("");
                                },
                              ),
                              SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  showDatePicker(
                                    helpText: "test",
                                    builder: (context, child) {
                                      return BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 5,
                                          sigmaY: 5,
                                        ),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              surface: Pallet.inside1,
                                              primary: Pallet.inside1,
                                              onPrimary: Pallet.font1,
                                              onSurface: Pallet.font1,
                                            ),
                                            textButtonTheme: TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                textStyle: TextStyle(
                                                  fontSize: 12,
                                                ),
                                                // primary: Pallet.font1, // button text color
                                              ),
                                            ),
                                            dialogTheme: DialogThemeData(
                                              backgroundColor: Pallet.inside1,
                                            ),
                                          ),
                                          child: child!,
                                        ),
                                      );
                                    },
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(DateTime.now().year + 2),
                                  ).then((date) {
                                    if (date != null) {
                                      plannerController.deadline.value =
                                          DateFormat('dd-MM-yyyy').format(date);
                                      refreshSink.add("");
                                      print(plannerController.deadline.value);
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Pallet.inside1,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 2),
                                      Expanded(
                                        child: Text(
                                          plannerController.deadline.value ??
                                              "Deadline",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Container(
                                        width: 4,
                                        height: 20,
                                        color:
                                            (plannerController.deadline.value !=
                                                null)
                                            ? Colors.green
                                            : Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "creds",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          "(performance)",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Pallet.font3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(width: 5),
                                  SizedBox(
                                    width: 60,
                                    child: SmallTextBox(
                                      controller: plannerController.creds.value,
                                      // type: "int",
                                    ),
                                  ),
                                ],
                              ),
                              if (plannerController.error.value.isNotEmpty)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "error: " + plannerController.error.value,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SmallButton(
                          label: "cancel",
                          onPress: () async {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(width: 10),
                        SmallButton(
                          label: "done",
                          onPress: () async {
                            await plannerController.save(bucketId);
                            if (plannerController.error.value.isEmpty) {
                              Navigator.of(context).pop();
                            } else {
                              refreshSink.add("");
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          // actions: <Widget>[

          // ],
        ),
      );
    },
  );
}

class RadialCheckBox extends StatelessWidget {
  const RadialCheckBox({
    super.key,
    required this.selected,
    required this.onSelect,
  });
  final bool selected;
  final Function onSelect;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelect();
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Pallet.font1),
        ),
        child: Center(
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Pallet.font1,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}

pickImage() async {}
