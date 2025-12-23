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
import 'bucket.dart' as _i2;
import 'ticket.dart' as _i3;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i4;

abstract class BucketTicketMap implements _i1.SerializableModel {
  BucketTicketMap._({
    this.id,
    required this.bucketId,
    this.bucket,
    required this.ticketId,
    this.ticket,
    required this.order,
  });

  factory BucketTicketMap({
    int? id,
    required int bucketId,
    _i2.Bucket? bucket,
    required int ticketId,
    _i3.Ticket? ticket,
    required int order,
  }) = _BucketTicketMapImpl;

  factory BucketTicketMap.fromJson(Map<String, dynamic> jsonSerialization) {
    return BucketTicketMap(
      id: jsonSerialization['id'] as int?,
      bucketId: jsonSerialization['bucketId'] as int,
      bucket: jsonSerialization['bucket'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Bucket>(jsonSerialization['bucket']),
      ticketId: jsonSerialization['ticketId'] as int,
      ticket: jsonSerialization['ticket'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Ticket>(jsonSerialization['ticket']),
      order: jsonSerialization['order'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int bucketId;

  _i2.Bucket? bucket;

  int ticketId;

  _i3.Ticket? ticket;

  int order;

  /// Returns a shallow copy of this [BucketTicketMap]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BucketTicketMap copyWith({
    int? id,
    int? bucketId,
    _i2.Bucket? bucket,
    int? ticketId,
    _i3.Ticket? ticket,
    int? order,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BucketTicketMap',
      if (id != null) 'id': id,
      'bucketId': bucketId,
      if (bucket != null) 'bucket': bucket?.toJson(),
      'ticketId': ticketId,
      if (ticket != null) 'ticket': ticket?.toJson(),
      'order': order,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BucketTicketMapImpl extends BucketTicketMap {
  _BucketTicketMapImpl({
    int? id,
    required int bucketId,
    _i2.Bucket? bucket,
    required int ticketId,
    _i3.Ticket? ticket,
    required int order,
  }) : super._(
         id: id,
         bucketId: bucketId,
         bucket: bucket,
         ticketId: ticketId,
         ticket: ticket,
         order: order,
       );

  /// Returns a shallow copy of this [BucketTicketMap]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BucketTicketMap copyWith({
    Object? id = _Undefined,
    int? bucketId,
    Object? bucket = _Undefined,
    int? ticketId,
    Object? ticket = _Undefined,
    int? order,
  }) {
    return BucketTicketMap(
      id: id is int? ? id : this.id,
      bucketId: bucketId ?? this.bucketId,
      bucket: bucket is _i2.Bucket? ? bucket : this.bucket?.copyWith(),
      ticketId: ticketId ?? this.ticketId,
      ticket: ticket is _i3.Ticket? ? ticket : this.ticket?.copyWith(),
      order: order ?? this.order,
    );
  }
}
