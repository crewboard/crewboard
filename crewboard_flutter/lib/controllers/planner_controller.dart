import 'dart:typed_data';
import 'dart:io';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:crewboard_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';

import 'package:crewboard_flutter/screens/docs/flows/flows_controller.dart';
import 'package:crewboard_flutter/screens/docs/docs_sidebar.dart';
import 'package:crewboard_flutter/screens/docs/document_editor_provider.dart';
import 'package:crewboard_flutter/widgets/mention_text_box.dart';
import 'package:crewboard_flutter/controllers/sidebar_controller.dart';
import 'package:crewboard_flutter/config/palette.dart';

enum PlannerSubPage { bucket, search }

class PlannerController extends GetxController {
  // Observable apps list (projects)
  final RxList<PlannerApp> apps = <PlannerApp>[].obs;

  // Observable selected app ID
  final Rxn<UuidValue> selectedAppId = Rxn<UuidValue>();

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
  // TODO: Add allDocs if we want to preload them here, for now we can fetch them on demand or reuse existing logic
  final RxList<Doc> allDocs = <Doc>[].obs;

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
  final RxList<AttachmentModel> attachments = <AttachmentModel>[].obs;
  final RxList<PlatformFile> pendingFiles = <PlatformFile>[].obs;
  final RxList<ThreadItemModel> ticketThread = <ThreadItemModel>[].obs;
  final Rxn<ThreadItemModel> lastActivity = Rxn<ThreadItemModel>();
  final Rxn<UuidValue> selectedTicketId = Rxn<UuidValue>();
  // Drag and Drop state
  final Rxn<PlannerTicket> draggingTicket = Rxn<PlannerTicket>();
  final Rxn<UuidValue> draggingSourceBucketId = Rxn<UuidValue>();
  UuidValue? _lastHolderBucketId;
  int? _lastHolderIndex;

  @override
  void onInit() {
    super.onInit();
    loadApps();
    getAddTicketData();
  }

  // Load apps (projects) from server
  Future<void> loadApps() async {
    try {
      debugPrint("Loading apps in PlannerController...");
      isLoadingApps.value = true;
      final response = await client.admin.getApps();
      debugPrint("Apps loaded in PlannerController: ${response.length}");
      apps.value = response;

      if (apps.isNotEmpty && selectedAppId.value == null) {
        selectApp(apps.first.id!);
      }
    } catch (e) {
      debugPrint('Error loading apps: $e');
    } finally {
      isLoadingApps.value = false;
    }
  }

  // Method to add a new app
  Future<void> addApp(String name, UuidValue colorId) async {
    try {
      await client.admin.addApp(name, colorId);
      await loadApps();
    } catch (e) {
      debugPrint('Error adding app: $e');
    }
  }

  // Select an app and load its planner data
  void selectApp(UuidValue appId) {
    selectedAppId.value = appId;
    loadPlannerData();
    getAddTicketData(); // Pre-load metadata for the project context
    loadAllTickets();
  }

  // Change subpage (Kanban/Search)
  void changeSubPage(PlannerSubPage subPage) {
    currentSubPage.value = subPage;
    if (selectedAppId.value != null) {
      if (subPage == PlannerSubPage.search) {
        loadAllTickets();
      } else {
        loadPlannerData();
      }
    }
  }

  // Fetch Kanban data
  Future<void> loadPlannerData({bool showLoading = true}) async {
    if (selectedAppId.value == null) return;
    try {
      if (showLoading) isLoadingPlanner.value = true;
      final response = await client.planner.getPlannerData(
        selectedAppId.value!,
      );
      buckets.value = response.buckets;
    } catch (e) {
      debugPrint('Error loading planner data: $e');
    } finally {
      if (showLoading) isLoadingPlanner.value = false;
    }
  }

  // Fetch search view data
  Future<void> loadAllTickets() async {
    if (selectedAppId.value == null) return;
    try {
      final response = await client.planner.getAllTickets(selectedAppId.value!);
      allTickets.value = response.tickets;
    } catch (e) {
      debugPrint('Error loading all tickets: $e');
    }
  }

  // Fetch full ticket data
  Future<TicketModel?> getTicketData(UuidValue ticketId) async {
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

      // Also try to load docs for the current app for autocomplete
      if (selectedAppId.value != null) {
        try {
          final docs = await client.docs.getDocs(selectedAppId.value!);
          allDocs.value = docs;
        } catch (e) {
          debugPrint("Error loading docs for suggestions: $e");
        }
      }
    } catch (e) {
      debugPrint('Error getting add ticket data: $e');
    }
  }

  Future<List<MentionSuggestion>> searchMentionable(String query) async {
    final lowerQuery = query.toLowerCase();
    
    // Flows
    final flowSuggestions = allFlows
        .where((f) => f.name.toLowerCase().contains(lowerQuery))
        .map((f) => MentionSuggestion(id: f.id.toString(), name: f.name, type: 'flow'))
        .toList();

    // Docs
    // If not loaded yet, maybe we trigger load? But assume getAddTicketData tries to load them.
    final docSuggestions = allDocs
        .where((d) => d.name.toLowerCase().contains(lowerQuery))
        .map((d) => MentionSuggestion(id: d.id.toString(), name: d.name, type: 'doc'))
        .toList();

    return [...flowSuggestions, ...docSuggestions];
  }

  // Clear data for adding a new ticket
  void getAddTicketDataForNew() {
    title.value.clear();
    body.value.clear();
    creds.value.text = "0";
    deadline.value = null;
    selectedUsers.clear();
    checklist.clear();
    attachments.clear();
    pendingFiles.clear();
    status.value = null;
    type.value = null;
    priority.value = null;
    error.value = "";
    mode.value = "none";
    getAddTicketData();
  }

  // Load ticket data for viewing/editing
  Future<void> getTicketDataFull(UuidValue ticketId) async {
    try {
      final response = await client.planner.getTicketData(ticketId);
      final ticket = response.ticket;
      title.value.text = ticket.ticketName;
      body.value.text = ticket.ticketBody;
      creds.value.text = ticket.creds.toString();
      if (ticket.deadline != null) {
        deadline.value = DateFormat('yyyy-MM-dd').format(DateTime.parse(ticket.deadline!));
      } else {
        deadline.value = null;
      }
      selectedUsers.assignAll(ticket.assignees);
      checklist.assignAll(ticket.checklist);
      attachments.assignAll(ticket.attachments);
      pendingFiles.clear();  // Clear pending files when loading existing ticket
      status.value = ticket.status;
      priority.value = ticket.priority;
      type.value = ticket.type;
      editStack.clear();
    } catch (e) {
      debugPrint('Error getting ticket data: $e');
    }
  }

  Future<void> getTicketCommentsFull(UuidValue ticketId) async {
    try {
      final response = await client.planner.getTicketComments(ticketId);
      comments.assignAll(response.comments);
    } catch (e) {
      debugPrint('Error getting comments: $e');
    }
  }

  Future<void> getTicketThread(UuidValue ticketId) async {
    try {
      final response = await client.planner.getTicketThread(ticketId);
      ticketThread.assignAll(response.items);
      if (ticketThread.isNotEmpty) {
        lastActivity.value = ticketThread.last;
      }
    } catch (e) {
      debugPrint('Error getting ticket thread: $e');
    }
  }

  /// Upload pending files and return AttachmentModel list
  Future<List<AttachmentModel>> _uploadPendingAttachments() async {
    final uploadedAttachments = <AttachmentModel>[];
    
    for (final file in pendingFiles) {
      try {
        // Read file bytes - on desktop, bytes might be null, so use path
        Uint8List? bytes = file.bytes;
        
        if (bytes == null && file.path != null) {
          try {
            final fileObj = File(file.path!);
            bytes = await fileObj.readAsBytes();
          } catch (e) {
            debugPrint('Error reading file from path: $e');
          }
        }
        
        if (bytes == null) {
          continue;
        }

        // Upload to server
        final byteData = ByteData.view(bytes.buffer);
        final url = await client.upload.uploadFile(file.name, byteData);
        
        if (url != null) {
          uploadedAttachments.add(
            AttachmentModel(
              id: UuidValue.fromString('00000000-0000-4000-8000-000000000000'),
              name: file.name,
              size: file.size.toDouble(),
              url: url,
              type: file.extension ?? '',
            ),
          );
        }
      } catch (e) {
        debugPrint('Error uploading file ${file.name}: $e');
      }
    }
    
    return uploadedAttachments;
  }

  Future<void> save(UuidValue bucketId) async {
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
    if (deadline.value == null) {
      error.value = "deadline cannot be empty";
      return;
    }

    try {
      // Upload pending files
      final uploadedAttachments = await _uploadPendingAttachments();
      
      // Combine with existing attachments
      final allAttachments = [...attachments, ...uploadedAttachments];

      final ticketModel = TicketModel(
        id: UuidValue.fromString(
          '00000000-0000-4000-8000-000000000000',
        ), // Dummy
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
        attachments: allAttachments,
      );

      final success = await client.planner.addTicket(
        AddTicketRequest(
          appId: selectedAppId.value!,
          bucketId: bucketId,
          ticket: ticketModel,
        ),
      );

      if (success) {
        error.value = "";
        pendingFiles.clear();
        loadPlannerData();
        loadAllTickets();
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

  Future<void> updateTicket(UuidValue ticketId) async {
    debugPrint('Updating ticket $ticketId');
    try {
      // Upload pending files
      final uploadedAttachments = await _uploadPendingAttachments();
      
      // Combine with existing attachments
      final allAttachments = [...attachments, ...uploadedAttachments];

      final ticketModel = TicketModel(
        id: ticketId,
        ticketName: title.value.text,
        ticketBody: body.value.text,
        status: status.value!,
        priority: priority.value!,
        type: type.value!,
        assignees: selectedUsers,
        creds: double.tryParse(creds.value.text) ?? 0.0,
        deadline: deadline.value, // Assuming format is already correct (yyyy-MM-dd) or null
        checklist: checklist,
        flows: "",
        attachments: allAttachments,
      );

      final success = await client.planner.updateTicket(ticketModel);
      
      if (success) {
        editStack.clear(); // Clear stack as we just synced everything
        pendingFiles.clear();
        loadPlannerData();
        getTicketThread(ticketId);
        
        // Also refresh individual ticket data just in case
        await getTicketDataFull(ticketId);
      }
    } catch (e) {
      debugPrint('Error updating ticket: $e');
      Get.snackbar(
        "Error",
        "Failed to update ticket",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  // Move ticket between buckets
  Future<bool> changeBucket(ChangeBucketRequest request) async {
    try {
      final success = await client.planner.changeBucket(request);
      if (success) {
        loadPlannerData(showLoading: false);
        return true;
      }
    } catch (e) {
      debugPrint('Error changing bucket: $e');
    }
    return false;
  }

  // Add a new bucket
  Future<bool> addBucket(String name) async {
    if (selectedAppId.value == null) return false;
    try {
      final success = await client.planner.addBucket(
        AddBucketRequest(
          appId: selectedAppId.value!,
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
    required UuidValue bucketId,
    required String title,
    required String body,
    required UuidValue statusId,
    required UuidValue priorityId,
    required UuidValue typeId,
    required List<UuidValue> assigneeIds,
    String? deadline,
    double? creds,
  }) async {
    if (selectedAppId.value == null) return false;
    try {
      final ticketModel = TicketModel(
        id: UuidValue.fromString(
          '00000000-0000-4000-8000-000000000000',
        ), // Server will assign
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
          appId: selectedAppId.value!,
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
  Future<List<CommentModel>> getTicketComments(UuidValue ticketId) async {
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

  // Drag and Drop Logic
  void onDragStarted(PlannerTicket ticket, UuidValue bucketId) {
    draggingTicket.value = ticket;
    draggingSourceBucketId.value = bucketId;
    _lastHolderBucketId = null;
    _lastHolderIndex = null;
  }

  void onDragUpdated(UuidValue bucketId, int index) {
    if (draggingTicket.value == null) return;
    if (_lastHolderBucketId == bucketId && _lastHolderIndex == index) return;

    _lastHolderBucketId = bucketId;
    _lastHolderIndex = index;

    // Find target bucket
    final targetBucket = buckets.firstWhereOrNull(
      (b) => b.bucketId == bucketId,
    );
    if (targetBucket == null) return;

    bool needsUpdate = false;

    // Remove existing holders
    for (var b in buckets) {
      if (b.tickets.any((t) => t.holder == 'true')) {
        b.tickets.removeWhere((t) => t.holder == 'true');
        needsUpdate = true;
      }
    }

    // Insert placeholder
    final placeholder = draggingTicket.value!.copyWith(holder: 'true');
    final safeIndex = index.clamp(0, targetBucket.tickets.length);
    targetBucket.tickets.insert(safeIndex, placeholder);
    needsUpdate = true;

    if (needsUpdate) {
      buckets.refresh();
    }
  }

  void onDrop(UuidValue bucketId, int index) {
    if (draggingTicket.value == null) return;

    final ticket = draggingTicket.value!;
    final ticketId = ticket.id;
    final sourceBucketId = draggingSourceBucketId.value;

    // Optimistic UI update: Remove from source, insert at target
    // 1. Remove from source bucket
    if (sourceBucketId != null) {
      final sourceBucket = buckets.firstWhereOrNull((b) => b.bucketId == sourceBucketId);
      if (sourceBucket != null) {
        sourceBucket.tickets.removeWhere((t) => t.id == ticketId);
      }
    }

    // 2. Remove placeholder from target bucket and insert ticket
    final targetBucket = buckets.firstWhereOrNull((b) => b.bucketId == bucketId);
    if (targetBucket != null) {
      targetBucket.tickets.removeWhere((t) => t.holder == 'true');
      final safeIndex = index.clamp(0, targetBucket.tickets.length);
      targetBucket.tickets.insert(safeIndex, ticket);
    }

    buckets.refresh();

    // Trigger server update
    changeBucket(
      ChangeBucketRequest(
        ticketId: ticketId,
        newBucketId: bucketId,
        newOrder: index + 1, // Server expects 1-indexed order
        oldBucketId:
            sourceBucketId ??
            UuidValue.fromString('00000000-0000-0000-0000-000000000000'),
      ),
    );

    // Cleanup drag state
    draggingTicket.value = null;
    draggingSourceBucketId.value = null;
    // Note: changeBucket already calls loadPlannerData(showLoading: false)
  }

  void onDragCancelled() {
    draggingTicket.value = null;
    draggingSourceBucketId.value = null;
    _lastHolderBucketId = null;
    _lastHolderIndex = null;

    // Remove holders
    for (var b in buckets) {
      if (b.tickets.any((t) => t.holder == 'true')) {
        b.tickets.removeWhere((t) => t.holder == 'true');
      }
    }
    buckets.refresh();
  }

  void openLinkedFlow(String flowName) {
    debugPrint("Opening linked flow: $flowName");
    final flow = allFlows.firstWhereOrNull(
      (f) => f.name.toLowerCase() == flowName.toLowerCase(),
    );

    if (flow != null) {
      // Close any open dialogs (like the ticket view)
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      // Find Flow Provider or Controller to switch context
      final FlowsController flowsController = Get.put(FlowsController());

      // Switching to Flows tab in Sidebar
      if (Get.isRegistered<SidebarController>()) {
        Get.find<SidebarController>().navigate(CurrentPage.documentation);
      }
      
      flowsController.sidebarMode.value = SidebarMode.flows;
      flowsController.currentSubPage.value = FlowSubPage.flows;
      flowsController.loadFlow(flow.id!);
      return;
    } 

    final doc = allDocs.firstWhereOrNull(
      (d) => d.name.toLowerCase() == flowName.toLowerCase(),
    );

    if (doc != null) {
       if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      if (Get.isRegistered<SidebarController>()) {
        Get.find<SidebarController>().navigate(CurrentPage.documentation);
      }

      final FlowsController flowsController = Get.put(FlowsController());
      
      // Sync selected app
      if (selectedAppId.value != null) {
        flowsController.selectedAppId.value = selectedAppId.value;
      }

      flowsController.sidebarMode.value = SidebarMode.flows;
      flowsController.changeSubPage("docs");

      if (!Get.isRegistered<DocumentEditorProvider>()) {
        Get.put(DocumentEditorProvider());
      }
      final docProvider = Get.find<DocumentEditorProvider>();
      
      // Use a slight delay to ensure the UI switch doesn't interfere, 
      // though typically GetX state should handle it.
      // Also ensuring we don't await loadSavedDocs which is triggered by changeSubPage
      docProvider.loadDoc(doc);
      return;
    }
    
    Get.snackbar(
        "Link Not Found",
        "Could not find a flow or doc named '#$flowName'",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    
  }
}
