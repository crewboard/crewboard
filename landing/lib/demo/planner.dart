import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import '../types.dart';
import '../widgets.dart';
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

  bool isBucketView = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    themeChangeStream.listen((event) {
      if (mounted) setState(() {});
    });

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
          'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible',
        );
      },
      child: SizedBox(
        width: Window.fullWidth,
        height: Window.fullHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (Window.isMobile)
                ? Column(
                    children: [
                      Animate(
                        controller: _controller,
                        effects: const [
                          ScaleEffect(duration: Duration(milliseconds: 1000)),
                          FadeEffect(duration: Duration(milliseconds: 1000)),
                        ],
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: Window.fullWidth,
                          decoration: BoxDecoration(
                            color: DemoPallet.background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: Window.fullHeight * 0.4,
                          child: DemoBackground(
                            child:
                                isBucketView ? BucketView() : SearchView(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: Window.fullWidth * 0.9,
                        child: Animate(
                          controller: _controller,
                          effects: const [
                            SlideEffect(duration: Duration(milliseconds: 1500)),
                            FadeEffect(duration: Duration(milliseconds: 1500)),
                          ],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Manage your team recources efficiently with planner",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Use bucket view to arrange tickets or search view to find specific ones.",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isBucketView = true;
                                      });
                                      animationSink.add("stop_planner");
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: isBucketView
                                            ? const Color(0xFF4A90E2)
                                            : const Color(0xFF24292F),
                                      ),
                                      child: const Text(
                                        "Bucket View",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isBucketView = false;
                                      });
                                      animationSink.add("show_planner");
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: !isBucketView
                                            ? const Color(0xFF4A90E2)
                                            : const Color(0xFF24292F),
                                      ),
                                      child: const Text(
                                        "Search View",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
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
                  )
                : Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            width: Window.fullWidth * 0.3,
                            child: Animate(
                              controller: _controller,
                              effects: const [
                                SlideEffect(
                                  duration: Duration(milliseconds: 1500),
                                ),
                                FadeEffect(
                                  duration: Duration(milliseconds: 1500),
                                ),
                              ],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Manage your team recources efficiently with planner",
                                    style: TextStyle(
                                      fontSize: 45,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "use bucket view to arrange tickets like in your mind board",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isBucketView = true;
                                      });
                                      animationSink.add("stop_planner");
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: isBucketView
                                            ? const Color(0xFF4A90E2)
                                            : const Color(0xFF24292F),
                                      ),
                                      child: const Text(
                                        "Bucket View",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  const Text(
                                    "use search view to perform search and filtering on your tickets",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isBucketView = false;
                                      });
                                      animationSink.add("show_planner");
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18, vertical: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: !isBucketView
                                            ? const Color(0xFF4A90E2)
                                            : const Color(0xFF24292F),
                                      ),
                                      child: const Text(
                                        "Search View",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
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
                            FadeEffect(duration: Duration(milliseconds: 1000)),
                          ],
                          child: Container(
                            decoration: BoxDecoration(
                              color: DemoPallet.background,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: Window.fullHeight * 0.5,
                            child: DemoBackground(
                              child:
                                  isBucketView ? BucketView() : SearchView(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Window.fullWidth * 0.1),
                    ],
                  ),
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
      "deadline": "2 days left",
      "assignees": [
        {"userName": "deepak", "color": "0xff009688"},
        {"userName": "chris", "color": "0xff9932cc"},
        {"userName": "rayan", "color": "0xffff5722"},
      ],
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
      "deadline": "Today",
      "assignees": [
        {"userName": "deepak", "color": "0xff009688"},
        {"userName": "chris", "color": "0xff9932cc"},
        {"userName": "rayan", "color": "0xffff5722"},
      ],
    },
  ],
  [
    {
      "id": 3,
      "ticketName": "new dash board screen",
      "ticketBody":
          "Biryani in India doesn't just mean biryani. There are variations across the length and breadth of the country. There is Hyderabadi biryani (which is what I'm sharing today) where the biryani has a lot of gravy or masala and is cooked slowly with rice in a sealed pot. Then there is the Muslim wedding biryani which actually has lesser masala, but packed with flavour mostly from whole spices; the Kerala biryani, donne biryani from Karnataka and so many more.",
      "typeName": "Feature",
      "typeColor": "0xff9acd32",
      "deadline": "2 months left",
      "assignees": [
        {"userName": "deepak", "color": "0xff009688"},
        {"userName": "chris", "color": "0xff9932cc"},
        {"userName": "rayan", "color": "0xffff5722"},
      ],
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
      "deadline": "1 week left",
      "assignees": [
        {"userName": "deepak", "color": "0xff009688"},
        {"userName": "chris", "color": "0xff9932cc"},
        {"userName": "rayan", "color": "0xffff5722"},
      ],
    },
  ],
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
          final double scale = Window.isMobile ? 0.6 : 1.0;
          Window.stageWidth = renderBox.size.width / scale;
          // print(Window.stageWidth);
          mouseX = ((Window.stageWidth - 430) / 2) - 10;
          mouseY = 26 * scale;
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

          // Calculate relative offsets
          final double sidebarWidth = Window.isMobile ? 100 : 180;
          final double dropdownX = Window.stageWidth - (Window.isMobile ? 152 : 165);

          // filter 1
          mouseX = Window.stageWidth - (sidebarWidth / 2) - 25;
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

          mouseX = Window.stageWidth - (sidebarWidth / 2) - 25;
          mouseY = Window.isMobile ? 65 : 80;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          initX = dropdownX;
          initY = Window.isMobile ? 85 : 100;
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

          mouseX = Window.stageWidth - (Window.isMobile ? 110 : 100);
          mouseY = Window.isMobile ? 140 : 170;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 800));
          isOpen = false;
          filters[0]["name"] = "Type";
          animationSink.add("");

          mouseX = Window.stageWidth - 100;
          mouseY = Window.isMobile ? 100 : 120;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          initX = dropdownX;
          initY = Window.isMobile ? 128 : 148;
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
          mouseX = Window.stageWidth - (Window.isMobile ? 110 : 100);
          mouseY = Window.isMobile ? 150 : 185;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 800));
          isOpen = false;
          filters[0]["value"] = "Feature";

          animationSink.add("");

          // filter 2
          mouseX = Window.stageWidth - (sidebarWidth / 2) - 25;
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
          mouseY = Window.isMobile ? 165 : 195;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          initX = dropdownX;
          initY = Window.isMobile ? 185 : 215;
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

          mouseX = Window.stageWidth - (sidebarWidth / 2) - 25;
          mouseY = 220;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 800));
          isOpen = false;
          filters[1]["name"] = "Status";
          animationSink.add("");

          mouseX = Window.stageWidth - (Window.isMobile ? 110 : 100);
          mouseY = Window.isMobile ? 220 : 248;
          animationSink.add("");

          if (!playing) {
            break;
          }
          await Future.delayed(const Duration(milliseconds: 500));

          initX = dropdownX;
          initY = Window.isMobile ? 235 : 265;
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
          mouseX = Window.stageWidth - (sidebarWidth / 2) - 25;
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
          mouseX = Window.stageWidth - (sidebarWidth / 2);
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
    final double scale = Window.isMobile ? 0.6 : 1.0;
    final double dropDownWidth = 150 * scale;
    return Positioned(
      left: initX * scale,
      top: initY * scale,
      height: 30.0 * items.length * scale,
      child: GlassMorph(
        width: dropDownWidth,
        padding: EdgeInsets.symmetric(vertical: 2 * scale),
        child: ListView.builder(
          // controller: controller,
          itemCount: items.length,
          itemBuilder: (_, i) => Container(
            decoration: BoxDecoration(
              color: (selectedIdx == i) ? Colors.red : Colors.transparent,
              borderRadius: BorderRadius.circular(5 * scale),
            ),
            height: 30 * scale,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0 * scale),
                  child: Text(
                    items[i]["name"],
                    style: TextStyle(
                        fontSize: 10 * scale,
                        color: Pallet.font2),
                  ),
                ),
              ],
            ),
          ),
        ),
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
    final double scale = Window.isMobile ? 0.6 : 1.0;
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
                    padding: EdgeInsets.only(
                      top: 25 * (Window.isMobile ? 0.6 : 1.0),
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: Window.isMobile ? Window.fullWidth * 0.8 : 250,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10 * scale,
                            vertical: 2 * scale,
                          ),
                          decoration: BoxDecoration(
                            color: Pallet.inner1,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: search,
                                  onChanged: (value) {},
                                  style: TextStyle(fontSize: 10 * scale),
                                  decoration: InputDecoration(
                                    hintText: "search",
                                    hintStyle: TextStyle(
                                      fontSize: 10 * scale,
                                      color: Pallet.font3,
                                    ),
                                    isDense: true,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Icon(Icons.search, size: 15 * scale),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: ListView(
                            children: [
                              for (var ticket in searchedTickets)
                                InkWell(
                                  onTap: () {},
                                  child: GlassMorph(
                                    margin: EdgeInsets.only(
                                      bottom: (Window.isMobile ? 5 : 10) * scale,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20 * scale,
                                      vertical: (Window.isMobile ? 3 : 8) * scale,
                                    ),
                                    height: (Window.isMobile ? 80 : 115) * scale,
                                    borderRadius: 10,
                                    sigmaX: 10,
                                    sigmaY: 10,
                                    color: DemoPallet.isGlass
                                        ? (DemoPallet.light
                                              ? Colors.white.withOpacity(0.5)
                                              : Colors.black.withOpacity(0.3))
                                        : Pallet.inner1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      ticket["ticketName"],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12 * scale,
                                                        color: Pallet.font1,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10 * scale),
                                                  CustomBadge(
                                                    label: ticket["typeName"],
                                                    color: Color(
                                                      int.parse(
                                                        ticket["typeColor"],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: (Window.isMobile ? 2 : 5) * scale),
                                              Text(
                                                ticket["ticketBody"],
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 10 * scale,
                                                  color: Pallet.font3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10 * scale),
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
                                                  size: 15 * scale,
                                                ),
                                                SizedBox(width: 2.5 * scale),
                                                Text(
                                                  (ticket["deadline"] == null)
                                                      ? "None"
                                                      : ticket["deadline"],
                                                  style: TextStyle(
                                                    fontSize: 10 * scale,
                                                    color: Pallet.font3,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10 * scale),
                                            Stack(
                                              children: [
                                                for (
                                                  var i = 0;
                                                  i <
                                                      ticket["assignees"]
                                                          .length;
                                                  i++
                                                )
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: i * 10 * scale,
                                                    ),
                                                    child: ProfileIcon(
                                                      size: (Window.isMobile ? 15 : 20) * scale,
                                                      fontSize: (Window.isMobile ? 8 : 10) * scale,
                                                      name:
                                                          ticket["assignees"][i]["userName"],
                                                      color: Color(
                                                        int.parse(
                                                          ticket["assignees"][i]["color"],
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
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: Window.isMobile ? 5 : 15,
                    left: Window.isMobile ? 5 : 10,
                    right: Window.isMobile ? 5 : 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 0.5,
                        color: Pallet.font3.withOpacity(0.2),
                      ),
                    ),
                  ),
                  width: Window.isMobile ? 100 : 180,
                  child: StreamBuilder<Object>(
                    stream: refreshStream,
                    builder: (context, snapshot) {
                      final double fScale = Window.isMobile ? 0.6 : 1.0;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  "filters",
                                  style: TextStyle(
                                      fontSize: 12 * fScale,
                                      color: Pallet.font1),
                                ),
                              ),
                              SmallButton(label: "add", onPress: () {}),
                              SizedBox(width: Window.isMobile ? 2 : 10),
                              SmallButton(label: "apply", onPress: () {}),
                              SizedBox(height: 10 * fScale),
                            ],
                          ),
                          for (var i = 0; i < filters.length; i++)
                              GlassMorph(
                                margin: EdgeInsets.only(
                                  top: (Window.isMobile ? 2 : 5) * fScale,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: (Window.isMobile ? 5 : 10) * fScale,
                                  vertical: (Window.isMobile ? 5 : 10) * fScale,
                                ),
                              borderRadius: Window.isMobile ? 5 :  10,
                              sigmaX: 10,
                              sigmaY: 10,
                              color: DemoPallet.isGlass
                                  ? (DemoPallet.light
                                        ? Colors.white.withOpacity(0.5)
                                        : Colors.black.withOpacity(0.3))
                                  : Pallet.inner2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "property",
                                    style: TextStyle(
                                        fontSize: 10 * fScale,
                                        color: Pallet.font1),
                                  ),
                                  SizedBox(height: 5 * fScale),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5 * fScale,
                                      horizontal: 8 * fScale,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Pallet.inner1,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          (filters[i]["name"]
                                                  .toString()
                                                  .isEmpty)
                                              ? "select"
                                              : filters[i]["name"],
                                          style: TextStyle(
                                              fontSize: 10 * fScale,
                                              color: Pallet.font2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5 * fScale),
                                  Text("value",
                                      style: TextStyle(
                                          fontSize: 10 * fScale,
                                          color: Pallet.font1)),
                                  SizedBox(height: 5 * fScale),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5 * fScale,
                                      horizontal: 8 * fScale,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Pallet.inner1,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          (filters[i]["value"]
                                                  .toString()
                                                  .isEmpty)
                                              ? "select"
                                              : filters[i]["value"],
                                          style: TextStyle(
                                              fontSize: 10 * fScale,
                                              color: Pallet.font2),
                                        ),
                                      ],
                                    ),
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
            ),
            if (isOpen) dropdown!,
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              top: mouseY * scale,
              left: mouseX * scale,
              child: SizedBox(
                width: 50 * scale,
                height: 30 * scale,
                // color: Colors.red,
                child: Lottie.asset('assets/white_select.json'),
              ),
            ),
          ],
        );
      },
    );
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
    return Container(
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
              style: TextStyle(
                color: Pallet.font3,
                fontSize: 9 * (Window.isMobile ? 0.8 : 1.0),
              ),
            ),
          ],
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
    final double scale = Window.isMobile ? 0.6 : 1.0;
    return ListView(
      // controller: _scrollController,
      scrollDirection: Axis.horizontal,
      children: [
        for (var i = 0; i < buckets.length; i++)
          SizedBox(
            width: 200 * scale,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 8 * scale,
                    right: 8 * scale,
                    top: 8 * scale,
                    bottom: 5 * scale,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(names[i], style: TextStyle(fontSize: 12 * scale, color: Pallet.font1)),
                      if (i == 0)
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Pallet.font3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.add,
                              color: Pallet.font3,
                              size: 12 * scale,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      for (var ticket in buckets[i])
                        GestureDetector(
                          onTap: () {},
                          child: Ticket(data: ticket),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5 * scale),
          width: 250 * scale,
          child: Column(
            children: [
              // AddBucket()
            ],
          ),
        ),
      ],
    );
  }
}

class Ticket extends StatelessWidget {
  const Ticket({super.key, required this.data});
  final Map data;
  @override
  Widget build(BuildContext context) {
    final double scale = Window.isMobile ? 0.6 : 1.0;
    return Container(
      width: 200 * scale,
      margin: EdgeInsets.all(5 * scale),
      padding: EdgeInsets.symmetric(vertical: 8 * scale, horizontal: 8 * scale),
      decoration: BoxDecoration(
        color: Pallet.inner2,
        borderRadius: BorderRadius.circular(8 * scale),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomBadge(
                label: data["typeName"],
                color: Color(int.parse(data["typeColor"])),
              ),
              Expanded(child: SizedBox()),
              Icon(Icons.upload_outlined, color: Pallet.font3, size: 18 * scale),
              Icon(Icons.download_outlined, color: Pallet.font3, size: 18 * scale),
            ],
          ),
          SizedBox(height: 10 * scale),
          Text(data["ticketName"],
              style: TextStyle(fontSize: 13 * scale, color: Pallet.font1)),
          SizedBox(height: 5 * scale),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2 * scale),
            child: Text(
              data["ticketBody"],
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 10 * scale, color: Pallet.font3),
            ),
          ),
          SizedBox(height: 5 * scale),
          Row(
            children: [
              Icon(Icons.alarm, color: Pallet.font3, size: 18 * scale),
              SizedBox(width: 5 * scale),
              Text(
                (data["deadline"] == null)
                    ? "None"
                    : data["deadline"].toString(),
                style: TextStyle(fontSize: 12 * scale, color: Pallet.font3),
              ),
              Expanded(child: Container()),
              Stack(
                children: [
                  for (var i = 0; i < data["assignees"].length; i++)
                    Padding(
                      padding: EdgeInsets.only(left: i * 10 * scale),
                      child: ProfileIcon(
                        size: 20 * scale,
                        fontSize: 10 * scale,
                        name: data["assignees"][i]["userName"],
                        color: Color(int.parse(data["assignees"][i]["color"])),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
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
      padding: EdgeInsets.symmetric(
        horizontal: Window.isMobile ? 3 : 5,
        vertical: Window.isMobile ? 1 : 2,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(Window.isMobile ? 2 : 5),
        color: color.withOpacity(0.2),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: Window.isMobile ? 6 : 8,
            color: color,
          ),
        ),
      ),
    );
  }
}
