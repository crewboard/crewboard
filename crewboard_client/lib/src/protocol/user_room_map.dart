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

abstract class UserRoomMap implements _i1.SerializableModel {
  UserRoomMap._({
    this.id,
    required this.roomId,
    required this.userId,
    this.lastSeenMessageId,
  });

  factory UserRoomMap({
    int? id,
    required int roomId,
    required int userId,
    int? lastSeenMessageId,
  }) = _UserRoomMapImpl;

  factory UserRoomMap.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserRoomMap(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      userId: jsonSerialization['userId'] as int,
      lastSeenMessageId: jsonSerialization['lastSeenMessageId'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomId;

  int userId;

  int? lastSeenMessageId;

  /// Returns a shallow copy of this [UserRoomMap]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserRoomMap copyWith({
    int? id,
    int? roomId,
    int? userId,
    int? lastSeenMessageId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserRoomMap',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      if (lastSeenMessageId != null) 'lastSeenMessageId': lastSeenMessageId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserRoomMapImpl extends UserRoomMap {
  _UserRoomMapImpl({
    int? id,
    required int roomId,
    required int userId,
    int? lastSeenMessageId,
  }) : super._(
         id: id,
         roomId: roomId,
         userId: userId,
         lastSeenMessageId: lastSeenMessageId,
       );

  /// Returns a shallow copy of this [UserRoomMap]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserRoomMap copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? userId,
    Object? lastSeenMessageId = _Undefined,
  }) {
    return UserRoomMap(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      lastSeenMessageId: lastSeenMessageId is int?
          ? lastSeenMessageId
          : this.lastSeenMessageId,
    );
  }
}
