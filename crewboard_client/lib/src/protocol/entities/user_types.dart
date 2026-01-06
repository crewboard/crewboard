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

abstract class UserTypes implements _i1.SerializableModel {
  UserTypes._({
    this.id,
    required this.userType,
    required this.colorId,
    this.color,
    required this.permissions,
    required this.isAdmin,
  });

  factory UserTypes({
    _i1.UuidValue? id,
    required String userType,
    required _i1.UuidValue colorId,
    _i2.SystemColor? color,
    required String permissions,
    required bool isAdmin,
  }) = _UserTypesImpl;

  factory UserTypes.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserTypes(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      userType: jsonSerialization['userType'] as String,
      colorId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['colorId'],
      ),
      color: jsonSerialization['color'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.SystemColor>(
              jsonSerialization['color'],
            ),
      permissions: jsonSerialization['permissions'] as String,
      isAdmin: jsonSerialization['isAdmin'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  String userType;

  _i1.UuidValue colorId;

  _i2.SystemColor? color;

  String permissions;

  bool isAdmin;

  /// Returns a shallow copy of this [UserTypes]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserTypes copyWith({
    _i1.UuidValue? id,
    String? userType,
    _i1.UuidValue? colorId,
    _i2.SystemColor? color,
    String? permissions,
    bool? isAdmin,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserTypes',
      if (id != null) 'id': id?.toJson(),
      'userType': userType,
      'colorId': colorId.toJson(),
      if (color != null) 'color': color?.toJson(),
      'permissions': permissions,
      'isAdmin': isAdmin,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserTypesImpl extends UserTypes {
  _UserTypesImpl({
    _i1.UuidValue? id,
    required String userType,
    required _i1.UuidValue colorId,
    _i2.SystemColor? color,
    required String permissions,
    required bool isAdmin,
  }) : super._(
         id: id,
         userType: userType,
         colorId: colorId,
         color: color,
         permissions: permissions,
         isAdmin: isAdmin,
       );

  /// Returns a shallow copy of this [UserTypes]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserTypes copyWith({
    Object? id = _Undefined,
    String? userType,
    _i1.UuidValue? colorId,
    Object? color = _Undefined,
    String? permissions,
    bool? isAdmin,
  }) {
    return UserTypes(
      id: id is _i1.UuidValue? ? id : this.id,
      userType: userType ?? this.userType,
      colorId: colorId ?? this.colorId,
      color: color is _i2.SystemColor? ? color : this.color?.copyWith(),
      permissions: permissions ?? this.permissions,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}
