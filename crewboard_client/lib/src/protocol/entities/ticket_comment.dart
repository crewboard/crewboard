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
import '../entities/ticket.dart' as _i2;
import '../entities/user.dart' as _i3;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i4;

abstract class TicketComment implements _i1.SerializableModel {
  TicketComment._({
    this.id,
    required this.ticketId,
    this.ticket,
    required this.userId,
    this.user,
    required this.message,
    this.createdAt,
  });

  factory TicketComment({
    _i1.UuidValue? id,
    required _i1.UuidValue ticketId,
    _i2.Ticket? ticket,
    required _i1.UuidValue userId,
    _i3.User? user,
    required String message,
    DateTime? createdAt,
  }) = _TicketCommentImpl;

  factory TicketComment.fromJson(Map<String, dynamic> jsonSerialization) {
    return TicketComment(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
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
      message: jsonSerialization['message'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
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

  String message;

  DateTime? createdAt;

  /// Returns a shallow copy of this [TicketComment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TicketComment copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? ticketId,
    _i2.Ticket? ticket,
    _i1.UuidValue? userId,
    _i3.User? user,
    String? message,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TicketComment',
      if (id != null) 'id': id?.toJson(),
      'ticketId': ticketId.toJson(),
      if (ticket != null) 'ticket': ticket?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'message': message,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TicketCommentImpl extends TicketComment {
  _TicketCommentImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue ticketId,
    _i2.Ticket? ticket,
    required _i1.UuidValue userId,
    _i3.User? user,
    required String message,
    DateTime? createdAt,
  }) : super._(
         id: id,
         ticketId: ticketId,
         ticket: ticket,
         userId: userId,
         user: user,
         message: message,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [TicketComment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TicketComment copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? ticketId,
    Object? ticket = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    String? message,
    Object? createdAt = _Undefined,
  }) {
    return TicketComment(
      id: id is _i1.UuidValue? ? id : this.id,
      ticketId: ticketId ?? this.ticketId,
      ticket: ticket is _i2.Ticket? ? ticket : this.ticket?.copyWith(),
      userId: userId ?? this.userId,
      user: user is _i3.User? ? user : this.user?.copyWith(),
      message: message ?? this.message,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
    );
  }
}
