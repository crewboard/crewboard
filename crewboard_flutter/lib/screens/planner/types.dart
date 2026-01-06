enum FilterName { status, priority, type, deadline }

enum FilterType { where, order, both }

enum FilterOperation { ascending, descending, value }

enum SortOrder { ascending, descending }

class Operation {
  final String name;
  final FilterOperation operation;
  Operation({required this.name, required this.operation});

  Map<String, dynamic> toJson() {
    return {"name": name};
  }
}

class Filter {
  final FilterName? name;
  final FilterType? type;
  FilterOperation? operation;
  dynamic value;

  Filter({this.name, this.type, this.value, this.operation});

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
      name: json['name'] != null
          ? FilterName.values.firstWhere(
              (e) => e.name == json['name'],
              orElse: () => FilterName.status,
            )
          : null,
      type: json['type'] != null
          ? FilterType.values.firstWhere(
              (e) => e.name == json['type'],
              orElse: () => FilterType.where,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name?.name, 'type': type?.name};
  }
}
