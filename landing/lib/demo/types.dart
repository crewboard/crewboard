import 'dart:convert';

// import '../backend/server.dart';
// import '../flowie/main.dart';

import '../types.dart';

enum Direction { down, right, left }

enum FlowType { terminal, process, condition }

class Defaults {
  static double lineHeight = 25;
  static double flowWidth = 100;
}

class Ram {
  static FlowType? selectedType;
  static Direction? selectedDirection;
  static int? selectedId;
}

// class View {
//   static FilePickerResult? image;
// }

class FlowClass {
  int id;
  int? pid;
  double width;
  double height;
  double x;
  double y;
  String value;
  FlowType type;
  Direction? direction;
  Line down;
  Line right;
  Line left;
  Direction? yes;
  FlowClass({
    required this.id,
    required this.width,
    required this.height,
    required this.x,
    required this.y,
    required this.value,
    required this.type,
    required this.down,
    required this.left,
    required this.right,
    this.pid,
    this.direction,
    this.yes,
  }) {}
}

class Line {
  double lineHeight = Defaults.lineHeight;
  bool hasChild = false;
  Line({this.lineHeight = 0, this.hasChild = false}) {
    if (lineHeight == 0) {
      lineHeight = Defaults.lineHeight;
    }
  }
}

class FlowieClass {
  List<FlowClass> flows = [];

  addFlow(FlowType type) {
    double y = 20;

    FlowClass flow = FlowClass(
      id: flows.length,
      width: Defaults.flowWidth,
      height: (type == FlowType.condition) ? Defaults.flowWidth : 40,
      x: Window.stageWidth / 2 - Defaults.flowWidth / 2,
      y: y,
      type: type,
      value: "start",
      down: Line(),
      left: Line(),
      right: Line(),
      pid: Ram.selectedId,
      direction: Ram.selectedDirection,
    );
    if (Ram.selectedId != null) {
      if (flows[Ram.selectedId!].type == FlowType.condition &&
          flows[Ram.selectedId!].yes == null) {
        flows[Ram.selectedId!].yes = Ram.selectedDirection;
      }
    }
    Ram.selectedId = flows.length;
    Ram.selectedType = type;
    flows.add(flow);
    Window.mode = "edit";
    update();
    refreshSink.add("");
  }

  delete(int id) {
    // print("deleting id " + id.toString());
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

    print(flows);

    print(id);
    flows.removeAt(id);
    print(flows);

    List<int> children = getChildIds(id);
    for (var child in children) {
      for (var i = 0; i < flows.length; i++) {
        if (flows[i].id == child) {
          flows.removeAt(i);
        }
      }
    }
    // fix ids
    for (var i = 0; i < flows.length; i++) {
      if (flows[i].id != i) {
        int oldId = flows[i].id;
        flows[i].id = i;
        for (var flow in flows) {
          if (flow.pid == oldId) {
            flow.pid = i;
          }
        }
      }
    }

    update();
    save();
    // refreshSink.add("");
  }

  List<int> getChildIds(int id) {
    // FlowClass? selectedItem;
    List<int> flowIds = [];
    for (var flow in flows) {
      if (flow.pid == id) {
        flowIds.add(flow.id);
        flowIds.addAll(getChildIds(flow.id));
      }
    }
    return flowIds;
  }

  update() {
    for (var flow in flows) {
      for (var child in flows) {
        if (child.pid == flow.id) {
          if (child.direction == Direction.down) {
            flow.down.hasChild = true;
          } else if (child.direction == Direction.right) {
            flow.right.hasChild = true;
          } else if (child.direction == Direction.left) {
            flow.left.hasChild = true;
          }
        }
      }
    }
    if (flows.isNotEmpty) {
      flows[0].x = (Window.stageWidth / 2) - flows[0].width / 2;
    }
    donwlines(0, Window.stageWidth / 2);
  }

  donwlines(int id, double x) {
    for (var flow in flows) {
      if (flow.pid == id && flow.direction == Direction.down) {
        flow.y = flows[id].y + flows[id].height + flows[id].down.lineHeight;
        flow.x = x - flow.width / 2;
        if (flow.type == FlowType.condition) {
          sideLines(flow.id);
        }
        donwlines(flow.id, x);
      }
    }
  }

  sideLines(int id) {
    // left
    for (var flow in flows) {
      if (flow.pid == id && flow.direction == Direction.left) {
        flow.y = flows[id].y + flows[id].height / 2 - flow.height / 2;
        flow.x = flows[id].x - flows[id].left.lineHeight - flow.width;
        if (flow.type == FlowType.condition) {
          sideLines(flow.id);
        }
        donwlines(flow.id, flow.x + flow.width / 2);
      }
    }
    // right
    for (var flow in flows) {
      if (flow.pid == id && flow.direction == Direction.right) {
        // print(flows[id].right.lineHeight);
        flow.y = flows[id].y + flows[id].height / 2 - flow.height / 2;
        flow.x = flows[id].x + flows[id].right.lineHeight + flows[id].width;
        if (flow.type == FlowType.condition) {
          sideLines(flow.id);
        }
        donwlines(flow.id, flow.x + flow.width / 2);
      }
    }
  }

  FlowieClass() {
    if (flows.isEmpty) {
      Window.mode = "add";
    }
  }

  fromJson(List _flows) {
    flows.clear();
    Direction _direction = Direction.down;
    FlowType _type = FlowType.terminal;
    Direction? _yes;
    for (var _flow in _flows) {
      if (_flow["direction"] == "down") {
        _direction = Direction.down;
      } else if (_flow["direction"] == "left") {
        _direction = Direction.left;
      } else if (_flow["direction"] == "right") {
        _direction = Direction.right;
      }

      if (_flow["type"] == "terminal") {
        _type = FlowType.terminal;
      } else if (_flow["type"] == "condition") {
        _type = FlowType.condition;
      } else if (_flow["type"] == "process") {
        _type = FlowType.process;
      }
      if (_flow["yes"] != "none") {
        if (_flow["yes"] == "down") {
          _yes = Direction.down;
        } else if (_flow["yes"] == "left") {
          _yes = Direction.left;
        } else if (_flow["yes"] == "right") {
          _yes = Direction.right;
        }
      }
      FlowClass flow = FlowClass(
        id: _flow["id"],
        width: _flow["width"],
        height: _flow["height"],
        x: _flow["x"],
        y: _flow["y"],
        type: _type,
        value: _flow["value"],
        down: Line(
          lineHeight: _flow["down"]["lineHeight"],
          hasChild: _flow["down"]["hasChild"],
        ),
        left: Line(
          lineHeight: _flow["left"]["lineHeight"],
          hasChild: _flow["left"]["hasChild"],
        ),
        right: Line(
          lineHeight: _flow["right"]["lineHeight"],
          hasChild: _flow["right"]["hasChild"],
        ),
        pid: _flow["pid"],
        direction: _direction,
        yes: _yes,
      );
      flows.add(flow);
    }
  }

  save() {
    // server.get(data: {"0": "save_flow", "1": flowId, "2": jsonEncode(toJson())}, func: (data) {});
  }

  toJson() {
    String _direction = "down";
    String _yes = "none";
    String _type = "terminal";
    List _flows = [];

    for (var flow in flows) {
      if (flow.direction == Direction.down) {
        _direction = "down";
      } else if (flow.direction == Direction.right) {
        _direction = "right";
      } else if (flow.direction == Direction.left) {
        _direction = "left";
      }

      if (flow.type == FlowType.terminal) {
        _type = "terminal";
      } else if (flow.type == FlowType.process) {
        _type = "process";
      } else if (flow.type == FlowType.condition) {
        _type = "condition";
      }

      if (flow.yes == Direction.down) {
        _yes = "down";
      } else if (flow.yes == Direction.right) {
        _yes = "right";
      } else if (flow.yes == Direction.left) {
        _yes = "left";
      }
      Map _flow = {
        "id": flow.id,
        "width": flow.width,
        "height": flow.height,
        "x": flow.x,
        "y": flow.y,
        "type": _type,
        "value": flow.value,
        "down": {
          "lineHeight": flow.down.lineHeight,
          "hasChild": flow.down.hasChild,
        },
        "left": {
          "lineHeight": flow.left.lineHeight,
          "hasChild": flow.left.hasChild,
        },
        "right": {
          "lineHeight": flow.right.lineHeight,
          "hasChild": flow.right.hasChild,
        },
        "pid": flow.pid,
        "direction": _direction,
        "yes": _yes,
      };
      _flows.add(_flow);
    }
    return _flows;
  }
}

FlowieClass flowie = FlowieClass();
