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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Ticket implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = TicketTable();

  static const db = TicketRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static TicketInclude include() {
    return TicketInclude._();
  }

  static TicketIncludeList includeList({
    _i1.WhereExpressionBuilder<TicketTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketTable>? orderByList,
    TicketInclude? include,
  }) {
    return TicketIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Ticket.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Ticket.t),
      include: include,
    );
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

class TicketUpdateTable extends _i1.UpdateTable<TicketTable> {
  TicketUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> appId(int value) => _i1.ColumnValue(
    table.appId,
    value,
  );

  _i1.ColumnValue<String, String> ticketName(String value) => _i1.ColumnValue(
    table.ticketName,
    value,
  );

  _i1.ColumnValue<String, String> ticketBody(String value) => _i1.ColumnValue(
    table.ticketBody,
    value,
  );

  _i1.ColumnValue<int, int> statusId(int value) => _i1.ColumnValue(
    table.statusId,
    value,
  );

  _i1.ColumnValue<int, int> priorityId(int value) => _i1.ColumnValue(
    table.priorityId,
    value,
  );

  _i1.ColumnValue<int, int> typeId(int value) => _i1.ColumnValue(
    table.typeId,
    value,
  );

  _i1.ColumnValue<String, String> checklist(String value) => _i1.ColumnValue(
    table.checklist,
    value,
  );

  _i1.ColumnValue<String, String> flows(String value) => _i1.ColumnValue(
    table.flows,
    value,
  );

  _i1.ColumnValue<int, int> creds(int value) => _i1.ColumnValue(
    table.creds,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> deadline(DateTime? value) =>
      _i1.ColumnValue(
        table.deadline,
        value,
      );
}

class TicketTable extends _i1.Table<int?> {
  TicketTable({super.tableRelation}) : super(tableName: 'tickets') {
    updateTable = TicketUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    appId = _i1.ColumnInt(
      'appId',
      this,
    );
    ticketName = _i1.ColumnString(
      'ticketName',
      this,
    );
    ticketBody = _i1.ColumnString(
      'ticketBody',
      this,
    );
    statusId = _i1.ColumnInt(
      'statusId',
      this,
    );
    priorityId = _i1.ColumnInt(
      'priorityId',
      this,
    );
    typeId = _i1.ColumnInt(
      'typeId',
      this,
    );
    checklist = _i1.ColumnString(
      'checklist',
      this,
    );
    flows = _i1.ColumnString(
      'flows',
      this,
    );
    creds = _i1.ColumnInt(
      'creds',
      this,
    );
    deadline = _i1.ColumnDateTime(
      'deadline',
      this,
    );
  }

  late final TicketUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt appId;

  late final _i1.ColumnString ticketName;

  late final _i1.ColumnString ticketBody;

  late final _i1.ColumnInt statusId;

  late final _i1.ColumnInt priorityId;

  late final _i1.ColumnInt typeId;

  late final _i1.ColumnString checklist;

  late final _i1.ColumnString flows;

  late final _i1.ColumnInt creds;

  late final _i1.ColumnDateTime deadline;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    appId,
    ticketName,
    ticketBody,
    statusId,
    priorityId,
    typeId,
    checklist,
    flows,
    creds,
    deadline,
  ];
}

class TicketInclude extends _i1.IncludeObject {
  TicketInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Ticket.t;
}

class TicketIncludeList extends _i1.IncludeList {
  TicketIncludeList._({
    _i1.WhereExpressionBuilder<TicketTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Ticket.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Ticket.t;
}

class TicketRepository {
  const TicketRepository._();

  /// Returns a list of [Ticket]s matching the given query parameters.
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
  Future<List<Ticket>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Ticket>(
      where: where?.call(Ticket.t),
      orderBy: orderBy?.call(Ticket.t),
      orderByList: orderByList?.call(Ticket.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Ticket] matching the given query parameters.
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
  Future<Ticket?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketTable>? where,
    int? offset,
    _i1.OrderByBuilder<TicketTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Ticket>(
      where: where?.call(Ticket.t),
      orderBy: orderBy?.call(Ticket.t),
      orderByList: orderByList?.call(Ticket.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Ticket] by its [id] or null if no such row exists.
  Future<Ticket?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Ticket>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Ticket]s in the list and returns the inserted rows.
  ///
  /// The returned [Ticket]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Ticket>> insert(
    _i1.Session session,
    List<Ticket> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Ticket>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Ticket] and returns the inserted row.
  ///
  /// The returned [Ticket] will have its `id` field set.
  Future<Ticket> insertRow(
    _i1.Session session,
    Ticket row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Ticket>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Ticket]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Ticket>> update(
    _i1.Session session,
    List<Ticket> rows, {
    _i1.ColumnSelections<TicketTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Ticket>(
      rows,
      columns: columns?.call(Ticket.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Ticket]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Ticket> updateRow(
    _i1.Session session,
    Ticket row, {
    _i1.ColumnSelections<TicketTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Ticket>(
      row,
      columns: columns?.call(Ticket.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Ticket] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Ticket?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<TicketUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Ticket>(
      id,
      columnValues: columnValues(Ticket.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Ticket]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Ticket>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<TicketUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TicketTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketTable>? orderBy,
    _i1.OrderByListBuilder<TicketTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Ticket>(
      columnValues: columnValues(Ticket.t.updateTable),
      where: where(Ticket.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Ticket.t),
      orderByList: orderByList?.call(Ticket.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Ticket]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Ticket>> delete(
    _i1.Session session,
    List<Ticket> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Ticket>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Ticket].
  Future<Ticket> deleteRow(
    _i1.Session session,
    Ticket row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Ticket>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Ticket>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TicketTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Ticket>(
      where: where(Ticket.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Ticket>(
      where: where?.call(Ticket.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
