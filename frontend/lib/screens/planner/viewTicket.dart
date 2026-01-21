import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/backend/server.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/widgets.dart';
import 'package:frontend/widgets/textbox.dart';
import 'package:frontend/widgets/dropdown.dart';
import 'package:get/get.dart';
import 'planner_controller.dart';

Future<void> viewTicket(context, ticketId) async {
    final plannerController = Get.find<PlannerController>();
    plannerController.mode.value = "none";
    String page = "";
    String editType = "none";

   plannerController.getAddTicketData();

   await server.lock();
   server.release();

   await plannerController.getTicketData(ticketId);

   await server.lock();
   server.release();

   await plannerController.getComments(ticketId);

   await server.lock();
   server.release();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Pallet.inside2,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        content: StreamBuilder<Object>(
            stream: refreshStream,
            builder: (context, snapshot) {
              if (page == "comments") {
                return Container(
                  width: 500,
                  constraints: BoxConstraints(maxHeight: Window.height * 0.8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                page = "view";
                                refreshSink.add("");
                              },
                              child: Icon(
                                Icons.arrow_back,
                                size: 15,
                              )),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Comments",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(Icons.refresh, size: 15),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          reverse: true,
                          children: [
                            for (var comment in plannerController.comments)
                              Row(
                                mainAxisAlignment:
                                    (comment["userName"] == "me") ? MainAxisAlignment.end : MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (comment["userName"] != "me")
                                        Row(
                                          children: [
                                            ProfileIcon(
                                              size: 20,
                                              color: Colors.red,
                                              fontSize: 12,
                                              name: comment["userName"],
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              comment["userName"],
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10), color: Pallet.inside1),
                                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                        child: Text(
                                          // "test ",
                                          comment["message"],
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child:                             SmallTextBox(
                            controller: plannerController.controller.value,
                              onEnter: (value) {},
                              hintText: "message",
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              // server.get(
                              //     data: {"0": "add_comment", "1": userId, "2": ticketId, "3": ticket.controller.text},
                              //     func: (data) {
                              //       refreshSink.add("event");
                              //     });
                            },
                            child: Icon(Icons.send),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  width: 500,
                  constraints: BoxConstraints(maxHeight: Window.height * 0.8),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: ListView(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "title",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (editType == "none") {
                                              editType = "title";
                                            } else {
                                              editType = "none";
                                            }
                                            refreshSink.add("");
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            size: 15,
                                            color: Pallet.font3,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    if (editType == "title")
                                      SmallTextBox(
                                        controller: plannerController.title.value,
                                        onType: (value) {
                                          bool contains = false;
                                          for (var edit in plannerController.editStack) {
                                            if (edit["name"] == "ticketName") {
                                              edit["value"] = value.replaceAll("'", "\'");
                                              contains = true;
                                            }
                                          }
                                          if (!contains) {
                                            plannerController.editStack
                                                .add({"name": "ticketName", "value": value.replaceAll("'", "\'")});
                                          }
                                          // ticket.editStack.add({})
                                          // server.
                                        },
                                      )
                                    else
                                      Text(
                                        plannerController.title.value.text,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "body",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (editType == "none") {
                                              editType = "body";
                                            } else {
                                              editType = "none";
                                            }
                                            refreshSink.add("");
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            size: 15,
                                            color: Pallet.font3,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    if (editType == "body")
                                      SmallTextBox(
                                        controller: plannerController.body.value,
                                        maxLines: 8,
                                        onType: (value) {
                                          bool contains = false;
                                          for (var edit in plannerController.editStack) {
                                            if (edit["name"] == "ticketBody") {
                                              // print(value.replaceAll("\'", "\\'"));
                                              edit["value"] = value.replaceAll("'", "\'");
                                              contains = true;
                                            }
                                          }
                                          if (!contains) {
                                            plannerController.editStack
                                                .add({"name": "ticketBody", "value": value.replaceAll("'", "\'")});
                                          }
                                        },
                                      )
                                    else
                                      Text(
                                        plannerController.body.value.text,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        ChipButton(
                                          name: "add attatchments",
                                          onPress: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform.pickFiles(withReadStream: true);

                                            if (result != null) {
                                              // server.uploadFile(
                                              //     fileStream: result.files.first.readStream!,
                                              //     fileSize: result.files.first.size,
                                              //     fileName: result.files.first.name,
                                              //     func: (url) {
                                              //       print(url);
                                              //       Attachment _attatchment = Attachment(
                                              //           name: result.files.first.name,
                                              //           size: result.files.first.size,
                                              //           url: url,
                                              //           type: server.getFileType(result.files.first.name));
                                              //       ticket.attachments.add(_attatchment);
                                              //       refreshSink.add("");
                                              //       server.get(data: {
                                              //         "0": "add_ticket_attachments",
                                              //         "1": ticketId,
                                              //         "2": _attatchment.name,
                                              //         "3": _attatchment.size,
                                              //         "4": _attatchment.url,
                                              //         "5": _attatchment.type
                                              //       }, func: (data) {});
                                                  // });
                                            } else {}
                                          },
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        ChipButton(
                                          name: "add checklist",
                                          onPress: () {
                                            plannerController.mode.value = "checklist";
                                            refreshSink.add("");
                                          },
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        ChipButton(
                                          name: "add flow",
                                          onPress: () {
                                            plannerController.mode.value = "flow";
                                            refreshSink.add("");
                                          },
                                        )
                                      ],
                                    ),
                                    if (plannerController.mode.value == "flow")
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: SmallTextBox(
                                              controller: plannerController.controller.value,
                                            )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            AddButton(onPress: () {
                                              // plannerController.checklist
                                              //     .add({"label": plannerController.controller.value.text, "selected": false});
                                              // plannerController.editTicket(
                                              //     ticketId: ticketId,
                                              //     data: {"name": "checklist", "value": plannerController.checklist});
                                              // plannerController.controller.value.clear();
                                              // plannerController.mode.value = "none";

                                              // refreshSink.add("");
                                            }),
                                          ],
                                        ),
                                      ),
                                    if (plannerController.mode.value == "checklist")
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child:                             SmallTextBox(
                                              controller: plannerController.controller.value,
                                            )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            AddButton(onPress: () {
                                              // plannerController.checklist
                                              //     .add({"label": plannerController.controller.value.text, "selected": false});
                                              // plannerController.editTicket(
                                              //     ticketId: ticketId,
                                              //     data: {"name": "checklist", "value": plannerController.checklist});
                                              // plannerController.controller.value.clear();
                                              // plannerController.mode.value = "none";

                                              refreshSink.add("");
                                            }),
                                          ],
                                        ),
                                      ),
                                    if (plannerController.flows.isNotEmpty)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "flows",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          // for (var i = 0; i < ticket.flows.length; i++)
                                          //   Padding(
                                          //     padding: const EdgeInsets.only(top: 10),
                                          //     child: InkWell(
                                          //       onTap: () {
                                          //         print(ticket.flows[i]["flowId"]);
                                          //         flowId = ticket.flows[i]["flowId"];
                                          //         Window.page.value = "flowie";
                                          //         flowPage = "flow";
                                          //         routerSink.add("");
                                          //         Navigator.pop(context);
                                          //       },
                                          //       child: Container(
                                          //         // margin: EdgeInsets.only(top: 10),
                                          //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          //         color: Pallet.inside1,
                                          //         child: Row(
                                          //           children: [
                                          //             Icon(
                                          //               Icons.link,
                                          //               size: 18,
                                          //             ),
                                          //             SizedBox(
                                          //               width: 10,
                                          //             ),
                                          //             Expanded(
                                          //               child: Text(
                                          //                 ticket.flows[i]["flowName"],
                                          //                 style: TextStyle(fontSize: 12, color: Pallet.font2),
                                          //               ),
                                          //             ),
                                          //             Icon(
                                          //               Icons.close,
                                          //               size: 18,
                                          //             )
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   )
                                        ],
                                      ),
                                    if (plannerController.checklist.isNotEmpty)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "to do",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          for (var point in plannerController.checklist)
                                            Row(
                                              children: [
                                                Checkbox(
                                                  value: point.selected,
                                                  checkColor: Pallet.inside3, // color of tick Mark
                                                  activeColor: Pallet.inside3,
                                                  shape: CircleBorder(),
                                                  onChanged: (bool? value) {
                                                    point.copyWith(selected: !point.selected) ;
                                                    refreshSink.add("");
                                                  },
                                                ),
                                                Text(
                                                  point.label,
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            )
                                        ],
                                      ),
                                    if (plannerController.attachments.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          "attachments",
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    for (var attachment in plannerController.attachments)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: [
                                            FilePreview(name: attachment.name, size: attachment.size.toInt()),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
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
                                            for (var i = 0; i < plannerController.selectedUsers.length; i++)
                                              // for (var user in ticket.selectedUsers)
                                              Padding(
                                                padding: EdgeInsets.only(left: i * 10),
                                                child: ProfileIcon(
                                                  size: 30,
                                                  name: plannerController.selectedUsers[i].userName,
                                                  color: Color(int.parse(plannerController.selectedUsers[i].color)),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MultiSelect(
                                      label: "Assignee",
                                      itemKey: "userName",
                                      items: plannerController.users,
                                      onChanged: (item) {
                                        if (item["selected"]) {
                                          plannerController.selectedUsers.add(item);
                                        } else {
                                          for (var i = 0; i < plannerController.selectedUsers.length; i++) {
                                            if (item["userId"] == plannerController.selectedUsers[i].userId) {
                                              plannerController.selectedUsers.removeAt(i);
                                            }
                                          }
                                        }
                                        refreshSink.add("");
                                      },
                                      menuDecoration:
                                          BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // DropDown(
                                    //   label: (ticket.status == null) ? "Status" : ticket.status!["statusName"],
                                    //   itemKey: "statusName",
                                    //   items: ticket.statuses,
                                    //   menuDecoration:
                                    //       BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                                    //   onPress: (data) {
                                    //     ticket.status = data;
                                    //     ticket.editTicket(
                                    //         ticketId: ticketId, data: {"name": "statusId", "value": data["statusId"]});

                                    //     refreshSink.add("");
                                    //   },
                                    // ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // DropDown(
                                    //   label: (ticket.type == null) ? "Type" : ticket.type!["typeName"],
                                    //   itemKey: "typeName",
                                    //   items: ticket.types,
                                    //   menuDecoration:
                                    //       BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                                    //   onPress: (data) {
                                    //     ticket.type = data;
                                    //     ticket.editTicket(
                                    //         ticketId: ticketId, data: {"name": "typeId", "value": data["typeId"]});
                                    //     refreshSink.add("");
                                    //   },
                                    // ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // DropDown(
                                    //   label: (ticket.priority == null) ? "Priority" : ticket.priority!["priorityName"],
                                    //   itemKey: "priorityName",
                                    //   items: ticket.priorities,
                                    //   menuDecoration:
                                    //       BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                                    //   onPress: (data) {
                                    //     ticket.priority = data;
                                    //     refreshSink.add("");
                                    //   },
                                    // ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showDatePicker(
                                                helpText: "test",
                                                builder: (context, child) {
                                                  return Theme(
                                                    data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              surface: Pallet.inside2,
                                              primary: Pallet.inside1,
                                              onPrimary: Pallet.font1,
                                              onSurface: Pallet.font1,
                                            ),
                                                      textButtonTheme: TextButtonThemeData(
                                                        style: TextButton.styleFrom(
                                                          textStyle: TextStyle(fontSize: 12),
                                                          foregroundColor: Pallet.font1, // button text color
                                                        ),
                                                      ),
                                                      // dialogTheme: DialogTheme(
                                                      //   backgroundColor: Pallet.inside2,
                                                      // ),
                                                    ),
                                                    child: child!,
                                                  );
                                                },
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(DateTime.now().year + 2))
                                            .then((value) => print(value));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Pallet.inside1,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Expanded(
                                              child: Text(
                                                plannerController.deadline.value ?? "Deadline",
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                            ),
                                            Container(
                                              width: 4,
                                              height: 20,
                                              color: (plannerController.deadline.value != null) ? Colors.green : Colors.transparent,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          page = "comments";
                                          refreshSink.add("");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Pallet.inside1,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Comments",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // if (ticket.creds.text != "0")
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "creds",
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              "(performance)",
                                              style: TextStyle(fontSize: 10, color: Pallet.font3),
                                            ),
                                          ],
                                        )),
                                        // SizedBox(width: 5),
                              SizedBox(
                                  width: 60,
                                  child: SmallTextBox(
                                    controller: plannerController.creds.value,
                                    onType: (value) {
                                      bool contains = false;
                                      for (var edit in plannerController.editStack) {
                                        if (edit["name"] == "creds") {
                                          edit["value"] = value;
                                          contains = true;
                                        }
                                      }
                                      if (!contains) {
                                        plannerController.editStack.add({"name": "creds", "value": value});
                                      }
                                    },
                                    type: "int",
                                  )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SmallButton(
                              label: "cancel",
                              onPress: () async {
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SmallButton(
                              label: "done",
                              onPress: () async {
                                if (plannerController.editStack.isNotEmpty) {
                                  plannerController.saveEditStack(ticketId);
                                }
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
        // actions: <Widget>[],
      );
    },
  );
}

