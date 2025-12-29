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
import 'user.dart' as _i2;
import 'status.dart' as _i3;
import 'priority.dart' as _i4;
import 'ticket_type.dart' as _i5;
import 'check_model.dart' as _i6;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i7;

abstract class Ticket implements _i1.SerializableModel {
  Ticket._({
    this.id,
    required this.userId,
    this.user,
    required this.appId,
    required this.ticketName,
    required this.ticketBody,
    required this.statusId,
    this.status,
    required this.priorityId,
    this.priority,
    required this.typeId,
    this.type,
    this.checklist,
    required this.flows,
    required this.creds,
    this.deadline,
  });

  factory Ticket({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    required _i1.UuidValue appId,
    required String ticketName,
    required String ticketBody,
    required _i1.UuidValue statusId,
    _i3.Status? status,
    required _i1.UuidValue priorityId,
    _i4.Priority? priority,
    required _i1.UuidValue typeId,
    _i5.TicketType? type,
    List<_i6.CheckModel>? checklist,
    required String flows,
    required int creds,
    DateTime? deadline,
  }) = _TicketImpl;

  factory Ticket.fromJson(Map<String, dynamic> jsonSerialization) {
    return Ticket(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i7.Protocol().deserialize<_i2.User>(jsonSerialization['user']),
      appId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['appId']),
      ticketName: jsonSerialization['ticketName'] as String,
      ticketBody: jsonSerialization['ticketBody'] as String,
      statusId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['statusId'],
      ),
      status: jsonSerialization['status'] == null
          ? null
          : _i7.Protocol().deserialize<_i3.Status>(jsonSerialization['status']),
      priorityId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['priorityId'],
      ),
      priority: jsonSerialization['priority'] == null
          ? null
          : _i7.Protocol().deserialize<_i4.Priority>(
              jsonSerialization['priority'],
            ),
      typeId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['typeId']),
      type: jsonSerialization['type'] == null
          ? null
          : _i7.Protocol().deserialize<_i5.TicketType>(
              jsonSerialization['type'],
            ),
      checklist: jsonSerialization['checklist'] == null
          ? null
          : _i7.Protocol().deserialize<List<_i6.CheckModel>>(
              jsonSerialization['checklist'],
            ),
      flows: jsonSerialization['flows'] as String,
      creds: jsonSerialization['creds'] as int,
      deadline: jsonSerialization['deadline'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deadline']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue userId;

  _i2.User? user;

  _i1.UuidValue appId;

  String ticketName;

  String ticketBody;

  _i1.UuidValue statusId;

  _i3.Status? status;

  _i1.UuidValue priorityId;

  _i4.Priority? priority;

  _i1.UuidValue typeId;

  _i5.TicketType? type;

  List<_i6.CheckModel>? checklist;

  String flows;

  int creds;

  DateTime? deadline;

  /// Returns a shallow copy of this [Ticket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Ticket copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? userId,
    _i2.User? user,
    _i1.UuidValue? appId,
    String? ticketName,
    String? ticketBody,
    _i1.UuidValue? statusId,
    _i3.Status? status,
    _i1.UuidValue? priorityId,
    _i4.Priority? priority,
    _i1.UuidValue? typeId,
    _i5.TicketType? type,
    List<_i6.CheckModel>? checklist,
    String? flows,
    int? creds,
    DateTime? deadline,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Ticket',
      if (id != null) 'id': id?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'appId': appId.toJson(),
      'ticketName': ticketName,
      'ticketBody': ticketBody,
      'statusId': statusId.toJson(),
      if (status != null) 'status': status?.toJson(),
      'priorityId': priorityId.toJson(),
      if (priority != null) 'priority': priority?.toJson(),
      'typeId': typeId.toJson(),
      if (type != null) 'type': type?.toJson(),
      if (checklist != null)
        'checklist': checklist?.toJson(valueToJson: (v) => v.toJson()),
      'flows': flows,
      'creds': creds,
      if (deadline != null) 'deadline': deadline?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TicketImpl extends Ticket {
  _TicketImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    required _i1.UuidValue appId,
    required String ticketName,
    required String ticketBody,
    required _i1.UuidValue statusId,
    _i3.Status? status,
    required _i1.UuidValue priorityId,
    _i4.Priority? priority,
    required _i1.UuidValue typeId,
    _i5.TicketType? type,
    List<_i6.CheckModel>? checklist,
    required String flows,
    required int creds,
    DateTime? deadline,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         appId: appId,
         ticketName: ticketName,
         ticketBody: ticketBody,
         statusId: statusId,
         status: status,
         priorityId: priorityId,
         priority: priority,
         typeId: typeId,
         type: type,
         checklist: checklist,
         flows: flows,
         creds: creds,
         deadline: deadline,
       );

  /// Returns a shallow copy of this [Ticket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Ticket copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    _i1.UuidValue? appId,
    String? ticketName,
    String? ticketBody,
    _i1.UuidValue? statusId,
    Object? status = _Undefined,
    _i1.UuidValue? priorityId,
    Object? priority = _Undefined,
    _i1.UuidValue? typeId,
    Object? type = _Undefined,
    Object? checklist = _Undefined,
    String? flows,
    int? creds,
    Object? deadline = _Undefined,
  }) {
    return Ticket(
      id: id is _i1.UuidValue? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      appId: appId ?? this.appId,
      ticketName: ticketName ?? this.ticketName,
      ticketBody: ticketBody ?? this.ticketBody,
      statusId: statusId ?? this.statusId,
      status: status is _i3.Status? ? status : this.status?.copyWith(),
      priorityId: priorityId ?? this.priorityId,
      priority: priority is _i4.Priority?
          ? priority
          : this.priority?.copyWith(),
      typeId: typeId ?? this.typeId,
      type: type is _i5.TicketType? ? type : this.type?.copyWith(),
      checklist: checklist is List<_i6.CheckModel>?
          ? checklist
          : this.checklist?.map((e0) => e0.copyWith()).toList(),
      flows: flows ?? this.flows,
      creds: creds ?? this.creds,
      deadline: deadline is DateTime? ? deadline : this.deadline,
    );
  }
}
