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
import '../entities/system_color.dart' as _i2;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i3;

abstract class TicketType implements _i1.SerializableModel {
  TicketType._({
    this.id,
    required this.typeName,
    required this.colorId,
    this.color,
  });

  factory TicketType({
    _i1.UuidValue? id,
    required String typeName,
    required _i1.UuidValue colorId,
    _i2.SystemColor? color,
  }) = _TicketTypeImpl;

  factory TicketType.fromJson(Map<String, dynamic> jsonSerialization) {
    return TicketType(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      typeName: jsonSerialization['typeName'] as String,
      colorId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['colorId'],
      ),
      color: jsonSerialization['color'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.SystemColor>(
              jsonSerialization['color'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  String typeName;

  _i1.UuidValue colorId;

  _i2.SystemColor? color;

  /// Returns a shallow copy of this [TicketType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TicketType copyWith({
    _i1.UuidValue? id,
    String? typeName,
    _i1.UuidValue? colorId,
    _i2.SystemColor? color,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TicketType',
      if (id != null) 'id': id?.toJson(),
      'typeName': typeName,
      'colorId': colorId.toJson(),
      if (color != null) 'color': color?.toJson(),
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
    _i1.UuidValue? id,
    required String typeName,
    required _i1.UuidValue colorId,
    _i2.SystemColor? color,
  }) : super._(
         id: id,
         typeName: typeName,
         colorId: colorId,
         color: color,
       );

  /// Returns a shallow copy of this [TicketType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TicketType copyWith({
    Object? id = _Undefined,
    String? typeName,
    _i1.UuidValue? colorId,
    Object? color = _Undefined,
  }) {
    return TicketType(
      id: id is _i1.UuidValue? ? id : this.id,
      typeName: typeName ?? this.typeName,
      colorId: colorId ?? this.colorId,
      color: color is _i2.SystemColor? ? color : this.color?.copyWith(),
    );
  }
}
