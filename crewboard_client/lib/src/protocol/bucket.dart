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
import 'user.dart' as _i2;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i3;

abstract class Bucket implements _i1.SerializableModel {
  Bucket._({
    this.id,
    required this.userId,
    this.user,
    required this.appId,
    required this.bucketName,
  });

  factory Bucket({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    required _i1.UuidValue appId,
    required String bucketName,
  }) = _BucketImpl;

  factory Bucket.fromJson(Map<String, dynamic> jsonSerialization) {
    return Bucket(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.User>(jsonSerialization['user']),
      appId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['appId']),
      bucketName: jsonSerialization['bucketName'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue userId;

  _i2.User? user;

  _i1.UuidValue appId;

  String bucketName;

  /// Returns a shallow copy of this [Bucket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Bucket copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? userId,
    _i2.User? user,
    _i1.UuidValue? appId,
    String? bucketName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Bucket',
      if (id != null) 'id': id?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'appId': appId.toJson(),
      'bucketName': bucketName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BucketImpl extends Bucket {
  _BucketImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    required _i1.UuidValue appId,
    required String bucketName,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         appId: appId,
         bucketName: bucketName,
       );

  /// Returns a shallow copy of this [Bucket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Bucket copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    _i1.UuidValue? appId,
    String? bucketName,
  }) {
    return Bucket(
      id: id is _i1.UuidValue? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      appId: appId ?? this.appId,
      bucketName: bucketName ?? this.bucketName,
    );
  }
}
