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

abstract class SystemColor implements _i1.SerializableModel {
  SystemColor._({
    this.id,
    this.colorName,
    required this.color,
    required this.isDefault,
  });

  factory SystemColor({
    int? id,
    String? colorName,
    required String color,
    required bool isDefault,
  }) = _SystemColorImpl;

  factory SystemColor.fromJson(Map<String, dynamic> jsonSerialization) {
    return SystemColor(
      id: jsonSerialization['id'] as int?,
      colorName: jsonSerialization['colorName'] as String?,
      color: jsonSerialization['color'] as String,
      isDefault: jsonSerialization['isDefault'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? colorName;

  String color;

  bool isDefault;

  /// Returns a shallow copy of this [SystemColor]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SystemColor copyWith({
    int? id,
    String? colorName,
    String? color,
    bool? isDefault,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SystemColor',
      if (id != null) 'id': id,
      if (colorName != null) 'colorName': colorName,
      'color': color,
      'isDefault': isDefault,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SystemColorImpl extends SystemColor {
  _SystemColorImpl({
    int? id,
    String? colorName,
    required String color,
    required bool isDefault,
  }) : super._(
         id: id,
         colorName: colorName,
         color: color,
         isDefault: isDefault,
       );

  /// Returns a shallow copy of this [SystemColor]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SystemColor copyWith({
    Object? id = _Undefined,
    Object? colorName = _Undefined,
    String? color,
    bool? isDefault,
  }) {
    return SystemColor(
      id: id is int? ? id : this.id,
      colorName: colorName is String? ? colorName : this.colorName,
      color: color ?? this.color,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
