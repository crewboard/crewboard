import 'package:flutter/material.dart';
import 'package:frontend/widgets/glass_morph.dart';
// import '../../../backend/server.dart'; // TODO: Re-enable when server methods are implemented
import '../../../backend/types.dart';
import '../../../globals.dart';
import '../../../widgets/widgets.dart';
// import '../../../widgets/dropdown.dart'; // TODO: Re-enable when dropdown is used
import 'add_user.dart';
import '../attendance/attendance_popup.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List<Map> users = [];
  List<Map> userTypes = [];

  @override
  void initState() {
    // test();
    // TODO: Fix server methods - get doesn't exist in ArriClient
    // server.get(
    //     refresh: true,
    //     data: {"0": "get_users_data"},
    //     func: (data) {
    //       users = List<Map>.from(data["users"]);
    //       userTypes = List<Map>.from(data["userTypes"]);
    //       setState(() {});
    //     });
    // server.get(
    //     data: {"0": "get_users_types"},
    //     func: (data) {
    //       userTypes = data;
    //       setState(() {});
    //     });
    super.initState();
  }

  test() async {
    await Future.delayed(Duration(seconds: 1));
    // addUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Users",
                    style: TextStyle(fontSize: 16, color: Pallet.font3),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GlassMorph(
                      height: 155,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      borderRadius: 10,
                      // decoration: BoxDecoration(
                      //   color: Pallet.inside1,
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("top 5 performers"),
                          SizedBox(height: 5),
                          Expanded(
                            child: ListView(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Pallet.inside1,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            ProfileIcon(
                                              color: Colors.greenAccent,
                                              size: 20,
                                              name: "j",
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "jerin",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Expanded(
                                      //     child: Text(
                                      //   "20/20/2023",
                                      //   style: TextStyle(fontSize: 12),
                                      // )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: GlassMorph(
                      // width: 300,
                      height: 155,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      borderRadius: 10,
                      // decoration: BoxDecoration(
                      //   color: Pallet.inside1,
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("birthdays"),
                          SizedBox(height: 5),
                          Expanded(
                            child: ListView(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Pallet.inside1,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            ProfileIcon(
                                              color: Colors.greenAccent,
                                              size: 20,
                                              name: "j",
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "jerin",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "20/20/2023",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: GlassMorph(
                      height: 155,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      borderRadius: 10,

                      // decoration: BoxDecoration(
                      //   color: Pallet.inside1,
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("add user"),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  if (Permissions.userData) {
                                    addUser(context, null);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Pallet.inside1,
                                    border: Border.all(color: Pallet.font3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.person_add_alt_1,
                                    size: 16,
                                    color: Pallet.font3,
                                  ),
                                ),
                              ),
                              // SmallButton(
                              //     label: "add",
                              //     onPress: () {
                              //     }),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text("dump to csv"),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  addUser(context, null);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Pallet.inside1,
                                    border: Border.all(color: Pallet.font3),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.download,
                                    size: 16,
                                    color: Pallet.font3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text("user")),
                    Expanded(flex: 2, child: Text("uset role")),
                    Expanded(flex: 2, child: Text("gender")),
                    Expanded(flex: 1, child: Text("actions")),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (var user in users)
                      InkWell(
                        onTap: () {
                          addUser(context, user);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Pallet.inside1,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    ProfileIcon(
                                      size: 30,
                                      name: user["userName"],
                                      image: user["image"],
                                      color: Color(int.parse(user["color"])),
                                    ),
                                    SizedBox(width: 10),
                                    Text(user["userName"]),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    CustomBadge(
                                      label: user["userType"],
                                      color: Color(
                                        int.parse(user["userTypeColor"]),
                                      ),

                                      // color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                              // Expanded(flex: 2, child: Text("1 lack")),
                              Expanded(flex: 2, child: Text(user["gender"])),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: user["deleted"]
                                            ? Colors.green
                                            : Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        user["deleted"]
                                            ? "activate"
                                            : "deactivate",
                                        style: TextStyle(fontSize: 12),
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
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "User Types",
                    style: TextStyle(fontSize: 16, color: Pallet.font3),
                  ),
                  AddButton(
                    onPress: () {
                      // addUserType(context, null); // TODO: Implement addUserType function
                    },
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                // decoration: BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text("user type")),
                    Expanded(flex: 1, child: Text("color")),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (var type in userTypes)
                      InkWell(
                        onTap: () {
                          // addUserType(context, type); // TODO: Implement addUserType function
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Pallet.inside1,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(flex: 2, child: Text(type["userType"])),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    ColorPicker(
                                      color: Color(int.parse(type["color"])),
                                      onSelect: (val) {},
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
