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

abstract class PlannerActivity implements _i1.SerializableModel {
  PlannerActivity._({
    this.id,
    required this.ticketId,
    required this.ticketName,
    required this.userName,
    this.userColor,
    required this.action,
    this.details,
    required this.createdAt,
  });

  factory PlannerActivity({
    _i1.UuidValue? id,
    required _i1.UuidValue ticketId,
    required String ticketName,
    required String userName,
    String? userColor,
    required String action,
    String? details,
    required DateTime createdAt,
  }) = _PlannerActivityImpl;

  factory PlannerActivity.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlannerActivity(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ticketId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['ticketId'],
      ),
      ticketName: jsonSerialization['ticketName'] as String,
      userName: jsonSerialization['userName'] as String,
      userColor: jsonSerialization['userColor'] as String?,
      action: jsonSerialization['action'] as String,
      details: jsonSerialization['details'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue ticketId;

  String ticketName;

  String userName;

  String? userColor;

  String action;

  String? details;

  DateTime createdAt;

  /// Returns a shallow copy of this [PlannerActivity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlannerActivity copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? ticketId,
    String? ticketName,
    String? userName,
    String? userColor,
    String? action,
    String? details,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlannerActivity',
      if (id != null) 'id': id?.toJson(),
      'ticketId': ticketId.toJson(),
      'ticketName': ticketName,
      'userName': userName,
      if (userColor != null) 'userColor': userColor,
      'action': action,
      if (details != null) 'details': details,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlannerActivityImpl extends PlannerActivity {
  _PlannerActivityImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue ticketId,
    required String ticketName,
    required String userName,
    String? userColor,
    required String action,
    String? details,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ticketId: ticketId,
         ticketName: ticketName,
         userName: userName,
         userColor: userColor,
         action: action,
         details: details,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PlannerActivity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlannerActivity copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? ticketId,
    String? ticketName,
    String? userName,
    Object? userColor = _Undefined,
    String? action,
    Object? details = _Undefined,
    DateTime? createdAt,
  }) {
    return PlannerActivity(
      id: id is _i1.UuidValue? ? id : this.id,
      ticketId: ticketId ?? this.ticketId,
      ticketName: ticketName ?? this.ticketName,
      userName: userName ?? this.userName,
      userColor: userColor is String? ? userColor : this.userColor,
      action: action ?? this.action,
      details: details is String? ? details : this.details,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
