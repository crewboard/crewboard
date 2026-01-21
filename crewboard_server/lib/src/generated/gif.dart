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

abstract class Gif implements _i1.SerializableModel, _i1.ProtocolSerialization {
  Gif._({
    required this.id,
    required this.url,
    this.title,
    this.previewUrl,
  });

  factory Gif({
    required String id,
    required String url,
    String? title,
    String? previewUrl,
  }) = _GifImpl;

  factory Gif.fromJson(Map<String, dynamic> jsonSerialization) {
    return Gif(
      id: jsonSerialization['id'] as String,
      url: jsonSerialization['url'] as String,
      title: jsonSerialization['title'] as String?,
      previewUrl: jsonSerialization['previewUrl'] as String?,
    );
  }

  String id;

  String url;

  String? title;

  String? previewUrl;

  /// Returns a shallow copy of this [Gif]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Gif copyWith({
    String? id,
    String? url,
    String? title,
    String? previewUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Gif',
      'id': id,
      'url': url,
      if (title != null) 'title': title,
      if (previewUrl != null) 'previewUrl': previewUrl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Gif',
      'id': id,
      'url': url,
      if (title != null) 'title': title,
      if (previewUrl != null) 'previewUrl': previewUrl,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GifImpl extends Gif {
  _GifImpl({
    required String id,
    required String url,
    String? title,
    String? previewUrl,
  }) : super._(
         id: id,
         url: url,
         title: title,
         previewUrl: previewUrl,
       );

  /// Returns a shallow copy of this [Gif]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Gif copyWith({
    String? id,
    String? url,
    Object? title = _Undefined,
    Object? previewUrl = _Undefined,
  }) {
    return Gif(
      id: id ?? this.id,
      url: url ?? this.url,
      title: title is String? ? title : this.title,
      previewUrl: previewUrl is String? ? previewUrl : this.previewUrl,
    );
  }
}
