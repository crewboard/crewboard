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

abstract class SignInResponse implements _i1.SerializableModel {
  SignInResponse._({
    required this.success,
    required this.message,
    this.userId,
    this.organizationId,
    this.authKeyId,
    this.authToken,
    this.authUserId,
  });

  factory SignInResponse({
    required bool success,
    required String message,
    String? userId,
    String? organizationId,
    int? authKeyId,
    String? authToken,
    String? authUserId,
  }) = _SignInResponseImpl;

  factory SignInResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return SignInResponse(
      success: jsonSerialization['success'] as bool,
      message: jsonSerialization['message'] as String,
      userId: jsonSerialization['userId'] as String?,
      organizationId: jsonSerialization['organizationId'] as String?,
      authKeyId: jsonSerialization['authKeyId'] as int?,
      authToken: jsonSerialization['authToken'] as String?,
      authUserId: jsonSerialization['authUserId'] as String?,
    );
  }

  bool success;

  String message;

  String? userId;

  String? organizationId;

  int? authKeyId;

  String? authToken;

  String? authUserId;

  /// Returns a shallow copy of this [SignInResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SignInResponse copyWith({
    bool? success,
    String? message,
    String? userId,
    String? organizationId,
    int? authKeyId,
    String? authToken,
    String? authUserId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SignInResponse',
      'success': success,
      'message': message,
      if (userId != null) 'userId': userId,
      if (organizationId != null) 'organizationId': organizationId,
      if (authKeyId != null) 'authKeyId': authKeyId,
      if (authToken != null) 'authToken': authToken,
      if (authUserId != null) 'authUserId': authUserId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SignInResponseImpl extends SignInResponse {
  _SignInResponseImpl({
    required bool success,
    required String message,
    String? userId,
    String? organizationId,
    int? authKeyId,
    String? authToken,
    String? authUserId,
  }) : super._(
         success: success,
         message: message,
         userId: userId,
         organizationId: organizationId,
         authKeyId: authKeyId,
         authToken: authToken,
         authUserId: authUserId,
       );

  /// Returns a shallow copy of this [SignInResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SignInResponse copyWith({
    bool? success,
    String? message,
    Object? userId = _Undefined,
    Object? organizationId = _Undefined,
    Object? authKeyId = _Undefined,
    Object? authToken = _Undefined,
    Object? authUserId = _Undefined,
  }) {
    return SignInResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      userId: userId is String? ? userId : this.userId,
      organizationId: organizationId is String?
          ? organizationId
          : this.organizationId,
      authKeyId: authKeyId is int? ? authKeyId : this.authKeyId,
      authToken: authToken is String? ? authToken : this.authToken,
      authUserId: authUserId is String? ? authUserId : this.authUserId,
    );
  }
}
