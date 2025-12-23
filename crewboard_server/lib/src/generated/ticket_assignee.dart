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
import 'ticket.dart' as _i2;
import 'user.dart' as _i3;
import 'package:crewboard_server/src/generated/protocol.dart' as _i4;

abstract class TicketAssignee
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TicketAssignee._({
    this.id,
    required this.ticketId,
    this.ticket,
    required this.userId,
    this.user,
  });

  factory TicketAssignee({
    int? id,
    required int ticketId,
    _i2.Ticket? ticket,
    required int userId,
    _i3.User? user,
  }) = _TicketAssigneeImpl;

  factory TicketAssignee.fromJson(Map<String, dynamic> jsonSerialization) {
    return TicketAssignee(
      id: jsonSerialization['id'] as int?,
      ticketId: jsonSerialization['ticketId'] as int,
      ticket: jsonSerialization['ticket'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Ticket>(jsonSerialization['ticket']),
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.User>(jsonSerialization['user']),
    );
  }

  static final t = TicketAssigneeTable();

  static const db = TicketAssigneeRepository._();

  @override
  int? id;

  int ticketId;

  _i2.Ticket? ticket;

  int userId;

  _i3.User? user;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TicketAssignee]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TicketAssignee copyWith({
    int? id,
    int? ticketId,
    _i2.Ticket? ticket,
    int? userId,
    _i3.User? user,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TicketAssignee',
      if (id != null) 'id': id,
      'ticketId': ticketId,
      if (ticket != null) 'ticket': ticket?.toJson(),
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TicketAssignee',
      if (id != null) 'id': id,
      'ticketId': ticketId,
      if (ticket != null) 'ticket': ticket?.toJsonForProtocol(),
      'userId': userId,
      if (user != null) 'user': user?.toJsonForProtocol(),
    };
  }

  static TicketAssigneeInclude include({
    _i2.TicketInclude? ticket,
    _i3.UserInclude? user,
  }) {
    return TicketAssigneeInclude._(
      ticket: ticket,
      user: user,
    );
  }

  static TicketAssigneeIncludeList includeList({
    _i1.WhereExpressionBuilder<TicketAssigneeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketAssigneeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketAssigneeTable>? orderByList,
    TicketAssigneeInclude? include,
  }) {
    return TicketAssigneeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TicketAssignee.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TicketAssignee.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TicketAssigneeImpl extends TicketAssignee {
  _TicketAssigneeImpl({
    int? id,
    required int ticketId,
    _i2.Ticket? ticket,
    required int userId,
    _i3.User? user,
  }) : super._(
         id: id,
         ticketId: ticketId,
         ticket: ticket,
         userId: userId,
         user: user,
       );

  /// Returns a shallow copy of this [TicketAssignee]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TicketAssignee copyWith({
    Object? id = _Undefined,
    int? ticketId,
    Object? ticket = _Undefined,
    int? userId,
    Object? user = _Undefined,
  }) {
    return TicketAssignee(
      id: id is int? ? id : this.id,
      ticketId: ticketId ?? this.ticketId,
      ticket: ticket is _i2.Ticket? ? ticket : this.ticket?.copyWith(),
      userId: userId ?? this.userId,
      user: user is _i3.User? ? user : this.user?.copyWith(),
    );
  }
}

class TicketAssigneeUpdateTable extends _i1.UpdateTable<TicketAssigneeTable> {
  TicketAssigneeUpdateTable(super.table);

  _i1.ColumnValue<int, int> ticketId(int value) => _i1.ColumnValue(
    table.ticketId,
    value,
  );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );
}

class TicketAssigneeTable extends _i1.Table<int?> {
  TicketAssigneeTable({super.tableRelation})
    : super(tableName: 'ticket_assignee') {
    updateTable = TicketAssigneeUpdateTable(this);
    ticketId = _i1.ColumnInt(
      'ticketId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
  }

  late final TicketAssigneeUpdateTable updateTable;

  late final _i1.ColumnInt ticketId;

  _i2.TicketTable? _ticket;

  late final _i1.ColumnInt userId;

  _i3.UserTable? _user;

  _i2.TicketTable get ticket {
    if (_ticket != null) return _ticket!;
    _ticket = _i1.createRelationTable(
      relationFieldName: 'ticket',
      field: TicketAssignee.t.ticketId,
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
      field: TicketAssignee.t.userId,
      foreignField: _i3.User.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.UserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    ticketId,
    userId,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'ticket') {
      return ticket;
    }
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class TicketAssigneeInclude extends _i1.IncludeObject {
  TicketAssigneeInclude._({
    _i2.TicketInclude? ticket,
    _i3.UserInclude? user,
  }) {
    _ticket = ticket;
    _user = user;
  }

  _i2.TicketInclude? _ticket;

  _i3.UserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {
    'ticket': _ticket,
    'user': _user,
  };

  @override
  _i1.Table<int?> get table => TicketAssignee.t;
}

class TicketAssigneeIncludeList extends _i1.IncludeList {
  TicketAssigneeIncludeList._({
    _i1.WhereExpressionBuilder<TicketAssigneeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TicketAssignee.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TicketAssignee.t;
}

class TicketAssigneeRepository {
  const TicketAssigneeRepository._();

  final attachRow = const TicketAssigneeAttachRowRepository._();

  /// Returns a list of [TicketAssignee]s matching the given query parameters.
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
  Future<List<TicketAssignee>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketAssigneeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketAssigneeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketAssigneeTable>? orderByList,
    _i1.Transaction? transaction,
    TicketAssigneeInclude? include,
  }) async {
    return session.db.find<TicketAssignee>(
      where: where?.call(TicketAssignee.t),
      orderBy: orderBy?.call(TicketAssignee.t),
      orderByList: orderByList?.call(TicketAssignee.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [TicketAssignee] matching the given query parameters.
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
  Future<TicketAssignee?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketAssigneeTable>? where,
    int? offset,
    _i1.OrderByBuilder<TicketAssigneeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketAssigneeTable>? orderByList,
    _i1.Transaction? transaction,
    TicketAssigneeInclude? include,
  }) async {
    return session.db.findFirstRow<TicketAssignee>(
      where: where?.call(TicketAssignee.t),
      orderBy: orderBy?.call(TicketAssignee.t),
      orderByList: orderByList?.call(TicketAssignee.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [TicketAssignee] by its [id] or null if no such row exists.
  Future<TicketAssignee?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    TicketAssigneeInclude? include,
  }) async {
    return session.db.findById<TicketAssignee>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [TicketAssignee]s in the list and returns the inserted rows.
  ///
  /// The returned [TicketAssignee]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<TicketAssignee>> insert(
    _i1.Session session,
    List<TicketAssignee> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<TicketAssignee>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [TicketAssignee] and returns the inserted row.
  ///
  /// The returned [TicketAssignee] will have its `id` field set.
  Future<TicketAssignee> insertRow(
    _i1.Session session,
    TicketAssignee row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TicketAssignee>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TicketAssignee]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TicketAssignee>> update(
    _i1.Session session,
    List<TicketAssignee> rows, {
    _i1.ColumnSelections<TicketAssigneeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TicketAssignee>(
      rows,
      columns: columns?.call(TicketAssignee.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TicketAssignee]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TicketAssignee> updateRow(
    _i1.Session session,
    TicketAssignee row, {
    _i1.ColumnSelections<TicketAssigneeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TicketAssignee>(
      row,
      columns: columns?.call(TicketAssignee.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TicketAssignee] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TicketAssignee?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<TicketAssigneeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TicketAssignee>(
      id,
      columnValues: columnValues(TicketAssignee.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TicketAssignee]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TicketAssignee>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<TicketAssigneeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TicketAssigneeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketAssigneeTable>? orderBy,
    _i1.OrderByListBuilder<TicketAssigneeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TicketAssignee>(
      columnValues: columnValues(TicketAssignee.t.updateTable),
      where: where(TicketAssignee.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TicketAssignee.t),
      orderByList: orderByList?.call(TicketAssignee.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TicketAssignee]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TicketAssignee>> delete(
    _i1.Session session,
    List<TicketAssignee> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TicketAssignee>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TicketAssignee].
  Future<TicketAssignee> deleteRow(
    _i1.Session session,
    TicketAssignee row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TicketAssignee>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TicketAssignee>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TicketAssigneeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TicketAssignee>(
      where: where(TicketAssignee.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketAssigneeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TicketAssignee>(
      where: where?.call(TicketAssignee.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class TicketAssigneeAttachRowRepository {
  const TicketAssigneeAttachRowRepository._();

  /// Creates a relation between the given [TicketAssignee] and [Ticket]
  /// by setting the [TicketAssignee]'s foreign key `ticketId` to refer to the [Ticket].
  Future<void> ticket(
    _i1.Session session,
    TicketAssignee ticketAssignee,
    _i2.Ticket ticket, {
    _i1.Transaction? transaction,
  }) async {
    if (ticketAssignee.id == null) {
      throw ArgumentError.notNull('ticketAssignee.id');
    }
    if (ticket.id == null) {
      throw ArgumentError.notNull('ticket.id');
    }

    var $ticketAssignee = ticketAssignee.copyWith(ticketId: ticket.id);
    await session.db.updateRow<TicketAssignee>(
      $ticketAssignee,
      columns: [TicketAssignee.t.ticketId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TicketAssignee] and [User]
  /// by setting the [TicketAssignee]'s foreign key `userId` to refer to the [User].
  Future<void> user(
    _i1.Session session,
    TicketAssignee ticketAssignee,
    _i3.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (ticketAssignee.id == null) {
      throw ArgumentError.notNull('ticketAssignee.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $ticketAssignee = ticketAssignee.copyWith(userId: user.id);
    await session.db.updateRow<TicketAssignee>(
      $ticketAssignee,
      columns: [TicketAssignee.t.userId],
      transaction: transaction,
    );
  }
}
