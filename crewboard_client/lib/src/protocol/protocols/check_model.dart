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

abstract class CheckModel implements _i1.SerializableModel {
  CheckModel._({
    required this.label,
    required this.selected,
  });

  factory CheckModel({
    required String label,
    required bool selected,
  }) = _CheckModelImpl;

  factory CheckModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return CheckModel(
      label: jsonSerialization['label'] as String,
      selected: jsonSerialization['selected'] as bool,
    );
  }

  String label;

  bool selected;

  /// Returns a shallow copy of this [CheckModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CheckModel copyWith({
    String? label,
    bool? selected,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CheckModel',
      'label': label,
      'selected': selected,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CheckModelImpl extends CheckModel {
  _CheckModelImpl({
    required String label,
    required bool selected,
  }) : super._(
         label: label,
         selected: selected,
       );

  /// Returns a shallow copy of this [CheckModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CheckModel copyWith({
    String? label,
    bool? selected,
  }) {
    return CheckModel(
      label: label ?? this.label,
      selected: selected ?? this.selected,
    );
  }
}
