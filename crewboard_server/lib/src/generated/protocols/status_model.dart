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

abstract class StatusModel
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  StatusModel._({
    required this.statusId,
    required this.statusName,
  });

  factory StatusModel({
    required _i1.UuidValue statusId,
    required String statusName,
  }) = _StatusModelImpl;

  factory StatusModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return StatusModel(
      statusId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['statusId'],
      ),
      statusName: jsonSerialization['statusName'] as String,
    );
  }

  _i1.UuidValue statusId;

  String statusName;

  /// Returns a shallow copy of this [StatusModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StatusModel copyWith({
    _i1.UuidValue? statusId,
    String? statusName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StatusModel',
      'statusId': statusId.toJson(),
      'statusName': statusName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StatusModel',
      'statusId': statusId.toJson(),
      'statusName': statusName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _StatusModelImpl extends StatusModel {
  _StatusModelImpl({
    required _i1.UuidValue statusId,
    required String statusName,
  }) : super._(
         statusId: statusId,
         statusName: statusName,
       );

  /// Returns a shallow copy of this [StatusModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StatusModel copyWith({
    _i1.UuidValue? statusId,
    String? statusName,
  }) {
    return StatusModel(
      statusId: statusId ?? this.statusId,
      statusName: statusName ?? this.statusName,
    );
  }
}
