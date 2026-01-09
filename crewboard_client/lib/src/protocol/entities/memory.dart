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

abstract class Memory implements _i1.SerializableModel {
  Memory._({
    this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory Memory({
    int? id,
    required _i1.UuidValue userId,
    required String title,
    required String body,
    required DateTime createdAt,
  }) = _MemoryImpl;

  factory Memory.fromJson(Map<String, dynamic> jsonSerialization) {
    return Memory(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue userId;

  String title;

  String body;

  DateTime createdAt;

  /// Returns a shallow copy of this [Memory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Memory copyWith({
    int? id,
    _i1.UuidValue? userId,
    String? title,
    String? body,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Memory',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'title': title,
      'body': body,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemoryImpl extends Memory {
  _MemoryImpl({
    int? id,
    required _i1.UuidValue userId,
    required String title,
    required String body,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         title: title,
         body: body,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Memory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Memory copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    String? title,
    String? body,
    DateTime? createdAt,
  }) {
    return Memory(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
