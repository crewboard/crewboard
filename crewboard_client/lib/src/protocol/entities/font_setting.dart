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

abstract class FontSetting implements _i1.SerializableModel {
  FontSetting._({
    this.id,
    required this.name,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.color,
    this.lineHeight,
    this.headerLevel,
  });

  factory FontSetting({
    int? id,
    required String name,
    double? fontSize,
    String? fontFamily,
    String? fontWeight,
    String? color,
    double? lineHeight,
    int? headerLevel,
  }) = _FontSettingImpl;

  factory FontSetting.fromJson(Map<String, dynamic> jsonSerialization) {
    return FontSetting(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      fontSize: (jsonSerialization['fontSize'] as num?)?.toDouble(),
      fontFamily: jsonSerialization['fontFamily'] as String?,
      fontWeight: jsonSerialization['fontWeight'] as String?,
      color: jsonSerialization['color'] as String?,
      lineHeight: (jsonSerialization['lineHeight'] as num?)?.toDouble(),
      headerLevel: jsonSerialization['headerLevel'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  double? fontSize;

  String? fontFamily;

  String? fontWeight;

  String? color;

  double? lineHeight;

  int? headerLevel;

  /// Returns a shallow copy of this [FontSetting]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FontSetting copyWith({
    int? id,
    String? name,
    double? fontSize,
    String? fontFamily,
    String? fontWeight,
    String? color,
    double? lineHeight,
    int? headerLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FontSetting',
      if (id != null) 'id': id,
      'name': name,
      if (fontSize != null) 'fontSize': fontSize,
      if (fontFamily != null) 'fontFamily': fontFamily,
      if (fontWeight != null) 'fontWeight': fontWeight,
      if (color != null) 'color': color,
      if (lineHeight != null) 'lineHeight': lineHeight,
      if (headerLevel != null) 'headerLevel': headerLevel,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FontSettingImpl extends FontSetting {
  _FontSettingImpl({
    int? id,
    required String name,
    double? fontSize,
    String? fontFamily,
    String? fontWeight,
    String? color,
    double? lineHeight,
    int? headerLevel,
  }) : super._(
         id: id,
         name: name,
         fontSize: fontSize,
         fontFamily: fontFamily,
         fontWeight: fontWeight,
         color: color,
         lineHeight: lineHeight,
         headerLevel: headerLevel,
       );

  /// Returns a shallow copy of this [FontSetting]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FontSetting copyWith({
    Object? id = _Undefined,
    String? name,
    Object? fontSize = _Undefined,
    Object? fontFamily = _Undefined,
    Object? fontWeight = _Undefined,
    Object? color = _Undefined,
    Object? lineHeight = _Undefined,
    Object? headerLevel = _Undefined,
  }) {
    return FontSetting(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      fontSize: fontSize is double? ? fontSize : this.fontSize,
      fontFamily: fontFamily is String? ? fontFamily : this.fontFamily,
      fontWeight: fontWeight is String? ? fontWeight : this.fontWeight,
      color: color is String? ? color : this.color,
      lineHeight: lineHeight is double? ? lineHeight : this.lineHeight,
      headerLevel: headerLevel is int? ? headerLevel : this.headerLevel,
    );
  }
}
