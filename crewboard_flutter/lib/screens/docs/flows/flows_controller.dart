import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'types.dart';
import 'package:crewboard_flutter/main.dart'; // For client
import 'package:crewboard_client/crewboard_client.dart'; // For generated models
import '../docs_sidebar.dart'; // For enums
import '../document_editor_provider.dart';
import 'package:flutter/material.dart';

class FlowsState {
  final List<FlowClass> flows;
  final List<FlowModel> savedFlows;
  final List<PlannerApp> apps;
  final UuidValue? selectedAppId;
  final SidebarMode sidebarMode;
  final FlowSubPage currentSubPage;
  final bool isLoadingApps;
  final bool isLoadingFlows;
  final String window;
  final FlowType? selectedType;
  final Direction? selectedDirection;
  final int selectedId;
  final String widthText;
  final String valueText;
  final String downText;
  final String leftText;
  final String rightText;
  final double stageWidth;
  final double windowHeight;
  final String widgetKey;
  final UuidValue? currentFlowId;
  final String currentFlowName;
  final bool isLightMode;
  final int hoveredProcessId;
  final String hoveredSide;
  final bool isMouseOverDot;
  final bool showAddHandles;
  final int flowCanvasRefreshCounter;
  final bool isDraggingLineHeight;
  final int draggedFlowId;
  final double initialDragX;
  final double initialDragY;
  final double initialLineHeight;
  final bool isPanning;
  final bool isSelectingLoop;
  final List<LoopLink> loopLinks;
  final int loopFrom;
  final int loopTo;
  final bool isPickingLoopFrom;
  final bool isPickingLoopTo;
  final int loopHoverId;
  final double loopPad;
  final String hoveredLoopPadAxis;
  final bool isDraggingLoopPad;
  final double initialLoopPadDragPos;
  final double initialLoopPadValue;
  final SystemVariables? systemVariables;
  final bool isLoadingSettings;

  FlowsState({
    this.flows = const [],
    this.savedFlows = const [],
    this.apps = const [],
    this.selectedAppId,
    this.sidebarMode = SidebarMode.apps,
    this.currentSubPage = FlowSubPage.flows,
    this.isLoadingApps = false,
    this.isLoadingFlows = false,
    this.window = "none",
    this.selectedType,
    this.selectedDirection,
    this.selectedId = -1,
    this.widthText = "",
    this.valueText = "",
    this.downText = "",
    this.leftText = "",
    this.rightText = "",
    this.stageWidth = 0.0,
    this.windowHeight = 0.0,
    this.widgetKey = "",
    this.currentFlowId,
    this.currentFlowName = "",
    this.isLightMode = false,
    this.hoveredProcessId = -1,
    this.hoveredSide = "",
    this.isMouseOverDot = false,
    this.showAddHandles = true,
    this.flowCanvasRefreshCounter = 0,
    this.isDraggingLineHeight = false,
    this.draggedFlowId = -1,
    this.initialDragX = 0.0,
    this.initialDragY = 0.0,
    this.initialLineHeight = 0.0,
    this.isPanning = false,
    this.isSelectingLoop = false,
    this.loopLinks = const [],
    this.loopFrom = -1,
    this.loopTo = -1,
    this.isPickingLoopFrom = false,
    this.isPickingLoopTo = false,
    this.loopHoverId = -1,
    this.loopPad = 40.0,
    this.hoveredLoopPadAxis = "",
    this.isDraggingLoopPad = false,
    this.initialLoopPadDragPos = 0.0,
    this.initialLoopPadValue = 40.0,
    this.systemVariables,
    this.isLoadingSettings = false,
  });

  FlowsState copyWith({
    List<FlowClass>? flows,
    List<FlowModel>? savedFlows,
    List<PlannerApp>? apps,
    UuidValue? selectedAppId,
    SidebarMode? sidebarMode,
    FlowSubPage? currentSubPage,
    bool? isLoadingApps,
    bool? isLoadingFlows,
    String? window,
    FlowType? selectedType,
    Direction? selectedDirection,
    int? selectedId,
    String? widthText,
    String? valueText,
    String? downText,
    String? leftText,
    String? rightText,
    double? stageWidth,
    double? windowHeight,
    String? widgetKey,
    UuidValue? currentFlowId,
    String? currentFlowName,
    bool? isLightMode,
    int? hoveredProcessId,
    String? hoveredSide,
    bool? isMouseOverDot,
    bool? showAddHandles,
    int? flowCanvasRefreshCounter,
    bool? isDraggingLineHeight,
    int? draggedFlowId,
    double? initialDragX,
    double? initialDragY,
    double? initialLineHeight,
    bool? isPanning,
    bool? isSelectingLoop,
    List<LoopLink>? loopLinks,
    int? loopFrom,
    int? loopTo,
    bool? isPickingLoopFrom,
    bool? isPickingLoopTo,
    int? loopHoverId,
    double? loopPad,
    String? hoveredLoopPadAxis,
    bool? isDraggingLoopPad,
    double? initialLoopPadDragPos,
    double? initialLoopPadValue,
    SystemVariables? systemVariables,
    bool? isLoadingSettings,
  }) {
    return FlowsState(
      flows: flows ?? this.flows,
      savedFlows: savedFlows ?? this.savedFlows,
      apps: apps ?? this.apps,
      selectedAppId: selectedAppId ?? this.selectedAppId,
      sidebarMode: sidebarMode ?? this.sidebarMode,
      currentSubPage: currentSubPage ?? this.currentSubPage,
      isLoadingApps: isLoadingApps ?? this.isLoadingApps,
      isLoadingFlows: isLoadingFlows ?? this.isLoadingFlows,
      window: window ?? this.window,
      selectedType: selectedType ?? this.selectedType,
      selectedDirection: selectedDirection ?? this.selectedDirection,
      selectedId: selectedId ?? this.selectedId,
      widthText: widthText ?? this.widthText,
      valueText: valueText ?? this.valueText,
      downText: downText ?? this.downText,
      leftText: leftText ?? this.leftText,
      rightText: rightText ?? this.rightText,
      stageWidth: stageWidth ?? this.stageWidth,
      windowHeight: windowHeight ?? this.windowHeight,
      widgetKey: widgetKey ?? this.widgetKey,
      currentFlowId: currentFlowId ?? this.currentFlowId,
      currentFlowName: currentFlowName ?? this.currentFlowName,
      isLightMode: isLightMode ?? this.isLightMode,
      hoveredProcessId: hoveredProcessId ?? this.hoveredProcessId,
      hoveredSide: hoveredSide ?? this.hoveredSide,
      isMouseOverDot: isMouseOverDot ?? this.isMouseOverDot,
      showAddHandles: showAddHandles ?? this.showAddHandles,
      flowCanvasRefreshCounter: flowCanvasRefreshCounter ?? this.flowCanvasRefreshCounter,
      isDraggingLineHeight: isDraggingLineHeight ?? this.isDraggingLineHeight,
      draggedFlowId: draggedFlowId ?? this.draggedFlowId,
      initialDragX: initialDragX ?? this.initialDragX,
      initialDragY: initialDragY ?? this.initialDragY,
      initialLineHeight: initialLineHeight ?? this.initialLineHeight,
      isPanning: isPanning ?? this.isPanning,
      isSelectingLoop: isSelectingLoop ?? this.isSelectingLoop,
      loopLinks: loopLinks ?? this.loopLinks,
      loopFrom: loopFrom ?? this.loopFrom,
      loopTo: loopTo ?? this.loopTo,
      isPickingLoopFrom: isPickingLoopFrom ?? this.isPickingLoopFrom,
      isPickingLoopTo: isPickingLoopTo ?? this.isPickingLoopTo,
      loopHoverId: loopHoverId ?? this.loopHoverId,
      loopPad: loopPad ?? this.loopPad,
      hoveredLoopPadAxis: hoveredLoopPadAxis ?? this.hoveredLoopPadAxis,
      isDraggingLoopPad: isDraggingLoopPad ?? this.isDraggingLoopPad,
      initialLoopPadDragPos: initialLoopPadDragPos ?? this.initialLoopPadDragPos,
      initialLoopPadValue: initialLoopPadValue ?? this.initialLoopPadValue,
      systemVariables: systemVariables ?? this.systemVariables,
      isLoadingSettings: isLoadingSettings ?? this.isLoadingSettings,
    );
  }
}

final flowsProvider = NotifierProvider<FlowsNotifier, FlowsState>(FlowsNotifier.new);

class FlowsNotifier extends Notifier<FlowsState> {
  Timer? _saveDebounce;

  @override
  FlowsState build() {
    Future.microtask(() {
      loadSettings();
      loadApps();
    });
    ref.onDispose(() {
      _saveDebounce?.cancel();
    });
    return FlowsState();
  }

  Future<void> loadSettings() async {
    try {
      state = state.copyWith(isLoadingSettings: true);
      final result = await client.admin.getSystemVariables();
      state = state.copyWith(systemVariables: result, isLoadingSettings: false);

      if (result != null) {
        if (result.lineHeight != null) Defaults.lineHeight = result.lineHeight!;
      }
    } catch (e) {
      debugPrint('Error loading settings: $e');
      state = state.copyWith(isLoadingSettings: false);
    }
  }

  void refreshUI() {
    state = state.copyWith(flowCanvasRefreshCounter: state.flowCanvasRefreshCounter + 1);
  }

  void setDimensions(double width, double height) {
    if (state.stageWidth == width && state.windowHeight == height) return;
    state = state.copyWith(stageWidth: width, windowHeight: height);
    updateFlowsReactive();
  }

  Future<void> loadApps() async {
    try {
      state = state.copyWith(isLoadingApps: true);
      final result = await client.admin.getApps();
      state = state.copyWith(apps: result, isLoadingApps: false);
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
    state = state.copyWith(selectedAppId: appId, sidebarMode: SidebarMode.flows);
    loadSavedFlows();
  }

  void setSidebarMode(SidebarMode mode) {
    state = state.copyWith(sidebarMode: mode);
  }

  void setSubPage(FlowSubPage subPage) {
    state = state.copyWith(currentSubPage: subPage);
  }

  void backToApps() {
    state = state.copyWith(
      selectedAppId: null,
      sidebarMode: SidebarMode.apps,
      savedFlows: [],
      flows: [],
      currentFlowId: null,
    );
  }

  void changeSubPage(String subPage) {
    if (subPage == "docs") {
      state = state.copyWith(currentSubPage: FlowSubPage.docs);
      if (state.selectedAppId != null) {
        ref.read(documentEditorProvider.notifier).loadSavedDocs(state.selectedAppId!);
      }
    } else if (subPage == "flows") {
      state = state.copyWith(currentSubPage: FlowSubPage.flows);
    }
  }

  Future<void> loadSavedFlows() async {
    if (state.selectedAppId == null) return;
    try {
      state = state.copyWith(isLoadingFlows: true);
      final result = await client.docs.getFlows(state.selectedAppId!);
      state = state.copyWith(savedFlows: result, isLoadingFlows: false);
    } catch (e) {
      debugPrint('Error loading flows: $e');
      state = state.copyWith(isLoadingFlows: false);
    }
  }

  Future<void> createNewFlow(String name) async {
    if (state.selectedAppId == null) return;
    try {
      final newFlow = FlowModel(
        appId: state.selectedAppId!,
        name: name,
        flow: jsonEncode([]),
        lastUpdated: DateTime.now(),
      );

      final success = await client.docs.createFlow(newFlow);
      if (success) {
        await loadSavedFlows();
      }
    } catch (e) {
      debugPrint('Error creating flow: $e');
    }
  }

  Future<void> loadFlow(UuidValue id) async {
    try {
      state = state.copyWith(isLoadingFlows: true);
      final flowModel = await client.docs.getFlow(id);
      if (flowModel != null) {
        final List<FlowClass> newFlows = [];
        final List<LoopLink> newLoopLinks = [];
        double newLoopPad = 40.0;

        if (flowModel.flow.isNotEmpty) {
          final List<dynamic> jsonList = jsonDecode(flowModel.flow);
          for (var item in jsonList) {
            if (item is Map && item.containsKey("_loops")) {
              final loops = item["_loops"] as List?;
              if (loops != null) {
                for (var l in loops) {
                  if (l is Map && l.containsKey("fromId") && l.containsKey("toId")) {
                    final fromId = l["fromId"];
                    final toId = l["toId"];
                    if (fromId is int && toId is int) {
                      newLoopLinks.add(LoopLink(fromId: fromId, toId: toId));
                    }
                  }
                }
              }
              continue;
            }
            if (item is Map && item.containsKey("_loopPad")) {
              final pad = item["_loopPad"];
              if (pad is num) newLoopPad = pad.toDouble();
              continue;
            }
            newFlows.add(FlowClass.fromJson(item));
          }
        }

        state = state.copyWith(
          currentFlowId: flowModel.id,
          currentFlowName: flowModel.name,
          flows: newFlows,
          loopLinks: newLoopLinks,
          loopPad: newLoopPad,
          window: newFlows.isEmpty ? "add" : "none",
          isLoadingFlows: false,
        );
        updateFlowsReactive();
      }
    } catch (e) {
      debugPrint('Error loading flow detail: $e');
      state = state.copyWith(isLoadingFlows: false);
    }
  }

  Future<void> save() async {
    if (state.currentFlowId == null) return;

    if (_saveDebounce?.isActive ?? false) _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final List<dynamic> flowData = state.flows.map((e) => e.toJson()).toList();
        if (state.loopLinks.isNotEmpty) {
          final List<Map<String, int>> loops = state.loopLinks
              .map((e) => {"fromId": e.fromId, "toId": e.toId})
              .toList();
          flowData.add({"_loops": loops});
        }
        flowData.add({"_loopPad": state.loopPad});

        final jsonString = jsonEncode(flowData);
        final flowModel = FlowModel(
          id: state.currentFlowId,
          appId: state.selectedAppId!,
          name: state.currentFlowName,
          flow: jsonString,
          lastUpdated: DateTime.now(),
        );

        await client.docs.updateFlow(flowModel);
      } catch (e) {
        debugPrint('Error saving flow: $e');
      }
    });
  }

  void updateFlows() {
    if (state.flows.isEmpty) return;

    // Create deep copies of all flows to avoid mutating state in-place
    final List<FlowClass> updatedFlows = state.flows.map((f) => f.copyWith(
      down: f.down.copyWith(hasChild: false),
      left: f.left.copyWith(hasChild: false),
      right: f.right.copyWith(hasChild: false),
    )).toList();

    final Map<int, FlowClass> nodeMap = {for (var f in updatedFlows) f.id: f};

    // Update hasChild flags
    for (var flow in updatedFlows) {
      final pid = flow.pid;
      if (pid != null) {
        final parent = nodeMap[pid];
        if (parent != null) {
          if (flow.direction == Direction.down) {
            nodeMap[pid] = parent.copyWith(down: parent.down.copyWith(hasChild: true));
          } else if (flow.direction == Direction.right) {
            nodeMap[pid] = parent.copyWith(right: parent.right.copyWith(hasChild: true));
          } else if (flow.direction == Direction.left) {
            nodeMap[pid] = parent.copyWith(left: parent.left.copyWith(hasChild: true));
          }
        }
      }
    }

    // Refresh updatedFlows from nodeMap because we replaced objects
    final List<FlowClass> finalFlows = nodeMap.values.toList();

    final roots = finalFlows.where((f) => f.pid == null).toList();
    if (roots.isEmpty) return;

    // Position roots with spacing if multiple exist
    const double rootSpacing = 200.0;
    double totalRootsWidth = (roots.length - 1) * rootSpacing;
    for (var root in roots) totalRootsWidth += root.width;
    
    double currentRootX = (state.stageWidth - totalRootsWidth) / 2;

    for (var i = 0; i < roots.length; i++) {
        final root = roots[i];
        final rootIdx = finalFlows.indexWhere((f) => f.id == root.id);
        
        finalFlows[rootIdx].x = currentRootX;
        finalFlows[rootIdx].y = 20;
        
        _positionChildren(finalFlows, nodeMap, finalFlows[rootIdx], currentRootX + root.width / 2);
        currentRootX += root.width + rootSpacing;
    }

    _centerFlows(finalFlows);
    state = state.copyWith(flows: finalFlows);
  }

  void _positionChildren(List<FlowClass> allFlows, Map<int, FlowClass> nodeMap, FlowClass parent, double centerX) {
    final children = allFlows.where((f) => f.pid == parent.id).toList();
    for (var child in children) {
      final childIdx = allFlows.indexWhere((f) => f.id == child.id);
      if (childIdx == -1) continue;

      if (child.direction == Direction.down) {
        allFlows[childIdx].y = parent.y + parent.height + parent.down.lineHeight;
        allFlows[childIdx].x = centerX - child.width / 2;
        _positionChildren(allFlows, nodeMap, allFlows[childIdx], centerX);
      } else if (child.direction == Direction.right) {
        allFlows[childIdx].y = parent.y + parent.height / 2 - child.height / 2;
        allFlows[childIdx].x = parent.x + parent.width + parent.right.lineHeight;
        _positionChildren(allFlows, nodeMap, allFlows[childIdx], allFlows[childIdx].x + child.width / 2);
      } else if (child.direction == Direction.left) {
        allFlows[childIdx].y = parent.y + parent.height / 2 - child.height / 2;
        allFlows[childIdx].x = parent.x - parent.left.lineHeight - child.width;
        _positionChildren(allFlows, nodeMap, allFlows[childIdx], allFlows[childIdx].x + child.width / 2);
      }
    }
  }

  void _centerFlows(List<FlowClass> allFlows) {
    if (allFlows.isEmpty) return;
    double minX = double.infinity, minY = double.infinity;
    double maxX = -double.infinity, maxY = -double.infinity;

    for (var flow in allFlows) {
      if (flow.x < minX) minX = flow.x;
      if (flow.y < minY) minY = flow.y;
      if (flow.x + flow.width > maxX) maxX = flow.x + flow.width;
      if (flow.y + flow.height > maxY) maxY = flow.y + flow.height;
    }

    final offsetX = (state.stageWidth - (maxX - minX)) / 2 - minX;
    final offsetY = (state.windowHeight - (maxY - minY)) / 2 - minY;

    for (var flow in allFlows) {
      flow.x += offsetX;
      flow.y += offsetY;
    }
  }

  void updateFlowsReactive() {
    updateFlows();
    refreshUI();
  }

  void forceRepositionAllFlows() {
    if (state.flows.isEmpty) return;
    updateFlowsReactive();
  }

  void addFlow(FlowType type) {
    final updatedFlows = List<FlowClass>.from(state.flows);
    
    // Generate a unique ID (max ID + 1)
    final id = updatedFlows.isEmpty 
        ? 0 
        : updatedFlows.fold<int>(0, (maxId, flow) => flow.id > maxId ? flow.id : maxId) + 1;
    
    double defaultWidth = Defaults.flowWidth;
    if (state.systemVariables != null) {
      if (type == FlowType.process) defaultWidth = state.systemVariables!.processWidth ?? Defaults.flowWidth;
      else if (type == FlowType.condition) defaultWidth = state.systemVariables!.conditionWidth ?? Defaults.flowWidth;
      else if (type == FlowType.terminal) defaultWidth = state.systemVariables!.terminalWidth ?? Defaults.flowWidth;
    }

    FlowClass flow = FlowClass(
      id: id,
      width: defaultWidth,
      height: (type == FlowType.condition || type == FlowType.user) ? Defaults.flowWidth : 40,
      x: state.stageWidth / 2 - defaultWidth / 2,
      y: 20,
      type: type,
      value: "start",
      down: Line(lineHeight: state.systemVariables?.lineHeight ?? Defaults.lineHeight),
      left: Line(lineHeight: state.systemVariables?.lineHeight ?? Defaults.lineHeight),
      right: Line(lineHeight: state.systemVariables?.lineHeight ?? Defaults.lineHeight),
      pid: state.selectedId >= 0 ? state.selectedId : null,
      direction: state.selectedDirection,
    );

    if (state.selectedId >= 0) {
      final parentIdx = updatedFlows.indexWhere((f) => f.id == state.selectedId);
      if (parentIdx != -1) {
        if (updatedFlows[parentIdx].type == FlowType.condition && updatedFlows[parentIdx].yes == null) {
          updatedFlows[parentIdx] = updatedFlows[parentIdx].copyWith(yes: state.selectedDirection);
        }
      }
    }

    updatedFlows.add(flow);
    state = state.copyWith(
      flows: updatedFlows,
      selectedId: id,
      selectedType: type,
      window: "edit",
    );

    updateFlowsReactive();
    onProcessUnhover();
    save();
  }

  void selectFlow(int id, Direction? direction, FlowType type) {
    if (state.isSelectingLoop) {
      _handleLoopSelection(id);
      return;
    }

    final flowIdx = state.flows.indexWhere((f) => f.id == id);
    if (flowIdx != -1) {
      final f = state.flows[flowIdx];
      state = state.copyWith(
        window: "edit",
        selectedId: id,
        selectedDirection: direction,
        selectedType: type,
        widthText: f.width.toString(),
        valueText: f.value,
        downText: f.down.lineHeight.toString(),
        leftText: f.left.lineHeight.toString(),
        rightText: f.right.lineHeight.toString(),
      );
    }
    
    onProcessUnhover();
    refreshUI();
  }

  void startLoopSelection(bool isFrom) {
    state = state.copyWith(
      isSelectingLoop: true,
      isPickingLoopFrom: isFrom,
      isPickingLoopTo: !isFrom,
      window: "none",
    );
  }

  void closeWindow() {
    state = state.copyWith(window: "none");
  }

  void startAddingFlow(int parentId, Direction direction) {
    state = state.copyWith(
      window: "add",
      selectedId: parentId,
      selectedDirection: direction,
    );
    refreshUI();
  }

  void cancelLoopSelection() {
    state = state.copyWith(
      isSelectingLoop: false,
      isPickingLoopFrom: false,
      isPickingLoopTo: false,
      loopFrom: -1,
      loopTo: -1,
    );
  }

  void flipPendingLoop() {
    if (state.loopFrom >= 0 && state.loopTo >= 0) {
      final from = state.loopFrom;
      final to = state.loopTo;
      state = state.copyWith(loopFrom: to, loopTo: from);
    }
  }

  void deleteLoop(int fromId, int toId) {
    state = state.copyWith(
      loopLinks: state.loopLinks
          .where((l) => !(l.fromId == fromId && l.toId == toId))
          .toList(),
    );
    save();
  }

  void _handleLoopSelection(int id) {
    if (state.isPickingLoopFrom) {
      state = state.copyWith(loopFrom: id, isPickingLoopFrom: false);
      Future.delayed(const Duration(milliseconds: 500), () {
        if (state.isSelectingLoop && state.loopFrom >= 0 && state.loopTo < 0) {
          state = state.copyWith(isPickingLoopTo: true);
        }
      });
    } else if (state.isPickingLoopTo) {
      if (state.loopFrom != id) {
        state = state.copyWith(loopTo: id, isPickingLoopTo: false);
        commitPendingLoop();
      }
    }
  }

  void deleteFlow(int id) {
    final updatedFlows = List<FlowClass>.from(state.flows);
    final flowIdx = updatedFlows.indexWhere((f) => f.id == id);
    if (flowIdx == -1) return;

    FlowClass selectedFlow = updatedFlows[flowIdx];
    
    // Cleanup children recursively
    void removeChildren(int parentId) {
      final childrenIds = updatedFlows.where((f) => f.pid == parentId).map((f) => f.id).toList();
      for (var cid in childrenIds) {
        removeChildren(cid);
        updatedFlows.removeWhere((f) => f.id == cid);
      }
    }

    removeChildren(id);
    updatedFlows.removeAt(flowIdx);
    
    state = state.copyWith(flows: updatedFlows, window: "none", selectedId: -1);
    updateFlowsReactive();
    save();
  }

  void startLineHeightDrag(int flowId, double startX, double startY) {
    final flowIdx = state.flows.indexWhere((f) => f.id == flowId);
    if (flowIdx == -1) return;
    final flow = state.flows[flowIdx];
    if (flow.pid == null) return;

    final parentIdx = state.flows.indexWhere((f) => f.id == flow.pid);
    if (parentIdx == -1) return;
    final parentFlow = state.flows[parentIdx];

    double initialLH = 0.0;
    if (flow.direction == Direction.down) initialLH = parentFlow.down.lineHeight;
    else if (flow.direction == Direction.left) initialLH = parentFlow.left.lineHeight;
    else if (flow.direction == Direction.right) initialLH = parentFlow.right.lineHeight;

    state = state.copyWith(
      isDraggingLineHeight: true,
      draggedFlowId: flowId,
      initialDragX: startX,
      initialDragY: startY,
      initialLineHeight: initialLH,
    );
  }

  void updateLineHeightDrag(double currentX, double currentY) {
    if (!state.isDraggingLineHeight || state.draggedFlowId < 0) return;
    
    final flowIdx = state.flows.indexWhere((f) => f.id == state.draggedFlowId);
    if (flowIdx == -1) return;
    final flow = state.flows[flowIdx];
    
    final parentIdx = state.flows.indexWhere((f) => f.id == flow.pid);
    if (parentIdx == -1) return;
    
    final deltaY = (currentY - state.initialDragY) * 0.5;
    final deltaX = (currentX - state.initialDragX) * 0.5;

    final updatedFlows = List<FlowClass>.from(state.flows);
    
    if (flow.direction == Direction.down) {
      updatedFlows[parentIdx] = updatedFlows[parentIdx].copyWith(
        down: updatedFlows[parentIdx].down.copyWith(lineHeight: (state.initialLineHeight + deltaY).clamp(10.0, 500.0))
      );
    } else if (flow.direction == Direction.left) {
      updatedFlows[parentIdx] = updatedFlows[parentIdx].copyWith(
        left: updatedFlows[parentIdx].left.copyWith(lineHeight: (state.initialLineHeight - deltaX).clamp(10.0, 500.0))
      );
    } else if (flow.direction == Direction.right) {
      updatedFlows[parentIdx] = updatedFlows[parentIdx].copyWith(
        right: updatedFlows[parentIdx].right.copyWith(lineHeight: (state.initialLineHeight + deltaX).clamp(10.0, 500.0))
      );
    }

    state = state.copyWith(flows: updatedFlows);
    updateFlowsReactive();
  }

  void endLineHeightDrag() {
    state = state.copyWith(isDraggingLineHeight: false, draggedFlowId: -1);
    save();
  }

  void onProcessHover(int id, String side) => state = state.copyWith(hoveredProcessId: id, hoveredSide: side);
  void onProcessUnhover() => state = state.copyWith(hoveredProcessId: -1, hoveredSide: "");
  void updateMouseOverDot(bool v) => state = state.copyWith(isMouseOverDot: v);

  void commitPendingLoop() {
    if (state.loopFrom >= 0 && state.loopTo >= 0) {
      final updatedLoops = List<LoopLink>.from(state.loopLinks);
      updatedLoops.add(LoopLink(fromId: state.loopFrom, toId: state.loopTo));
      state = state.copyWith(loopLinks: updatedLoops, isSelectingLoop: false);
      save();
    }
  }

  void deleteAllLoopsForFlow(int id) {
    state = state.copyWith(loopLinks: state.loopLinks.where((l) => l.fromId != id && l.toId != id).toList());
  }
}
