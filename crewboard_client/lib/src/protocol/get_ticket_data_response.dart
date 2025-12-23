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
import 'ticket_model.dart' as _i2;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i3;

abstract class GetTicketDataResponse implements _i1.SerializableModel {
  GetTicketDataResponse._({required this.ticket});

  factory GetTicketDataResponse({required _i2.TicketModel ticket}) =
      _GetTicketDataResponseImpl;

  factory GetTicketDataResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return GetTicketDataResponse(
      ticket: _i3.Protocol().deserialize<_i2.TicketModel>(
        jsonSerialization['ticket'],
      ),
    );
  }

  _i2.TicketModel ticket;

  /// Returns a shallow copy of this [GetTicketDataResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GetTicketDataResponse copyWith({_i2.TicketModel? ticket});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GetTicketDataResponse',
      'ticket': ticket.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GetTicketDataResponseImpl extends GetTicketDataResponse {
  _GetTicketDataResponseImpl({required _i2.TicketModel ticket})
    : super._(ticket: ticket);

  /// Returns a shallow copy of this [GetTicketDataResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GetTicketDataResponse copyWith({_i2.TicketModel? ticket}) {
    return GetTicketDataResponse(ticket: ticket ?? this.ticket.copyWith());
  }
}
