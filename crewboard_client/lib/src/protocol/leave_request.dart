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
import 'user.dart' as _i2;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i3;

abstract class LeaveRequest implements _i1.SerializableModel {
  LeaveRequest._({
    this.id,
    required this.userId,
    this.user,
    required this.request,
    this.accepted,
    this.date,
  });

  factory LeaveRequest({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    required String request,
    bool? accepted,
    DateTime? date,
  }) = _LeaveRequestImpl;

  factory LeaveRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeaveRequest(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.User>(jsonSerialization['user']),
      request: jsonSerialization['request'] as String,
      accepted: jsonSerialization['accepted'] as bool?,
      date: jsonSerialization['date'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue userId;

  _i2.User? user;

  String request;

  bool? accepted;

  DateTime? date;

  /// Returns a shallow copy of this [LeaveRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LeaveRequest copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? userId,
    _i2.User? user,
    String? request,
    bool? accepted,
    DateTime? date,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeaveRequest',
      if (id != null) 'id': id?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'request': request,
      if (accepted != null) 'accepted': accepted,
      if (date != null) 'date': date?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LeaveRequestImpl extends LeaveRequest {
  _LeaveRequestImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    required String request,
    bool? accepted,
    DateTime? date,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         request: request,
         accepted: accepted,
         date: date,
       );

  /// Returns a shallow copy of this [LeaveRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LeaveRequest copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    String? request,
    Object? accepted = _Undefined,
    Object? date = _Undefined,
  }) {
    return LeaveRequest(
      id: id is _i1.UuidValue? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      request: request ?? this.request,
      accepted: accepted is bool? ? accepted : this.accepted,
      date: date is DateTime? ? date : this.date,
    );
  }
}
