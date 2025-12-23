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

abstract class TicketType implements _i1.SerializableModel {
  TicketType._({
    this.id,
    required this.typeName,
    required this.colorId,
  });

  factory TicketType({
    int? id,
    required String typeName,
    required int colorId,
  }) = _TicketTypeImpl;

  factory TicketType.fromJson(Map<String, dynamic> jsonSerialization) {
    return TicketType(
      id: jsonSerialization['id'] as int?,
      typeName: jsonSerialization['typeName'] as String,
      colorId: jsonSerialization['colorId'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String typeName;

  int colorId;

  /// Returns a shallow copy of this [TicketType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TicketType copyWith({
    int? id,
    String? typeName,
    int? colorId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TicketType',
      if (id != null) 'id': id,
      'typeName': typeName,
      'colorId': colorId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TicketTypeImpl extends TicketType {
  _TicketTypeImpl({
    int? id,
    required String typeName,
    required int colorId,
  }) : super._(
         id: id,
         typeName: typeName,
         colorId: colorId,
       );

  /// Returns a shallow copy of this [TicketType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TicketType copyWith({
    Object? id = _Undefined,
    String? typeName,
    int? colorId,
  }) {
    return TicketType(
      id: id is int? ? id : this.id,
      typeName: typeName ?? this.typeName,
      colorId: colorId ?? this.colorId,
    );
  }
}
