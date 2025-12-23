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
  });

  factory CommentModel({
    required int commentId,
    required int userId,
    required String userName,
    required String message,
    required String createdAt,
  }) = _CommentModelImpl;

  factory CommentModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return CommentModel(
      commentId: jsonSerialization['commentId'] as int,
      userId: jsonSerialization['userId'] as int,
      userName: jsonSerialization['userName'] as String,
      message: jsonSerialization['message'] as String,
      createdAt: jsonSerialization['createdAt'] as String,
    );
  }

  int commentId;

  int userId;

  String userName;

  String message;

  String createdAt;

  /// Returns a shallow copy of this [CommentModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CommentModel copyWith({
    int? commentId,
    int? userId,
    String? userName,
    String? message,
    String? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CommentModel',
      'commentId': commentId,
      'userId': userId,
      'userName': userName,
      'message': message,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CommentModelImpl extends CommentModel {
  _CommentModelImpl({
    required int commentId,
    required int userId,
    required String userName,
    required String message,
    required String createdAt,
  }) : super._(
         commentId: commentId,
         userId: userId,
         userName: userName,
         message: message,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CommentModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CommentModel copyWith({
    int? commentId,
    int? userId,
    String? userName,
    String? message,
    String? createdAt,
  }) {
    return CommentModel(
      commentId: commentId ?? this.commentId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
