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
    );
  }
}
