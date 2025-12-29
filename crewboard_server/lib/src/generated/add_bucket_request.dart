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

abstract class AddBucketRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AddBucketRequest._({
    required this.appId,
    required this.bucketName,
  });

  factory AddBucketRequest({
    required _i1.UuidValue appId,
    required String bucketName,
  }) = _AddBucketRequestImpl;

  factory AddBucketRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return AddBucketRequest(
      appId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['appId']),
      bucketName: jsonSerialization['bucketName'] as String,
    );
  }

  _i1.UuidValue appId;

  String bucketName;

  /// Returns a shallow copy of this [AddBucketRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AddBucketRequest copyWith({
    _i1.UuidValue? appId,
    String? bucketName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AddBucketRequest',
      'appId': appId.toJson(),
      'bucketName': bucketName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AddBucketRequest',
      'appId': appId.toJson(),
      'bucketName': bucketName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AddBucketRequestImpl extends AddBucketRequest {
  _AddBucketRequestImpl({
    required _i1.UuidValue appId,
    required String bucketName,
  }) : super._(
         appId: appId,
         bucketName: bucketName,
       );

  /// Returns a shallow copy of this [AddBucketRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AddBucketRequest copyWith({
    _i1.UuidValue? appId,
    String? bucketName,
  }) {
    return AddBucketRequest(
      appId: appId ?? this.appId,
      bucketName: bucketName ?? this.bucketName,
    );
  }
}
