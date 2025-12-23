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

abstract class ChatRoom implements _i1.SerializableModel {
  ChatRoom._({
    this.id,
    this.roomName,
    required this.roomType,
    this.lastMessageId,
    required this.messageCount,
  });

  factory ChatRoom({
    int? id,
    String? roomName,
    required String roomType,
    int? lastMessageId,
    required int messageCount,
  }) = _ChatRoomImpl;

  factory ChatRoom.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatRoom(
      id: jsonSerialization['id'] as int?,
      roomName: jsonSerialization['roomName'] as String?,
      roomType: jsonSerialization['roomType'] as String,
      lastMessageId: jsonSerialization['lastMessageId'] as int?,
      messageCount: jsonSerialization['messageCount'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? roomName;

  String roomType;

  int? lastMessageId;

  int messageCount;

  /// Returns a shallow copy of this [ChatRoom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatRoom copyWith({
    int? id,
    String? roomName,
    String? roomType,
    int? lastMessageId,
    int? messageCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatRoom',
      if (id != null) 'id': id,
      if (roomName != null) 'roomName': roomName,
      'roomType': roomType,
      if (lastMessageId != null) 'lastMessageId': lastMessageId,
      'messageCount': messageCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatRoomImpl extends ChatRoom {
  _ChatRoomImpl({
    int? id,
    String? roomName,
    required String roomType,
    int? lastMessageId,
    required int messageCount,
  }) : super._(
         id: id,
         roomName: roomName,
         roomType: roomType,
         lastMessageId: lastMessageId,
         messageCount: messageCount,
       );

  /// Returns a shallow copy of this [ChatRoom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatRoom copyWith({
    Object? id = _Undefined,
    Object? roomName = _Undefined,
    String? roomType,
    Object? lastMessageId = _Undefined,
    int? messageCount,
  }) {
    return ChatRoom(
      id: id is int? ? id : this.id,
      roomName: roomName is String? ? roomName : this.roomName,
      roomType: roomType ?? this.roomType,
      lastMessageId: lastMessageId is int? ? lastMessageId : this.lastMessageId,
      messageCount: messageCount ?? this.messageCount,
    );
  }
}
