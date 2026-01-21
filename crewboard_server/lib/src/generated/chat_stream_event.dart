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
import 'package:serverpod/serverpod.dart' as _i1;
import 'entities/chat_message.dart' as _i2;
import 'typing_indicator.dart' as _i3;
import 'package:crewboard_server/src/generated/protocol.dart' as _i4;

abstract class ChatStreamEvent
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ChatStreamEvent._({
    this.message,
    this.typing,
  });

  factory ChatStreamEvent({
    _i2.ChatMessage? message,
    _i3.TypingIndicator? typing,
  }) = _ChatStreamEventImpl;

  factory ChatStreamEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatStreamEvent(
      message: jsonSerialization['message'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.ChatMessage>(
              jsonSerialization['message'],
            ),
      typing: jsonSerialization['typing'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.TypingIndicator>(
              jsonSerialization['typing'],
            ),
    );
  }

  _i2.ChatMessage? message;

  _i3.TypingIndicator? typing;

  /// Returns a shallow copy of this [ChatStreamEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatStreamEvent copyWith({
    _i2.ChatMessage? message,
    _i3.TypingIndicator? typing,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatStreamEvent',
      if (message != null) 'message': message?.toJson(),
      if (typing != null) 'typing': typing?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatStreamEvent',
      if (message != null) 'message': message?.toJsonForProtocol(),
      if (typing != null) 'typing': typing?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatStreamEventImpl extends ChatStreamEvent {
  _ChatStreamEventImpl({
    _i2.ChatMessage? message,
    _i3.TypingIndicator? typing,
  }) : super._(
         message: message,
         typing: typing,
       );

  /// Returns a shallow copy of this [ChatStreamEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatStreamEvent copyWith({
    Object? message = _Undefined,
    Object? typing = _Undefined,
  }) {
    return ChatStreamEvent(
      message: message is _i2.ChatMessage? ? message : this.message?.copyWith(),
      typing: typing is _i3.TypingIndicator? ? typing : this.typing?.copyWith(),
    );
  }
}
