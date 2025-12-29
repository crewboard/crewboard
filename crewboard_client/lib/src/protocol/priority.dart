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
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Priority implements _i1.SerializableModel {
  Priority._({
    this.id,
    required this.priorityName,
    required this.priority,
  });

  factory Priority({
    _i1.UuidValue? id,
    required String priorityName,
    required int priority,
  }) = _PriorityImpl;

  factory Priority.fromJson(Map<String, dynamic> jsonSerialization) {
    return Priority(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      priorityName: jsonSerialization['priorityName'] as String,
      priority: jsonSerialization['priority'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  String priorityName;

  int priority;

  /// Returns a shallow copy of this [Priority]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Priority copyWith({
    _i1.UuidValue? id,
    String? priorityName,
    int? priority,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Priority',
      if (id != null) 'id': id?.toJson(),
      'priorityName': priorityName,
      'priority': priority,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PriorityImpl extends Priority {
  _PriorityImpl({
    _i1.UuidValue? id,
    required String priorityName,
    required int priority,
  }) : super._(
         id: id,
         priorityName: priorityName,
         priority: priority,
       );

  /// Returns a shallow copy of this [Priority]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Priority copyWith({
    Object? id = _Undefined,
    String? priorityName,
    int? priority,
  }) {
    return Priority(
      id: id is _i1.UuidValue? ? id : this.id,
      priorityName: priorityName ?? this.priorityName,
      priority: priority ?? this.priority,
    );
  }
}
