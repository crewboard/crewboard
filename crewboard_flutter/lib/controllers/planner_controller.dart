import 'package:crewboard_client/crewboard_client.dart';
import 'package:crewboard_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PlannerSubPage { bucket, search }

class PlannerController extends GetxController {
  // Observable apps list (projects)
  final RxList<PlannerApp> apps = <PlannerApp>[].obs;

  // Observable selected app ID
  final RxInt selectedAppId = 0.obs;

  // Observable current subpage (buckets or search)
  final Rx<PlannerSubPage> currentSubPage = PlannerSubPage.bucket.obs;

  // Observable loading state
  final RxBool isLoadingApps = false.obs;
  final RxBool isLoadingPlanner = false.obs;

  // Observable buckets with tickets
  final RxList<BucketModel> buckets = <BucketModel>[].obs;

  // Observable all tickets for search
  final RxList<PlannerTicket> allTickets = <PlannerTicket>[].obs;

  // Metadata for adding tickets
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxList<StatusModel> statuses = <StatusModel>[].obs;
  final RxList<PriorityModel> priorities = <PriorityModel>[].obs;
  final RxList<TypeModel> types = <TypeModel>[].obs;
  final RxList<FlowModel> allFlows = <FlowModel>[].obs;

  // New states for ticket creation and viewing
  final RxString mode = "none".obs;
  final RxString error = "".obs;
  final Rx<TextEditingController> title = TextEditingController().obs;
  final Rx<TextEditingController> body = TextEditingController().obs;
  final Rx<TextEditingController> creds = TextEditingController(text: "0").obs;
  final RxnString deadline = RxnString();
  final RxList<UserModel> selectedUsers = <UserModel>[].obs;
  final RxList<CheckModel> checklist = <CheckModel>[].obs;
  final RxList<CommentModel> comments = <CommentModel>[].obs;
  final Rxn<StatusModel> status = Rxn<StatusModel>();
  final Rxn<TypeModel> type = Rxn<TypeModel>();
  final Rxn<PriorityModel> priority = Rxn<PriorityModel>();
  final Rx<TextEditingController> controller = TextEditingController().obs;
  final RxList<Map<String, dynamic>> editStack = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadApps();
    getAddTicketData();
  }

  // Load apps (projects) from server
  Future<void> loadApps() async {
    try {
      isLoadingApps.value = true;
      final response = await client.admin.getApps();
      apps.assignAll(response);

      if (apps.isNotEmpty && selectedAppId.value == 0) {
        selectApp(apps.first.id!);
      }
    } catch (e) {
      debugPrint('Error loading apps: $e');
    } finally {
      isLoadingApps.value = false;
    }
  }

  // Method to add a new app
  Future<void> addApp(String name, int colorId) async {
    try {
      await client.admin.addApp(name, colorId);
      await loadApps();
    } catch (e) {
      debugPrint('Error adding app: $e');
    }
  }

  // Select an app and load its planner data
  void selectApp(int appId) {
    selectedAppId.value = appId;
    loadPlannerData();
    getAddTicketData(); // Pre-load metadata for the project context
    if (currentSubPage.value == PlannerSubPage.search) {
      loadAllTickets();
    }
  }

  // Change subpage (Kanban/Search)
  void changeSubPage(PlannerSubPage subPage) {
    currentSubPage.value = subPage;
    if (selectedAppId.value != 0) {
      if (subPage == PlannerSubPage.search) {
        loadAllTickets();
      } else {
        loadPlannerData();
      }
    }
  }

  // Fetch Kanban data
  Future<void> loadPlannerData() async {
    if (selectedAppId.value == 0) return;
    try {
      isLoadingPlanner.value = true;
      final response = await client.planner.getPlannerData(selectedAppId.value);
      buckets.value = response.buckets;
    } catch (e) {
      debugPrint('Error loading planner data: $e');
    } finally {
      isLoadingPlanner.value = false;
    }
  }

  // Fetch search view data
  Future<void> loadAllTickets() async {
    if (selectedAppId.value == 0) return;
    try {
      final response = await client.planner.getAllTickets(selectedAppId.value);
      allTickets.value = response.tickets;
    } catch (e) {
      debugPrint('Error loading all tickets: $e');
    }
  }

  // Fetch full ticket data
  Future<TicketModel?> getTicketData(int ticketId) async {
    try {
      final response = await client.planner.getTicketData(ticketId);
      return response.ticket;
    } catch (e) {
      debugPrint('Error getting ticket data: $e');
      return null;
    }
  }

  // Fetch metadata for Add Ticket form
  Future<void> getAddTicketData() async {
    try {
      final response = await client.planner.getAddTicketData();
      users.value = response.users;
      statuses.value = response.statuses;
      priorities.value = response.priorities;
      types.value = response.types;
      allFlows.value = response.flows;
    } catch (e) {
      debugPrint('Error getting add ticket data: $e');
    }
  }

  // Clear data for adding a new ticket
  void getAddTicketDataForNew() {
    title.value.clear();
    body.value.clear();
    creds.value.text = "0";
    deadline.value = null;
    selectedUsers.clear();
    checklist.clear();
    status.value = null;
    type.value = null;
    priority.value = null;
    error.value = "";
    mode.value = "none";
    getAddTicketData();
  }

  // Load ticket data for viewing/editing
  Future<void> getTicketDataFull(int ticketId) async {
    try {
      final response = await client.planner.getTicketData(ticketId);
      final ticket = response.ticket;
      title.value.text = ticket.ticketName;
      body.value.text = ticket.ticketBody;
      creds.value.text = ticket.creds.toString();
      deadline.value = ticket.deadline;
      selectedUsers.assignAll(ticket.assignees);
      checklist.assignAll(ticket.checklist);
      status.value = ticket.status;
      priority.value = ticket.priority;
      type.value = ticket.type;
      editStack.clear();
    } catch (e) {
      debugPrint('Error getting ticket data: $e');
    }
  }

  Future<void> getTicketCommentsFull(int ticketId) async {
    try {
      final response = await client.planner.getTicketComments(ticketId);
      comments.assignAll(response.comments);
    } catch (e) {
      debugPrint('Error getting comments: $e');
    }
  }

  Future<void> save(int bucketId) async {
    error.value = "";
    if (title.value.text.isEmpty) {
      error.value = "title cannot be empty";
      return;
    }
    if (status.value == null) {
      error.value = "status cannot be empty";
      return;
    }
    if (type.value == null) {
      error.value = "type cannot be empty";
      return;
    }
    if (priority.value == null) {
      error.value = "priority cannot be empty";
      return;
    }

    try {
      final ticketModel = TicketModel(
        id: 0,
        ticketName: title.value.text,
        ticketBody: body.value.text,
        status: status.value!,
        priority: priority.value!,
        type: type.value!,
        assignees: selectedUsers,
        creds: double.tryParse(creds.value.text) ?? 0.0,
        deadline: deadline.value,
        checklist: checklist,
        flows: "",
        attachments: [],
      );

      final success = await client.planner.addTicket(
        AddTicketRequest(
          appId: selectedAppId.value,
          bucketId: bucketId,
          ticket: ticketModel,
        ),
      );

      if (success) {
        loadPlannerData();
        error.value = "";
      } else {
        error.value = "Failed to save ticket";
      }
    } catch (e) {
      error.value = "Error saving ticket: $e";
    }
  }

  void addToEditStack(String name, String value) {
    int index = editStack.indexWhere((e) => e['name'] == name);
    if (index != -1) {
      editStack[index]['value'] = value;
    } else {
      editStack.add({'name': name, 'value': value});
    }
  }

  void addCheckItem(String label) {
    checklist.add(CheckModel(label: label, selected: false));
  }

  Future<void> saveEditStack(int ticketId) async {
    debugPrint('Saving edit stack for ticket $ticketId: $editStack');
    // Implement field updates if needed
  }

  // Move ticket between buckets
  Future<bool> changeBucket(ChangeBucketRequest request) async {
    try {
      final success = await client.planner.changeBucket(request);
      if (success) {
        loadPlannerData();
        return true;
      }
    } catch (e) {
      debugPrint('Error changing bucket: $e');
    }
    return false;
  }

  // Add a new bucket
  Future<bool> addBucket(String name) async {
    if (selectedAppId.value == 0) return false;
    try {
      final success = await client.planner.addBucket(
        AddBucketRequest(
          appId: selectedAppId.value,
          bucketName: name,
        ),
      );
      if (success) {
        loadPlannerData();
        return true;
      }
    } catch (e) {
      debugPrint('Error adding bucket: $e');
    }
    return false;
  }

  // Create a new ticket
  Future<bool> addTicket({
    required int bucketId,
    required String title,
    required String body,
    required int statusId,
    required int priorityId,
    required int typeId,
    required List<int> assigneeIds,
    String? deadline,
    double? creds,
  }) async {
    if (selectedAppId.value == 0) return false;
    try {
      final ticketModel = TicketModel(
        id: 0, // Server will assign
        ticketName: title,
        ticketBody: body,
        status: statuses.firstWhere((s) => s.statusId == statusId),
        priority: priorities.firstWhere((p) => p.priorityId == priorityId),
        type: types.firstWhere((t) => t.typeId == typeId),
        assignees: users.where((u) => assigneeIds.contains(u.userId)).toList(),
        creds: creds ?? 0.0,
        deadline: deadline,
        checklist: [], // TODO: Support checklist
        flows: "", // TODO: Support flows
        attachments: [],
      );

      final success = await client.planner.addTicket(
        AddTicketRequest(
          appId: selectedAppId.value,
          bucketId: bucketId,
          ticket: ticketModel,
        ),
      );

      if (success) {
        if (currentSubPage.value == PlannerSubPage.bucket) {
          loadPlannerData();
        } else {
          loadAllTickets();
        }
        return true;
      }
    } catch (e) {
      debugPrint('Error adding ticket: $e');
    }
    return false;
  }

  // Fetch comments for a ticket
  Future<List<CommentModel>> getTicketComments(int ticketId) async {
    try {
      final response = await client.planner.getTicketComments(ticketId);
      return response.comments;
    } catch (e) {
      debugPrint('Error getting comments: $e');
      return [];
    }
  }

  // Add a comment
  Future<bool> addComment(AddCommentRequest request) async {
    try {
      return await client.planner.addComment(request);
    } catch (e) {
      debugPrint('Error adding comment: $e');
      return false;
    }
  }
}
