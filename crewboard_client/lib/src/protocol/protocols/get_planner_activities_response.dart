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
import '../entities/planner_activity.dart' as _i2;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i3;

abstract class GetPlannerActivitiesResponse implements _i1.SerializableModel {
  GetPlannerActivitiesResponse._({required this.activities});

  factory GetPlannerActivitiesResponse({
    required List<_i2.PlannerActivity> activities,
  }) = _GetPlannerActivitiesResponseImpl;

  factory GetPlannerActivitiesResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return GetPlannerActivitiesResponse(
      activities: _i3.Protocol().deserialize<List<_i2.PlannerActivity>>(
        jsonSerialization['activities'],
      ),
    );
  }

  List<_i2.PlannerActivity> activities;

  /// Returns a shallow copy of this [GetPlannerActivitiesResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GetPlannerActivitiesResponse copyWith({
    List<_i2.PlannerActivity>? activities,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GetPlannerActivitiesResponse',
      'activities': activities.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GetPlannerActivitiesResponseImpl extends GetPlannerActivitiesResponse {
  _GetPlannerActivitiesResponseImpl({
    required List<_i2.PlannerActivity> activities,
  }) : super._(activities: activities);

  /// Returns a shallow copy of this [GetPlannerActivitiesResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GetPlannerActivitiesResponse copyWith({
    List<_i2.PlannerActivity>? activities,
  }) {
    return GetPlannerActivitiesResponse(
      activities:
          activities ?? this.activities.map((e0) => e0.copyWith()).toList(),
    );
  }
}
