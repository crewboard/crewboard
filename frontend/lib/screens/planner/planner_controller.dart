import 'package:flutter/material.dart' hide Flow;
import 'package:frontend/services/arri_client.rpc.dart';
import 'package:frontend/services/local_storage_service.dart';
import 'package:get/get.dart';
import '../../backend/server.dart';
import '../../services/arri_client.rpc.dart' as rpc;
import '../../globals.dart';
import 'types.dart';

class PlannerController extends GetxController {
  // Observable apps list
  final RxList<rpc.App> apps = <rpc.App>[].obs;

  // Observable selected app ID
  final RxString selectedAppId = ''.obs;

  // Observable current subpage (buckets or search)
  final Rx<PlannerSubPage> currentSubPage = PlannerSubPage.bucket.obs;

  // Observable subpage string
  final Rx<String> subPage = ''.obs;

  // Observable mode for UI states (none, checklist, flow)
  final RxString mode = ''.obs;

  // Observable loading state
  final RxBool isLoadingApps = false.obs;

  // Observable buckets
  final RxList<rpc.Bucket> buckets = <rpc.Bucket>[].obs;

  // Observable tickets (list of lists for each bucket)
  final RxList<List<TicketModel>> tickets = <List<TicketModel>>[].obs;

  // Observable all tickets for search
  final RxList<rpc.Ticket> allTickets = <rpc.Ticket>[].obs;

  // Observable selected plan for drag
  final Rx<TicketModel> selectedPlan = TicketModel.empty().obs;

  // TicketBe properties moved here
  final Rx<TextEditingController> title = TextEditingController().obs;
  final Rx<TextEditingController> body = TextEditingController().obs;
  final Rx<TextEditingController> creds = TextEditingController(text: "0").obs;
  final Rx<TextEditingController> controller = TextEditingController().obs;

  final Rx<Status?> status = Rx<Status?>(null);
  final Rx<Priority?> priority = Rx<Priority?>(null);
  final Rx<TicketType?> type = Rx<TicketType?>(null);
  final RxList<Map> assignees = <Map>[].obs;
  final Rx<String?> deadline = Rx<String?>(null);
  final RxList<Status> statuses = <Status>[].obs;
  final RxList<Priority> priorities = <Priority>[].obs;
  final RxList<TicketType> types = <TicketType>[].obs;
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxList<UserModel> selectedUsers = <UserModel>[].obs;
  final RxList<Check> checklist = <Check>[].obs;
  final RxList<Flow> allFlows = <Flow>[].obs;
  final RxList<Flow> flows = <Flow>[].obs;
  final RxList<rpc.Attachment> attachments = <rpc.Attachment>[].obs;
  final RxList<Map> comments = <Map>[].obs;

  final RxList<Map> editStack = <Map>[].obs;
  final RxString error = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadApps();
  }

  // Method to load apps from API
  Future<void> loadApps() async {
    try {
      isLoadingApps.value = true;

      // Call getApps API using centralized server client
      final response = await server.admin.getApps(rpc.GetAppsParams());

      if (response.apps != null) {
        apps.value = response.apps;
        print('Loaded ${response.apps.length} apps');
      } else {
        print('Failed to load apps');
      }
    } catch (e) {
      print('Error loading apps: $e');
    } finally {
      isLoadingApps.value = false;
    }
  }

  // Method to select an app
  void selectApp(String appId) {
    selectedAppId.value = appId;
    // Update global appId
    appId = appId;
    // Load planner data
    loadPlannerData();
    // Load all tickets if current subpage is search
    if (currentSubPage.value == PlannerSubPage.search) {
      loadAllTickets();
    }
  }

  // Method to load planner data
  Future<void> loadPlannerData() async {
    try {
      final res = await server.planner.getPlannerData(
        rpc.GetPlannerDataParams(appId: selectedAppId.value),
      );
      tickets.clear();
      for (var bucket in res.buckets) {
        tickets.add(bucket.tickets);
      }
      buckets.value = res.buckets.toList();
    } catch (e) {
      print('Error loading planner data: $e');
    }
  }

  // Method to load all tickets for search
  Future<void> loadAllTickets() async {
    try {
      final userId = await LocalStorageService.getUserId();
      if (userId == null) {
        print('Error: User ID not found');
        return;
      }
      final res = await server.planner.getAllTickets(
        rpc.GetAllTicketsParams(appId: selectedAppId.value),
      );
      allTickets.value = res.tickets;
      print('Loaded ${res.tickets.length} tickets for search');
    } catch (e) {
      print('Error loading all tickets: $e');
    }
  }

  // Method to change subpage
  void changeSubPage(String newSubPage) {
    PlannerSubPage subPageEnum;
    if (newSubPage == "search") {
      subPageEnum = PlannerSubPage.search;
    } else {
      subPageEnum = PlannerSubPage.bucket;
    }
    currentSubPage.value = subPageEnum;
    subPage.value = newSubPage;
    // Load data when changing subpage if app is selected
    if (selectedAppId.value.isNotEmpty) {
      if (newSubPage == "search") {
        loadAllTickets();
      } else {
        loadPlannerData();
      }
    }
  }

  // TicketBe methods moved here
  void getAddTicketData() async {
    final userId = await LocalStorageService.getUserId();

    server.planner.getAddTicketData(rpc.GetAddTicketDataParams()).then((data) {
      users.value = data.users;
      for (var user in users) {
        if (user.userId == userId) {
          selectedUsers.add(user);
          user = user.copyWith(selected: true);
          // user["selected"] = true;
        } else {
          user = user.copyWith(selected: false);
          // user["selected"] = false;
        }
      }
      statuses.value = data.statuses;
      priorities.value = data.priorities;
      types.value = data.types;
      allFlows.value = data.flows;
    });
  }

  void editTicket({required int ticketId, required Map data}) {
    // TODO: Implement edit ticket functionality
    // For now, just refresh the data
    requestSink.add("get_planner_data");
  }

  void saveEditStack(int ticketId) {
    print(editStack);
    // TODO: Implement save edit stack functionality
    // For now, just refresh the data
    requestSink.add("get_planner_data");
  }

  Future<void> getTicketData(int ticketId) async {
    final data = await server.planner.getTicketData(
      rpc.GetTicketDataParams(ticketId: ticketId.toString()),
    );
    title.value.text = data.ticket.ticketName;
    body.value.text = data.ticket.ticketBody;
    creds.value.text = data.ticket.creds.toString();
    deadline.value = data.ticket.deadline;

    // for (var attachment in data.ticket.attachments) {
    //   final _attachment = Attachment(
    //     name: attachment.attachmentName,
    //     size: attachment.attachmentSize,
    //     url: attachment.attachmentUrl ?? "",
    //     type: attachment.attachmentType,
    //   );
    // attachments.add(_attachment);
    // }

    // checklist = List<Map>.from(data.ticket.checklist.map((c) => c.toJson()));
    // assignees = List<Map>.from(data.ticket.assignees.map((a) => a.toJson()));
    // flows = List<Map>.from(data.ticket.flows.map((f) => f.toJson()));

    status.value = data.ticket.status;
    type.value = data.ticket.type;
    priority.value = data.ticket.priority;
    // type.value ={"priorityName": data.ticket.priorityName};
  }

  Future<void> getComments(int ticketId) async {
    final userId = await LocalStorageService.getUserId();

    final data = await server.planner.getTicketComments(
      rpc.GetTicketCommentsParams(ticketId: ticketId.toString()),
    );
    comments.value = List<Map>.from(data.comments.map((c) => c.toJson()));
    for (var comment in comments) {
      if (comment["userId"] == userId) {
        comment["userName"] = "me";
      }
    }
    refreshSink.add("");
  }

  Future<void> save(String bucketId) async {
    List<Map> _attachments = [];
    for (var attachment in attachments) {
      // TODO: implement upload via planner add-ticket-attachment if needed
      _attachments.add({
        "url": attachment.url ?? "",
        "name": attachment.name,
        "size": attachment.size,
        "type": attachment.type ?? "",
      });
    }

    error.value = "";
    if (title.value.text.isEmpty) {
      error.value = "title must not be empty";
    } else if (body.value.text.isEmpty) {
      error.value = "body must not be empty";
    } else if (status.value == null) {
      error.value = "status must be selected";
    } else if (priority.value == null) {
      error.value = "priority must be selected";
    } else if (type.value == null) {
      error.value = "type must be selected";
    }
    print(error.value);
    if (error.value == "") {
      print("saving");
      await server.planner.addTicket(
        AddTicketParams(
          appId: selectedAppId.value,
          bucketId: bucketId,
          ticket: Ticket(
            id: "",
            ticketName: title.value.text,
            ticketBody: body.value.text,
            status: status.value!,
            priority: priority.value!,
            type: type.value!,
            checklist: checklist.value,
            flows: flows.value,
            creds: double.parse(creds.value.text),
            attachments: [],
            assignees: selectedUsers,
          ),
        ),
      );
    }
  }
}
