/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class PriorityModel
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  PriorityModel._({
    required this.priorityId,
    required this.priorityName,
    required this.priority,
  });

  factory PriorityModel({
    required _i1.UuidValue priorityId,
    required String priorityName,
    required int priority,
  }) = _PriorityModelImpl;

  factory PriorityModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return PriorityModel(
      priorityId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['priorityId'],
      ),
      priorityName: jsonSerialization['priorityName'] as String,
      priority: jsonSerialization['priority'] as int,
    );
  }

  _i1.UuidValue priorityId;

  String priorityName;

  int priority;

  /// Returns a shallow copy of this [PriorityModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PriorityModel copyWith({
    _i1.UuidValue? priorityId,
    String? priorityName,
    int? priority,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PriorityModel',
      'priorityId': priorityId.toJson(),
      'priorityName': priorityName,
      'priority': priority,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PriorityModel',
      'priorityId': priorityId.toJson(),
      'priorityName': priorityName,
      'priority': priority,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PriorityModelImpl extends PriorityModel {
  _PriorityModelImpl({
    required _i1.UuidValue priorityId,
    required String priorityName,
    required int priority,
  }) : super._(
         priorityId: priorityId,
         priorityName: priorityName,
         priority: priority,
       );

  /// Returns a shallow copy of this [PriorityModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PriorityModel copyWith({
    _i1.UuidValue? priorityId,
    String? priorityName,
    int? priority,
  }) {
    return PriorityModel(
      priorityId: priorityId ?? this.priorityId,
      priorityName: priorityName ?? this.priorityName,
      priority: priority ?? this.priority,
    );
  }
}
