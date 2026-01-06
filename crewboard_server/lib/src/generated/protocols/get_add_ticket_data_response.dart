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
import '../protocols/user_model.dart' as _i2;
import '../protocols/status_model.dart' as _i3;
import '../protocols/priority_model.dart' as _i4;
import '../protocols/type_model.dart' as _i5;
import '../entities/flow_model.dart' as _i6;
import 'package:crewboard_server/src/generated/protocol.dart' as _i7;

abstract class GetAddTicketDataResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  GetAddTicketDataResponse._({
    required this.users,
    required this.statuses,
    required this.priorities,
    required this.types,
    required this.flows,
  });

  factory GetAddTicketDataResponse({
    required List<_i2.UserModel> users,
    required List<_i3.StatusModel> statuses,
    required List<_i4.PriorityModel> priorities,
    required List<_i5.TypeModel> types,
    required List<_i6.FlowModel> flows,
  }) = _GetAddTicketDataResponseImpl;

  factory GetAddTicketDataResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return GetAddTicketDataResponse(
      users: _i7.Protocol().deserialize<List<_i2.UserModel>>(
        jsonSerialization['users'],
      ),
      statuses: _i7.Protocol().deserialize<List<_i3.StatusModel>>(
        jsonSerialization['statuses'],
      ),
      priorities: _i7.Protocol().deserialize<List<_i4.PriorityModel>>(
        jsonSerialization['priorities'],
      ),
      types: _i7.Protocol().deserialize<List<_i5.TypeModel>>(
        jsonSerialization['types'],
      ),
      flows: _i7.Protocol().deserialize<List<_i6.FlowModel>>(
        jsonSerialization['flows'],
      ),
    );
  }

  List<_i2.UserModel> users;

  List<_i3.StatusModel> statuses;

  List<_i4.PriorityModel> priorities;

  List<_i5.TypeModel> types;

  List<_i6.FlowModel> flows;

  /// Returns a shallow copy of this [GetAddTicketDataResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GetAddTicketDataResponse copyWith({
    List<_i2.UserModel>? users,
    List<_i3.StatusModel>? statuses,
    List<_i4.PriorityModel>? priorities,
    List<_i5.TypeModel>? types,
    List<_i6.FlowModel>? flows,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GetAddTicketDataResponse',
      'users': users.toJson(valueToJson: (v) => v.toJson()),
      'statuses': statuses.toJson(valueToJson: (v) => v.toJson()),
      'priorities': priorities.toJson(valueToJson: (v) => v.toJson()),
      'types': types.toJson(valueToJson: (v) => v.toJson()),
      'flows': flows.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GetAddTicketDataResponse',
      'users': users.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'statuses': statuses.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'priorities': priorities.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'types': types.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'flows': flows.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GetAddTicketDataResponseImpl extends GetAddTicketDataResponse {
  _GetAddTicketDataResponseImpl({
    required List<_i2.UserModel> users,
    required List<_i3.StatusModel> statuses,
    required List<_i4.PriorityModel> priorities,
    required List<_i5.TypeModel> types,
    required List<_i6.FlowModel> flows,
  }) : super._(
         users: users,
         statuses: statuses,
         priorities: priorities,
         types: types,
         flows: flows,
       );

  /// Returns a shallow copy of this [GetAddTicketDataResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GetAddTicketDataResponse copyWith({
    List<_i2.UserModel>? users,
    List<_i3.StatusModel>? statuses,
    List<_i4.PriorityModel>? priorities,
    List<_i5.TypeModel>? types,
    List<_i6.FlowModel>? flows,
  }) {
    return GetAddTicketDataResponse(
      users: users ?? this.users.map((e0) => e0.copyWith()).toList(),
      statuses: statuses ?? this.statuses.map((e0) => e0.copyWith()).toList(),
      priorities:
          priorities ?? this.priorities.map((e0) => e0.copyWith()).toList(),
      types: types ?? this.types.map((e0) => e0.copyWith()).toList(),
      flows: flows ?? this.flows.map((e0) => e0.copyWith()).toList(),
    );
  }
}
