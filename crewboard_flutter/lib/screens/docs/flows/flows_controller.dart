import 'dart:convert';

import 'package:get/get.dart';
import 'dart:async';
import 'types.dart';
import 'package:crewboard_flutter/main.dart'; // For client
import 'package:crewboard_client/crewboard_client.dart'; // For generated models
import '../docs_sidebar.dart'; // For enums
import '../document_editor_provider.dart';

class FlowsController extends GetxController {
  // Observable flows list for the canvas
  final RxList<FlowClass> flows = <FlowClass>[].obs;

  // Observable saved flows list (from API, for Sidebar)
  final RxList<FlowModel> savedFlows = <FlowModel>[].obs;

  // Observable apps list
  final RxList<PlannerApp> apps = <PlannerApp>[].obs;

  // Observable selected app ID
  final Rx<UuidValue?> selectedAppId = Rx<UuidValue?>(null);

  // Observable sidebar mode
  final Rx<SidebarMode> sidebarMode = SidebarMode.apps.obs;

  // Observable current subpage
  final Rx<FlowSubPage> currentSubPage = FlowSubPage.flows.obs;

  // Observable loading state for apps
  final RxBool isLoadingApps = false.obs;

  // Observable loading state
  final RxBool isLoadingFlows = false.obs;

  // Observable window mode (add, edit, none)
  final RxString window = "none".obs;

  // Observable selected flow properties
  final Rx<FlowType?> selectedType = Rx<FlowType?>(null);
  final Rx<Direction?> selectedDirection = Rx<Direction?>(null);
  final RxInt selectedId = (-1).obs;

  // Observable flow properties for editing
  final RxString widthText = "".obs;
  final RxString valueText = "".obs;
  final RxString downText = "".obs;
  final RxString leftText = "".obs;
  final RxString rightText = "".obs;

  // Observable window dimensions
  final RxDouble stageWidth = 0.0.obs;
  final RxDouble windowHeight = 0.0.obs;

  // Observable widget key for positioning
  final RxString widgetKey = "".obs;

  // Current Flow properties
  final Rx<UuidValue?> currentFlowId = Rx<UuidValue?>(null);
  final RxString currentFlowName = "".obs;

  // Observable palette settings (simplified for now)
  final RxBool isLightMode = false.obs;

  // Observable hover state for process flows
  final RxInt hoveredProcessId = (-1).obs;
  final RxString hoveredSide = "".obs; // "left", "right", or ""

  // Observable mouse over dot state
  final RxBool isMouseOverDot = false.obs;

  // Toggle to show/hide add handles (dots and hover lines)
  final RxBool showAddHandles = true.obs;

  // Observable refresh counter to force UI updates
  final RxInt flowCanvasRefreshCounter = 0.obs;

  // Drag states
  final RxBool isDraggingLineHeight = false.obs;
  final RxInt draggedFlowId = (-1).obs;
  final RxDouble initialDragX = 0.0.obs;
  final RxDouble initialDragY = 0.0.obs;
  final RxDouble initialLineHeight = 0.0.obs;

  final RxBool isPanning = false.obs;

  // Loop selection state
  final RxBool isSelectingLoop = false.obs;
  final RxList<LoopLink> loopLinks = <LoopLink>[].obs;
  final RxInt loopFrom = (-1).obs;
  final RxInt loopTo = (-1).obs;
  final RxBool isPickingLoopFrom = false.obs;
  final RxBool isPickingLoopTo = false.obs;
  final RxInt loopHoverId = (-1).obs;

  final RxDouble loopPad = 40.0.obs;
  final RxString hoveredLoopPadAxis = "".obs;
  final RxBool isDraggingLoopPad = false.obs;
  final RxDouble initialLoopPadDragPos = 0.0.obs;
  final RxDouble initialLoopPadValue = 40.0.obs;
  
  // Observable system variables for settings
  final Rx<SystemVariables?> systemVariables = Rx<SystemVariables?>(null);
  final RxBool isLoadingSettings = false.obs;

  Timer? _saveDebounce;

  @override
  void onInit() {
    super.onInit();
    // Load settings and apps
    loadSettings();
    loadApps();
  }

  Future<void> loadSettings() async {
    try {
      isLoadingSettings.value = true;
      final result = await client.admin.getSystemVariables();
      systemVariables.value = result;
      
      // Update Defaults
      if (result != null) {
        if (result.lineHeight != null) Defaults.lineHeight = result.lineHeight!;
        // Note: flowWidth is a base value, each node can have its own width.
        // We use processWidth as the default for new nodes if applicable.
      }
    } catch (e) {
      print('Error loading settings: $e');
    } finally {
      isLoadingSettings.value = false;
    }
  }

  void refreshUI() {
    flowCanvasRefreshCounter.value++;
    update();
  }

  // --- API Methods ---

  Future<void> loadApps() async {
    try {
      isLoadingApps.value = true;
      final result = await client.admin.getApps();
      apps.value = result;
    } catch (e) {
      print('Error loading apps: $e');
    } finally {
      isLoadingApps.value = false;
    }
  }

  Future<void> addApp(String name, UuidValue colorId) async {
    try {
      await client.admin.addApp(name, colorId);
      await loadApps();
    } catch (e) {
      print('Error adding app: $e');
    }
  }

  void selectApp(UuidValue appId) {
    selectedAppId.value = appId;
    sidebarMode.value = SidebarMode.flows;
    loadSavedFlows();
  }

  void backToApps() {
    selectedAppId.value = null;
    sidebarMode.value = SidebarMode.apps;
    savedFlows.clear();
    flows.clear();
    currentFlowId.value = null;
  }

  void changeSubPage(String subPage) {
    if (subPage == "docs") {
      currentSubPage.value = FlowSubPage.docs;
      // Load docs when switching to docs tab
      if (selectedAppId.value != null) {
        if (!Get.isRegistered<DocumentEditorProvider>()) {
          Get.put(DocumentEditorProvider());
        }
        final docProvider = Get.find<DocumentEditorProvider>();
        docProvider.loadSavedDocs(selectedAppId.value!);
      }
    } else if (subPage == "flows") {
      currentSubPage.value = FlowSubPage.flows;
    }
  }

  Future<void> loadSavedFlows() async {
    if (selectedAppId.value == null) return;
    try {
      isLoadingFlows.value = true;
      final result = await client.docs.getFlows(selectedAppId.value!);
      savedFlows.value = result;
    } catch (e) {
      print('Error loading flows: $e');
      Get.snackbar("Error", "Failed to load flows");
    } finally {
      isLoadingFlows.value = false;
    }
  }

  Future<void> createNewFlow(String name) async {
    if (selectedAppId.value == null) return;
    try {
      final newFlow = FlowModel(
        appId: selectedAppId.value!,
        name: name,
        flow: jsonEncode([]), // Empty flow
        lastUpdated: DateTime.now(),
      );

      final success = await client.docs.createFlow(newFlow);
      if (success) {
        await loadSavedFlows();
      }
    } catch (e) {
      print('Error creating flow: $e');
    }
  }

  Future<void> loadFlow(UuidValue id) async {
    try {
      isLoadingFlows.value = true;
      final flowModel = await client.docs.getFlow(id);
      if (flowModel != null) {
        currentFlowId.value = flowModel.id!;
        currentFlowName.value = flowModel.name;

        flows.clear();
        loopLinks.clear();

        if (flowModel.flow.isNotEmpty) {
          final List<dynamic> jsonList = jsonDecode(flowModel.flow);
          for (var item in jsonList) {
            // Handle special loops payload
            if (item is Map && item.containsKey("_loops")) {
              final loops = item["_loops"] as List?;
              if (loops != null) {
                for (var l in loops) {
                  if (l is Map && l.containsKey("fromId") && l.containsKey("toId")) {
                    final fromId = l["fromId"];
                    final toId = l["toId"];
                    if (fromId is int && toId is int) {
                      loopLinks.add(LoopLink(fromId: fromId, toId: toId));
                    }
                  }
                }
              }
              continue;
            }
            // Handle loop pad value payload
            if (item is Map && item.containsKey("_loopPad")) {
              final pad = item["_loopPad"];
              if (pad is num) {
                loopPad.value = pad.toDouble();
              }
              continue;
            }
            
            flows.add(FlowClass.fromJson(item));
          }
        }

        // Reset view
        window.value = flows.isEmpty ? "add" : "none";
        refreshUI();
      }
    } catch (e) {
      print('Error loading flow detail: $e');
    } finally {
      isLoadingFlows.value = false;
    }
  }

  Future<void> save() async {
    if (currentFlowId.value == null) return;

    // Debounce save
    if (_saveDebounce?.isActive ?? false) _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final List<dynamic> flowData = flows.map((e) => e.toJson()).toList();
        
        // Append loops payload
        if (loopLinks.isNotEmpty) {
          final List<Map<String, int>> loops = loopLinks
              .map((e) => {"fromId": e.fromId, "toId": e.toId})
              .toList();
          flowData.add({"_loops": loops});
        }
        // Append loop pad value
        flowData.add({"_loopPad": loopPad.value});

        final jsonString = jsonEncode(flowData);

        final flowModel = FlowModel(
          id: currentFlowId.value,
          appId: selectedAppId.value!,
          name: currentFlowName.value,
          flow: jsonString,
          lastUpdated: DateTime.now(),
        );

        await client.docs.updateFlow(flowModel);
        print("Flow saved");
      } catch (e) {
        print('Error saving flow: $e');
      }
    });
  }

  Future<void> deleteCurrentFlow() async {
    if (currentFlowId.value == null) return;
    try {
      final success = await client.docs.deleteFlow(currentFlowId.value!);
      if (success) {
        flows.clear();
        currentFlowId.value = null;
        currentFlowName.value = "";
        await loadSavedFlows();
      }
    } catch (e) {
      print('Error deleting flow: $e');
    }
  }

  // --- Logic Methods (Ported from old controller) ---

  // ... (Paste logic methods, simplified/cleaned)
  // Need to include updateFlowsReactive, forceRepositionAllFlows, etc.

  // --- Logic Methods ---

  // Update flow positions (canvas paint helper)
  void updateFlows() {
    if (flows.isEmpty) return;
    
    // 1. Reset hasChild flags
    for (var flow in flows) {
      flow.down.hasChild = false;
      flow.left.hasChild = false;
      flow.right.hasChild = false;
    }

    // 2. Map for quick lookup
    final Map<int, FlowClass> nodeMap = {for (var f in flows) f.id: f};

    // 3. Update hasChild based on parent IDs
    for (var flow in flows) {
      if (flow.pid != null) {
        final parent = nodeMap[flow.pid];
        if (parent != null) {
          if (flow.direction == Direction.down) parent.down.hasChild = true;
          else if (flow.direction == Direction.right) parent.right.hasChild = true;
          else if (flow.direction == Direction.left) parent.left.hasChild = true;
        }
      }
    }

    // 4. Find root(s)
    final roots = flows.where((f) => f.pid == null).toList();
    if (roots.isEmpty) return;

    // 5. Initial horizontal position for roots
    // For now, let's just use the first root as the main one, or space them out
    double currentRootX = stageWidth.value / 2;
    for (var root in roots) {
      root.x = currentRootX - root.width / 2;
      root.y = 20; // Default top padding
      
      // 6. Recursively position children
      _positionChildren(nodeMap, root, currentRootX);
      
      // If we had multiple roots, we'd shift currentRootX here
    }

    // 7. Calculate bounding box and center
    _centerFlows();
  }

  void _positionChildren(Map<int, FlowClass> nodeMap, FlowClass parent, double x) {
    // Collect children mapping to their directions
    final children = flows.where((f) => f.pid == parent.id).toList();
    
    for (var child in children) {
      if (child.direction == Direction.down) {
        child.y = parent.y + parent.height + parent.down.lineHeight;
        child.x = x - child.width / 2;
        _positionChildren(nodeMap, child, x);
      } else if (child.direction == Direction.right) {
        child.y = parent.y + parent.height / 2 - child.height / 2;
        child.x = parent.x + parent.width + parent.right.lineHeight;
        _positionChildren(nodeMap, child, child.x + child.width / 2);
      } else if (child.direction == Direction.left) {
        child.y = parent.y + parent.height / 2 - child.height / 2;
        child.x = parent.x - parent.left.lineHeight - child.width;
        _positionChildren(nodeMap, child, child.x + child.width / 2);
      }
    }
  }

  void _centerFlows() {
    if (flows.isEmpty) return;

    double minX = double.infinity, minY = double.infinity;
    double maxX = -double.infinity, maxY = -double.infinity;

    for (var flow in flows) {
      if (flow.x < minX) minX = flow.x;
      if (flow.y < minY) minY = flow.y;
      if (flow.x + flow.width > maxX) maxX = flow.x + flow.width;
      if (flow.y + flow.height > maxY) maxY = flow.y + flow.height;
    }

    final double contentWidth = maxX - minX;
    final double contentHeight = maxY - minY;

    final double offsetX = (stageWidth.value - contentWidth) / 2 - minX;
    final double offsetY = (windowHeight.value - contentHeight) / 2 - minY;

    for (var flow in flows) {
      flow.x += offsetX;
      flow.y += offsetY;
    }
  }

  // Reactive methods for state updates
  void updateFlowsReactive() {
    updateFlows();
    refreshUI();
  }

  void forceRepositionAllFlows() {
    if (flows.isEmpty) return;
    updateFlowsReactive();
  }


  void addFlow(FlowType type) {
    double y = 20;
    FlowClass flow = FlowClass(
      id: flows.length,
      width: (type == FlowType.process) 
          ? (systemVariables.value?.processWidth ?? Defaults.flowWidth)
          : (type == FlowType.condition)
              ? (systemVariables.value?.conditionWidth ?? Defaults.flowWidth)
              : (type == FlowType.terminal)
                  ? (systemVariables.value?.terminalWidth ?? Defaults.flowWidth)
                  : Defaults.flowWidth,
      height: (type == FlowType.condition || type == FlowType.user) ? Defaults.flowWidth : 40,
      x: stageWidth.value / 2 - Defaults.flowWidth / 2,
      y: y,
      type: type,
      value: "start",
      down: Line(lineHeight: systemVariables.value?.lineHeight ?? Defaults.lineHeight),
      left: Line(lineHeight: systemVariables.value?.lineHeight ?? Defaults.lineHeight),
      right: Line(lineHeight: systemVariables.value?.lineHeight ?? Defaults.lineHeight),
      pid: selectedId.value >= 0 ? selectedId.value : null,
      direction: selectedDirection.value,
    );

    if (selectedId.value >= 0 && selectedId.value < flows.length) {
      if (flows[selectedId.value].type == FlowType.condition && flows[selectedId.value].yes == null) {
        flows[selectedId.value].yes = selectedDirection.value;
      }
    }

    selectedId.value = flows.length;
    selectedType.value = type;
    flows.add(flow);

    updateFlowsReactive();
    onProcessUnhover();
    save();

    window.value = "edit";
  }

  void selectFlow(int id, Direction? direction, FlowType type) {
    if (isSelectingLoop.value) {
      if (isPickingLoopFrom.value) {
        loopFrom.value = id;
        isPickingLoopFrom.value = false;
        Future.delayed(Duration(milliseconds: 500), () {
          if (isSelectingLoop.value && loopFrom.value >= 0 && loopTo.value < 0) {
            isPickingLoopTo.value = true;
          }
        });
      } else if (isPickingLoopTo.value) {
        if (loopFrom.value != id) {
          loopTo.value = id;
          commitPendingLoop();
        }
        isPickingLoopTo.value = false;
      } else {
        if (loopFrom.value < 0) {
          loopFrom.value = id;
          Future.delayed(Duration(milliseconds: 500), () {
            if (isSelectingLoop.value && loopFrom.value >= 0 && loopTo.value < 0) {
              isPickingLoopTo.value = true;
            }
          });
        } else if (loopTo.value < 0 && loopFrom.value != id) {
          loopTo.value = id;
          commitPendingLoop();
        }
      }
      return;
    }

    window.value = "edit";
    selectedId.value = id;
    selectedDirection.value = direction;
    selectedType.value = type;

    onProcessUnhover();

    if (id >= 0 && id < flows.length) {
      widthText.value = flows[id].width.toString();
      valueText.value = flows[id].value;
      downText.value = flows[id].down.lineHeight.toString();
      leftText.value = flows[id].left.lineHeight.toString();
      rightText.value = flows[id].right.lineHeight.toString();
    }
    refreshUI();
  }

  void deleteFlow(int id) {
    if (id < 0 || id >= flows.length) return;

    FlowClass selectedFlow = flows[id];
    for (var flow in flows) {
      if (flow.id == selectedFlow.pid) {
        if (selectedFlow.direction == Direction.down) {
          flow.down.hasChild = false;
        }
        if (selectedFlow.direction == Direction.left) {
          flow.left.hasChild = false;
        }
        if (selectedFlow.direction == Direction.right) {
          flow.right.hasChild = false;
        }
      }
    }

    flows.removeAt(id);

    List<int> children = getChildIds(id);
    // Remove children recursively
    // Note: Iterating backwards or collecting indices is safer when removing
    for (var child in children) {
       flows.removeWhere((f) => f.id == child);
    }

    // Fix IDs
    for (var i = 0; i < flows.length; i++) {
        int oldId = flows[i].id;
        flows[i].id = i;
        for (var flow in flows) {
            if (flow.pid == oldId) {
                flow.pid = i;
            }
        }
        // Also fix loop links
        for (var link in loopLinks) {
            if (link.fromId == oldId) link.fromId = i;
            if (link.toId == oldId) link.toId = i;
        }
    }

    deleteAllLoopsForFlow(id); // Actually old ID is gone, but we might need to cleanup by index if logic wasn't perfect
    // In this basic re-index logic, we should probably clear loops for removed items first.
    
    updateFlowsReactive();
    save();
    window.value = "none";
    refreshUI();
  }

  List<int> getChildIds(int id) {
    List<int> flowIds = [];
    for (var flow in flows) {
      if (flow.pid == id) {
        flowIds.add(flow.id);
        flowIds.addAll(getChildIds(flow.id));
      }
    }
    return flowIds;
  }

  // Line height dragging implementation
  void startLineHeightDrag(int flowId, double startX, double startY) {
    if (flowId < 0 || flowId >= flows.length) return;

    final flow = flows[flowId];
    if (flow.pid == null) return; // Can't drag root flow

    final parentFlow = flows.firstWhere((f) => f.id == flow.pid);

    // Determine which line height to adjust based on flow direction
    double currentLineHeight = 0.0;
    if (flow.direction == Direction.down) {
      currentLineHeight = parentFlow.down.lineHeight;
    } else if (flow.direction == Direction.left) {
      currentLineHeight = parentFlow.left.lineHeight;
    } else if (flow.direction == Direction.right) {
      currentLineHeight = parentFlow.right.lineHeight;
    }

    isDraggingLineHeight.value = true;
    draggedFlowId.value = flowId;
    initialDragX.value = startX;
    initialDragY.value = startY;
    initialLineHeight.value = currentLineHeight;
  }

  void updateLineHeightDrag(double currentX, double currentY) {
    if (!isDraggingLineHeight.value || draggedFlowId.value < 0) return;

    final flowId = draggedFlowId.value;
    if (flowId >= flows.length) return;

    final flow = flows[flowId];
    if (flow.pid == null) return;

    final parentFlow = flows.firstWhere((f) => f.id == flow.pid);
    final deltaY = currentY - initialDragY.value;
    final deltaX = currentX - initialDragX.value;

    // Apply drag sensitivity (reduce sensitivity for smoother control)
    final adjustedDeltaY = deltaY * 0.5;
    final adjustedDeltaX = deltaX * 0.5;

    // Calculate new line height (minimum 10px, maximum 500px)
    double newLineHeight = initialLineHeight.value;
    if (flow.direction == Direction.down) {
      newLineHeight = (initialLineHeight.value + adjustedDeltaY).clamp(10.0, 500.0);
      parentFlow.down.lineHeight = newLineHeight;
    } else if (flow.direction == Direction.left) {
      // Moving left (decreasing X) should increase line height
      newLineHeight = (initialLineHeight.value + (-adjustedDeltaX)).clamp(10.0, 500.0);
      parentFlow.left.lineHeight = newLineHeight;
    } else if (flow.direction == Direction.right) {
      // Moving right (increasing X) should increase line height
      newLineHeight = (initialLineHeight.value + adjustedDeltaX).clamp(10.0, 500.0);
      parentFlow.right.lineHeight = newLineHeight;
    }

    // Reposition all flows to reflect the new line height
    forceRepositionAllFlows();
  }

  void endLineHeightDrag() {
    if (isDraggingLineHeight.value) {
      isDraggingLineHeight.value = false;
      draggedFlowId.value = -1;
      initialDragY.value = 0.0;
      initialDragX.value = 0.0;
      initialLineHeight.value = 0.0;

      // Save the changes
      save();
    }
  }

  // Hover logic
  void onProcessHover(int id, String side) {
    hoveredProcessId.value = id;
    hoveredSide.value = side;
  }

  void onProcessUnhover() {
    hoveredProcessId.value = -1;
    hoveredSide.value = "";
  }

  void updateMouseOverDot(bool v) {
    isMouseOverDot.value = v;
  }

  void setHoveredLoopPadAxis(String axis) {
    hoveredLoopPadAxis.value = axis;
  }

  // Loop pad dragging implementation
  void startLoopPadDrag(double pointerX, double pointerY) {
    if (hoveredLoopPadAxis.value.isEmpty) return;
    isDraggingLoopPad.value = true;
    initialLoopPadValue.value = loopPad.value;
    initialLoopPadDragPos.value = hoveredLoopPadAxis.value == "vertical"
        ? pointerY
        : pointerX;
  }

  void updateLoopPadDrag(double pointerX, double pointerY) {
    if (!isDraggingLoopPad.value) return;
    const double minPad = 10.0;
    const double maxPad = 300.0;
    final currentPos = hoveredLoopPadAxis.value == "vertical"
        ? pointerY
        : pointerX;
    final delta = currentPos - initialLoopPadDragPos.value;
    final newValue = (initialLoopPadValue.value + delta).clamp(minPad, maxPad);
    loopPad.value = newValue;
    // Trigger repaint
    flowCanvasRefreshCounter.value++;
    update();
  }

  void endLoopPadDrag() {
    if (!isDraggingLoopPad.value) return;
    isDraggingLoopPad.value = false;
    // Persist loop corridor/lanes offset changes
    save();
  }

  // Loop selection implementation
  void startLoopSelection() {
    isSelectingLoop.value = true;
    loopFrom.value = -1;
    loopTo.value = -1;
    isPickingLoopFrom.value = true; // auto-start picking from
    isPickingLoopTo.value = false;
    loopHoverId.value = -1;
    // Make sure edit panel is shown for loop controls
    window.value = "edit";
  }

  void cancelLoopSelection() {
    if (!isSelectingLoop.value &&
        !isPickingLoopFrom.value &&
        !isPickingLoopTo.value) {
      return;
    }
    isSelectingLoop.value = false;
    isPickingLoopFrom.value = false;
    isPickingLoopTo.value = false;
    loopFrom.value = -1;
    loopTo.value = -1;
    loopHoverId.value = -1;
    update();
  }

  void setLoopFrom(int id) {
    if (id >= 0 && id < flows.length) {
      loopFrom.value = id;
    }
  }

  void setLoopTo(int id) {
    if (id >= 0 && id < flows.length) {
      loopTo.value = id;
    }
  }

  void flipPendingLoop() {
    // If a committed link exists for current selection, flip it in place
    if (loopFrom.value >= 0 && loopTo.value >= 0) {
      final int from = loopFrom.value;
      final int to = loopTo.value;
      final int existingIndex = loopLinks.indexWhere(
        (l) => l.fromId == from && l.toId == to,
      );
      if (existingIndex >= 0) {
        loopLinks[existingIndex] = LoopLink(fromId: to, toId: from);
        update();
        save();
      }
    }
    // Always swap the pending endpoints for the UI
    final int tmp = loopFrom.value;
    loopFrom.value = loopTo.value;
    loopTo.value = tmp;
  }

  void setLoopHover(int id) {
    if (isSelectingLoop.value) {
      loopHoverId.value = id;
    }
  }

  void commitPendingLoop() {
    if (loopFrom.value >= 0 &&
        loopTo.value >= 0 &&
        loopFrom.value != loopTo.value) {
      loopLinks.add(LoopLink(fromId: loopFrom.value, toId: loopTo.value));
      isSelectingLoop.value = false;
      update();
      save();
    }
  }

  void deleteLoop(int fromId, int toId) {
    loopLinks.removeWhere((link) => link.fromId == fromId && link.toId == toId);
    update();
    save();
  }

  void deleteAllLoopsForFlow(int flowId) {
    loopLinks.removeWhere(
      (link) => link.fromId == flowId || link.toId == flowId,
    );
    update();
    save();
  }


}
