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
import 'ticket.dart' as _i2;
import 'user.dart' as _i3;
import 'status.dart' as _i4;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i5;

abstract class TicketStatusChange implements _i1.SerializableModel {
  TicketStatusChange._({
    this.id,
    required this.ticketId,
    this.ticket,
    required this.userId,
    this.user,
    required this.oldStatusId,
    this.oldStatus,
    required this.newStatusId,
    this.newStatus,
    this.changedAt,
  });

  factory TicketStatusChange({
    _i1.UuidValue? id,
    required _i1.UuidValue ticketId,
    _i2.Ticket? ticket,
    required _i1.UuidValue userId,
    _i3.User? user,
    required _i1.UuidValue oldStatusId,
    _i4.Status? oldStatus,
    required _i1.UuidValue newStatusId,
    _i4.Status? newStatus,
    DateTime? changedAt,
  }) = _TicketStatusChangeImpl;

  factory TicketStatusChange.fromJson(Map<String, dynamic> jsonSerialization) {
    return TicketStatusChange(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ticketId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['ticketId'],
      ),
      ticket: jsonSerialization['ticket'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Ticket>(jsonSerialization['ticket']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.User>(jsonSerialization['user']),
      oldStatusId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['oldStatusId'],
      ),
      oldStatus: jsonSerialization['oldStatus'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.Status>(
              jsonSerialization['oldStatus'],
            ),
      newStatusId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['newStatusId'],
      ),
      newStatus: jsonSerialization['newStatus'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.Status>(
              jsonSerialization['newStatus'],
            ),
      changedAt: jsonSerialization['changedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['changedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue ticketId;

  _i2.Ticket? ticket;

  _i1.UuidValue userId;

  _i3.User? user;

  _i1.UuidValue oldStatusId;

  _i4.Status? oldStatus;

  _i1.UuidValue newStatusId;

  _i4.Status? newStatus;

  DateTime? changedAt;

  /// Returns a shallow copy of this [TicketStatusChange]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TicketStatusChange copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? ticketId,
    _i2.Ticket? ticket,
    _i1.UuidValue? userId,
    _i3.User? user,
    _i1.UuidValue? oldStatusId,
    _i4.Status? oldStatus,
    _i1.UuidValue? newStatusId,
    _i4.Status? newStatus,
    DateTime? changedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TicketStatusChange',
      if (id != null) 'id': id?.toJson(),
      'ticketId': ticketId.toJson(),
      if (ticket != null) 'ticket': ticket?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'oldStatusId': oldStatusId.toJson(),
      if (oldStatus != null) 'oldStatus': oldStatus?.toJson(),
      'newStatusId': newStatusId.toJson(),
      if (newStatus != null) 'newStatus': newStatus?.toJson(),
      if (changedAt != null) 'changedAt': changedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TicketStatusChangeImpl extends TicketStatusChange {
  _TicketStatusChangeImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue ticketId,
    _i2.Ticket? ticket,
    required _i1.UuidValue userId,
    _i3.User? user,
    required _i1.UuidValue oldStatusId,
    _i4.Status? oldStatus,
    required _i1.UuidValue newStatusId,
    _i4.Status? newStatus,
    DateTime? changedAt,
  }) : super._(
         id: id,
         ticketId: ticketId,
         ticket: ticket,
         userId: userId,
         user: user,
         oldStatusId: oldStatusId,
         oldStatus: oldStatus,
         newStatusId: newStatusId,
         newStatus: newStatus,
         changedAt: changedAt,
       );

  /// Returns a shallow copy of this [TicketStatusChange]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TicketStatusChange copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? ticketId,
    Object? ticket = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    _i1.UuidValue? oldStatusId,
    Object? oldStatus = _Undefined,
    _i1.UuidValue? newStatusId,
    Object? newStatus = _Undefined,
    Object? changedAt = _Undefined,
  }) {
    return TicketStatusChange(
      id: id is _i1.UuidValue? ? id : this.id,
      ticketId: ticketId ?? this.ticketId,
      ticket: ticket is _i2.Ticket? ? ticket : this.ticket?.copyWith(),
      userId: userId ?? this.userId,
      user: user is _i3.User? ? user : this.user?.copyWith(),
      oldStatusId: oldStatusId ?? this.oldStatusId,
      oldStatus: oldStatus is _i4.Status?
          ? oldStatus
          : this.oldStatus?.copyWith(),
      newStatusId: newStatusId ?? this.newStatusId,
      newStatus: newStatus is _i4.Status?
          ? newStatus
          : this.newStatus?.copyWith(),
      changedAt: changedAt is DateTime? ? changedAt : this.changedAt,
    );
  }
}
