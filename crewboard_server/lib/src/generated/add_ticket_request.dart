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
import 'ticket_model.dart' as _i2;
import 'package:crewboard_server/src/generated/protocol.dart' as _i3;

abstract class AddTicketRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AddTicketRequest._({
    required this.appId,
    required this.bucketId,
    required this.ticket,
  });

  factory AddTicketRequest({
    required _i1.UuidValue appId,
    required _i1.UuidValue bucketId,
    required _i2.TicketModel ticket,
  }) = _AddTicketRequestImpl;

  factory AddTicketRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return AddTicketRequest(
      appId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['appId']),
      bucketId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['bucketId'],
      ),
      ticket: _i3.Protocol().deserialize<_i2.TicketModel>(
        jsonSerialization['ticket'],
      ),
    );
  }

  _i1.UuidValue appId;

  _i1.UuidValue bucketId;

  _i2.TicketModel ticket;

  /// Returns a shallow copy of this [AddTicketRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AddTicketRequest copyWith({
    _i1.UuidValue? appId,
    _i1.UuidValue? bucketId,
    _i2.TicketModel? ticket,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AddTicketRequest',
      'appId': appId.toJson(),
      'bucketId': bucketId.toJson(),
      'ticket': ticket.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AddTicketRequest',
      'appId': appId.toJson(),
      'bucketId': bucketId.toJson(),
      'ticket': ticket.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AddTicketRequestImpl extends AddTicketRequest {
  _AddTicketRequestImpl({
    required _i1.UuidValue appId,
    required _i1.UuidValue bucketId,
    required _i2.TicketModel ticket,
  }) : super._(
         appId: appId,
         bucketId: bucketId,
         ticket: ticket,
       );

  /// Returns a shallow copy of this [AddTicketRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AddTicketRequest copyWith({
    _i1.UuidValue? appId,
    _i1.UuidValue? bucketId,
    _i2.TicketModel? ticket,
  }) {
    return AddTicketRequest(
      appId: appId ?? this.appId,
      bucketId: bucketId ?? this.bucketId,
      ticket: ticket ?? this.ticket.copyWith(),
    );
  }
}
