import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:landing/main.dart';
import 'package:lottie/lottie.dart';
import '../types.dart';
import 'package:visibility_detector/visibility_detector.dart';

GlobalKey screenKey = GlobalKey();
// GlobalKey filter1Key = GlobalKey();
// GlobalKey filter2Key = GlobalKey();
// GlobalKey filter3Key = GlobalKey();
double mouseX = 0;
double mouseY = 0;

TextEditingController search = TextEditingController();

class PlannerDemo extends StatefulWidget {
  const PlannerDemo({super.key});

  @override
  State<PlannerDemo> createState() => _PlannerDemoState();
}

class _PlannerDemoState extends State<PlannerDemo>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool played = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('planner'),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;

        if (visiblePercentage > 5) {
          if (!played) {
            _controller.reset();
            _controller.forward();
            played = true;
          }
          print("asked to play");
        }

        if (visiblePercentage > 60.0) {
          animationSink.add("stop_chat");
          animationSink.add("stop_flowie");

          animationSink.add("show_planner");
          _controller.forward();
        }
        if (visiblePercentage < 40.0) {
          print("requested stop planner");
          animationSink.add("stop_planner");

          _controller.reset();
        }

        debugPrint(
            'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
      },
      child: SizedBox(
        width: Window.fullWidth,
        height: Window.fullHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: [
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: Window.fullWidth * 0.3,
                    child: Animate(
                      controller: _controller,
                      effects: const [
                        SlideEffect(duration: Duration(milliseconds: 1500)),
                        FadeEffect(duration: Duration(milliseconds: 1500))
                      ],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Manage your team recources efficiently with planner",
                            style: TextStyle(fontSize: 45, color: Pallet.font1),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "use bucket view to arrange tickets like in your mind board",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              animationSink.add("false");
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.withOpacity(0.25)),
                              child: const Text("Bucket View"),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                              "use search view to perform search and filtering on your tickets",
                              style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.withOpacity(0.25)),
                              child: const Text("Search View"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Animate(
                  controller: _controller,
                  effects: const [
                    ScaleEffect(duration: Duration(milliseconds: 1000)),
                    FadeEffect(duration: Duration(milliseconds: 1000))
                  ],
                  child: Container(
                    decoration: BoxDecoration(
                        color: Pallet.background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Pallet.font1)),
                    height: Window.fullHeight * 0.6,
                    child: SearchView(),
                  ),
                ),
              ),
              SizedBox(
                width: Window.fullWidth * 0.1,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

List<List> buckets = [
  [
    {
      "id": 1,
      "ticketName": "user login screen not working",
      "ticketBody":
          "No one wants a cake to stick to the pan, so it\'s important to prep your pans before pouring in the batter. With the exception of angel food and chiffon cakes, most recipes call for greasing and flouring the pan or lining the pan with waxed or parchment paper.\nAs for selecting the right type of baking pan to use, our Test Kitchen prefers shiny pans, which absorb less heat and produce a golden crust. Pans with a dark or dull finish absorb more heat and may burn your crust, so if you\'re using one of these, reduce your oven temperature by 25°F and check on the cake 3-5 minutes earlier than the recipe suggests.",
      "typeName": "Bug",
      "typeColor": "0xffdc143c",
      "assignees": [
        {"userName": "deepak", "color": "0xff009688"},
        {"userName": "chris", "color": "0xff9932cc"},
        {"userName": "rayan", "color": "0xffff5722"}
      ]
    },
    {
      "id": 2,
      "ticketName": "user name error",
      "ticketBody":
          """Serve hot chicken biryani with your favourite chutney or raita Cook for 15-20 minutes with a closed lid and garnish with 1 tbsp fried onions and coriander leaves

Tips
The first and foremost important thing to take care of while preparing chicken biryani recipe is, always use a heavy-bottomed pan as you would not want the chicken getting cooked.
The restaurant-style chicken biryani recipe uses the whole chicken in preparation and the chicken can dry when cooking at home. Always use chicken thigh or drumsticks.
If you want your chicken to be juicier in your biryani, do not remove the bone.""",
      "typeName": "Bug",
      "typeColor": "0xffdc143c",
      "assignees": [
        {"userName": "deepak", "color": "0xff009688"},
        {"userName": "chris", "color": "0xff9932cc"},
        {"userName": "rayan", "color": "0xffff5722"}
      ]
    }
  ],
  [
    {
      "id": 3,
      "ticketName": "new dash board screen",
      "ticketBody":
          "Biryani in India doesn't just mean biryani. There are variations across the length and breadth of the country. There is Hyderabadi biryani (which is what I'm sharing today) where the biryani has a lot of gravy or masala and is cooked slowly with rice in a sealed pot. Then there is the Muslim wedding biryani which actually has lesser masala, but packed with flavour mostly from whole spices; the Kerala biryani, donne biryani from Karnataka and so many more.",
      "typeName": "Feature",
      "typeColor": "0xff9acd32",
      "assignees": [
        {"userName": "deepak", "color": "0xff009688"},
        {"userName": "chris", "color": "0xff9932cc"},
        {"userName": "rayan", "color": "0xffff5722"}
      ]
    },
  ],
  [
    {
      "id": 4,
      "ticketName": "need to migrate a list of users",
      "ticketBody":
          "Biryani in India doesn't just mean biryani. There are variations across the length and breadth of the country. There is Hyderabadi biryani (which is what I'm sharing today) where the biryani has a lot of gravy or masala and is cooked slowly with rice in a sealed pot. Then there is the Muslim wedding biryani which actually has lesser masala, but packed with flavour mostly from whole spices; the Kerala biryani, donne biryani from Karnataka and so many more.",
      "typeName": "Requirement",
      "typeColor": "0xffff5722",
      "assignees": [
        {"userName": "deepak", "color": "0xff009688"},
        {"userName": "chris", "color": "0xff9932cc"},
        {"userName": "rayan", "color": "0xffff5722"}
      ]
    }
  ]
];
List<String> names = ["new", "need inputs", "pending by co-worker"];

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List tickets = [];
  List searchedTickets = [];
  List filters = [];
  bool playing = false;

  bool isOpen = false;
  double height = 0, width = 0, initX = 0, initY = 0;
  int? selectedIdx;
  Positioned? dropdown;

  @override
  void initState() {
    tickets.clear();

    for (var temp in buckets) {
      for (var ticket in temp) {
        tickets.add(ticket);
      }
    }
    print("il" + tickets.length.toString());
    searchedTickets = tickets;
    animationSink.add("");
    events.registerEvent("show_planner", () async {
      if (!playing) {
        print("playing chat");
        playing = true;
        while (playing) {
          search.clear();
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));
          RenderBox renderBox =
              screenKey.currentContext!.findRenderObject() as RenderBox;
          Window.stageWidth = renderBox.size.width;
          // print(Window.stageWidth);
          mouseX = ((Window.stageWidth - 430) / 2) - 10;
          mouseY = 26;
          animationSink.add("");
          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          for (var char in "user name".characters) {
            Random random = Random();

            if (!playing) {
              break;
            }
            await Future.delayed(Duration(milliseconds: random.nextInt(500)));
            search.text += char;
            searchValue(search.text);
            animationSink.add("");
          }
          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          search.text = "";
          searchValue("");
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          // filter 1
          mouseX = Window.stageWidth - 100;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          filters.add({"name": "", "value": ""});
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          mouseX = Window.stageWidth - 100;
          mouseY = 80;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          initX = Window.stageWidth - 165;
          initY = 100;
          dropdown = _createDropDown([
            {"name": "Status"},
            {"name": "Priority"},
            {"name": "Type"},
            {"name": "Deadline"},
          ]);
          isOpen = true;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          mouseX = Window.stageWidth - 100;
          mouseY = 170;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 800));
          isOpen = false;
          filters[0]["name"] = "Type";
          animationSink.add("");

          mouseX = Window.stageWidth - 100;
          mouseY = 120;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          initX = Window.stageWidth - 165;
          initY = 148;
          dropdown = _createDropDown([
            {"name": "Bug"},
            {"name": "Feature"},
            {"name": "Requirement"},
          ]);
          isOpen = true;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));
          mouseX = Window.stageWidth - 100;
          mouseY = 185;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 800));
          isOpen = false;
          filters[0]["value"] = "Feature";

          animationSink.add("");

          // filter 2
          mouseX = Window.stageWidth - 100;
          mouseY = 26;

          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          filters.add({"name": "", "value": ""});
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          mouseX = Window.stageWidth - 100;
          mouseY = 195;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          initX = Window.stageWidth - 165;
          initY = 215;
          dropdown = _createDropDown([
            {"name": "Status"},
            {"name": "Priority"},
            {"name": "Type"},
            {"name": "Deadline"},
          ]);
          isOpen = true;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          mouseX = Window.stageWidth - 100;
          mouseY = 220;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 800));
          isOpen = false;
          filters[1]["name"] = "Status";
          animationSink.add("");

          mouseX = Window.stageWidth - 100;
          mouseY = 248;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          initX = Window.stageWidth - 165;
          initY = 265;
          dropdown = _createDropDown([
            {"name": "Pending"},
            {"name": "Testing"},
            {"name": "Complete"},
          ]);
          isOpen = true;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));
          mouseX = Window.stageWidth - 100;
          mouseY = 275;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 800));
          isOpen = false;
          filters[1]["value"] = "Pending";
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));
          mouseX = Window.stageWidth - 50;
          mouseY = 26;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          searchedTickets = [];
          searchedTickets.add(tickets[2]);
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(seconds: 2));
          searchedTickets = tickets;
          filters.clear();
          animationSink.add("");
        }

        print("playing");
      }
      print("stopped planner");
    });

    events.registerEvent("stop_planner", () async {
      playing = false;
    });

    super.initState();
  }

  void close() {
    if (isOpen = true) {
      selectedIdx = null;
      // dropdown!.remove();
      isOpen = false;
    }
  }

  Positioned _createDropDown(List items) {
    return Positioned(
      left: initX,
      top: initY,
      height: 30.0 * items.length,
      child: Container(
        width: 150,
        padding: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
            color: Pallet.inner3, borderRadius: BorderRadius.circular(5)),
        child: ListView.builder(
            // controller: controller,
            itemCount: items.length,
            itemBuilder: (_, i) => Container(
                  decoration: BoxDecoration(
                      color:
                          (selectedIdx == i) ? Colors.red : Colors.transparent,
                      // color: (selectedIdx == i) ? Pallet.inner3 : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  height: 30,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          items[i]["name"],
                          style: TextStyle(fontSize: 10, color: Pallet.font2),
                        ),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }

  searchValue(String value) {
    searchedTickets = [];
    if (value.isEmpty) {
      searchedTickets = tickets;
    } else {
      for (var ticket in tickets) {
        if (ticket["ticketName"].toString().contains(value)) {
          searchedTickets.add(ticket);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: animationStream,
        builder: (context, snapshot) {
          return Stack(
            key: screenKey,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 10, right: 10),
                    child: Column(
                      children: [
                        Container(
                          width: 250,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                              color: Pallet.inner1,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                    controller: search,
                                    onChanged: (value) {},
                                    style: TextStyle(fontSize: 10),
                                    decoration: InputDecoration(
                                      hintText: "search",
                                      hintStyle: TextStyle(
                                          fontSize: 10, color: Pallet.font3),
                                      isDense: true,
                                      border: InputBorder.none,
                                    )),
                              ),
                              Icon(
                                Icons.search,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              for (var ticket in searchedTickets)
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    height: 90,
                                    decoration: BoxDecoration(
                                        color: Pallet.inner1,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    ticket["ticketName"],
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomBadge(
                                                      label: ticket["typeName"],
                                                      color: Color(int.parse(
                                                          ticket["typeColor"])))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                ticket["ticketBody"],
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Pallet.font3),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.alarm,
                                                  color: Pallet.font3,
                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  (ticket["deadline"] == null)
                                                      ? "None"
                                                      : ticket["deadline"],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Stack(
                                              children: [
                                                for (var i = 0;
                                                    i <
                                                        ticket["assignees"]
                                                            .length;
                                                    i++)
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: i * 10),
                                                    child: ProfileIcon(
                                                      size: 20,
                                                      fontSize: 10,
                                                      name: ticket["assignees"]
                                                          [i]["userName"],
                                                      color: Color(int.parse(
                                                          ticket["assignees"][i]
                                                              ["color"])),
                                                    ),
                                                  ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
                  Container(
                    padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 0.5,
                          color: Pallet.font3.withOpacity(0.2),
                        ),
                      ),
                    ),
                    width: 180,
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
                                      style: TextStyle(fontSize: 12),
                                    )),
                                    SmallButton(
                                      label: "add",
                                      onPress: () {},
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SmallButton(
                                      label: "apply",
                                      onPress: () {},
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ]),
                              for (var i = 0; i < filters.length; i++)
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Pallet.inner2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "property",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Pallet.inner1),
                                        child: Row(
                                          children: [
                                            Text(
                                              (filters[i]["name"]
                                                      .toString()
                                                      .isEmpty)
                                                  ? "select"
                                                  : filters[i]["name"],
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "value",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Pallet.inner1),
                                        child: Row(
                                          children: [
                                            Text(
                                              (filters[i]["value"]
                                                      .toString()
                                                      .isEmpty)
                                                  ? "select"
                                                  : filters[i]["value"],
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )

                              // for (var i = 0; i < selectedFilters.length; i++)
                              //   Container(
                              //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              //     margin: EdgeInsets.only(bottom: 10),
                              //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Pallet.inner2),
                              //     child: Column(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children: [
                              //         Row(
                              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Text(
                              //               "property",
                              //               style: TextStyle(fontSize: 12),
                              //             ),
                              //             InkWell(
                              //               onTap: () {
                              //                 selectedFilters.removeAt(i);
                              //                 server.get(
                              //                     data: {"0": "ticket_filter", "1": userId, "2": appId, "3": jsonEncode(selectedFilters)},
                              //                     func: (data) {
                              //                       tickets.value = data;
                              //                     });
                              //               },
                              //               child: Icon(
                              //                 Icons.close,
                              //                 size: 14,
                              //               ),
                              //             )
                              //           ],
                              //         ),
                              //         SizedBox(
                              //           height: 10,
                              //         ),
                              //         DropDown(
                              //           label: selectedFilters[i]["name"].toString(),
                              //           itemKey: "name",
                              //           items: filters,
                              //           onPress: (value) {
                              //             selectedFilters[i] = value;
                              //             print(ticket.statuses);
                              //             refreshSink.add("");
                              //           },
                              //           menuDecoration: BoxDecoration(color: Pallet.inner1, borderRadius: BorderRadius.circular(10)),
                              //         ),
                              //         SizedBox(
                              //           height: 10,
                              //         ),
                              //         if (selectedFilters[i]["name"] == "status")
                              //           Column(
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //               Text(
                              //                 "value",
                              //                 style: TextStyle(fontSize: 12),
                              //               ),
                              //               SizedBox(
                              //                 height: 10,
                              //               ),
                              //               DropDown(
                              //                 label: (ticket.status == null) ? "Status" : ticket.status!["statusName"],
                              //                 itemKey: "statusName",
                              //                 items: ticket.statuses,
                              //                 menuDecoration: BoxDecoration(color: Pallet.inner1, borderRadius: BorderRadius.circular(10)),
                              //                 onPress: (data) {
                              //                   ticket.status = data;
                              //                   selectedFilters[i]["value"] = data["statusName"];
                              //                   refreshSink.add("");
                              //                 },
                              //               ),
                              //               SizedBox(
                              //                 height: 10,
                              //               ),
                              //             ],
                              //           ),
                              //         if (selectedFilters[i]["name"] == "type")
                              //           Column(
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //               Text(
                              //                 "value",
                              //                 style: TextStyle(fontSize: 12),
                              //               ),
                              //               SizedBox(
                              //                 height: 10,
                              //               ),
                              //               DropDown(
                              //                 label: (ticket.type == null) ? "Type" : ticket.type!["typeName"],
                              //                 itemKey: "typeName",
                              //                 items: ticket.types,
                              //                 menuDecoration: BoxDecoration(color: Pallet.inner1, borderRadius: BorderRadius.circular(10)),
                              //                 onPress: (data) {
                              //                   ticket.type = data;
                              //                   selectedFilters[i]["value"] = data["typeName"];
                              //                   refreshSink.add("");
                              //                 },
                              //               ),
                              //               SizedBox(
                              //                 height: 10,
                              //               ),
                              //             ],
                              //           ),
                              //         if (selectedFilters[i]["type"] == "both")
                              //           Column(
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //               Text(
                              //                 "type",
                              //                 style: TextStyle(fontSize: 12),
                              //               ),
                              //               SizedBox(
                              //                 height: 10,
                              //               ),
                              //               DropDown(
                              //                 label: selectedFilters[i]["value"] == null ? "value" : selectedFilters[i]["value"],
                              //                 itemKey: "name",
                              //                 items: [
                              //                   {"name": "ascending"},
                              //                   {"name": "descending"},
                              //                   {"name": "value"},
                              //                 ],
                              //                 menuDecoration: BoxDecoration(color: Pallet.inner1, borderRadius: BorderRadius.circular(10)),
                              //                 onPress: (data) {
                              //                   if (data["name"] == "value") {
                              //                     selectedFilters[i]["is_value"] = true;
                              //                   } else {
                              //                     selectedFilters[i]["is_value"] = false;
                              //                   }
                              //                   selectedFilters[i]["value"] = data["name"];
                              //                   // ticket.status = data;
                              //                   refreshSink.add("");
                              //                 },
                              //               ),
                              //               SizedBox(
                              //                 height: 10,
                              //               ),
                              //             ],
                              //           ),
                              //         if (selectedFilters[i]["is_value"] == true)
                              //           Column(
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //               Text(
                              //                 "value",
                              //                 style: TextStyle(fontSize: 12),
                              //               ),
                              //               SizedBox(
                              //                 height: 10,
                              //               ),
                              //               DropDown(
                              //                 label: (ticket.priority == null) ? "Priority" : ticket.priority!["priorityName"],
                              //                 itemKey: "priorityName",
                              //                 items: ticket.priorities,
                              //                 menuDecoration: BoxDecoration(color: Pallet.inner1, borderRadius: BorderRadius.circular(10)),
                              //                 onPress: (data) {
                              //                   selectedFilters[i]["value"] = data["priorityName"];

                              //                   ticket.priority = data;
                              //                   refreshSink.add("");
                              //                 },
                              //               ),
                              //               SizedBox(
                              //                 height: 10,
                              //               ),
                              //             ],
                              //           ),
                              //         if (selectedFilters[i]["name"] == "deadline")
                              //           Column(
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //               Text(
                              //                 "type",
                              //                 style: TextStyle(fontSize: 12),
                              //               ),
                              //               SizedBox(
                              //                 height: 10,
                              //               ),
                              //               DropDown(
                              //                 label: (selectedFilters[i]["value"] == null) ? "value" : selectedFilters[i]["value"],
                              //                 itemKey: "name",
                              //                 items: [
                              //                   {"name": "ascending"},
                              //                   {"name": "descending"},
                              //                 ],
                              //                 menuDecoration: BoxDecoration(color: Pallet.inner1, borderRadius: BorderRadius.circular(10)),
                              //                 onPress: (data) {
                              //                   selectedFilters[i]["value"] = data["name"];
                              //                   refreshSink.add("");
                              //                 },
                              //               ),
                              //               SizedBox(
                              //                 height: 10,
                              //               ),
                              //             ],
                              //           ),
                              // ],
                              // ),
                              // )
                            ],
                          );
                        }),
                  )
                ],
              ),
              if (isOpen) dropdown!,
              AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  top: mouseY,
                  left: mouseX,
                  child: SizedBox(
                      width: 50,
                      height: 30,
                      // color: Colors.red,
                      child: Lottie.asset('assets/white_select.json')))
            ],
          );
        });
  }
}

class Properties extends StatefulWidget {
  const Properties({super.key});

  @override
  State<Properties> createState() => _PropertiesState();
}

class _PropertiesState extends State<Properties> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class SmallButton extends StatelessWidget {
  const SmallButton({super.key, required this.label, required this.onPress});
  final String label;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
        minimumSize: Size(30, 30),
      ),
      onPressed: () {
        onPress();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Pallet.inner1,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(color: Pallet.font3, fontSize: 9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BucketView extends StatefulWidget {
  const BucketView({super.key});

  @override
  State<BucketView> createState() => _BucketViewState();
}

class _BucketViewState extends State<BucketView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // controller: _scrollController,
      scrollDirection: Axis.horizontal,
      children: [
        for (var i = 0; i < buckets.length; i++)
          SizedBox(
              width: 200,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 8, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          names[i],
                          style: TextStyle(fontSize: 12),
                        ),
                        if (i == 0)
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Pallet.font3),
                                borderRadius: BorderRadius.circular(2)),
                            child: InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.add,
                                color: Pallet.font3,
                                size: 12,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      for (var ticket in buckets[i])
                        GestureDetector(
                            onTap: () {}, child: Ticket(data: ticket))
                    ],
                  )),
                ],
              )),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          width: 250,
          child: Column(
            children: [
              // AddBucket()
            ],
          ),
        )
      ],
    );
  }
}

class Ticket extends StatelessWidget {
  const Ticket({super.key, required this.data});
  final Map data;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          color: Pallet.inner2, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomBadge(
                  label: data["typeName"],
                  color: Color(int.parse(data["typeColor"]))),
              Expanded(child: SizedBox()),
              Icon(
                Icons.upload_outlined,
                color: Pallet.font3,
                size: 18,
              ),
              Icon(
                Icons.download_outlined,
                color: Pallet.font3,
                size: 18,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            data["ticketName"],
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              data["ticketBody"],
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 10, color: Pallet.font3),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(
                Icons.alarm,
                color: Pallet.font3,
                size: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                (data["deadline"] == null)
                    ? "None"
                    : data["deadline"].toString(),
                style: TextStyle(fontSize: 12),
              ),
              Expanded(child: Container()),
              Stack(
                children: [
                  for (var i = 0; i < data["assignees"].length; i++)
                    Padding(
                      padding: EdgeInsets.only(left: i * 10),
                      child: ProfileIcon(
                        size: 20,
                        fontSize: 10,
                        name: data["assignees"][i]["userName"],
                        color: Color(int.parse(data["assignees"][i]["color"])),
                      ),
                    ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProfileIcon extends StatelessWidget {
  const ProfileIcon(
      {super.key,
      this.image,
      this.name,
      this.color,
      required this.size,
      this.fontSize});
  final String? image;
  final String? name;
  final Color? color;
  final double size;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(size)),
      child: Center(
        child: Text(name![0].toString().toUpperCase(),
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontSize: fontSize, fontWeight: FontWeight.w500))),
      ),
    );
  }
}

class CustomBadge extends StatelessWidget {
  const CustomBadge({super.key, required this.label, required this.color});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(5),
        color: color.withOpacity(0.2),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(fontSize: 8, color: color),
        ),
      ),
    );
  }
}
