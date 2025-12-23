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
    int? id,
    required String appName,
    required int colorId,
    int? organizationId,
  }) = _PlannerAppImpl;

  factory PlannerApp.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlannerApp(
      id: jsonSerialization['id'] as int?,
      appName: jsonSerialization['appName'] as String,
      colorId: jsonSerialization['colorId'] as int,
      organizationId: jsonSerialization['organizationId'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String appName;

  int colorId;

  int? organizationId;

  /// Returns a shallow copy of this [PlannerApp]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlannerApp copyWith({
    int? id,
    String? appName,
    int? colorId,
    int? organizationId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlannerApp',
      if (id != null) 'id': id,
      'appName': appName,
      'colorId': colorId,
      if (organizationId != null) 'organizationId': organizationId,
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
    int? id,
    required String appName,
    required int colorId,
    int? organizationId,
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
    int? colorId,
    Object? organizationId = _Undefined,
  }) {
    return PlannerApp(
      id: id is int? ? id : this.id,
      appName: appName ?? this.appName,
      colorId: colorId ?? this.colorId,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
    );
  }
}
