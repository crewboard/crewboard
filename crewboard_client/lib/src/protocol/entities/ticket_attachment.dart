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
import 'package:crewboard_client/src/protocol/protocol.dart' as _i3;

abstract class TicketAttachment implements _i1.SerializableModel {
  TicketAttachment._({
    this.id,
    required this.ticketId,
    this.ticket,
    required this.attachmentName,
    required this.attachmentSize,
    required this.attachmentUrl,
    required this.attachmentType,
  });

  factory TicketAttachment({
    _i1.UuidValue? id,
    required _i1.UuidValue ticketId,
    _i2.Ticket? ticket,
    required String attachmentName,
    required double attachmentSize,
    required String attachmentUrl,
    required String attachmentType,
  }) = _TicketAttachmentImpl;

  factory TicketAttachment.fromJson(Map<String, dynamic> jsonSerialization) {
    return TicketAttachment(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ticketId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['ticketId'],
      ),
      ticket: jsonSerialization['ticket'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Ticket>(jsonSerialization['ticket']),
      attachmentName: jsonSerialization['attachmentName'] as String,
      attachmentSize: (jsonSerialization['attachmentSize'] as num).toDouble(),
      attachmentUrl: jsonSerialization['attachmentUrl'] as String,
      attachmentType: jsonSerialization['attachmentType'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue ticketId;

  _i2.Ticket? ticket;

  String attachmentName;

  double attachmentSize;

  String attachmentUrl;

  String attachmentType;

  /// Returns a shallow copy of this [TicketAttachment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TicketAttachment copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? ticketId,
    _i2.Ticket? ticket,
    String? attachmentName,
    double? attachmentSize,
    String? attachmentUrl,
    String? attachmentType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TicketAttachment',
      if (id != null) 'id': id?.toJson(),
      'ticketId': ticketId.toJson(),
      if (ticket != null) 'ticket': ticket?.toJson(),
      'attachmentName': attachmentName,
      'attachmentSize': attachmentSize,
      'attachmentUrl': attachmentUrl,
      'attachmentType': attachmentType,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TicketAttachmentImpl extends TicketAttachment {
  _TicketAttachmentImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue ticketId,
    _i2.Ticket? ticket,
    required String attachmentName,
    required double attachmentSize,
    required String attachmentUrl,
    required String attachmentType,
  }) : super._(
         id: id,
         ticketId: ticketId,
         ticket: ticket,
         attachmentName: attachmentName,
         attachmentSize: attachmentSize,
         attachmentUrl: attachmentUrl,
         attachmentType: attachmentType,
       );

  /// Returns a shallow copy of this [TicketAttachment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TicketAttachment copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? ticketId,
    Object? ticket = _Undefined,
    String? attachmentName,
    double? attachmentSize,
    String? attachmentUrl,
    String? attachmentType,
  }) {
    return TicketAttachment(
      id: id is _i1.UuidValue? ? id : this.id,
      ticketId: ticketId ?? this.ticketId,
      ticket: ticket is _i2.Ticket? ? ticket : this.ticket?.copyWith(),
      attachmentName: attachmentName ?? this.attachmentName,
      attachmentSize: attachmentSize ?? this.attachmentSize,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      attachmentType: attachmentType ?? this.attachmentType,
    );
  }
}
