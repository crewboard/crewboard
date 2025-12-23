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

abstract class AddCommentRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AddCommentRequest._({
    required this.ticketId,
    required this.message,
  });

  factory AddCommentRequest({
    required int ticketId,
    required String message,
  }) = _AddCommentRequestImpl;

  factory AddCommentRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return AddCommentRequest(
      ticketId: jsonSerialization['ticketId'] as int,
      message: jsonSerialization['message'] as String,
    );
  }

  int ticketId;

  String message;

  /// Returns a shallow copy of this [AddCommentRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AddCommentRequest copyWith({
    int? ticketId,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AddCommentRequest',
      'ticketId': ticketId,
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AddCommentRequest',
      'ticketId': ticketId,
      'message': message,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AddCommentRequestImpl extends AddCommentRequest {
  _AddCommentRequestImpl({
    required int ticketId,
    required String message,
  }) : super._(
         ticketId: ticketId,
         message: message,
       );

  /// Returns a shallow copy of this [AddCommentRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AddCommentRequest copyWith({
    int? ticketId,
    String? message,
  }) {
    return AddCommentRequest(
      ticketId: ticketId ?? this.ticketId,
      message: message ?? this.message,
    );
  }
}
