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

abstract class UserBreak implements _i1.SerializableModel {
  UserBreak._({
    this.id,
    required this.userId,
    this.user,
    this.breakStart,
    this.breakEnd,
    this.breakTime,
    required this.date,
  });

  factory UserBreak({
    int? id,
    required int userId,
    _i2.User? user,
    String? breakStart,
    String? breakEnd,
    int? breakTime,
    required DateTime date,
  }) = _UserBreakImpl;

  factory UserBreak.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserBreak(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.User>(jsonSerialization['user']),
      breakStart: jsonSerialization['breakStart'] as String?,
      breakEnd: jsonSerialization['breakEnd'] as String?,
      breakTime: jsonSerialization['breakTime'] as int?,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  _i2.User? user;

  String? breakStart;

  String? breakEnd;

  int? breakTime;

  DateTime date;

  /// Returns a shallow copy of this [UserBreak]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserBreak copyWith({
    int? id,
    int? userId,
    _i2.User? user,
    String? breakStart,
    String? breakEnd,
    int? breakTime,
    DateTime? date,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserBreak',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      if (breakStart != null) 'breakStart': breakStart,
      if (breakEnd != null) 'breakEnd': breakEnd,
      if (breakTime != null) 'breakTime': breakTime,
      'date': date.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserBreakImpl extends UserBreak {
  _UserBreakImpl({
    int? id,
    required int userId,
    _i2.User? user,
    String? breakStart,
    String? breakEnd,
    int? breakTime,
    required DateTime date,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         breakStart: breakStart,
         breakEnd: breakEnd,
         breakTime: breakTime,
         date: date,
       );

  /// Returns a shallow copy of this [UserBreak]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserBreak copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    Object? breakStart = _Undefined,
    Object? breakEnd = _Undefined,
    Object? breakTime = _Undefined,
    DateTime? date,
  }) {
    return UserBreak(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      breakStart: breakStart is String? ? breakStart : this.breakStart,
      breakEnd: breakEnd is String? ? breakEnd : this.breakEnd,
      breakTime: breakTime is int? ? breakTime : this.breakTime,
      date: date ?? this.date,
    );
  }
}
