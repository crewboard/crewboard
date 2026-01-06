/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../entities/ticket.dart' as _i2;
import 'package:crewboard_server/src/generated/protocol.dart' as _i3;

abstract class TicketAttachment
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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

  static final t = TicketAttachmentTable();

  static const db = TicketAttachmentRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue ticketId;

  _i2.Ticket? ticket;

  String attachmentName;

  double attachmentSize;

  String attachmentUrl;

  String attachmentType;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TicketAttachment',
      if (id != null) 'id': id?.toJson(),
      'ticketId': ticketId.toJson(),
      if (ticket != null) 'ticket': ticket?.toJsonForProtocol(),
      'attachmentName': attachmentName,
      'attachmentSize': attachmentSize,
      'attachmentUrl': attachmentUrl,
      'attachmentType': attachmentType,
    };
  }

  static TicketAttachmentInclude include({_i2.TicketInclude? ticket}) {
    return TicketAttachmentInclude._(ticket: ticket);
  }

  static TicketAttachmentIncludeList includeList({
    _i1.WhereExpressionBuilder<TicketAttachmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketAttachmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketAttachmentTable>? orderByList,
    TicketAttachmentInclude? include,
  }) {
    return TicketAttachmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TicketAttachment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TicketAttachment.t),
      include: include,
    );
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

class TicketAttachmentUpdateTable
    extends _i1.UpdateTable<TicketAttachmentTable> {
  TicketAttachmentUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> ticketId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.ticketId,
        value,
      );

  _i1.ColumnValue<String, String> attachmentName(String value) =>
      _i1.ColumnValue(
        table.attachmentName,
        value,
      );

  _i1.ColumnValue<double, double> attachmentSize(double value) =>
      _i1.ColumnValue(
        table.attachmentSize,
        value,
      );

  _i1.ColumnValue<String, String> attachmentUrl(String value) =>
      _i1.ColumnValue(
        table.attachmentUrl,
        value,
      );

  _i1.ColumnValue<String, String> attachmentType(String value) =>
      _i1.ColumnValue(
        table.attachmentType,
        value,
      );
}

class TicketAttachmentTable extends _i1.Table<_i1.UuidValue?> {
  TicketAttachmentTable({super.tableRelation})
    : super(tableName: 'ticket_attachments') {
    updateTable = TicketAttachmentUpdateTable(this);
    ticketId = _i1.ColumnUuid(
      'ticketId',
      this,
    );
    attachmentName = _i1.ColumnString(
      'attachmentName',
      this,
    );
    attachmentSize = _i1.ColumnDouble(
      'attachmentSize',
      this,
    );
    attachmentUrl = _i1.ColumnString(
      'attachmentUrl',
      this,
    );
    attachmentType = _i1.ColumnString(
      'attachmentType',
      this,
    );
  }

  late final TicketAttachmentUpdateTable updateTable;

  late final _i1.ColumnUuid ticketId;

  _i2.TicketTable? _ticket;

  late final _i1.ColumnString attachmentName;

  late final _i1.ColumnDouble attachmentSize;

  late final _i1.ColumnString attachmentUrl;

  late final _i1.ColumnString attachmentType;

  _i2.TicketTable get ticket {
    if (_ticket != null) return _ticket!;
    _ticket = _i1.createRelationTable(
      relationFieldName: 'ticket',
      field: TicketAttachment.t.ticketId,
      foreignField: _i2.Ticket.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.TicketTable(tableRelation: foreignTableRelation),
    );
    return _ticket!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    ticketId,
    attachmentName,
    attachmentSize,
    attachmentUrl,
    attachmentType,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'ticket') {
      return ticket;
    }
    return null;
  }
}

class TicketAttachmentInclude extends _i1.IncludeObject {
  TicketAttachmentInclude._({_i2.TicketInclude? ticket}) {
    _ticket = ticket;
  }

  _i2.TicketInclude? _ticket;

  @override
  Map<String, _i1.Include?> get includes => {'ticket': _ticket};

  @override
  _i1.Table<_i1.UuidValue?> get table => TicketAttachment.t;
}

class TicketAttachmentIncludeList extends _i1.IncludeList {
  TicketAttachmentIncludeList._({
    _i1.WhereExpressionBuilder<TicketAttachmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TicketAttachment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => TicketAttachment.t;
}

class TicketAttachmentRepository {
  const TicketAttachmentRepository._();

  final attachRow = const TicketAttachmentAttachRowRepository._();

  /// Returns a list of [TicketAttachment]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<TicketAttachment>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketAttachmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketAttachmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketAttachmentTable>? orderByList,
    _i1.Transaction? transaction,
    TicketAttachmentInclude? include,
  }) async {
    return session.db.find<TicketAttachment>(
      where: where?.call(TicketAttachment.t),
      orderBy: orderBy?.call(TicketAttachment.t),
      orderByList: orderByList?.call(TicketAttachment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [TicketAttachment] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<TicketAttachment?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketAttachmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<TicketAttachmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketAttachmentTable>? orderByList,
    _i1.Transaction? transaction,
    TicketAttachmentInclude? include,
  }) async {
    return session.db.findFirstRow<TicketAttachment>(
      where: where?.call(TicketAttachment.t),
      orderBy: orderBy?.call(TicketAttachment.t),
      orderByList: orderByList?.call(TicketAttachment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [TicketAttachment] by its [id] or null if no such row exists.
  Future<TicketAttachment?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    TicketAttachmentInclude? include,
  }) async {
    return session.db.findById<TicketAttachment>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [TicketAttachment]s in the list and returns the inserted rows.
  ///
  /// The returned [TicketAttachment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<TicketAttachment>> insert(
    _i1.Session session,
    List<TicketAttachment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<TicketAttachment>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [TicketAttachment] and returns the inserted row.
  ///
  /// The returned [TicketAttachment] will have its `id` field set.
  Future<TicketAttachment> insertRow(
    _i1.Session session,
    TicketAttachment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TicketAttachment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TicketAttachment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TicketAttachment>> update(
    _i1.Session session,
    List<TicketAttachment> rows, {
    _i1.ColumnSelections<TicketAttachmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TicketAttachment>(
      rows,
      columns: columns?.call(TicketAttachment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TicketAttachment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TicketAttachment> updateRow(
    _i1.Session session,
    TicketAttachment row, {
    _i1.ColumnSelections<TicketAttachmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TicketAttachment>(
      row,
      columns: columns?.call(TicketAttachment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TicketAttachment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TicketAttachment?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<TicketAttachmentUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TicketAttachment>(
      id,
      columnValues: columnValues(TicketAttachment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TicketAttachment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TicketAttachment>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<TicketAttachmentUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<TicketAttachmentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketAttachmentTable>? orderBy,
    _i1.OrderByListBuilder<TicketAttachmentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TicketAttachment>(
      columnValues: columnValues(TicketAttachment.t.updateTable),
      where: where(TicketAttachment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TicketAttachment.t),
      orderByList: orderByList?.call(TicketAttachment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TicketAttachment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TicketAttachment>> delete(
    _i1.Session session,
    List<TicketAttachment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TicketAttachment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TicketAttachment].
  Future<TicketAttachment> deleteRow(
    _i1.Session session,
    TicketAttachment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TicketAttachment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TicketAttachment>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TicketAttachmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TicketAttachment>(
      where: where(TicketAttachment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketAttachmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TicketAttachment>(
      where: where?.call(TicketAttachment.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class TicketAttachmentAttachRowRepository {
  const TicketAttachmentAttachRowRepository._();

  /// Creates a relation between the given [TicketAttachment] and [Ticket]
  /// by setting the [TicketAttachment]'s foreign key `ticketId` to refer to the [Ticket].
  Future<void> ticket(
    _i1.Session session,
    TicketAttachment ticketAttachment,
    _i2.Ticket ticket, {
    _i1.Transaction? transaction,
  }) async {
    if (ticketAttachment.id == null) {
      throw ArgumentError.notNull('ticketAttachment.id');
    }
    if (ticket.id == null) {
      throw ArgumentError.notNull('ticket.id');
    }

    var $ticketAttachment = ticketAttachment.copyWith(ticketId: ticket.id);
    await session.db.updateRow<TicketAttachment>(
      $ticketAttachment,
      columns: [TicketAttachment.t.ticketId],
      transaction: transaction,
    );
  }
}
