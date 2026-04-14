import 'dart:typed_data';
import 'dart:io';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:crewboard_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';

import 'package:crewboard_flutter/screens/docs/flows/flows_controller.dart';
import 'package:crewboard_flutter/screens/docs/flows/types.dart'; // Manual import for FlowSubPage maybe? No, it's in docs_sidebar usually.
import 'package:crewboard_flutter/screens/docs/docs_sidebar.dart';
import 'package:crewboard_flutter/screens/docs/document_editor_provider.dart';
import 'package:crewboard_flutter/widgets/mention_text_box.dart';
import 'package:crewboard_flutter/controllers/sidebar_controller.dart';
import 'package:crewboard_flutter/config/palette.dart';

enum PlannerSubPage { bucket, search }

class PlannerState {
  final List<PlannerApp> apps;
  final UuidValue? selectedAppId;
  final PlannerSubPage currentSubPage;
  final bool isLoadingApps;
  final bool isLoadingPlanner;
  final List<BucketModel> buckets;
  final List<PlannerTicket> allTickets;
  final List<UserModel> users;
  final List<StatusModel> statuses;
  final List<PriorityModel> priorities;
  final List<TypeModel> types;
  final List<FlowModel> allFlows;
  final List<Doc> allDocs;
  final String mode;
  final String error;
  final String? deadline;
  final List<UserModel> selectedUsers;
  final List<CheckModel> checklist;
  final List<CommentModel> comments;
  final StatusModel? status;
  final TypeModel? type;
  final PriorityModel? priority;
  final List<AttachmentModel> attachments;
  final List<PlatformFile> pendingFiles;
  final List<ThreadItemModel> ticketThread;
  final ThreadItemModel? lastActivity;
  final UuidValue? selectedTicketId;
  final PlannerTicket? draggingTicket;
  final UuidValue? draggingSourceBucketId;
  final Map<String, String> editStack;
  final DateTime? currentTicketCreatedAt;

  PlannerState({
    this.apps = const [],
    this.selectedAppId,
    this.currentSubPage = PlannerSubPage.bucket,
    this.isLoadingApps = false,
    this.isLoadingPlanner = false,
    this.buckets = const [],
    this.allTickets = const [],
    this.users = const [],
    this.statuses = const [],
    this.priorities = const [],
    this.types = const [],
    this.allFlows = const [],
    this.allDocs = const [],
    this.mode = "none",
    this.error = "",
    this.deadline,
    this.selectedUsers = const [],
    this.checklist = const [],
    this.comments = const [],
    this.status,
    this.type,
    this.priority,
    this.attachments = const [],
    this.pendingFiles = const [],
    this.ticketThread = const [],
    this.lastActivity,
    this.selectedTicketId,
    this.draggingTicket,
    this.draggingSourceBucketId,
    this.editStack = const {},
    this.currentTicketCreatedAt,
  });

  PlannerState copyWith({
    List<PlannerApp>? apps,
    UuidValue? selectedAppId,
    PlannerSubPage? currentSubPage,
    bool? isLoadingApps,
    bool? isLoadingPlanner,
    List<BucketModel>? buckets,
    List<PlannerTicket>? allTickets,
    List<UserModel>? users,
    List<StatusModel>? statuses,
    List<PriorityModel>? priorities,
    List<TypeModel>? types,
    List<FlowModel>? allFlows,
    List<Doc>? allDocs,
    String? mode,
    String? error,
    String? deadline,
    List<UserModel>? selectedUsers,
    List<CheckModel>? checklist,
    List<CommentModel>? comments,
    StatusModel? status,
    TypeModel? type,
    PriorityModel? priority,
    List<AttachmentModel>? attachments,
    List<PlatformFile>? pendingFiles,
    List<ThreadItemModel>? ticketThread,
    ThreadItemModel? lastActivity,
    UuidValue? selectedTicketId,
    PlannerTicket? draggingTicket,
    UuidValue? draggingSourceBucketId,
    Map<String, String>? editStack,
    DateTime? currentTicketCreatedAt,
    bool clearDeadline = false,
    bool clearStatus = false,
    bool clearType = false,
    bool clearPriority = false,
    bool clearLastActivity = false,
    bool clearSelectedTicketId = false,
    bool clearDraggingTicket = false,
    bool clearDraggingSourceBucketId = false,
  }) {
    return PlannerState(
      apps: apps ?? this.apps,
      selectedAppId: selectedAppId ?? this.selectedAppId,
      currentSubPage: currentSubPage ?? this.currentSubPage,
      isLoadingApps: isLoadingApps ?? this.isLoadingApps,
      isLoadingPlanner: isLoadingPlanner ?? this.isLoadingPlanner,
      buckets: buckets ?? this.buckets,
      allTickets: allTickets ?? this.allTickets,
      users: users ?? this.users,
      statuses: statuses ?? this.statuses,
      priorities: priorities ?? this.priorities,
      types: types ?? this.types,
      allFlows: allFlows ?? this.allFlows,
      allDocs: allDocs ?? this.allDocs,
      mode: mode ?? this.mode,
      error: error ?? this.error,
      deadline: clearDeadline ? null : (deadline ?? this.deadline),
      selectedUsers: selectedUsers ?? this.selectedUsers,
      checklist: checklist ?? this.checklist,
      comments: comments ?? this.comments,
      status: clearStatus ? null : (status ?? this.status),
      type: clearType ? null : (type ?? this.type),
      priority: clearPriority ? null : (priority ?? this.priority),
      attachments: attachments ?? this.attachments,
      pendingFiles: pendingFiles ?? this.pendingFiles,
      ticketThread: ticketThread ?? this.ticketThread,
      lastActivity: clearLastActivity
          ? null
          : (lastActivity ?? this.lastActivity),
      selectedTicketId: clearSelectedTicketId
          ? null
          : (selectedTicketId ?? this.selectedTicketId),
      draggingTicket: clearDraggingTicket
          ? null
          : (draggingTicket ?? this.draggingTicket),
      draggingSourceBucketId: clearDraggingSourceBucketId
          ? null
          : (draggingSourceBucketId ?? this.draggingSourceBucketId),
      editStack: editStack ?? this.editStack,
      currentTicketCreatedAt:
          currentTicketCreatedAt ?? this.currentTicketCreatedAt,
    );
  }
}

final plannerProvider = NotifierProvider<PlannerNotifier, PlannerState>(
  PlannerNotifier.new,
);

class PlannerNotifier extends Notifier<PlannerState> {
  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();
  final TextEditingController creds = TextEditingController(text: "0");
  final TextEditingController commentController = TextEditingController();

  UuidValue? _lastHolderBucketId;
  int? _lastHolderIndex;

  @override
  PlannerState build() {
    Future.microtask(() {
      loadApps();
      getAddTicketData();
    });
    ref.onDispose(() {
      title.dispose();
      body.dispose();
      creds.dispose();
      commentController.dispose();
    });
    return PlannerState();
  }

  Future<void> loadApps() async {
    try {
      state = state.copyWith(isLoadingApps: true);
      final response = await client.admin.getApps();
      state = state.copyWith(apps: response, isLoadingApps: false);

      if (response.isNotEmpty && state.selectedAppId == null) {
        selectApp(response.first.id!);
      }
    } catch (e) {
      debugPrint('Error loading apps: $e');
      state = state.copyWith(isLoadingApps: false);
    }
  }

  Future<void> addApp(String name, UuidValue colorId) async {
    try {
      await client.admin.addApp(name, colorId);
      await loadApps();
    } catch (e) {
      debugPrint('Error adding app: $e');
    }
  }

  void selectApp(UuidValue appId) {
    state = state.copyWith(selectedAppId: appId);
    loadPlannerData();
    getAddTicketData();
    loadAllTickets();
  }

  void changeSubPage(PlannerSubPage subPage) {
    state = state.copyWith(currentSubPage: subPage);
    if (state.selectedAppId != null) {
      if (subPage == PlannerSubPage.search) {
        loadAllTickets();
      } else {
        loadPlannerData();
      }
    }
  }

  Future<void> loadPlannerData({bool showLoading = true}) async {
    if (state.selectedAppId == null) return;
    try {
      if (showLoading) state = state.copyWith(isLoadingPlanner: true);
      final response = await client.planner.getPlannerData(
        state.selectedAppId!,
      );
      state = state.copyWith(
        buckets: response.buckets,
        isLoadingPlanner: false,
      );
    } catch (e) {
      debugPrint('Error loading planner data: $e');
      if (showLoading) state = state.copyWith(isLoadingPlanner: false);
    }
  }

  Future<void> loadAllTickets() async {
    if (state.selectedAppId == null) return;
    try {
      final response = await client.planner.getAllTickets(state.selectedAppId!);
      state = state.copyWith(allTickets: response.tickets);
    } catch (e) {
      debugPrint('Error loading all tickets: $e');
    }
  }

  Future<TicketModel?> getTicketData(UuidValue ticketId) async {
    try {
      final response = await client.planner.getTicketData(ticketId);
      return response.ticket;
    } catch (e) {
      debugPrint('Error getting ticket data: $e');
      return null;
    }
  }

  Future<void> getAddTicketData() async {
    try {
      final response = await client.planner.getAddTicketData();
      state = state.copyWith(
        users: response.users,
        statuses: response.statuses,
        priorities: response.priorities,
        types: response.types,
        allFlows: response.flows,
      );

      if (state.selectedAppId != null) {
        try {
          final docs = await client.docs.getDocs(state.selectedAppId!);
          state = state.copyWith(allDocs: docs);
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
    final flowSuggestions = state.allFlows
        .where((f) => f.name.toLowerCase().contains(lowerQuery))
        .map(
          (f) => MentionSuggestion(
            id: f.id.toString(),
            name: f.name,
            type: 'flow',
          ),
        )
        .toList();

    final docSuggestions = state.allDocs
        .where((d) => d.name.toLowerCase().contains(lowerQuery))
        .map(
          (d) =>
              MentionSuggestion(id: d.id.toString(), name: d.name, type: 'doc'),
        )
        .toList();

    return [...flowSuggestions, ...docSuggestions];
  }

  void getAddTicketDataForNew() {
    title.clear();
    body.clear();
    creds.text = "0";
    state = state.copyWith(
      deadline: null,
      selectedUsers: [],
      checklist: [],
      attachments: [],
      pendingFiles: [],
      status: null,
      type: null,
      priority: null,
      error: "",
      mode: "none",
      currentTicketCreatedAt: DateTime.now(),
    );
    getAddTicketData();
  }

  Future<void> getTicketDataFull(UuidValue ticketId) async {
    try {
      final response = await client.planner.getTicketData(ticketId);
      final ticket = response.ticket;
      title.text = ticket.ticketName;
      body.text = ticket.ticketBody;
      creds.text = ticket.creds.toString();

      String? deadlineStr;
      if (ticket.deadline != null) {
        deadlineStr = DateFormat(
          'yyyy-MM-dd',
        ).format(DateTime.parse(ticket.deadline!));
      }

      final plannerTicket = state.allTickets.firstWhereOrNull(
        (t) => t.id == ticketId,
      );
      final createdAt = plannerTicket?.createdAt ?? DateTime.now();

      state = state.copyWith(
        deadline: deadlineStr,
        selectedUsers: ticket.assignees,
        checklist: ticket.checklist,
        attachments: ticket.attachments,
        pendingFiles: [],
        status: ticket.status,
        priority: ticket.priority,
        type: ticket.type,
        currentTicketCreatedAt: createdAt,
      );
    } catch (e) {
      debugPrint('Error getting ticket data: $e');
    }
  }

  Future<void> getTicketCommentsFull(UuidValue ticketId) async {
    try {
      final response = await client.planner.getTicketComments(ticketId);
      state = state.copyWith(comments: response.comments);
    } catch (e) {
      debugPrint('Error getting comments: $e');
    }
  }

  Future<void> getTicketThread(UuidValue ticketId) async {
    try {
      final response = await client.planner.getTicketThread(ticketId);
      state = state.copyWith(
        ticketThread: response.items,
        lastActivity: response.items.isNotEmpty ? response.items.last : null,
      );
    } catch (e) {
      debugPrint('Error getting ticket thread: $e');
    }
  }

  Future<List<AttachmentModel>> _uploadPendingAttachments() async {
    final uploadedAttachments = <AttachmentModel>[];
    for (final file in state.pendingFiles) {
      try {
        Uint8List? bytes = file.bytes;
        if (bytes == null && file.path != null) {
          bytes = await File(file.path!).readAsBytes();
        }
        if (bytes == null) continue;

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
    state = state.copyWith(error: "");
    if (title.text.isEmpty) {
      state = state.copyWith(error: "title cannot be empty");
      return;
    }
    if (state.status == null) {
      state = state.copyWith(error: "status cannot be empty");
      return;
    }
    if (state.type == null) {
      state = state.copyWith(error: "type cannot be empty");
      return;
    }
    if (state.priority == null) {
      state = state.copyWith(error: "priority cannot be empty");
      return;
    }
    if (state.deadline == null) {
      state = state.copyWith(error: "deadline cannot be empty");
      return;
    }

    try {
      final uploadedAttachments = await _uploadPendingAttachments();
      final allAttachments = [...state.attachments, ...uploadedAttachments];

      final ticketModel = TicketModel(
        id: UuidValue.fromString('00000000-0000-4000-8000-000000000000'),
        ticketName: title.text,
        ticketBody: body.text,
        status: state.status!,
        priority: state.priority!,
        type: state.type!,
        assignees: state.selectedUsers,
        creds: double.tryParse(creds.text) ?? 0.0,
        deadline: state.deadline,
        checklist: state.checklist,
        flows: "",
        attachments: allAttachments,
      );

      final success = await client.planner.addTicket(
        AddTicketRequest(
          appId: state.selectedAppId!,
          bucketId: bucketId,
          ticket: ticketModel,
        ),
      );

      if (success) {
        state = state.copyWith(error: "", pendingFiles: []);
        loadPlannerData();
        loadAllTickets();
      } else {
        state = state.copyWith(error: "Failed to save ticket");
      }
    } catch (e) {
      state = state.copyWith(error: "Error saving ticket: $e");
    }
  }

  void addCheckItem(String label) {
    state = state.copyWith(
      checklist: [
        ...state.checklist,
        CheckModel(label: label, selected: false),
      ],
    );
  }

  Future<void> updateTicket(UuidValue ticketId) async {
    debugPrint('Updating ticket $ticketId');
    try {
      final uploadedAttachments = await _uploadPendingAttachments();
      final allAttachments = [...state.attachments, ...uploadedAttachments];

      final ticketModel = TicketModel(
        id: ticketId,
        ticketName: title.text,
        ticketBody: body.text,
        status: state.status!,
        priority: state.priority!,
        type: state.type!,
        assignees: state.selectedUsers,
        creds: double.tryParse(creds.text) ?? 0.0,
        deadline: state.deadline,
        checklist: state.checklist,
        flows: "",
        attachments: allAttachments,
      );

      final success = await client.planner.updateTicket(ticketModel);
      if (success) {
        state = state.copyWith(pendingFiles: []);
        loadPlannerData();
        getTicketThread(ticketId);
        await getTicketDataFull(ticketId);
      }
    } catch (e) {
      debugPrint('Error updating ticket: $e');
    }
  }

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

  Future<bool> addBucket(String name) async {
    if (state.selectedAppId == null) return false;
    try {
      final success = await client.planner.addBucket(
        AddBucketRequest(appId: state.selectedAppId!, bucketName: name),
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

  void onDragStarted(PlannerTicket ticket, UuidValue bucketId) {
    state = state.copyWith(
      draggingTicket: ticket,
      draggingSourceBucketId: bucketId,
    );
    _lastHolderBucketId = null;
    _lastHolderIndex = null;
  }

  void onDragUpdated(UuidValue bucketId, int index) {
    if (state.draggingTicket == null) return;
    if (_lastHolderBucketId == bucketId && _lastHolderIndex == index) return;

    _lastHolderBucketId = bucketId;
    _lastHolderIndex = index;

    final updatedBuckets = List<BucketModel>.from(state.buckets);
    bool needsUpdate = false;

    for (var b in updatedBuckets) {
      if (b.tickets.any((t) => t.holder == 'true')) {
        b.tickets.removeWhere((t) => t.holder == 'true');
        needsUpdate = true;
      }
    }

    final targetBucketIndex = updatedBuckets.indexWhere(
      (b) => b.bucketId == bucketId,
    );
    if (targetBucketIndex != -1) {
      final targetBucket = updatedBuckets[targetBucketIndex];
      final placeholder = state.draggingTicket!.copyWith(holder: 'true');
      final safeIndex = index.clamp(0, targetBucket.tickets.length);
      targetBucket.tickets.insert(safeIndex, placeholder);
      needsUpdate = true;
    }

    if (needsUpdate) {
      state = state.copyWith(buckets: updatedBuckets);
    }
  }

  void onDrop(UuidValue bucketId, int index) {
    if (state.draggingTicket == null) return;

    final ticket = state.draggingTicket!;
    final ticketId = ticket.id;
    final sourceBucketId = state.draggingSourceBucketId;

    final updatedBuckets = List<BucketModel>.from(state.buckets);
    if (sourceBucketId != null) {
      final sourceBucket = updatedBuckets.firstWhereOrNull(
        (b) => b.bucketId == sourceBucketId,
      );
      sourceBucket?.tickets.removeWhere((t) => t.id == ticketId);
    }

    final targetBucket = updatedBuckets.firstWhereOrNull(
      (b) => b.bucketId == bucketId,
    );
    if (targetBucket != null) {
      targetBucket.tickets.removeWhere((t) => t.holder == 'true');
      final safeIndex = index.clamp(0, targetBucket.tickets.length);
      targetBucket.tickets.insert(safeIndex, ticket);
    }

    state = state.copyWith(
      buckets: updatedBuckets,
      draggingTicket: null,
      draggingSourceBucketId: null,
    );

    changeBucket(
      ChangeBucketRequest(
        ticketId: ticketId,
        newBucketId: bucketId,
        newOrder: index + 1,
        oldBucketId:
            sourceBucketId ??
            UuidValue.fromString('00000000-0000-0000-0000-000000000000'),
      ),
    );
  }

  void onDragCancelled() {
    state = state.copyWith(draggingTicket: null, draggingSourceBucketId: null);
    _lastHolderBucketId = null;
    _lastHolderIndex = null;

    final updatedBuckets = List<BucketModel>.from(state.buckets);
    for (var b in updatedBuckets) {
      b.tickets.removeWhere((t) => t.holder == 'true');
    }
    state = state.copyWith(buckets: updatedBuckets);
  }

  void openLinkedFlow(String flowName) {
    final flow = state.allFlows.firstWhereOrNull(
      (f) => f.name.toLowerCase() == flowName.toLowerCase(),
    );
    if (flow != null) {
      ref.read(sidebarProvider.notifier).navigate(CurrentPage.documentation);
      final flowsNotifier = ref.read(flowsProvider.notifier);
      flowsNotifier.setSidebarMode(SidebarMode.flows);
      flowsNotifier.setSubPage(FlowSubPage.flows);
      flowsNotifier.loadFlow(flow.id!);
      return;
    }

    final doc = state.allDocs.firstWhereOrNull(
      (d) => d.name.toLowerCase() == flowName.toLowerCase(),
    );
    if (doc != null) {
      ref.read(sidebarProvider.notifier).navigate(CurrentPage.documentation);
      final flowsNotifier = ref.read(flowsProvider.notifier);
      if (state.selectedAppId != null) {
        flowsNotifier.selectApp(state.selectedAppId!);
      }
      flowsNotifier.setSidebarMode(SidebarMode.flows);
      flowsNotifier.changeSubPage("docs");
      ref.read(documentEditorProvider.notifier).loadDoc(doc);
      return;
    }
  }

  void addAttachedFile(PlatformFile file) {
    state = state.copyWith(pendingFiles: [...state.pendingFiles, file]);
  }

  void removeAttachedFile(PlatformFile file) {
    state = state.copyWith(
      pendingFiles: state.pendingFiles.where((f) => f != file).toList(),
    );
  }

  // Update state helpers
  void setStatus(StatusModel? s) => state = state.copyWith(status: s);
  void setType(TypeModel? t) => state = state.copyWith(type: t);
  void setPriority(PriorityModel? p) => state = state.copyWith(priority: p);
  void setDeadline(String? d) => state = state.copyWith(deadline: d);
  void copyWithMode(String mode) => state = state.copyWith(mode: mode);
  void setSelectedUsers(List<UserModel> users) =>
      state = state.copyWith(selectedUsers: users);

  void setSelectedTicketId(UuidValue? id) {
    if (id == null) {
      state = state.copyWith(clearSelectedTicketId: true);
    } else {
      state = state.copyWith(selectedTicketId: id);
    }
  }

  void addToEditStack(String key, String value) {
    final newStack = Map<String, String>.from(state.editStack);
    newStack[key] = value;
    state = state.copyWith(editStack: newStack);
  }

  Future<bool> addComment(AddCommentRequest request) async {
    try {
      final response = await client.planner.addComment(request);
      return response;
    } catch (e) {
      debugPrint('Error adding comment: $e');
      return false;
    }
  }
}
