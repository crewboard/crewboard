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
    _i1.UuidValue? id,
    required _i1.UuidValue roomId,
    required _i1.UuidValue userId,
    _i1.UuidValue? lastSeenMessageId,
  }) = _UserRoomMapImpl;

  factory UserRoomMap.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserRoomMap(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      roomId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['roomId']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      lastSeenMessageId: jsonSerialization['lastSeenMessageId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['lastSeenMessageId'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue roomId;

  _i1.UuidValue userId;

  _i1.UuidValue? lastSeenMessageId;

  /// Returns a shallow copy of this [UserRoomMap]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserRoomMap copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? roomId,
    _i1.UuidValue? userId,
    _i1.UuidValue? lastSeenMessageId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserRoomMap',
      if (id != null) 'id': id?.toJson(),
      'roomId': roomId.toJson(),
      'userId': userId.toJson(),
      if (lastSeenMessageId != null)
        'lastSeenMessageId': lastSeenMessageId?.toJson(),
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
    _i1.UuidValue? id,
    required _i1.UuidValue roomId,
    required _i1.UuidValue userId,
    _i1.UuidValue? lastSeenMessageId,
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
    _i1.UuidValue? roomId,
    _i1.UuidValue? userId,
    Object? lastSeenMessageId = _Undefined,
  }) {
    return UserRoomMap(
      id: id is _i1.UuidValue? ? id : this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      lastSeenMessageId: lastSeenMessageId is _i1.UuidValue?
          ? lastSeenMessageId
          : this.lastSeenMessageId,
    );
  }
}
