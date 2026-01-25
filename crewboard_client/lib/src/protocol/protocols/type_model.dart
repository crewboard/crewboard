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

abstract class TypeModel implements _i1.SerializableModel {
  TypeModel._({
    required this.typeId,
    required this.typeName,
    required this.color,
    required this.colorId,
  });

  factory TypeModel({
    required _i1.UuidValue typeId,
    required String typeName,
    required String color,
    required _i1.UuidValue colorId,
  }) = _TypeModelImpl;

  factory TypeModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return TypeModel(
      typeId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['typeId']),
      typeName: jsonSerialization['typeName'] as String,
      color: jsonSerialization['color'] as String,
      colorId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['colorId'],
      ),
    );
  }

  _i1.UuidValue typeId;

  String typeName;

  String color;

  _i1.UuidValue colorId;

  /// Returns a shallow copy of this [TypeModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TypeModel copyWith({
    _i1.UuidValue? typeId,
    String? typeName,
    String? color,
    _i1.UuidValue? colorId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TypeModel',
      'typeId': typeId.toJson(),
      'typeName': typeName,
      'color': color,
      'colorId': colorId.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TypeModelImpl extends TypeModel {
  _TypeModelImpl({
    required _i1.UuidValue typeId,
    required String typeName,
    required String color,
    required _i1.UuidValue colorId,
  }) : super._(
         typeId: typeId,
         typeName: typeName,
         color: color,
         colorId: colorId,
       );

  /// Returns a shallow copy of this [TypeModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TypeModel copyWith({
    _i1.UuidValue? typeId,
    String? typeName,
    String? color,
    _i1.UuidValue? colorId,
  }) {
    return TypeModel(
      typeId: typeId ?? this.typeId,
      typeName: typeName ?? this.typeName,
      color: color ?? this.color,
      colorId: colorId ?? this.colorId,
    );
  }
}
