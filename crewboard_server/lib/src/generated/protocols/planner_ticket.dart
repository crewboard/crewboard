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
import '../protocols/planner_assignee.dart' as _i2;
import 'package:crewboard_server/src/generated/protocol.dart' as _i3;

abstract class PlannerTicket
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  PlannerTicket._({
    required this.id,
    required this.ticketName,
    required this.ticketBody,
    required this.statusName,
    required this.priorityName,
    required this.typeName,
    required this.typeColor,
    this.deadline,
    required this.assignees,
    required this.holder,
    this.creds,
    this.createdAt,
    bool? hasNewActivity,
    this.latestActivity,
  }) : hasNewActivity = hasNewActivity ?? false;

  factory PlannerTicket({
    required _i1.UuidValue id,
    required String ticketName,
    required String ticketBody,
    required String statusName,
    required String priorityName,
    required String typeName,
    required String typeColor,
    String? deadline,
    required List<_i2.PlannerAssignee> assignees,
    required String holder,
    double? creds,
    DateTime? createdAt,
    bool? hasNewActivity,
    String? latestActivity,
  }) = _PlannerTicketImpl;

  factory PlannerTicket.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlannerTicket(
      id: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ticketName: jsonSerialization['ticketName'] as String,
      ticketBody: jsonSerialization['ticketBody'] as String,
      statusName: jsonSerialization['statusName'] as String,
      priorityName: jsonSerialization['priorityName'] as String,
      typeName: jsonSerialization['typeName'] as String,
      typeColor: jsonSerialization['typeColor'] as String,
      deadline: jsonSerialization['deadline'] as String?,
      assignees: _i3.Protocol().deserialize<List<_i2.PlannerAssignee>>(
        jsonSerialization['assignees'],
      ),
      holder: jsonSerialization['holder'] as String,
      creds: (jsonSerialization['creds'] as num?)?.toDouble(),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      hasNewActivity: jsonSerialization['hasNewActivity'] as bool,
      latestActivity: jsonSerialization['latestActivity'] as String?,
    );
  }

  _i1.UuidValue id;

  String ticketName;

  String ticketBody;

  String statusName;

  String priorityName;

  String typeName;

  String typeColor;

  String? deadline;

  List<_i2.PlannerAssignee> assignees;

  String holder;

  double? creds;

  DateTime? createdAt;

  bool hasNewActivity;

  String? latestActivity;

  /// Returns a shallow copy of this [PlannerTicket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlannerTicket copyWith({
    _i1.UuidValue? id,
    String? ticketName,
    String? ticketBody,
    String? statusName,
    String? priorityName,
    String? typeName,
    String? typeColor,
    String? deadline,
    List<_i2.PlannerAssignee>? assignees,
    String? holder,
    double? creds,
    DateTime? createdAt,
    bool? hasNewActivity,
    String? latestActivity,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlannerTicket',
      'id': id.toJson(),
      'ticketName': ticketName,
      'ticketBody': ticketBody,
      'statusName': statusName,
      'priorityName': priorityName,
      'typeName': typeName,
      'typeColor': typeColor,
      if (deadline != null) 'deadline': deadline,
      'assignees': assignees.toJson(valueToJson: (v) => v.toJson()),
      'holder': holder,
      if (creds != null) 'creds': creds,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      'hasNewActivity': hasNewActivity,
      if (latestActivity != null) 'latestActivity': latestActivity,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlannerTicket',
      'id': id.toJson(),
      'ticketName': ticketName,
      'ticketBody': ticketBody,
      'statusName': statusName,
      'priorityName': priorityName,
      'typeName': typeName,
      'typeColor': typeColor,
      if (deadline != null) 'deadline': deadline,
      'assignees': assignees.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'holder': holder,
      if (creds != null) 'creds': creds,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      'hasNewActivity': hasNewActivity,
      if (latestActivity != null) 'latestActivity': latestActivity,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlannerTicketImpl extends PlannerTicket {
  _PlannerTicketImpl({
    required _i1.UuidValue id,
    required String ticketName,
    required String ticketBody,
    required String statusName,
    required String priorityName,
    required String typeName,
    required String typeColor,
    String? deadline,
    required List<_i2.PlannerAssignee> assignees,
    required String holder,
    double? creds,
    DateTime? createdAt,
    bool? hasNewActivity,
    String? latestActivity,
  }) : super._(
         id: id,
         ticketName: ticketName,
         ticketBody: ticketBody,
         statusName: statusName,
         priorityName: priorityName,
         typeName: typeName,
         typeColor: typeColor,
         deadline: deadline,
         assignees: assignees,
         holder: holder,
         creds: creds,
         createdAt: createdAt,
         hasNewActivity: hasNewActivity,
         latestActivity: latestActivity,
       );

  /// Returns a shallow copy of this [PlannerTicket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlannerTicket copyWith({
    _i1.UuidValue? id,
    String? ticketName,
    String? ticketBody,
    String? statusName,
    String? priorityName,
    String? typeName,
    String? typeColor,
    Object? deadline = _Undefined,
    List<_i2.PlannerAssignee>? assignees,
    String? holder,
    Object? creds = _Undefined,
    Object? createdAt = _Undefined,
    bool? hasNewActivity,
    Object? latestActivity = _Undefined,
  }) {
    return PlannerTicket(
      id: id ?? this.id,
      ticketName: ticketName ?? this.ticketName,
      ticketBody: ticketBody ?? this.ticketBody,
      statusName: statusName ?? this.statusName,
      priorityName: priorityName ?? this.priorityName,
      typeName: typeName ?? this.typeName,
      typeColor: typeColor ?? this.typeColor,
      deadline: deadline is String? ? deadline : this.deadline,
      assignees:
          assignees ?? this.assignees.map((e0) => e0.copyWith()).toList(),
      holder: holder ?? this.holder,
      creds: creds is double? ? creds : this.creds,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      hasNewActivity: hasNewActivity ?? this.hasNewActivity,
      latestActivity: latestActivity is String?
          ? latestActivity
          : this.latestActivity,
    );
  }
}
