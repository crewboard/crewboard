
import 'package:flutter/material.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/screens/admin/attendance/attendance_popup.dart';
import 'package:frontend/widgets/widgets.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List<Map> users = [];
  List<Map> leaveConfigs = [];
  List<Map> leaveRequests = [];

  @override
  void initState() {
    // TODO: Fix server.get method
    // server.get(
    //     refresh: true,
    //     data: {"0": "get_attendance_data"},
    //     func: (data) {
    //       print(data);
    //       users = List<Map>.from(data["users"]);
    //       leaveConfigs = List<Map>.from(data["configs"]);
    //       leaveRequests = List<Map>.from(data["requests"]);

    //       setState(() {});
    //     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Attendance",
                style: TextStyle(fontSize: 16, color: Pallet.font3),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 150,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("punching mode"),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Radio(
                                  value: "bio_metric",
                                  groupValue: "bio_metric", // TODO: Fix SystemVariables.punchingMode
                                  onChanged: (value) {
                                    print(value); //selected value
                                  }),
                              Text(
                                "bio metric",
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: "manual_user",
                                  groupValue: "bio_metric", // TODO: Fix SystemVariables.punchingMode
                                  onChanged: (value) {
                                    print(value); //selected value
                                  }),
                              Text(
                                "manual (user)",
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: "manual_hr",
                                  groupValue: "bio_metric", // TODO: Fix SystemVariables.punchingMode
                                  onChanged: (value) {
                                    print(value); //selected value
                                  }),
                              Text(
                                "manual (hr)",
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      // width: 300,
                      height: 150,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("bio metric api"),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              decoration: BoxDecoration(color: Pallet.inside3, borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                "{server_url}/punching?punchId={id}",
                                style: TextStyle(fontSize: 12),
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 150,
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("leave requests"),
                          SizedBox(height: 5),
                          Expanded(
                            child: ListView(
                              children: [
                                for (var request in leaveRequests)
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Pallet.inside3),
                                      child: Row(
                                        children: [
                                          ProfileIcon(
                                            size: 20,
                                            name: request["userName"],
                                            color: Color(int.parse(request["color"])),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              request["userName"],
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          Expanded(child: SizedBox()),
                                          Container(
                                            width: 15,
                                            height: 15,
                                            color: Colors.yellow,
                                          ),
                                          SizedBox(width: 5)
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                // decoration: BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text("user")),
                    Expanded(flex: 2, child: Text("login time")),
                    Expanded(flex: 2, child: Text("logout time")),
                    Expanded(flex: 2, child: Text("leave config")),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (var user in users)
                      InkWell(
                        onTap: () {
                          // viewUserAttendance(context); // TODO: Implement viewUserAttendance function
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    ProfileIcon(
                                      size: 30,
                                      name: user["userName"],
                                      color: Color(int.parse(user["color"])),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(user["userName"])
                                  ],
                                ),
                              ),
                              Expanded(flex: 2, child: Text("8:34 am")),
                              Expanded(flex: 2, child: Text("8:34 am")),
                              Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Map data = {
                                            "configId": user["configId"],
                                            "configName": user["configName"],
                                            "config": user["config"],
                                            "fullDay": user["fullDay"],
                                            "halfDay": user["halfDay"],
                                          };
                                          viewLeaveConfig(context, data, true);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(color: Pallet.inside2, borderRadius: BorderRadius.circular(10)),
                                            child: Text(
                                              user["configName"],
                                              style: TextStyle(fontSize: 12),
                                            )),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
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
          flex: 1,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Leave Configs",
                    style: TextStyle(fontSize: 16, color: Pallet.font3),
                  ),
                  AddButton(onPress: () {
                    viewLeaveConfig(context, null, false);
                  })
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (var config in leaveConfigs)
                      InkWell(
                        onTap: () {
                          viewLeaveConfig(context, config, false);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Text(config["configName"]),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class Performance extends StatefulWidget {
  const Performance({super.key});

  @override
  State<Performance> createState() => _PerformanceState();
}

class _PerformanceState extends State<Performance> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Performance",
                style: TextStyle(fontSize: 16, color: Pallet.font3),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                // decoration: BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text("user")),
                    Expanded(flex: 2, child: Text("creds")),
                    Expanded(flex: 2, child: Text("config")),
                    Expanded(flex: 2, child: Text("manual values")),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                ProfileIcon(
                                  size: 30,
                                  name: "user",
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("userName")
                              ],
                            ),
                          ),
                          Expanded(flex: 2, child: Text("1")),
                          Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 70,
                                    child: Stack(
                                      children: [
                                        Center(
                                            child: Container(
                                                decoration: BoxDecoration(border: Border.all(color: Pallet.font3), borderRadius: BorderRadius.circular(5)),
                                                width: 60,
                                                height: 30,
                                                child: Center(
                                                    child: Text(
                                                  "view",
                                                  style: TextStyle(fontSize: 12),
                                                )))),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "1",
                                                style: TextStyle(fontSize: 8, fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  CustomElevatedButton(
                                    onPress: () {
                                      // viewLeaveConfig(context, user["configId"], user["configName"], user["config"], false);
                                    },
                                    label: "set",
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
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
          flex: 1,
          child: Container(
            // width: Window.stageWidth * 0.3,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Leave Configs",
                      style: TextStyle(fontSize: 16, color: Pallet.font3),
                    ),
                    AddButton(onPress: () {
                      // addPerformanceConfig(context); // TODO: Implement addPerformanceConfig function
                    })
                  ],
                ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                //   // decoration: BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                //   child: Row(
                //     children: [
                //       Text("user type"),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      // for (var types in userTypes)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        decoration: BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Text("types"),
                            // Expanded(
                            //     flex: 1,
                            //     child: Row(
                            //       children: [
                            //         ColorPicker(
                            //           color: Color(int.parse(types["color"])),
                            //         ),
                            //       ],
                            //     )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
