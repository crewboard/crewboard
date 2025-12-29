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
import 'status_model.dart' as _i2;
import 'priority_model.dart' as _i3;
import 'type_model.dart' as _i4;
import 'check_model.dart' as _i5;
import 'user_model.dart' as _i6;
import 'attachment_model.dart' as _i7;
import 'package:crewboard_server/src/generated/protocol.dart' as _i8;

abstract class TicketModel
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TicketModel._({
    required this.id,
    required this.ticketName,
    required this.ticketBody,
    required this.status,
    required this.priority,
    required this.type,
    required this.checklist,
    this.flows,
    this.deadline,
    required this.creds,
    required this.assignees,
    required this.attachments,
  });

  factory TicketModel({
    required _i1.UuidValue id,
    required String ticketName,
    required String ticketBody,
    required _i2.StatusModel status,
    required _i3.PriorityModel priority,
    required _i4.TypeModel type,
    required List<_i5.CheckModel> checklist,
    String? flows,
    String? deadline,
    required double creds,
    required List<_i6.UserModel> assignees,
    required List<_i7.AttachmentModel> attachments,
  }) = _TicketModelImpl;

  factory TicketModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return TicketModel(
      id: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ticketName: jsonSerialization['ticketName'] as String,
      ticketBody: jsonSerialization['ticketBody'] as String,
      status: _i8.Protocol().deserialize<_i2.StatusModel>(
        jsonSerialization['status'],
      ),
      priority: _i8.Protocol().deserialize<_i3.PriorityModel>(
        jsonSerialization['priority'],
      ),
      type: _i8.Protocol().deserialize<_i4.TypeModel>(
        jsonSerialization['type'],
      ),
      checklist: _i8.Protocol().deserialize<List<_i5.CheckModel>>(
        jsonSerialization['checklist'],
      ),
      flows: jsonSerialization['flows'] as String?,
      deadline: jsonSerialization['deadline'] as String?,
      creds: (jsonSerialization['creds'] as num).toDouble(),
      assignees: _i8.Protocol().deserialize<List<_i6.UserModel>>(
        jsonSerialization['assignees'],
      ),
      attachments: _i8.Protocol().deserialize<List<_i7.AttachmentModel>>(
        jsonSerialization['attachments'],
      ),
    );
  }

  _i1.UuidValue id;

  String ticketName;

  String ticketBody;

  _i2.StatusModel status;

  _i3.PriorityModel priority;

  _i4.TypeModel type;

  List<_i5.CheckModel> checklist;

  String? flows;

  String? deadline;

  double creds;

  List<_i6.UserModel> assignees;

  List<_i7.AttachmentModel> attachments;

  /// Returns a shallow copy of this [TicketModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TicketModel copyWith({
    _i1.UuidValue? id,
    String? ticketName,
    String? ticketBody,
    _i2.StatusModel? status,
    _i3.PriorityModel? priority,
    _i4.TypeModel? type,
    List<_i5.CheckModel>? checklist,
    String? flows,
    String? deadline,
    double? creds,
    List<_i6.UserModel>? assignees,
    List<_i7.AttachmentModel>? attachments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TicketModel',
      'id': id.toJson(),
      'ticketName': ticketName,
      'ticketBody': ticketBody,
      'status': status.toJson(),
      'priority': priority.toJson(),
      'type': type.toJson(),
      'checklist': checklist.toJson(valueToJson: (v) => v.toJson()),
      if (flows != null) 'flows': flows,
      if (deadline != null) 'deadline': deadline,
      'creds': creds,
      'assignees': assignees.toJson(valueToJson: (v) => v.toJson()),
      'attachments': attachments.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TicketModel',
      'id': id.toJson(),
      'ticketName': ticketName,
      'ticketBody': ticketBody,
      'status': status.toJsonForProtocol(),
      'priority': priority.toJsonForProtocol(),
      'type': type.toJsonForProtocol(),
      'checklist': checklist.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (flows != null) 'flows': flows,
      if (deadline != null) 'deadline': deadline,
      'creds': creds,
      'assignees': assignees.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'attachments': attachments.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TicketModelImpl extends TicketModel {
  _TicketModelImpl({
    required _i1.UuidValue id,
    required String ticketName,
    required String ticketBody,
    required _i2.StatusModel status,
    required _i3.PriorityModel priority,
    required _i4.TypeModel type,
    required List<_i5.CheckModel> checklist,
    String? flows,
    String? deadline,
    required double creds,
    required List<_i6.UserModel> assignees,
    required List<_i7.AttachmentModel> attachments,
  }) : super._(
         id: id,
         ticketName: ticketName,
         ticketBody: ticketBody,
         status: status,
         priority: priority,
         type: type,
         checklist: checklist,
         flows: flows,
         deadline: deadline,
         creds: creds,
         assignees: assignees,
         attachments: attachments,
       );

  /// Returns a shallow copy of this [TicketModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TicketModel copyWith({
    _i1.UuidValue? id,
    String? ticketName,
    String? ticketBody,
    _i2.StatusModel? status,
    _i3.PriorityModel? priority,
    _i4.TypeModel? type,
    List<_i5.CheckModel>? checklist,
    Object? flows = _Undefined,
    Object? deadline = _Undefined,
    double? creds,
    List<_i6.UserModel>? assignees,
    List<_i7.AttachmentModel>? attachments,
  }) {
    return TicketModel(
      id: id ?? this.id,
      ticketName: ticketName ?? this.ticketName,
      ticketBody: ticketBody ?? this.ticketBody,
      status: status ?? this.status.copyWith(),
      priority: priority ?? this.priority.copyWith(),
      type: type ?? this.type.copyWith(),
      checklist:
          checklist ?? this.checklist.map((e0) => e0.copyWith()).toList(),
      flows: flows is String? ? flows : this.flows,
      deadline: deadline is String? ? deadline : this.deadline,
      creds: creds ?? this.creds,
      assignees:
          assignees ?? this.assignees.map((e0) => e0.copyWith()).toList(),
      attachments:
          attachments ?? this.attachments.map((e0) => e0.copyWith()).toList(),
    );
  }
}
