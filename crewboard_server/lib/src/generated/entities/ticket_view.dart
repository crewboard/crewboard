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
import 'package:crewboard_server/src/generated/protocol.dart' as _i4;

abstract class TicketView
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  TicketView._({
    this.id,
    required this.ticketId,
    this.ticket,
    required this.userId,
    this.user,
    required this.lastRead,
  });

  factory TicketView({
    _i1.UuidValue? id,
    required _i1.UuidValue ticketId,
    _i2.Ticket? ticket,
    required _i1.UuidValue userId,
    _i3.User? user,
    required DateTime lastRead,
  }) = _TicketViewImpl;

  factory TicketView.fromJson(Map<String, dynamic> jsonSerialization) {
    return TicketView(
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
      lastRead: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastRead'],
      ),
    );
  }

  static final t = TicketViewTable();

  static const db = TicketViewRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue ticketId;

  _i2.Ticket? ticket;

  _i1.UuidValue userId;

  _i3.User? user;

  DateTime lastRead;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [TicketView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TicketView copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? ticketId,
    _i2.Ticket? ticket,
    _i1.UuidValue? userId,
    _i3.User? user,
    DateTime? lastRead,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TicketView',
      if (id != null) 'id': id?.toJson(),
      'ticketId': ticketId.toJson(),
      if (ticket != null) 'ticket': ticket?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'lastRead': lastRead.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TicketView',
      if (id != null) 'id': id?.toJson(),
      'ticketId': ticketId.toJson(),
      if (ticket != null) 'ticket': ticket?.toJsonForProtocol(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      'lastRead': lastRead.toJson(),
    };
  }

  static TicketViewInclude include({
    _i2.TicketInclude? ticket,
    _i3.UserInclude? user,
  }) {
    return TicketViewInclude._(
      ticket: ticket,
      user: user,
    );
  }

  static TicketViewIncludeList includeList({
    _i1.WhereExpressionBuilder<TicketViewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketViewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketViewTable>? orderByList,
    TicketViewInclude? include,
  }) {
    return TicketViewIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TicketView.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TicketView.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TicketViewImpl extends TicketView {
  _TicketViewImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue ticketId,
    _i2.Ticket? ticket,
    required _i1.UuidValue userId,
    _i3.User? user,
    required DateTime lastRead,
  }) : super._(
         id: id,
         ticketId: ticketId,
         ticket: ticket,
         userId: userId,
         user: user,
         lastRead: lastRead,
       );

  /// Returns a shallow copy of this [TicketView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TicketView copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? ticketId,
    Object? ticket = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    DateTime? lastRead,
  }) {
    return TicketView(
      id: id is _i1.UuidValue? ? id : this.id,
      ticketId: ticketId ?? this.ticketId,
      ticket: ticket is _i2.Ticket? ? ticket : this.ticket?.copyWith(),
      userId: userId ?? this.userId,
      user: user is _i3.User? ? user : this.user?.copyWith(),
      lastRead: lastRead ?? this.lastRead,
    );
  }
}

class TicketViewUpdateTable extends _i1.UpdateTable<TicketViewTable> {
  TicketViewUpdateTable(super.table);

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

  _i1.ColumnValue<DateTime, DateTime> lastRead(DateTime value) =>
      _i1.ColumnValue(
        table.lastRead,
        value,
      );
}

class TicketViewTable extends _i1.Table<_i1.UuidValue?> {
  TicketViewTable({super.tableRelation}) : super(tableName: 'ticket_views') {
    updateTable = TicketViewUpdateTable(this);
    ticketId = _i1.ColumnUuid(
      'ticketId',
      this,
    );
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    lastRead = _i1.ColumnDateTime(
      'lastRead',
      this,
    );
  }

  late final TicketViewUpdateTable updateTable;

  late final _i1.ColumnUuid ticketId;

  _i2.TicketTable? _ticket;

  late final _i1.ColumnUuid userId;

  _i3.UserTable? _user;

  late final _i1.ColumnDateTime lastRead;

  _i2.TicketTable get ticket {
    if (_ticket != null) return _ticket!;
    _ticket = _i1.createRelationTable(
      relationFieldName: 'ticket',
      field: TicketView.t.ticketId,
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
      field: TicketView.t.userId,
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
    lastRead,
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

class TicketViewInclude extends _i1.IncludeObject {
  TicketViewInclude._({
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
  _i1.Table<_i1.UuidValue?> get table => TicketView.t;
}

class TicketViewIncludeList extends _i1.IncludeList {
  TicketViewIncludeList._({
    _i1.WhereExpressionBuilder<TicketViewTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TicketView.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => TicketView.t;
}

class TicketViewRepository {
  const TicketViewRepository._();

  final attachRow = const TicketViewAttachRowRepository._();

  /// Returns a list of [TicketView]s matching the given query parameters.
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
  Future<List<TicketView>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketViewTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketViewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketViewTable>? orderByList,
    _i1.Transaction? transaction,
    TicketViewInclude? include,
  }) async {
    return session.db.find<TicketView>(
      where: where?.call(TicketView.t),
      orderBy: orderBy?.call(TicketView.t),
      orderByList: orderByList?.call(TicketView.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [TicketView] matching the given query parameters.
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
  Future<TicketView?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketViewTable>? where,
    int? offset,
    _i1.OrderByBuilder<TicketViewTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketViewTable>? orderByList,
    _i1.Transaction? transaction,
    TicketViewInclude? include,
  }) async {
    return session.db.findFirstRow<TicketView>(
      where: where?.call(TicketView.t),
      orderBy: orderBy?.call(TicketView.t),
      orderByList: orderByList?.call(TicketView.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [TicketView] by its [id] or null if no such row exists.
  Future<TicketView?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    TicketViewInclude? include,
  }) async {
    return session.db.findById<TicketView>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [TicketView]s in the list and returns the inserted rows.
  ///
  /// The returned [TicketView]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<TicketView>> insert(
    _i1.Session session,
    List<TicketView> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<TicketView>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [TicketView] and returns the inserted row.
  ///
  /// The returned [TicketView] will have its `id` field set.
  Future<TicketView> insertRow(
    _i1.Session session,
    TicketView row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TicketView>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TicketView]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TicketView>> update(
    _i1.Session session,
    List<TicketView> rows, {
    _i1.ColumnSelections<TicketViewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TicketView>(
      rows,
      columns: columns?.call(TicketView.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TicketView]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TicketView> updateRow(
    _i1.Session session,
    TicketView row, {
    _i1.ColumnSelections<TicketViewTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TicketView>(
      row,
      columns: columns?.call(TicketView.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TicketView] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TicketView?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<TicketViewUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TicketView>(
      id,
      columnValues: columnValues(TicketView.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TicketView]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TicketView>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<TicketViewUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TicketViewTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketViewTable>? orderBy,
    _i1.OrderByListBuilder<TicketViewTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TicketView>(
      columnValues: columnValues(TicketView.t.updateTable),
      where: where(TicketView.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TicketView.t),
      orderByList: orderByList?.call(TicketView.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TicketView]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TicketView>> delete(
    _i1.Session session,
    List<TicketView> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TicketView>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TicketView].
  Future<TicketView> deleteRow(
    _i1.Session session,
    TicketView row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TicketView>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TicketView>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TicketViewTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TicketView>(
      where: where(TicketView.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketViewTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TicketView>(
      where: where?.call(TicketView.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class TicketViewAttachRowRepository {
  const TicketViewAttachRowRepository._();

  /// Creates a relation between the given [TicketView] and [Ticket]
  /// by setting the [TicketView]'s foreign key `ticketId` to refer to the [Ticket].
  Future<void> ticket(
    _i1.Session session,
    TicketView ticketView,
    _i2.Ticket ticket, {
    _i1.Transaction? transaction,
  }) async {
    if (ticketView.id == null) {
      throw ArgumentError.notNull('ticketView.id');
    }
    if (ticket.id == null) {
      throw ArgumentError.notNull('ticket.id');
    }

    var $ticketView = ticketView.copyWith(ticketId: ticket.id);
    await session.db.updateRow<TicketView>(
      $ticketView,
      columns: [TicketView.t.ticketId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TicketView] and [User]
  /// by setting the [TicketView]'s foreign key `userId` to refer to the [User].
  Future<void> user(
    _i1.Session session,
    TicketView ticketView,
    _i3.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (ticketView.id == null) {
      throw ArgumentError.notNull('ticketView.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $ticketView = ticketView.copyWith(userId: user.id);
    await session.db.updateRow<TicketView>(
      $ticketView,
      columns: [TicketView.t.userId],
      transaction: transaction,
    );
  }
}
