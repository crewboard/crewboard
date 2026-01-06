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
import '../protocols/planner_ticket.dart' as _i2;
import 'package:crewboard_server/src/generated/protocol.dart' as _i3;

abstract class PlannerBucket
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  PlannerBucket._({
    required this.bucketId,
    required this.bucketName,
    required this.tickets,
  });

  factory PlannerBucket({
    required _i1.UuidValue bucketId,
    required String bucketName,
    required List<_i2.PlannerTicket> tickets,
  }) = _PlannerBucketImpl;

  factory PlannerBucket.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlannerBucket(
      bucketId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['bucketId'],
      ),
      bucketName: jsonSerialization['bucketName'] as String,
      tickets: _i3.Protocol().deserialize<List<_i2.PlannerTicket>>(
        jsonSerialization['tickets'],
      ),
    );
  }

  _i1.UuidValue bucketId;

  String bucketName;

  List<_i2.PlannerTicket> tickets;

  /// Returns a shallow copy of this [PlannerBucket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlannerBucket copyWith({
    _i1.UuidValue? bucketId,
    String? bucketName,
    List<_i2.PlannerTicket>? tickets,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlannerBucket',
      'bucketId': bucketId.toJson(),
      'bucketName': bucketName,
      'tickets': tickets.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlannerBucket',
      'bucketId': bucketId.toJson(),
      'bucketName': bucketName,
      'tickets': tickets.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PlannerBucketImpl extends PlannerBucket {
  _PlannerBucketImpl({
    required _i1.UuidValue bucketId,
    required String bucketName,
    required List<_i2.PlannerTicket> tickets,
  }) : super._(
         bucketId: bucketId,
         bucketName: bucketName,
         tickets: tickets,
       );

  /// Returns a shallow copy of this [PlannerBucket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlannerBucket copyWith({
    _i1.UuidValue? bucketId,
    String? bucketName,
    List<_i2.PlannerTicket>? tickets,
  }) {
    return PlannerBucket(
      bucketId: bucketId ?? this.bucketId,
      bucketName: bucketName ?? this.bucketName,
      tickets: tickets ?? this.tickets.map((e0) => e0.copyWith()).toList(),
    );
  }
}
