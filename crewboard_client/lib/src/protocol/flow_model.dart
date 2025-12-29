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

abstract class FlowModel implements _i1.SerializableModel {
  FlowModel._({
    this.id,
    required this.appId,
    required this.name,
    required this.flow,
    required this.lastUpdated,
  });

  factory FlowModel({
    _i1.UuidValue? id,
    required _i1.UuidValue appId,
    required String name,
    required String flow,
    required DateTime lastUpdated,
  }) = _FlowModelImpl;

  factory FlowModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return FlowModel(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      appId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['appId']),
      name: jsonSerialization['name'] as String,
      flow: jsonSerialization['flow'] as String,
      lastUpdated: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastUpdated'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue appId;

  String name;

  String flow;

  DateTime lastUpdated;

  /// Returns a shallow copy of this [FlowModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FlowModel copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? appId,
    String? name,
    String? flow,
    DateTime? lastUpdated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FlowModel',
      if (id != null) 'id': id?.toJson(),
      'appId': appId.toJson(),
      'name': name,
      'flow': flow,
      'lastUpdated': lastUpdated.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FlowModelImpl extends FlowModel {
  _FlowModelImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue appId,
    required String name,
    required String flow,
    required DateTime lastUpdated,
  }) : super._(
         id: id,
         appId: appId,
         name: name,
         flow: flow,
         lastUpdated: lastUpdated,
       );

  /// Returns a shallow copy of this [FlowModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FlowModel copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? appId,
    String? name,
    String? flow,
    DateTime? lastUpdated,
  }) {
    return FlowModel(
      id: id is _i1.UuidValue? ? id : this.id,
      appId: appId ?? this.appId,
      name: name ?? this.name,
      flow: flow ?? this.flow,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
