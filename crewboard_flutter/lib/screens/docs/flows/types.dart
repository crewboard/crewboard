enum Direction {
  down,
  right,
  left,
}

enum FlowType {
  terminal,
  process,
  condition,
}

class Defaults {
  static double lineHeight = 25;
  static double flowWidth = 100;
}

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
  });

  // Serialization needed for storing as JSON in Serverpod
  Map<String, dynamic> toJson() => {
    'id': id,
    'pid': pid,
    'width': width,
    'height': height,
    'x': x,
    'y': y,
    'value': value,
    'type': type.index,
    'direction': direction?.index,
    'down': down.toJson(),
    'left': left.toJson(),
    'right': right.toJson(),
    'yes': yes?.index,
  };

  factory FlowClass.fromJson(Map<String, dynamic> json) {
    return FlowClass(
      id: json['id'],
      pid: json['pid'],
      width: json['width'],
      height: json['height'],
      x: json['x'],
      y: json['y'],
      value: json['value'],
      type: FlowType.values[json['type']],
      direction: json['direction'] != null
          ? Direction.values[json['direction']]
          : null,
      down: Line.fromJson(json['down']),
      left: Line.fromJson(json['left']),
      right: Line.fromJson(json['right']),
      yes: json['yes'] != null ? Direction.values[json['yes']] : null,
    );
  }
}

class Line {
  double lineHeight = Defaults.lineHeight;
  bool hasChild = false;

  Line({this.lineHeight = 0, this.hasChild = false}) {
    if (lineHeight == 0) {
      lineHeight = Defaults.lineHeight;
    }
  }

  Map<String, dynamic> toJson() => {
    'lineHeight': lineHeight,
    'hasChild': hasChild,
  };

  factory Line.fromJson(Map<String, dynamic> json) {
    return Line(
      lineHeight: json['lineHeight'],
      hasChild: json['hasChild'],
    );
  }
}

class LoopLink {
  int fromId;
  int toId;
  LoopLink({required this.fromId, required this.toId});

  Map<String, dynamic> toJson() => {
    'fromId': fromId,
    'toId': toId,
  };

  factory LoopLink.fromJson(Map<String, dynamic> json) {
    return LoopLink(
      fromId: json['fromId'],
      toId: json['toId'],
    );
  }
}
