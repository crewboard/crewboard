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

abstract class PlannerApp implements _i1.SerializableModel {
  PlannerApp._({
    this.id,
    required this.appName,
    required this.colorId,
    this.organizationId,
  });

  factory PlannerApp({
    _i1.UuidValue? id,
    required String appName,
    required _i1.UuidValue colorId,
    _i1.UuidValue? organizationId,
  }) = _PlannerAppImpl;

  factory PlannerApp.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlannerApp(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      appName: jsonSerialization['appName'] as String,
      colorId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['colorId'],
      ),
      organizationId: jsonSerialization['organizationId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['organizationId'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  String appName;

  _i1.UuidValue colorId;

  _i1.UuidValue? organizationId;

  /// Returns a shallow copy of this [PlannerApp]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlannerApp copyWith({
    _i1.UuidValue? id,
    String? appName,
    _i1.UuidValue? colorId,
    _i1.UuidValue? organizationId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlannerApp',
      if (id != null) 'id': id?.toJson(),
      'appName': appName,
      'colorId': colorId.toJson(),
      if (organizationId != null) 'organizationId': organizationId?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlannerAppImpl extends PlannerApp {
  _PlannerAppImpl({
    _i1.UuidValue? id,
    required String appName,
    required _i1.UuidValue colorId,
    _i1.UuidValue? organizationId,
  }) : super._(
         id: id,
         appName: appName,
         colorId: colorId,
         organizationId: organizationId,
       );

  /// Returns a shallow copy of this [PlannerApp]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlannerApp copyWith({
    Object? id = _Undefined,
    String? appName,
    _i1.UuidValue? colorId,
    Object? organizationId = _Undefined,
  }) {
    return PlannerApp(
      id: id is _i1.UuidValue? ? id : this.id,
      appName: appName ?? this.appName,
      colorId: colorId ?? this.colorId,
      organizationId: organizationId is _i1.UuidValue?
          ? organizationId
          : this.organizationId,
    );
  }
}
