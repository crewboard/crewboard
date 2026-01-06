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
import '../protocols/bucket_model.dart' as _i2;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i3;

abstract class GetPlannerDataResponse implements _i1.SerializableModel {
  GetPlannerDataResponse._({required this.buckets});

  factory GetPlannerDataResponse({required List<_i2.BucketModel> buckets}) =
      _GetPlannerDataResponseImpl;

  factory GetPlannerDataResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return GetPlannerDataResponse(
      buckets: _i3.Protocol().deserialize<List<_i2.BucketModel>>(
        jsonSerialization['buckets'],
      ),
    );
  }

  List<_i2.BucketModel> buckets;

  /// Returns a shallow copy of this [GetPlannerDataResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GetPlannerDataResponse copyWith({List<_i2.BucketModel>? buckets});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GetPlannerDataResponse',
      'buckets': buckets.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GetPlannerDataResponseImpl extends GetPlannerDataResponse {
  _GetPlannerDataResponseImpl({required List<_i2.BucketModel> buckets})
    : super._(buckets: buckets);

  /// Returns a shallow copy of this [GetPlannerDataResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GetPlannerDataResponse copyWith({List<_i2.BucketModel>? buckets}) {
    return GetPlannerDataResponse(
      buckets: buckets ?? this.buckets.map((e0) => e0.copyWith()).toList(),
    );
  }
}
