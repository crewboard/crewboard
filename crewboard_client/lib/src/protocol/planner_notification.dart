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
import 'package:crewboard_client/src/protocol/protocol.dart' as _i4;

abstract class PlannerNotification implements _i1.SerializableModel {
  PlannerNotification._({
    this.id,
    required this.notification,
    required this.notificationType,
    required this.ticketId,
    this.ticket,
    required this.userId,
    this.user,
    required this.seenUserList,
  });

  factory PlannerNotification({
    _i1.UuidValue? id,
    required String notification,
    required String notificationType,
    required _i1.UuidValue ticketId,
    _i2.Ticket? ticket,
    required _i1.UuidValue userId,
    _i3.User? user,
    required List<_i1.UuidValue> seenUserList,
  }) = _PlannerNotificationImpl;

  factory PlannerNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlannerNotification(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      notification: jsonSerialization['notification'] as String,
      notificationType: jsonSerialization['notificationType'] as String,
      ticketId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['ticketId'],
      ),
      ticket: jsonSerialization['ticket'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Ticket>(jsonSerialization['ticket']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.User>(jsonSerialization['user']),
      seenUserList: _i4.Protocol().deserialize<List<_i1.UuidValue>>(
        jsonSerialization['seenUserList'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  String notification;

  String notificationType;

  _i1.UuidValue ticketId;

  _i2.Ticket? ticket;

  _i1.UuidValue userId;

  _i3.User? user;

  List<_i1.UuidValue> seenUserList;

  /// Returns a shallow copy of this [PlannerNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlannerNotification copyWith({
    _i1.UuidValue? id,
    String? notification,
    String? notificationType,
    _i1.UuidValue? ticketId,
    _i2.Ticket? ticket,
    _i1.UuidValue? userId,
    _i3.User? user,
    List<_i1.UuidValue>? seenUserList,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlannerNotification',
      if (id != null) 'id': id?.toJson(),
      'notification': notification,
      'notificationType': notificationType,
      'ticketId': ticketId.toJson(),
      if (ticket != null) 'ticket': ticket?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'seenUserList': seenUserList.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlannerNotificationImpl extends PlannerNotification {
  _PlannerNotificationImpl({
    _i1.UuidValue? id,
    required String notification,
    required String notificationType,
    required _i1.UuidValue ticketId,
    _i2.Ticket? ticket,
    required _i1.UuidValue userId,
    _i3.User? user,
    required List<_i1.UuidValue> seenUserList,
  }) : super._(
         id: id,
         notification: notification,
         notificationType: notificationType,
         ticketId: ticketId,
         ticket: ticket,
         userId: userId,
         user: user,
         seenUserList: seenUserList,
       );

  /// Returns a shallow copy of this [PlannerNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlannerNotification copyWith({
    Object? id = _Undefined,
    String? notification,
    String? notificationType,
    _i1.UuidValue? ticketId,
    Object? ticket = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    List<_i1.UuidValue>? seenUserList,
  }) {
    return PlannerNotification(
      id: id is _i1.UuidValue? ? id : this.id,
      notification: notification ?? this.notification,
      notificationType: notificationType ?? this.notificationType,
      ticketId: ticketId ?? this.ticketId,
      ticket: ticket is _i2.Ticket? ? ticket : this.ticket?.copyWith(),
      userId: userId ?? this.userId,
      user: user is _i3.User? ? user : this.user?.copyWith(),
      seenUserList: seenUserList ?? this.seenUserList.map((e0) => e0).toList(),
    );
  }
}
