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

abstract class Doc implements _i1.SerializableModel {
  Doc._({
    this.id,
    required this.appId,
    required this.name,
    this.doc,
    this.outline,
    required this.lastUpdated,
  });

  factory Doc({
    _i1.UuidValue? id,
    required _i1.UuidValue appId,
    required String name,
    String? doc,
    String? outline,
    required DateTime lastUpdated,
  }) = _DocImpl;

  factory Doc.fromJson(Map<String, dynamic> jsonSerialization) {
    return Doc(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      appId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['appId']),
      name: jsonSerialization['name'] as String,
      doc: jsonSerialization['doc'] as String?,
      outline: jsonSerialization['outline'] as String?,
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

  String? doc;

  String? outline;

  DateTime lastUpdated;

  /// Returns a shallow copy of this [Doc]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Doc copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? appId,
    String? name,
    String? doc,
    String? outline,
    DateTime? lastUpdated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Doc',
      if (id != null) 'id': id?.toJson(),
      'appId': appId.toJson(),
      'name': name,
      if (doc != null) 'doc': doc,
      if (outline != null) 'outline': outline,
      'lastUpdated': lastUpdated.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DocImpl extends Doc {
  _DocImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue appId,
    required String name,
    String? doc,
    String? outline,
    required DateTime lastUpdated,
  }) : super._(
         id: id,
         appId: appId,
         name: name,
         doc: doc,
         outline: outline,
         lastUpdated: lastUpdated,
       );

  /// Returns a shallow copy of this [Doc]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Doc copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? appId,
    String? name,
    Object? doc = _Undefined,
    Object? outline = _Undefined,
    DateTime? lastUpdated,
  }) {
    return Doc(
      id: id is _i1.UuidValue? ? id : this.id,
      appId: appId ?? this.appId,
      name: name ?? this.name,
      doc: doc is String? ? doc : this.doc,
      outline: outline is String? ? outline : this.outline,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
