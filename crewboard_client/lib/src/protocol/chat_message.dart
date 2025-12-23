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
import 'message_type.dart' as _i2;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i3;

abstract class ChatMessage implements _i1.SerializableModel {
  ChatMessage._({
    this.id,
    required this.roomId,
    this.parentMessageId,
    required this.userId,
    required this.message,
    required this.messageType,
    required this.seenUserList,
    required this.sameUser,
    required this.deleted,
    required this.createdAt,
  });

  factory ChatMessage({
    int? id,
    required int roomId,
    int? parentMessageId,
    required int userId,
    required String message,
    required _i2.MessageType messageType,
    required List<int> seenUserList,
    required bool sameUser,
    required bool deleted,
    required DateTime createdAt,
  }) = _ChatMessageImpl;

  factory ChatMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatMessage(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      parentMessageId: jsonSerialization['parentMessageId'] as int?,
      userId: jsonSerialization['userId'] as int,
      message: jsonSerialization['message'] as String,
      messageType: _i2.MessageType.fromJson(
        (jsonSerialization['messageType'] as String),
      ),
      seenUserList: _i3.Protocol().deserialize<List<int>>(
        jsonSerialization['seenUserList'],
      ),
      sameUser: jsonSerialization['sameUser'] as bool,
      deleted: jsonSerialization['deleted'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomId;

  int? parentMessageId;

  int userId;

  String message;

  _i2.MessageType messageType;

  List<int> seenUserList;

  bool sameUser;

  bool deleted;

  DateTime createdAt;

  /// Returns a shallow copy of this [ChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatMessage copyWith({
    int? id,
    int? roomId,
    int? parentMessageId,
    int? userId,
    String? message,
    _i2.MessageType? messageType,
    List<int>? seenUserList,
    bool? sameUser,
    bool? deleted,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatMessage',
      if (id != null) 'id': id,
      'roomId': roomId,
      if (parentMessageId != null) 'parentMessageId': parentMessageId,
      'userId': userId,
      'message': message,
      'messageType': messageType.toJson(),
      'seenUserList': seenUserList.toJson(),
      'sameUser': sameUser,
      'deleted': deleted,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatMessageImpl extends ChatMessage {
  _ChatMessageImpl({
    int? id,
    required int roomId,
    int? parentMessageId,
    required int userId,
    required String message,
    required _i2.MessageType messageType,
    required List<int> seenUserList,
    required bool sameUser,
    required bool deleted,
    required DateTime createdAt,
  }) : super._(
         id: id,
         roomId: roomId,
         parentMessageId: parentMessageId,
         userId: userId,
         message: message,
         messageType: messageType,
         seenUserList: seenUserList,
         sameUser: sameUser,
         deleted: deleted,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatMessage copyWith({
    Object? id = _Undefined,
    int? roomId,
    Object? parentMessageId = _Undefined,
    int? userId,
    String? message,
    _i2.MessageType? messageType,
    List<int>? seenUserList,
    bool? sameUser,
    bool? deleted,
    DateTime? createdAt,
  }) {
    return ChatMessage(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      parentMessageId: parentMessageId is int?
          ? parentMessageId
          : this.parentMessageId,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      messageType: messageType ?? this.messageType,
      seenUserList: seenUserList ?? this.seenUserList.map((e0) => e0).toList(),
      sameUser: sameUser ?? this.sameUser,
      deleted: deleted ?? this.deleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
