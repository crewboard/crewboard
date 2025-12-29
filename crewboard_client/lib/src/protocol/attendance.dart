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

abstract class Attendance implements _i1.SerializableModel {
  Attendance._({
    this.id,
    required this.userId,
    this.user,
    this.inTime,
    this.outTime,
    this.inTimeStatus,
    this.outTimeStatus,
    this.overTime,
    this.earlyTime,
    required this.date,
  });

  factory Attendance({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    String? inTime,
    String? outTime,
    String? inTimeStatus,
    String? outTimeStatus,
    String? overTime,
    String? earlyTime,
    required DateTime date,
  }) = _AttendanceImpl;

  factory Attendance.fromJson(Map<String, dynamic> jsonSerialization) {
    return Attendance(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.User>(jsonSerialization['user']),
      inTime: jsonSerialization['inTime'] as String?,
      outTime: jsonSerialization['outTime'] as String?,
      inTimeStatus: jsonSerialization['inTimeStatus'] as String?,
      outTimeStatus: jsonSerialization['outTimeStatus'] as String?,
      overTime: jsonSerialization['overTime'] as String?,
      earlyTime: jsonSerialization['earlyTime'] as String?,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue userId;

  _i2.User? user;

  String? inTime;

  String? outTime;

  String? inTimeStatus;

  String? outTimeStatus;

  String? overTime;

  String? earlyTime;

  DateTime date;

  /// Returns a shallow copy of this [Attendance]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Attendance copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? userId,
    _i2.User? user,
    String? inTime,
    String? outTime,
    String? inTimeStatus,
    String? outTimeStatus,
    String? overTime,
    String? earlyTime,
    DateTime? date,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Attendance',
      if (id != null) 'id': id?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      if (inTime != null) 'inTime': inTime,
      if (outTime != null) 'outTime': outTime,
      if (inTimeStatus != null) 'inTimeStatus': inTimeStatus,
      if (outTimeStatus != null) 'outTimeStatus': outTimeStatus,
      if (overTime != null) 'overTime': overTime,
      if (earlyTime != null) 'earlyTime': earlyTime,
      'date': date.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AttendanceImpl extends Attendance {
  _AttendanceImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    String? inTime,
    String? outTime,
    String? inTimeStatus,
    String? outTimeStatus,
    String? overTime,
    String? earlyTime,
    required DateTime date,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         inTime: inTime,
         outTime: outTime,
         inTimeStatus: inTimeStatus,
         outTimeStatus: outTimeStatus,
         overTime: overTime,
         earlyTime: earlyTime,
         date: date,
       );

  /// Returns a shallow copy of this [Attendance]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Attendance copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    Object? inTime = _Undefined,
    Object? outTime = _Undefined,
    Object? inTimeStatus = _Undefined,
    Object? outTimeStatus = _Undefined,
    Object? overTime = _Undefined,
    Object? earlyTime = _Undefined,
    DateTime? date,
  }) {
    return Attendance(
      id: id is _i1.UuidValue? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      inTime: inTime is String? ? inTime : this.inTime,
      outTime: outTime is String? ? outTime : this.outTime,
      inTimeStatus: inTimeStatus is String? ? inTimeStatus : this.inTimeStatus,
      outTimeStatus: outTimeStatus is String?
          ? outTimeStatus
          : this.outTimeStatus,
      overTime: overTime is String? ? overTime : this.overTime,
      earlyTime: earlyTime is String? ? earlyTime : this.earlyTime,
      date: date ?? this.date,
    );
  }
}
