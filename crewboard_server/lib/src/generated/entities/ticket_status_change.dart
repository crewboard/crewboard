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
import '../entities/user.dart' as _i3;
import '../entities/status.dart' as _i4;
import 'package:crewboard_server/src/generated/protocol.dart' as _i5;

abstract class TicketStatusChange
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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

  static final t = TicketStatusChangeTable();

  static const db = TicketStatusChangeRepository._();

  @override
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

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TicketStatusChange',
      if (id != null) 'id': id?.toJson(),
      'ticketId': ticketId.toJson(),
      if (ticket != null) 'ticket': ticket?.toJsonForProtocol(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      'oldStatusId': oldStatusId.toJson(),
      if (oldStatus != null) 'oldStatus': oldStatus?.toJsonForProtocol(),
      'newStatusId': newStatusId.toJson(),
      if (newStatus != null) 'newStatus': newStatus?.toJsonForProtocol(),
      if (changedAt != null) 'changedAt': changedAt?.toJson(),
    };
  }

  static TicketStatusChangeInclude include({
    _i2.TicketInclude? ticket,
    _i3.UserInclude? user,
    _i4.StatusInclude? oldStatus,
    _i4.StatusInclude? newStatus,
  }) {
    return TicketStatusChangeInclude._(
      ticket: ticket,
      user: user,
      oldStatus: oldStatus,
      newStatus: newStatus,
    );
  }

  static TicketStatusChangeIncludeList includeList({
    _i1.WhereExpressionBuilder<TicketStatusChangeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketStatusChangeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketStatusChangeTable>? orderByList,
    TicketStatusChangeInclude? include,
  }) {
    return TicketStatusChangeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TicketStatusChange.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TicketStatusChange.t),
      include: include,
    );
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

class TicketStatusChangeUpdateTable
    extends _i1.UpdateTable<TicketStatusChangeTable> {
  TicketStatusChangeUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> ticketId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.ticketId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> oldStatusId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.oldStatusId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> newStatusId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.newStatusId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> changedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.changedAt,
        value,
      );
}

class TicketStatusChangeTable extends _i1.Table<_i1.UuidValue?> {
  TicketStatusChangeTable({super.tableRelation})
    : super(tableName: 'ticket_status_change') {
    updateTable = TicketStatusChangeUpdateTable(this);
    ticketId = _i1.ColumnUuid(
      'ticketId',
      this,
    );
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    oldStatusId = _i1.ColumnUuid(
      'oldStatusId',
      this,
    );
    newStatusId = _i1.ColumnUuid(
      'newStatusId',
      this,
    );
    changedAt = _i1.ColumnDateTime(
      'changedAt',
      this,
    );
  }

  late final TicketStatusChangeUpdateTable updateTable;

  late final _i1.ColumnUuid ticketId;

  _i2.TicketTable? _ticket;

  late final _i1.ColumnUuid userId;

  _i3.UserTable? _user;

  late final _i1.ColumnUuid oldStatusId;

  _i4.StatusTable? _oldStatus;

  late final _i1.ColumnUuid newStatusId;

  _i4.StatusTable? _newStatus;

  late final _i1.ColumnDateTime changedAt;

  _i2.TicketTable get ticket {
    if (_ticket != null) return _ticket!;
    _ticket = _i1.createRelationTable(
      relationFieldName: 'ticket',
      field: TicketStatusChange.t.ticketId,
      foreignField: _i2.Ticket.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.TicketTable(tableRelation: foreignTableRelation),
    );
    return _ticket!;
  }

  _i3.UserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: TicketStatusChange.t.userId,
      foreignField: _i3.User.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.UserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i4.StatusTable get oldStatus {
    if (_oldStatus != null) return _oldStatus!;
    _oldStatus = _i1.createRelationTable(
      relationFieldName: 'oldStatus',
      field: TicketStatusChange.t.oldStatusId,
      foreignField: _i4.Status.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.StatusTable(tableRelation: foreignTableRelation),
    );
    return _oldStatus!;
  }

  _i4.StatusTable get newStatus {
    if (_newStatus != null) return _newStatus!;
    _newStatus = _i1.createRelationTable(
      relationFieldName: 'newStatus',
      field: TicketStatusChange.t.newStatusId,
      foreignField: _i4.Status.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.StatusTable(tableRelation: foreignTableRelation),
    );
    return _newStatus!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    ticketId,
    userId,
    oldStatusId,
    newStatusId,
    changedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'ticket') {
      return ticket;
    }
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'oldStatus') {
      return oldStatus;
    }
    if (relationField == 'newStatus') {
      return newStatus;
    }
    return null;
  }
}

class TicketStatusChangeInclude extends _i1.IncludeObject {
  TicketStatusChangeInclude._({
    _i2.TicketInclude? ticket,
    _i3.UserInclude? user,
    _i4.StatusInclude? oldStatus,
    _i4.StatusInclude? newStatus,
  }) {
    _ticket = ticket;
    _user = user;
    _oldStatus = oldStatus;
    _newStatus = newStatus;
  }

  _i2.TicketInclude? _ticket;

  _i3.UserInclude? _user;

  _i4.StatusInclude? _oldStatus;

  _i4.StatusInclude? _newStatus;

  @override
  Map<String, _i1.Include?> get includes => {
    'ticket': _ticket,
    'user': _user,
    'oldStatus': _oldStatus,
    'newStatus': _newStatus,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => TicketStatusChange.t;
}

class TicketStatusChangeIncludeList extends _i1.IncludeList {
  TicketStatusChangeIncludeList._({
    _i1.WhereExpressionBuilder<TicketStatusChangeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TicketStatusChange.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => TicketStatusChange.t;
}

class TicketStatusChangeRepository {
  const TicketStatusChangeRepository._();

  final attachRow = const TicketStatusChangeAttachRowRepository._();

  /// Returns a list of [TicketStatusChange]s matching the given query parameters.
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
  Future<List<TicketStatusChange>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketStatusChangeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketStatusChangeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketStatusChangeTable>? orderByList,
    _i1.Transaction? transaction,
    TicketStatusChangeInclude? include,
  }) async {
    return session.db.find<TicketStatusChange>(
      where: where?.call(TicketStatusChange.t),
      orderBy: orderBy?.call(TicketStatusChange.t),
      orderByList: orderByList?.call(TicketStatusChange.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [TicketStatusChange] matching the given query parameters.
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
  Future<TicketStatusChange?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketStatusChangeTable>? where,
    int? offset,
    _i1.OrderByBuilder<TicketStatusChangeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketStatusChangeTable>? orderByList,
    _i1.Transaction? transaction,
    TicketStatusChangeInclude? include,
  }) async {
    return session.db.findFirstRow<TicketStatusChange>(
      where: where?.call(TicketStatusChange.t),
      orderBy: orderBy?.call(TicketStatusChange.t),
      orderByList: orderByList?.call(TicketStatusChange.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [TicketStatusChange] by its [id] or null if no such row exists.
  Future<TicketStatusChange?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    TicketStatusChangeInclude? include,
  }) async {
    return session.db.findById<TicketStatusChange>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [TicketStatusChange]s in the list and returns the inserted rows.
  ///
  /// The returned [TicketStatusChange]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<TicketStatusChange>> insert(
    _i1.Session session,
    List<TicketStatusChange> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<TicketStatusChange>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [TicketStatusChange] and returns the inserted row.
  ///
  /// The returned [TicketStatusChange] will have its `id` field set.
  Future<TicketStatusChange> insertRow(
    _i1.Session session,
    TicketStatusChange row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TicketStatusChange>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TicketStatusChange]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TicketStatusChange>> update(
    _i1.Session session,
    List<TicketStatusChange> rows, {
    _i1.ColumnSelections<TicketStatusChangeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TicketStatusChange>(
      rows,
      columns: columns?.call(TicketStatusChange.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TicketStatusChange]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TicketStatusChange> updateRow(
    _i1.Session session,
    TicketStatusChange row, {
    _i1.ColumnSelections<TicketStatusChangeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TicketStatusChange>(
      row,
      columns: columns?.call(TicketStatusChange.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TicketStatusChange] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TicketStatusChange?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<TicketStatusChangeUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TicketStatusChange>(
      id,
      columnValues: columnValues(TicketStatusChange.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TicketStatusChange]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TicketStatusChange>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<TicketStatusChangeUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<TicketStatusChangeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketStatusChangeTable>? orderBy,
    _i1.OrderByListBuilder<TicketStatusChangeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TicketStatusChange>(
      columnValues: columnValues(TicketStatusChange.t.updateTable),
      where: where(TicketStatusChange.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TicketStatusChange.t),
      orderByList: orderByList?.call(TicketStatusChange.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TicketStatusChange]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TicketStatusChange>> delete(
    _i1.Session session,
    List<TicketStatusChange> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TicketStatusChange>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TicketStatusChange].
  Future<TicketStatusChange> deleteRow(
    _i1.Session session,
    TicketStatusChange row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TicketStatusChange>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TicketStatusChange>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TicketStatusChangeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TicketStatusChange>(
      where: where(TicketStatusChange.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketStatusChangeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TicketStatusChange>(
      where: where?.call(TicketStatusChange.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class TicketStatusChangeAttachRowRepository {
  const TicketStatusChangeAttachRowRepository._();

  /// Creates a relation between the given [TicketStatusChange] and [Ticket]
  /// by setting the [TicketStatusChange]'s foreign key `ticketId` to refer to the [Ticket].
  Future<void> ticket(
    _i1.Session session,
    TicketStatusChange ticketStatusChange,
    _i2.Ticket ticket, {
    _i1.Transaction? transaction,
  }) async {
    if (ticketStatusChange.id == null) {
      throw ArgumentError.notNull('ticketStatusChange.id');
    }
    if (ticket.id == null) {
      throw ArgumentError.notNull('ticket.id');
    }

    var $ticketStatusChange = ticketStatusChange.copyWith(ticketId: ticket.id);
    await session.db.updateRow<TicketStatusChange>(
      $ticketStatusChange,
      columns: [TicketStatusChange.t.ticketId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TicketStatusChange] and [User]
  /// by setting the [TicketStatusChange]'s foreign key `userId` to refer to the [User].
  Future<void> user(
    _i1.Session session,
    TicketStatusChange ticketStatusChange,
    _i3.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (ticketStatusChange.id == null) {
      throw ArgumentError.notNull('ticketStatusChange.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $ticketStatusChange = ticketStatusChange.copyWith(userId: user.id);
    await session.db.updateRow<TicketStatusChange>(
      $ticketStatusChange,
      columns: [TicketStatusChange.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TicketStatusChange] and [Status]
  /// by setting the [TicketStatusChange]'s foreign key `oldStatusId` to refer to the [Status].
  Future<void> oldStatus(
    _i1.Session session,
    TicketStatusChange ticketStatusChange,
    _i4.Status oldStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (ticketStatusChange.id == null) {
      throw ArgumentError.notNull('ticketStatusChange.id');
    }
    if (oldStatus.id == null) {
      throw ArgumentError.notNull('oldStatus.id');
    }

    var $ticketStatusChange = ticketStatusChange.copyWith(
      oldStatusId: oldStatus.id,
    );
    await session.db.updateRow<TicketStatusChange>(
      $ticketStatusChange,
      columns: [TicketStatusChange.t.oldStatusId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TicketStatusChange] and [Status]
  /// by setting the [TicketStatusChange]'s foreign key `newStatusId` to refer to the [Status].
  Future<void> newStatus(
    _i1.Session session,
    TicketStatusChange ticketStatusChange,
    _i4.Status newStatus, {
    _i1.Transaction? transaction,
  }) async {
    if (ticketStatusChange.id == null) {
      throw ArgumentError.notNull('ticketStatusChange.id');
    }
    if (newStatus.id == null) {
      throw ArgumentError.notNull('newStatus.id');
    }

    var $ticketStatusChange = ticketStatusChange.copyWith(
      newStatusId: newStatus.id,
    );
    await session.db.updateRow<TicketStatusChange>(
      $ticketStatusChange,
      columns: [TicketStatusChange.t.newStatusId],
      transaction: transaction,
    );
  }
}
