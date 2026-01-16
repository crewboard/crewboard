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

abstract class ThreadItemModel implements _i1.SerializableModel {
  ThreadItemModel._({
    required this.id,
    required this.userId,
    required this.userName,
    this.userColor,
    this.message,
    this.oldStatus,
    this.newStatus,
    required this.createdAt,
    this.action,
    this.details,
    required this.type,
  });

  factory ThreadItemModel({
    required _i1.UuidValue id,
    required _i1.UuidValue userId,
    required String userName,
    String? userColor,
    String? message,
    String? oldStatus,
    String? newStatus,
    required String createdAt,
    String? action,
    String? details,
    required String type,
  }) = _ThreadItemModelImpl;

  factory ThreadItemModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return ThreadItemModel(
      id: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      userName: jsonSerialization['userName'] as String,
      userColor: jsonSerialization['userColor'] as String?,
      message: jsonSerialization['message'] as String?,
      oldStatus: jsonSerialization['oldStatus'] as String?,
      newStatus: jsonSerialization['newStatus'] as String?,
      createdAt: jsonSerialization['createdAt'] as String,
      action: jsonSerialization['action'] as String?,
      details: jsonSerialization['details'] as String?,
      type: jsonSerialization['type'] as String,
    );
  }

  _i1.UuidValue id;

  _i1.UuidValue userId;

  String userName;

  String? userColor;

  String? message;

  String? oldStatus;

  String? newStatus;

  String createdAt;

  String? action;

  String? details;

  String type;

  /// Returns a shallow copy of this [ThreadItemModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ThreadItemModel copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? userId,
    String? userName,
    String? userColor,
    String? message,
    String? oldStatus,
    String? newStatus,
    String? createdAt,
    String? action,
    String? details,
    String? type,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ThreadItemModel',
      'id': id.toJson(),
      'userId': userId.toJson(),
      'userName': userName,
      if (userColor != null) 'userColor': userColor,
      if (message != null) 'message': message,
      if (oldStatus != null) 'oldStatus': oldStatus,
      if (newStatus != null) 'newStatus': newStatus,
      'createdAt': createdAt,
      if (action != null) 'action': action,
      if (details != null) 'details': details,
      'type': type,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ThreadItemModelImpl extends ThreadItemModel {
  _ThreadItemModelImpl({
    required _i1.UuidValue id,
    required _i1.UuidValue userId,
    required String userName,
    String? userColor,
    String? message,
    String? oldStatus,
    String? newStatus,
    required String createdAt,
    String? action,
    String? details,
    required String type,
  }) : super._(
         id: id,
         userId: userId,
         userName: userName,
         userColor: userColor,
         message: message,
         oldStatus: oldStatus,
         newStatus: newStatus,
         createdAt: createdAt,
         action: action,
         details: details,
         type: type,
       );

  /// Returns a shallow copy of this [ThreadItemModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ThreadItemModel copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? userId,
    String? userName,
    Object? userColor = _Undefined,
    Object? message = _Undefined,
    Object? oldStatus = _Undefined,
    Object? newStatus = _Undefined,
    String? createdAt,
    Object? action = _Undefined,
    Object? details = _Undefined,
    String? type,
  }) {
    return ThreadItemModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userColor: userColor is String? ? userColor : this.userColor,
      message: message is String? ? message : this.message,
      oldStatus: oldStatus is String? ? oldStatus : this.oldStatus,
      newStatus: newStatus is String? ? newStatus : this.newStatus,
      createdAt: createdAt ?? this.createdAt,
      action: action is String? ? action : this.action,
      details: details is String? ? details : this.details,
      type: type ?? this.type,
    );
  }
}
