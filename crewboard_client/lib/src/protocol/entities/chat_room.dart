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
import '../entities/chat_message.dart' as _i2;
import '../entities/user.dart' as _i3;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i4;

abstract class ChatRoom implements _i1.SerializableModel {
  ChatRoom._({
    this.id,
    this.roomName,
    required this.roomType,
    this.lastMessageId,
    this.lastMessage,
    required this.messageCount,
    this.roomUsers,
  });

  factory ChatRoom({
    _i1.UuidValue? id,
    String? roomName,
    required String roomType,
    _i1.UuidValue? lastMessageId,
    _i2.ChatMessage? lastMessage,
    required int messageCount,
    List<_i3.User>? roomUsers,
  }) = _ChatRoomImpl;

  factory ChatRoom.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatRoom(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      roomName: jsonSerialization['roomName'] as String?,
      roomType: jsonSerialization['roomType'] as String,
      lastMessageId: jsonSerialization['lastMessageId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['lastMessageId'],
            ),
      lastMessage: jsonSerialization['lastMessage'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.ChatMessage>(
              jsonSerialization['lastMessage'],
            ),
      messageCount: jsonSerialization['messageCount'] as int,
      roomUsers: jsonSerialization['roomUsers'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.User>>(
              jsonSerialization['roomUsers'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  String? roomName;

  String roomType;

  _i1.UuidValue? lastMessageId;

  _i2.ChatMessage? lastMessage;

  int messageCount;

  List<_i3.User>? roomUsers;

  /// Returns a shallow copy of this [ChatRoom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatRoom copyWith({
    _i1.UuidValue? id,
    String? roomName,
    String? roomType,
    _i1.UuidValue? lastMessageId,
    _i2.ChatMessage? lastMessage,
    int? messageCount,
    List<_i3.User>? roomUsers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatRoom',
      if (id != null) 'id': id?.toJson(),
      if (roomName != null) 'roomName': roomName,
      'roomType': roomType,
      if (lastMessageId != null) 'lastMessageId': lastMessageId?.toJson(),
      if (lastMessage != null) 'lastMessage': lastMessage?.toJson(),
      'messageCount': messageCount,
      if (roomUsers != null)
        'roomUsers': roomUsers?.toJson(valueToJson: (v) => v.toJson()),
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
    _i1.UuidValue? id,
    String? roomName,
    required String roomType,
    _i1.UuidValue? lastMessageId,
    _i2.ChatMessage? lastMessage,
    required int messageCount,
    List<_i3.User>? roomUsers,
  }) : super._(
         id: id,
         roomName: roomName,
         roomType: roomType,
         lastMessageId: lastMessageId,
         lastMessage: lastMessage,
         messageCount: messageCount,
         roomUsers: roomUsers,
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
    Object? lastMessage = _Undefined,
    int? messageCount,
    Object? roomUsers = _Undefined,
  }) {
    return ChatRoom(
      id: id is _i1.UuidValue? ? id : this.id,
      roomName: roomName is String? ? roomName : this.roomName,
      roomType: roomType ?? this.roomType,
      lastMessageId: lastMessageId is _i1.UuidValue?
          ? lastMessageId
          : this.lastMessageId,
      lastMessage: lastMessage is _i2.ChatMessage?
          ? lastMessage
          : this.lastMessage?.copyWith(),
      messageCount: messageCount ?? this.messageCount,
      roomUsers: roomUsers is List<_i3.User>?
          ? roomUsers
          : this.roomUsers?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
