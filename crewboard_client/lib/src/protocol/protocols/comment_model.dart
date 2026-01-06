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

abstract class CommentModel implements _i1.SerializableModel {
  CommentModel._({
    required this.commentId,
    required this.userId,
    required this.userName,
    required this.message,
    required this.createdAt,
    this.userColor,
  });

  factory CommentModel({
    required _i1.UuidValue commentId,
    required _i1.UuidValue userId,
    required String userName,
    required String message,
    required String createdAt,
    String? userColor,
  }) = _CommentModelImpl;

  factory CommentModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommentModel(
      commentId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['commentId'],
      ),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      userName: jsonSerialization['userName'] as String,
      message: jsonSerialization['message'] as String,
      createdAt: jsonSerialization['createdAt'] as String,
      userColor: jsonSerialization['userColor'] as String?,
    );
  }

  _i1.UuidValue commentId;

  _i1.UuidValue userId;

  String userName;

  String message;

  String createdAt;

  String? userColor;

  /// Returns a shallow copy of this [CommentModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CommentModel copyWith({
    _i1.UuidValue? commentId,
    _i1.UuidValue? userId,
    String? userName,
    String? message,
    String? createdAt,
    String? userColor,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CommentModel',
      'commentId': commentId.toJson(),
      'userId': userId.toJson(),
      'userName': userName,
      'message': message,
      'createdAt': createdAt,
      if (userColor != null) 'userColor': userColor,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CommentModelImpl extends CommentModel {
  _CommentModelImpl({
    required _i1.UuidValue commentId,
    required _i1.UuidValue userId,
    required String userName,
    required String message,
    required String createdAt,
    String? userColor,
  }) : super._(
         commentId: commentId,
         userId: userId,
         userName: userName,
         message: message,
         createdAt: createdAt,
         userColor: userColor,
       );

  /// Returns a shallow copy of this [CommentModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CommentModel copyWith({
    _i1.UuidValue? commentId,
    _i1.UuidValue? userId,
    String? userName,
    String? message,
    String? createdAt,
    Object? userColor = _Undefined,
  }) {
    return CommentModel(
      commentId: commentId ?? this.commentId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      userColor: userColor is String? ? userColor : this.userColor,
    );
  }
}
