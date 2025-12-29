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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class AttachmentModel
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AttachmentModel._({
    required this.id,
    required this.name,
    required this.url,
    required this.size,
    required this.type,
  });

  factory AttachmentModel({
    required _i1.UuidValue id,
    required String name,
    required String url,
    required double size,
    required String type,
  }) = _AttachmentModelImpl;

  factory AttachmentModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return AttachmentModel(
      id: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      name: jsonSerialization['name'] as String,
      url: jsonSerialization['url'] as String,
      size: (jsonSerialization['size'] as num).toDouble(),
      type: jsonSerialization['type'] as String,
    );
  }

  _i1.UuidValue id;

  String name;

  String url;

  double size;

  String type;

  /// Returns a shallow copy of this [AttachmentModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AttachmentModel copyWith({
    _i1.UuidValue? id,
    String? name,
    String? url,
    double? size,
    String? type,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AttachmentModel',
      'id': id.toJson(),
      'name': name,
      'url': url,
      'size': size,
      'type': type,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AttachmentModel',
      'id': id.toJson(),
      'name': name,
      'url': url,
      'size': size,
      'type': type,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AttachmentModelImpl extends AttachmentModel {
  _AttachmentModelImpl({
    required _i1.UuidValue id,
    required String name,
    required String url,
    required double size,
    required String type,
  }) : super._(
         id: id,
         name: name,
         url: url,
         size: size,
         type: type,
       );

  /// Returns a shallow copy of this [AttachmentModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AttachmentModel copyWith({
    _i1.UuidValue? id,
    String? name,
    String? url,
    double? size,
    String? type,
  }) {
    return AttachmentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      size: size ?? this.size,
      type: type ?? this.type,
    );
  }
}
