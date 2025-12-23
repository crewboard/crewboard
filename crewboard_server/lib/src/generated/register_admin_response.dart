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

abstract class RegisterAdminResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  RegisterAdminResponse._({
    required this.success,
    required this.message,
    this.userId,
  });

  factory RegisterAdminResponse({
    required bool success,
    required String message,
    String? userId,
  }) = _RegisterAdminResponseImpl;

  factory RegisterAdminResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return RegisterAdminResponse(
      success: jsonSerialization['success'] as bool,
      message: jsonSerialization['message'] as String,
      userId: jsonSerialization['userId'] as String?,
    );
  }

  bool success;

  String message;

  String? userId;

  /// Returns a shallow copy of this [RegisterAdminResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RegisterAdminResponse copyWith({
    bool? success,
    String? message,
    String? userId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RegisterAdminResponse',
      'success': success,
      'message': message,
      if (userId != null) 'userId': userId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RegisterAdminResponse',
      'success': success,
      'message': message,
      if (userId != null) 'userId': userId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RegisterAdminResponseImpl extends RegisterAdminResponse {
  _RegisterAdminResponseImpl({
    required bool success,
    required String message,
    String? userId,
  }) : super._(
         success: success,
         message: message,
         userId: userId,
       );

  /// Returns a shallow copy of this [RegisterAdminResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RegisterAdminResponse copyWith({
    bool? success,
    String? message,
    Object? userId = _Undefined,
  }) {
    return RegisterAdminResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      userId: userId is String? ? userId : this.userId,
    );
  }
}
