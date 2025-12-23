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

abstract class Ticket implements _i1.SerializableModel {
  Ticket._({
    this.id,
    required this.userId,
    required this.appId,
    required this.ticketName,
    required this.ticketBody,
    required this.statusId,
    required this.priorityId,
    required this.typeId,
    required this.checklist,
    required this.flows,
    required this.creds,
    this.deadline,
  });

  factory Ticket({
    int? id,
    required int userId,
    required int appId,
    required String ticketName,
    required String ticketBody,
    required int statusId,
    required int priorityId,
    required int typeId,
    required String checklist,
    required String flows,
    required int creds,
    DateTime? deadline,
  }) = _TicketImpl;

  factory Ticket.fromJson(Map<String, dynamic> jsonSerialization) {
    return Ticket(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      appId: jsonSerialization['appId'] as int,
      ticketName: jsonSerialization['ticketName'] as String,
      ticketBody: jsonSerialization['ticketBody'] as String,
      statusId: jsonSerialization['statusId'] as int,
      priorityId: jsonSerialization['priorityId'] as int,
      typeId: jsonSerialization['typeId'] as int,
      checklist: jsonSerialization['checklist'] as String,
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
  int? id;

  int userId;

  int appId;

  String ticketName;

  String ticketBody;

  int statusId;

  int priorityId;

  int typeId;

  String checklist;

  String flows;

  int creds;

  DateTime? deadline;

  /// Returns a shallow copy of this [Ticket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Ticket copyWith({
    int? id,
    int? userId,
    int? appId,
    String? ticketName,
    String? ticketBody,
    int? statusId,
    int? priorityId,
    int? typeId,
    String? checklist,
    String? flows,
    int? creds,
    DateTime? deadline,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Ticket',
      if (id != null) 'id': id,
      'userId': userId,
      'appId': appId,
      'ticketName': ticketName,
      'ticketBody': ticketBody,
      'statusId': statusId,
      'priorityId': priorityId,
      'typeId': typeId,
      'checklist': checklist,
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
    int? id,
    required int userId,
    required int appId,
    required String ticketName,
    required String ticketBody,
    required int statusId,
    required int priorityId,
    required int typeId,
    required String checklist,
    required String flows,
    required int creds,
    DateTime? deadline,
  }) : super._(
         id: id,
         userId: userId,
         appId: appId,
         ticketName: ticketName,
         ticketBody: ticketBody,
         statusId: statusId,
         priorityId: priorityId,
         typeId: typeId,
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
    int? userId,
    int? appId,
    String? ticketName,
    String? ticketBody,
    int? statusId,
    int? priorityId,
    int? typeId,
    String? checklist,
    String? flows,
    int? creds,
    Object? deadline = _Undefined,
  }) {
    return Ticket(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      appId: appId ?? this.appId,
      ticketName: ticketName ?? this.ticketName,
      ticketBody: ticketBody ?? this.ticketBody,
      statusId: statusId ?? this.statusId,
      priorityId: priorityId ?? this.priorityId,
      typeId: typeId ?? this.typeId,
      checklist: checklist ?? this.checklist,
      flows: flows ?? this.flows,
      creds: creds ?? this.creds,
      deadline: deadline is DateTime? ? deadline : this.deadline,
    );
  }
}
