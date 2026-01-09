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
import '../protocols/thread_item_model.dart' as _i2;
import 'package:crewboard_server/src/generated/protocol.dart' as _i3;

abstract class GetTicketThreadResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  GetTicketThreadResponse._({required this.items});

  factory GetTicketThreadResponse({required List<_i2.ThreadItemModel> items}) =
      _GetTicketThreadResponseImpl;

  factory GetTicketThreadResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return GetTicketThreadResponse(
      items: _i3.Protocol().deserialize<List<_i2.ThreadItemModel>>(
        jsonSerialization['items'],
      ),
    );
  }

  List<_i2.ThreadItemModel> items;

  /// Returns a shallow copy of this [GetTicketThreadResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GetTicketThreadResponse copyWith({List<_i2.ThreadItemModel>? items});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GetTicketThreadResponse',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GetTicketThreadResponse',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GetTicketThreadResponseImpl extends GetTicketThreadResponse {
  _GetTicketThreadResponseImpl({required List<_i2.ThreadItemModel> items})
    : super._(items: items);

  /// Returns a shallow copy of this [GetTicketThreadResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GetTicketThreadResponse copyWith({List<_i2.ThreadItemModel>? items}) {
    return GetTicketThreadResponse(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
