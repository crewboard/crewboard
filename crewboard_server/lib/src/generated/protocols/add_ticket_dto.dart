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
import '../protocols/ticket_attachment_dto.dart' as _i2;
import '../protocols/planner_assignee.dart' as _i3;
import 'package:crewboard_server/src/generated/protocol.dart' as _i4;

abstract class AddTicketDTO
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AddTicketDTO._({
    required this.ticketName,
    required this.ticketBody,
    required this.statusId,
    required this.priorityId,
    required this.typeId,
    this.deadline,
    required this.creds,
    required this.checklist,
    required this.flows,
    required this.attachments,
    required this.assignees,
  });

  factory AddTicketDTO({
    required String ticketName,
    required String ticketBody,
    required _i1.UuidValue statusId,
    required _i1.UuidValue priorityId,
    required _i1.UuidValue typeId,
    DateTime? deadline,
    required int creds,
    required String checklist,
    required String flows,
    required List<_i2.TicketAttachmentDTO> attachments,
    required List<_i3.PlannerAssignee> assignees,
  }) = _AddTicketDTOImpl;

  factory AddTicketDTO.fromJson(Map<String, dynamic> jsonSerialization) {
    return AddTicketDTO(
      ticketName: jsonSerialization['ticketName'] as String,
      ticketBody: jsonSerialization['ticketBody'] as String,
      statusId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['statusId'],
      ),
      priorityId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['priorityId'],
      ),
      typeId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['typeId']),
      deadline: jsonSerialization['deadline'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deadline']),
      creds: jsonSerialization['creds'] as int,
      checklist: jsonSerialization['checklist'] as String,
      flows: jsonSerialization['flows'] as String,
      attachments: _i4.Protocol().deserialize<List<_i2.TicketAttachmentDTO>>(
        jsonSerialization['attachments'],
      ),
      assignees: _i4.Protocol().deserialize<List<_i3.PlannerAssignee>>(
        jsonSerialization['assignees'],
      ),
    );
  }

  String ticketName;

  String ticketBody;

  _i1.UuidValue statusId;

  _i1.UuidValue priorityId;

  _i1.UuidValue typeId;

  DateTime? deadline;

  int creds;

  String checklist;

  String flows;

  List<_i2.TicketAttachmentDTO> attachments;

  List<_i3.PlannerAssignee> assignees;

  /// Returns a shallow copy of this [AddTicketDTO]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AddTicketDTO copyWith({
    String? ticketName,
    String? ticketBody,
    _i1.UuidValue? statusId,
    _i1.UuidValue? priorityId,
    _i1.UuidValue? typeId,
    DateTime? deadline,
    int? creds,
    String? checklist,
    String? flows,
    List<_i2.TicketAttachmentDTO>? attachments,
    List<_i3.PlannerAssignee>? assignees,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AddTicketDTO',
      'ticketName': ticketName,
      'ticketBody': ticketBody,
      'statusId': statusId.toJson(),
      'priorityId': priorityId.toJson(),
      'typeId': typeId.toJson(),
      if (deadline != null) 'deadline': deadline?.toJson(),
      'creds': creds,
      'checklist': checklist,
      'flows': flows,
      'attachments': attachments.toJson(valueToJson: (v) => v.toJson()),
      'assignees': assignees.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AddTicketDTO',
      'ticketName': ticketName,
      'ticketBody': ticketBody,
      'statusId': statusId.toJson(),
      'priorityId': priorityId.toJson(),
      'typeId': typeId.toJson(),
      if (deadline != null) 'deadline': deadline?.toJson(),
      'creds': creds,
      'checklist': checklist,
      'flows': flows,
      'attachments': attachments.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'assignees': assignees.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AddTicketDTOImpl extends AddTicketDTO {
  _AddTicketDTOImpl({
    required String ticketName,
    required String ticketBody,
    required _i1.UuidValue statusId,
    required _i1.UuidValue priorityId,
    required _i1.UuidValue typeId,
    DateTime? deadline,
    required int creds,
    required String checklist,
    required String flows,
    required List<_i2.TicketAttachmentDTO> attachments,
    required List<_i3.PlannerAssignee> assignees,
  }) : super._(
         ticketName: ticketName,
         ticketBody: ticketBody,
         statusId: statusId,
         priorityId: priorityId,
         typeId: typeId,
         deadline: deadline,
         creds: creds,
         checklist: checklist,
         flows: flows,
         attachments: attachments,
         assignees: assignees,
       );

  /// Returns a shallow copy of this [AddTicketDTO]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AddTicketDTO copyWith({
    String? ticketName,
    String? ticketBody,
    _i1.UuidValue? statusId,
    _i1.UuidValue? priorityId,
    _i1.UuidValue? typeId,
    Object? deadline = _Undefined,
    int? creds,
    String? checklist,
    String? flows,
    List<_i2.TicketAttachmentDTO>? attachments,
    List<_i3.PlannerAssignee>? assignees,
  }) {
    return AddTicketDTO(
      ticketName: ticketName ?? this.ticketName,
      ticketBody: ticketBody ?? this.ticketBody,
      statusId: statusId ?? this.statusId,
      priorityId: priorityId ?? this.priorityId,
      typeId: typeId ?? this.typeId,
      deadline: deadline is DateTime? ? deadline : this.deadline,
      creds: creds ?? this.creds,
      checklist: checklist ?? this.checklist,
      flows: flows ?? this.flows,
      attachments:
          attachments ?? this.attachments.map((e0) => e0.copyWith()).toList(),
      assignees:
          assignees ?? this.assignees.map((e0) => e0.copyWith()).toList(),
    );
  }
}
