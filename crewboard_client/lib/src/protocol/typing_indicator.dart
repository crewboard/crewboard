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

abstract class TypingIndicator implements _i1.SerializableModel {
  TypingIndicator._({
    required this.userId,
    required this.roomId,
    required this.isTyping,
    required this.userName,
  });

  factory TypingIndicator({
    required _i1.UuidValue userId,
    required _i1.UuidValue roomId,
    required bool isTyping,
    required String userName,
  }) = _TypingIndicatorImpl;

  factory TypingIndicator.fromJson(Map<String, dynamic> jsonSerialization) {
    return TypingIndicator(
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      roomId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['roomId']),
      isTyping: jsonSerialization['isTyping'] as bool,
      userName: jsonSerialization['userName'] as String,
    );
  }

  _i1.UuidValue userId;

  _i1.UuidValue roomId;

  bool isTyping;

  String userName;

  /// Returns a shallow copy of this [TypingIndicator]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TypingIndicator copyWith({
    _i1.UuidValue? userId,
    _i1.UuidValue? roomId,
    bool? isTyping,
    String? userName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TypingIndicator',
      'userId': userId.toJson(),
      'roomId': roomId.toJson(),
      'isTyping': isTyping,
      'userName': userName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TypingIndicatorImpl extends TypingIndicator {
  _TypingIndicatorImpl({
    required _i1.UuidValue userId,
    required _i1.UuidValue roomId,
    required bool isTyping,
    required String userName,
  }) : super._(
         userId: userId,
         roomId: roomId,
         isTyping: isTyping,
         userName: userName,
       );

  /// Returns a shallow copy of this [TypingIndicator]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TypingIndicator copyWith({
    _i1.UuidValue? userId,
    _i1.UuidValue? roomId,
    bool? isTyping,
    String? userName,
  }) {
    return TypingIndicator(
      userId: userId ?? this.userId,
      roomId: roomId ?? this.roomId,
      isTyping: isTyping ?? this.isTyping,
      userName: userName ?? this.userName,
    );
  }
}
