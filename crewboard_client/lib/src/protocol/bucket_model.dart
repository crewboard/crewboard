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
import 'planner_ticket.dart' as _i2;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i3;

abstract class BucketModel implements _i1.SerializableModel {
  BucketModel._({
    required this.bucketId,
    required this.bucketName,
    required this.tickets,
    this.isDefault,
  });

  factory BucketModel({
    required _i1.UuidValue bucketId,
    required String bucketName,
    required List<_i2.PlannerTicket> tickets,
    bool? isDefault,
  }) = _BucketModelImpl;

  factory BucketModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return BucketModel(
      bucketId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['bucketId'],
      ),
      bucketName: jsonSerialization['bucketName'] as String,
      tickets: _i3.Protocol().deserialize<List<_i2.PlannerTicket>>(
        jsonSerialization['tickets'],
      ),
      isDefault: jsonSerialization['isDefault'] as bool?,
    );
  }

  _i1.UuidValue bucketId;

  String bucketName;

  List<_i2.PlannerTicket> tickets;

  bool? isDefault;

  /// Returns a shallow copy of this [BucketModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BucketModel copyWith({
    _i1.UuidValue? bucketId,
    String? bucketName,
    List<_i2.PlannerTicket>? tickets,
    bool? isDefault,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BucketModel',
      'bucketId': bucketId.toJson(),
      'bucketName': bucketName,
      'tickets': tickets.toJson(valueToJson: (v) => v.toJson()),
      if (isDefault != null) 'isDefault': isDefault,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BucketModelImpl extends BucketModel {
  _BucketModelImpl({
    required _i1.UuidValue bucketId,
    required String bucketName,
    required List<_i2.PlannerTicket> tickets,
    bool? isDefault,
  }) : super._(
         bucketId: bucketId,
         bucketName: bucketName,
         tickets: tickets,
         isDefault: isDefault,
       );

  /// Returns a shallow copy of this [BucketModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BucketModel copyWith({
    _i1.UuidValue? bucketId,
    String? bucketName,
    List<_i2.PlannerTicket>? tickets,
    Object? isDefault = _Undefined,
  }) {
    return BucketModel(
      bucketId: bucketId ?? this.bucketId,
      bucketName: bucketName ?? this.bucketName,
      tickets: tickets ?? this.tickets.map((e0) => e0.copyWith()).toList(),
      isDefault: isDefault is bool? ? isDefault : this.isDefault,
    );
  }
}
