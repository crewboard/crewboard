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
    required this.flowId,
    required this.flowName,
  });

  factory FlowModel({
    required int flowId,
    required String flowName,
  }) = _FlowModelImpl;

  factory FlowModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return FlowModel(
      flowId: jsonSerialization['flowId'] as int,
      flowName: jsonSerialization['flowName'] as String,
    );
  }

  int flowId;

  String flowName;

  /// Returns a shallow copy of this [FlowModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FlowModel copyWith({
    int? flowId,
    String? flowName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FlowModel',
      'flowId': flowId,
      'flowName': flowName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FlowModelImpl extends FlowModel {
  _FlowModelImpl({
    required int flowId,
    required String flowName,
  }) : super._(
         flowId: flowId,
         flowName: flowName,
       );

  /// Returns a shallow copy of this [FlowModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FlowModel copyWith({
    int? flowId,
    String? flowName,
  }) {
    return FlowModel(
      flowId: flowId ?? this.flowId,
      flowName: flowName ?? this.flowName,
    );
  }
}
