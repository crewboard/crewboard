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

abstract class ChangeBucketRequest implements _i1.SerializableModel {
  ChangeBucketRequest._({
    required this.ticketId,
    required this.oldBucketId,
    required this.newBucketId,
    required this.newOrder,
  });

  factory ChangeBucketRequest({
    required _i1.UuidValue ticketId,
    required _i1.UuidValue oldBucketId,
    required _i1.UuidValue newBucketId,
    required int newOrder,
  }) = _ChangeBucketRequestImpl;

  factory ChangeBucketRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChangeBucketRequest(
      ticketId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['ticketId'],
      ),
      oldBucketId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['oldBucketId'],
      ),
      newBucketId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['newBucketId'],
      ),
      newOrder: jsonSerialization['newOrder'] as int,
    );
  }

  _i1.UuidValue ticketId;

  _i1.UuidValue oldBucketId;

  _i1.UuidValue newBucketId;

  int newOrder;

  /// Returns a shallow copy of this [ChangeBucketRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChangeBucketRequest copyWith({
    _i1.UuidValue? ticketId,
    _i1.UuidValue? oldBucketId,
    _i1.UuidValue? newBucketId,
    int? newOrder,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChangeBucketRequest',
      'ticketId': ticketId.toJson(),
      'oldBucketId': oldBucketId.toJson(),
      'newBucketId': newBucketId.toJson(),
      'newOrder': newOrder,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ChangeBucketRequestImpl extends ChangeBucketRequest {
  _ChangeBucketRequestImpl({
    required _i1.UuidValue ticketId,
    required _i1.UuidValue oldBucketId,
    required _i1.UuidValue newBucketId,
    required int newOrder,
  }) : super._(
         ticketId: ticketId,
         oldBucketId: oldBucketId,
         newBucketId: newBucketId,
         newOrder: newOrder,
       );

  /// Returns a shallow copy of this [ChangeBucketRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChangeBucketRequest copyWith({
    _i1.UuidValue? ticketId,
    _i1.UuidValue? oldBucketId,
    _i1.UuidValue? newBucketId,
    int? newOrder,
  }) {
    return ChangeBucketRequest(
      ticketId: ticketId ?? this.ticketId,
      oldBucketId: oldBucketId ?? this.oldBucketId,
      newBucketId: newBucketId ?? this.newBucketId,
      newOrder: newOrder ?? this.newOrder,
    );
  }
}
