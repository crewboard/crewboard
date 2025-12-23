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

abstract class LeaveConfig implements _i1.SerializableModel {
  LeaveConfig._({
    this.id,
    required this.configName,
    required this.fullDay,
    required this.halfDay,
    this.config,
  });

  factory LeaveConfig({
    int? id,
    required String configName,
    required int fullDay,
    required int halfDay,
    String? config,
  }) = _LeaveConfigImpl;

  factory LeaveConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeaveConfig(
      id: jsonSerialization['id'] as int?,
      configName: jsonSerialization['configName'] as String,
      fullDay: jsonSerialization['fullDay'] as int,
      halfDay: jsonSerialization['halfDay'] as int,
      config: jsonSerialization['config'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String configName;

  int fullDay;

  int halfDay;

  String? config;

  /// Returns a shallow copy of this [LeaveConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LeaveConfig copyWith({
    int? id,
    String? configName,
    int? fullDay,
    int? halfDay,
    String? config,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeaveConfig',
      if (id != null) 'id': id,
      'configName': configName,
      'fullDay': fullDay,
      'halfDay': halfDay,
      if (config != null) 'config': config,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LeaveConfigImpl extends LeaveConfig {
  _LeaveConfigImpl({
    int? id,
    required String configName,
    required int fullDay,
    required int halfDay,
    String? config,
  }) : super._(
         id: id,
         configName: configName,
         fullDay: fullDay,
         halfDay: halfDay,
         config: config,
       );

  /// Returns a shallow copy of this [LeaveConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LeaveConfig copyWith({
    Object? id = _Undefined,
    String? configName,
    int? fullDay,
    int? halfDay,
    Object? config = _Undefined,
  }) {
    return LeaveConfig(
      id: id is int? ? id : this.id,
      configName: configName ?? this.configName,
      fullDay: fullDay ?? this.fullDay,
      halfDay: halfDay ?? this.halfDay,
      config: config is String? ? config : this.config,
    );
  }
}
