import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:frontend/services/local_storage_service.dart';
import 'package:get/get.dart';
import 'package:frontend/backend/server.dart';
import 'package:frontend/backend/types.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/widgets.dart';
import 'package:frontend/widgets/textbox.dart';
import 'package:frontend/widgets/dropdown.dart';
import 'package:frontend/services/arri_client.rpc.dart';
import 'package:frontend/screens/planner/planner_controller.dart';
import 'addTicket.dart';
import 'viewTicket.dart';

class BucketView extends StatelessWidget {
  const BucketView({super.key});

  @override
  Widget build(BuildContext context) {
    final PlannerController plannerController = Get.find<PlannerController>();
    final ScrollController _scrollController = ScrollController();

    return Obx(() {
      final buckets = plannerController.buckets;
      final tickets = plannerController.tickets;
      return Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            children: [
              for (var i = 0; i < buckets.length; i++)
                SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 8,
                          top: 8,
                          bottom: 5,
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(buckets[i].bucketName)),
                            if (buckets[i].bucketName
                                        .toString()
                                        .toLowerCase() ==
                                    "new" &&
                                Permissions.planner)
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Pallet.font3),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    addTicket(
                                      context,
                                      buckets[i].bucketId,
                                    ).then((_) async {
                                      if (Window.subPage != "search") {
                                        plannerController.loadPlannerData();
                                      }
                                    });
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Pallet.font3,
                                    size: 15,
                                  ),
                                ),
                              )
                            else
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {},

                                    child: Icon(Icons.edit, size: 16),
                                  ),
                                  SizedBox(width: 5),
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(Icons.delete, size: 16),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: CustomScrollView(
                          //Instead of ListView or SingleChildScrollView put CustomScrollVIew to use Expanded or spacer
                          slivers: [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (var j = 0; j < tickets[i].length; j++)
                                    if (tickets[i][j].holder == true)
                                      DragTarget<int>(
                                        builder:
                                            (
                                              BuildContext context,
                                              List<dynamic> accepted,
                                              List<dynamic> rejected,
                                            ) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.blue
                                                      .withOpacity(0.2),
                                                  border: Border.all(
                                                    color: Colors.blue,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                height: 300,
                                              );
                                            },
                                        onAccept: (int data) {
                                          print("yo");
                                          for (
                                            var ii = 0;
                                            ii < tickets.length;
                                            ii++
                                          ) {
                                            for (
                                              var jj = 0;
                                              jj < tickets[ii].length;
                                              jj++
                                            ) {
                                              if (tickets[ii][jj].id ==
                                                  plannerController
                                                      .selectedPlan
                                                      .value
                                                      .id) {
                                                tickets[ii].removeAt(jj);
                                              }
                                            }
                                          }
                                          // for (var ii = 0; ii < tickets.length; ii++) {
                                          //   for (var jj = 0; jj < tickets[ii].length; jj++) {
                                          //     if (tickets[ii][jj]["holder"] == true) {
                                          //       tickets[ii].removeAt(jj);
                                          //       tickets[ii].insert(jj, selectedPlan);
                                          //       server.planner.changeBucket(
                                          //         // ChangeBucketParams(
                                          //         //   ticketId: selectedPlan["id"],
                                          //         //   bucketId: buckets[i]["bucketId"],
                                          //         //   // order: jj,
                                          //         // ),
                                          //       );
                                          //     }
                                          //   }
                                          // }
                                          plannerController.loadPlannerData();
                                        },
                                      )
                                    else
                                      DragTarget<int>(
                                        builder:
                                            (
                                              BuildContext context,
                                              List<dynamic> accepted,
                                              List<dynamic> rejected,
                                            ) {
                                              return DraggableCard(
                                                data: tickets[i][j],
                                                onDragStart: () {
                                                  plannerController
                                                          .selectedPlan
                                                          .value =
                                                      tickets[i][j];
                                                  print(
                                                    plannerController
                                                        .selectedPlan,
                                                  );
                                                },
                                                value: tickets[i][j].id,
                                              );
                                            },
                                        onWillAccept: (int? data) {
                                          if (data.toString() !=
                                              tickets[i][j].id) {
                                            for (
                                              var ii = 0;
                                              ii < tickets.length;
                                              ii++
                                            ) {
                                              for (
                                                var jj = 0;
                                                jj < tickets[ii].length;
                                                jj++
                                              ) {
                                                if (tickets[ii][jj].holder ==
                                                    true) {
                                                  tickets[ii].removeAt(jj);
                                                }
                                              }
                                            }
                                            // plannerController.loadPlannerData();
                                            print(j);
                                            tickets[i].insert(
                                              j,
                                              TicketModel.empty().copyWith(
                                                holder: true,
                                              ),
                                            );
                                            // plannerController.loadPlannerData();
                                          }

                                          return true;
                                        },
                                      ),
                                  Expanded(
                                    child: DragTarget<int>(
                                      builder:
                                          (
                                            BuildContext context,
                                            List<dynamic> accepted,
                                            List<dynamic> rejected,
                                          ) {
                                            return Container();
                                          },
                                      onWillAccept: (int? data) {
                                        for (
                                          var ii = 0;
                                          ii < tickets.length;
                                          ii++
                                        ) {
                                          for (
                                            var jj = 0;
                                            jj < tickets[ii].length;
                                            jj++
                                          ) {
                                            if (tickets[ii][jj].holder ==
                                                true) {
                                              tickets[ii].removeAt(jj);
                                            }
                                          }
                                        }
                                        tickets[i].add(
                                          TicketModel.empty().copyWith(
                                            holder: true,
                                          ),
                                        );
                                        plannerController.loadPlannerData();

                                        return true;
                                      },
                                      onAccept: (int data) {
                                        int? idx;
                                        int? jdx;
                                        for (
                                          var ii = 0;
                                          ii < tickets.length;
                                          ii++
                                        ) {
                                          for (
                                            var jj = 0;
                                            jj < tickets[ii].length;
                                            jj++
                                          ) {
                                            if (tickets[ii][jj].id ==
                                                data.toString()) {
                                              idx = ii;
                                              jdx = jj;
                                            }
                                            if (tickets[ii][jj].holder ==
                                                true) {
                                              tickets[ii].removeAt(jj);
                                            }
                                          }
                                        }
                                        if (jdx != null && idx != null) {
                                          TicketModel val = tickets[idx][jdx];
                                          tickets[idx].removeAt(jdx);
                                          tickets[i].add(val);
                                          print("object");
                                          server.planner.changeBucket(
                                            ChangeBucketParams(
                                              ticketId: plannerController
                                                  .selectedPlan
                                                  .value
                                                  .id
                                                  .toString(),
                                              bucketId: buckets[i].bucketId,
                                              order: 1,
                                            ),
                                          );
                                        }
                                        plannerController.loadPlannerData();
                                      },
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                width: 250,
                child: Column(children: [AddBucket()]),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class AddBucket extends StatefulWidget {
  const AddBucket({super.key});

  @override
  State<AddBucket> createState() => _AddBucketState();
}

class _AddBucketState extends State<AddBucket> {
  bool isAdd = false;
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (isAdd) {
      return Animate(
        effects: [FadeEffect()],
        child: Container(
          width: 230,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Pallet.inside1,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text("Name", style: TextStyle(fontSize: 12)),
              SizedBox(height: 10),
              SmallTextBox(
                controller: name,
                onEnter: (value) {
                  save();
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SmallButton(
                    label: "close",
                    onPress: () {
                      isAdd = false;
                      setState(() {});
                    },
                  ),
                  SizedBox(width: 10),
                  SmallButton(
                    label: "done",
                    onPress: () async {
                      save();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    return Animate(
      effects: [FadeEffect(duration: Duration(milliseconds: 500))],
      // child: Text("add"),
      child: Button(
        label: "add bucket",
        onPress: () async {
          isAdd = true;
          setState(() {});
        },
      ),
    );
  }

  save() async {
    final userId = await LocalStorageService.getUserId();

    final PlannerController plannerController = Get.find<PlannerController>();
    server.planner
        .addBucket(
          AddBucketParams(
            appId: plannerController.selectedAppId.value,
            userId: userId!,
            bucketName: name.text,
          ),
        )
        .then((data) {
          print(data);
          Get.find<PlannerController>();
          plannerController.loadPlannerData();
        });
    isAdd = false;
    setState(() {});
  }
}

class DraggableCard extends StatelessWidget {
  const DraggableCard({
    super.key,
    required this.value,
    required this.onDragStart,
    required this.data,
  });
  final String value;
  final Function onDragStart;
  final TicketModel data;
  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: value,
      feedback: Material(
        color: Colors.transparent,
        child: TicketWidget(data: data),
      ),
      childWhenDragging: Material(
        color: Colors.transparent,
        child: Container(),
      ),
      child: InkWell(
        onTap: () {
          print(data.id);
          viewTicket(context, int.parse(data.id));
        },
        child: TicketWidget(data: data),
      ),
      onDragStarted: () {
        onDragStart();
      },
    );
  }
}

class TicketWidget extends StatelessWidget {
  const TicketWidget({super.key, required this.data});
  final TicketModel data;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Pallet.inside2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomBadge(
                label: data.typeName,
                color: Color(int.parse(data.typeColor)),
              ),
              Expanded(child: SizedBox()),
              Icon(Icons.upload_outlined, color: Pallet.font3),
              Icon(Icons.download_outlined, color: Pallet.font3),
            ],
          ),
          SizedBox(height: 10),
          Text(data.ticketName, style: TextStyle(fontSize: 16)),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              data.ticketBody,
              //               """For making Homemade Cake, make sure you whisk the cake mix well. And better use an electric blender for mixing all the ingredients, as this will make the mixture frothy and light.
              // If you do not have butter at home, you can even use clarified butter or ghee. Or you can use homemade white butter for extra flavour""",
              maxLines: 12,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: Pallet.font3),
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.alarm, color: Pallet.font3),
              SizedBox(width: 5),
              Text((data.deadline == null) ? "None" : data.deadline.toString()),
              Expanded(child: Container()),
              Stack(
                children: [
                  for (var i = 0; i < data.assignees.length; i++)
                    Padding(
                      padding: EdgeInsets.only(left: i * 10),
                      child: ProfileIcon(
                        size: 30,
                        name: "J",
                        // name: data.assignees[i].,
                        color: Colors.red,
                        // color: Color(int.parse(data["assignees"][i]["color"])),
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
