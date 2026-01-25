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

abstract class SystemVariables implements _i1.SerializableModel {
  SystemVariables._({
    this.id,
    required this.punchingMode,
    this.lineHeight,
    this.processWidth,
    this.conditionWidth,
    this.terminalWidth,
    this.allowEdit,
    this.showEdit,
    this.allowDelete,
    this.showDelete,
    this.googleFonts,
    this.tabPreset1,
    this.tabPreset2,
    this.titleFont,
    this.headingFont,
    this.subHeadingFont,
  });

  factory SystemVariables({
    int? id,
    required String punchingMode,
    double? lineHeight,
    double? processWidth,
    double? conditionWidth,
    double? terminalWidth,
    bool? allowEdit,
    bool? showEdit,
    bool? allowDelete,
    bool? showDelete,
    List<String>? googleFonts,
    String? tabPreset1,
    String? tabPreset2,
    String? titleFont,
    String? headingFont,
    String? subHeadingFont,
  }) = _SystemVariablesImpl;

  factory SystemVariables.fromJson(Map<String, dynamic> jsonSerialization) {
    return SystemVariables(
      id: jsonSerialization['id'] as int?,
      punchingMode: jsonSerialization['punchingMode'] as String,
      lineHeight: (jsonSerialization['lineHeight'] as num?)?.toDouble(),
      processWidth: (jsonSerialization['processWidth'] as num?)?.toDouble(),
      conditionWidth: (jsonSerialization['conditionWidth'] as num?)?.toDouble(),
      terminalWidth: (jsonSerialization['terminalWidth'] as num?)?.toDouble(),
      allowEdit: jsonSerialization['allowEdit'] as bool?,
      showEdit: jsonSerialization['showEdit'] as bool?,
      allowDelete: jsonSerialization['allowDelete'] as bool?,
      showDelete: jsonSerialization['showDelete'] as bool?,
      googleFonts: jsonSerialization['googleFonts'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['googleFonts'],
            ),
      tabPreset1: jsonSerialization['tabPreset1'] as String?,
      tabPreset2: jsonSerialization['tabPreset2'] as String?,
      titleFont: jsonSerialization['titleFont'] as String?,
      headingFont: jsonSerialization['headingFont'] as String?,
      subHeadingFont: jsonSerialization['subHeadingFont'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String punchingMode;

  double? lineHeight;

  double? processWidth;

  double? conditionWidth;

  double? terminalWidth;

  bool? allowEdit;

  bool? showEdit;

  bool? allowDelete;

  bool? showDelete;

  List<String>? googleFonts;

  String? tabPreset1;

  String? tabPreset2;

  String? titleFont;

  String? headingFont;

  String? subHeadingFont;

  /// Returns a shallow copy of this [SystemVariables]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SystemVariables copyWith({
    int? id,
    String? punchingMode,
    double? lineHeight,
    double? processWidth,
    double? conditionWidth,
    double? terminalWidth,
    bool? allowEdit,
    bool? showEdit,
    bool? allowDelete,
    bool? showDelete,
    List<String>? googleFonts,
    String? tabPreset1,
    String? tabPreset2,
    String? titleFont,
    String? headingFont,
    String? subHeadingFont,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SystemVariables',
      if (id != null) 'id': id,
      'punchingMode': punchingMode,
      if (lineHeight != null) 'lineHeight': lineHeight,
      if (processWidth != null) 'processWidth': processWidth,
      if (conditionWidth != null) 'conditionWidth': conditionWidth,
      if (terminalWidth != null) 'terminalWidth': terminalWidth,
      if (allowEdit != null) 'allowEdit': allowEdit,
      if (showEdit != null) 'showEdit': showEdit,
      if (allowDelete != null) 'allowDelete': allowDelete,
      if (showDelete != null) 'showDelete': showDelete,
      if (googleFonts != null) 'googleFonts': googleFonts?.toJson(),
      if (tabPreset1 != null) 'tabPreset1': tabPreset1,
      if (tabPreset2 != null) 'tabPreset2': tabPreset2,
      if (titleFont != null) 'titleFont': titleFont,
      if (headingFont != null) 'headingFont': headingFont,
      if (subHeadingFont != null) 'subHeadingFont': subHeadingFont,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SystemVariablesImpl extends SystemVariables {
  _SystemVariablesImpl({
    int? id,
    required String punchingMode,
    double? lineHeight,
    double? processWidth,
    double? conditionWidth,
    double? terminalWidth,
    bool? allowEdit,
    bool? showEdit,
    bool? allowDelete,
    bool? showDelete,
    List<String>? googleFonts,
    String? tabPreset1,
    String? tabPreset2,
    String? titleFont,
    String? headingFont,
    String? subHeadingFont,
  }) : super._(
         id: id,
         punchingMode: punchingMode,
         lineHeight: lineHeight,
         processWidth: processWidth,
         conditionWidth: conditionWidth,
         terminalWidth: terminalWidth,
         allowEdit: allowEdit,
         showEdit: showEdit,
         allowDelete: allowDelete,
         showDelete: showDelete,
         googleFonts: googleFonts,
         tabPreset1: tabPreset1,
         tabPreset2: tabPreset2,
         titleFont: titleFont,
         headingFont: headingFont,
         subHeadingFont: subHeadingFont,
       );

  /// Returns a shallow copy of this [SystemVariables]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SystemVariables copyWith({
    Object? id = _Undefined,
    String? punchingMode,
    Object? lineHeight = _Undefined,
    Object? processWidth = _Undefined,
    Object? conditionWidth = _Undefined,
    Object? terminalWidth = _Undefined,
    Object? allowEdit = _Undefined,
    Object? showEdit = _Undefined,
    Object? allowDelete = _Undefined,
    Object? showDelete = _Undefined,
    Object? googleFonts = _Undefined,
    Object? tabPreset1 = _Undefined,
    Object? tabPreset2 = _Undefined,
    Object? titleFont = _Undefined,
    Object? headingFont = _Undefined,
    Object? subHeadingFont = _Undefined,
  }) {
    return SystemVariables(
      id: id is int? ? id : this.id,
      punchingMode: punchingMode ?? this.punchingMode,
      lineHeight: lineHeight is double? ? lineHeight : this.lineHeight,
      processWidth: processWidth is double? ? processWidth : this.processWidth,
      conditionWidth: conditionWidth is double?
          ? conditionWidth
          : this.conditionWidth,
      terminalWidth: terminalWidth is double?
          ? terminalWidth
          : this.terminalWidth,
      allowEdit: allowEdit is bool? ? allowEdit : this.allowEdit,
      showEdit: showEdit is bool? ? showEdit : this.showEdit,
      allowDelete: allowDelete is bool? ? allowDelete : this.allowDelete,
      showDelete: showDelete is bool? ? showDelete : this.showDelete,
      googleFonts: googleFonts is List<String>?
          ? googleFonts
          : this.googleFonts?.map((e0) => e0).toList(),
      tabPreset1: tabPreset1 is String? ? tabPreset1 : this.tabPreset1,
      tabPreset2: tabPreset2 is String? ? tabPreset2 : this.tabPreset2,
      titleFont: titleFont is String? ? titleFont : this.titleFont,
      headingFont: headingFont is String? ? headingFont : this.headingFont,
      subHeadingFont: subHeadingFont is String?
          ? subHeadingFont
          : this.subHeadingFont,
    );
  }
}
