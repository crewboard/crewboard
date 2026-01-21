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
import 'package:crewboard_client/src/protocol/protocol.dart' as _i2;

abstract class Emoji implements _i1.SerializableModel {
  Emoji._({
    this.id,
    required this.emoji,
    required this.hexcode,
    required this.group,
    required this.subgroup,
    required this.annotation,
    required this.tags,
    required this.shortcodes,
    required this.emoticons,
  });

  factory Emoji({
    int? id,
    required String emoji,
    required String hexcode,
    required String group,
    required String subgroup,
    required String annotation,
    required List<String> tags,
    required List<String> shortcodes,
    required List<String> emoticons,
  }) = _EmojiImpl;

  factory Emoji.fromJson(Map<String, dynamic> jsonSerialization) {
    return Emoji(
      id: jsonSerialization['id'] as int?,
      emoji: jsonSerialization['emoji'] as String,
      hexcode: jsonSerialization['hexcode'] as String,
      group: jsonSerialization['group'] as String,
      subgroup: jsonSerialization['subgroup'] as String,
      annotation: jsonSerialization['annotation'] as String,
      tags: _i2.Protocol().deserialize<List<String>>(jsonSerialization['tags']),
      shortcodes: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['shortcodes'],
      ),
      emoticons: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['emoticons'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String emoji;

  String hexcode;

  String group;

  String subgroup;

  String annotation;

  List<String> tags;

  List<String> shortcodes;

  List<String> emoticons;

  /// Returns a shallow copy of this [Emoji]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Emoji copyWith({
    int? id,
    String? emoji,
    String? hexcode,
    String? group,
    String? subgroup,
    String? annotation,
    List<String>? tags,
    List<String>? shortcodes,
    List<String>? emoticons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Emoji',
      if (id != null) 'id': id,
      'emoji': emoji,
      'hexcode': hexcode,
      'group': group,
      'subgroup': subgroup,
      'annotation': annotation,
      'tags': tags.toJson(),
      'shortcodes': shortcodes.toJson(),
      'emoticons': emoticons.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmojiImpl extends Emoji {
  _EmojiImpl({
    int? id,
    required String emoji,
    required String hexcode,
    required String group,
    required String subgroup,
    required String annotation,
    required List<String> tags,
    required List<String> shortcodes,
    required List<String> emoticons,
  }) : super._(
         id: id,
         emoji: emoji,
         hexcode: hexcode,
         group: group,
         subgroup: subgroup,
         annotation: annotation,
         tags: tags,
         shortcodes: shortcodes,
         emoticons: emoticons,
       );

  /// Returns a shallow copy of this [Emoji]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Emoji copyWith({
    Object? id = _Undefined,
    String? emoji,
    String? hexcode,
    String? group,
    String? subgroup,
    String? annotation,
    List<String>? tags,
    List<String>? shortcodes,
    List<String>? emoticons,
  }) {
    return Emoji(
      id: id is int? ? id : this.id,
      emoji: emoji ?? this.emoji,
      hexcode: hexcode ?? this.hexcode,
      group: group ?? this.group,
      subgroup: subgroup ?? this.subgroup,
      annotation: annotation ?? this.annotation,
      tags: tags ?? this.tags.map((e0) => e0).toList(),
      shortcodes: shortcodes ?? this.shortcodes.map((e0) => e0).toList(),
      emoticons: emoticons ?? this.emoticons.map((e0) => e0).toList(),
    );
  }
}
