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
import '../entities/user.dart' as _i2;
import '../entities/status.dart' as _i3;
import '../entities/priority.dart' as _i4;
import '../entities/ticket_type.dart' as _i5;
import '../protocols/check_model.dart' as _i6;
import 'package:crewboard_server/src/generated/protocol.dart' as _i7;

abstract class Ticket
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Ticket._({
    this.id,
    required this.userId,
    this.user,
    required this.appId,
    required this.ticketName,
    required this.ticketBody,
    required this.statusId,
    this.status,
    required this.priorityId,
    this.priority,
    required this.typeId,
    this.type,
    this.checklist,
    required this.flows,
    required this.creds,
    this.deadline,
    this.createdAt,
  });

  factory Ticket({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    required _i1.UuidValue appId,
    required String ticketName,
    required String ticketBody,
    required _i1.UuidValue statusId,
    _i3.Status? status,
    required _i1.UuidValue priorityId,
    _i4.Priority? priority,
    required _i1.UuidValue typeId,
    _i5.TicketType? type,
    List<_i6.CheckModel>? checklist,
    required String flows,
    required int creds,
    DateTime? deadline,
    DateTime? createdAt,
  }) = _TicketImpl;

  factory Ticket.fromJson(Map<String, dynamic> jsonSerialization) {
    return Ticket(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i7.Protocol().deserialize<_i2.User>(jsonSerialization['user']),
      appId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['appId']),
      ticketName: jsonSerialization['ticketName'] as String,
      ticketBody: jsonSerialization['ticketBody'] as String,
      statusId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['statusId'],
      ),
      status: jsonSerialization['status'] == null
          ? null
          : _i7.Protocol().deserialize<_i3.Status>(jsonSerialization['status']),
      priorityId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['priorityId'],
      ),
      priority: jsonSerialization['priority'] == null
          ? null
          : _i7.Protocol().deserialize<_i4.Priority>(
              jsonSerialization['priority'],
            ),
      typeId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['typeId']),
      type: jsonSerialization['type'] == null
          ? null
          : _i7.Protocol().deserialize<_i5.TicketType>(
              jsonSerialization['type'],
            ),
      checklist: jsonSerialization['checklist'] == null
          ? null
          : _i7.Protocol().deserialize<List<_i6.CheckModel>>(
              jsonSerialization['checklist'],
            ),
      flows: jsonSerialization['flows'] as String,
      creds: jsonSerialization['creds'] as int,
      deadline: jsonSerialization['deadline'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deadline']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = TicketTable();

  static const db = TicketRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue userId;

  _i2.User? user;

  _i1.UuidValue appId;

  String ticketName;

  String ticketBody;

  _i1.UuidValue statusId;

  _i3.Status? status;

  _i1.UuidValue priorityId;

  _i4.Priority? priority;

  _i1.UuidValue typeId;

  _i5.TicketType? type;

  List<_i6.CheckModel>? checklist;

  String flows;

  int creds;

  DateTime? deadline;

  DateTime? createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Ticket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Ticket copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? userId,
    _i2.User? user,
    _i1.UuidValue? appId,
    String? ticketName,
    String? ticketBody,
    _i1.UuidValue? statusId,
    _i3.Status? status,
    _i1.UuidValue? priorityId,
    _i4.Priority? priority,
    _i1.UuidValue? typeId,
    _i5.TicketType? type,
    List<_i6.CheckModel>? checklist,
    String? flows,
    int? creds,
    DateTime? deadline,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Ticket',
      if (id != null) 'id': id?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'appId': appId.toJson(),
      'ticketName': ticketName,
      'ticketBody': ticketBody,
      'statusId': statusId.toJson(),
      if (status != null) 'status': status?.toJson(),
      'priorityId': priorityId.toJson(),
      if (priority != null) 'priority': priority?.toJson(),
      'typeId': typeId.toJson(),
      if (type != null) 'type': type?.toJson(),
      if (checklist != null)
        'checklist': checklist?.toJson(valueToJson: (v) => v.toJson()),
      'flows': flows,
      'creds': creds,
      if (deadline != null) 'deadline': deadline?.toJson(),
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Ticket',
      if (id != null) 'id': id?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      'appId': appId.toJson(),
      'ticketName': ticketName,
      'ticketBody': ticketBody,
      'statusId': statusId.toJson(),
      if (status != null) 'status': status?.toJsonForProtocol(),
      'priorityId': priorityId.toJson(),
      if (priority != null) 'priority': priority?.toJsonForProtocol(),
      'typeId': typeId.toJson(),
      if (type != null) 'type': type?.toJsonForProtocol(),
      if (checklist != null)
        'checklist': checklist?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      'flows': flows,
      'creds': creds,
      if (deadline != null) 'deadline': deadline?.toJson(),
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  static TicketInclude include({
    _i2.UserInclude? user,
    _i3.StatusInclude? status,
    _i4.PriorityInclude? priority,
    _i5.TicketTypeInclude? type,
  }) {
    return TicketInclude._(
      user: user,
      status: status,
      priority: priority,
      type: type,
    );
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
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    required _i1.UuidValue appId,
    required String ticketName,
    required String ticketBody,
    required _i1.UuidValue statusId,
    _i3.Status? status,
    required _i1.UuidValue priorityId,
    _i4.Priority? priority,
    required _i1.UuidValue typeId,
    _i5.TicketType? type,
    List<_i6.CheckModel>? checklist,
    required String flows,
    required int creds,
    DateTime? deadline,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         appId: appId,
         ticketName: ticketName,
         ticketBody: ticketBody,
         statusId: statusId,
         status: status,
         priorityId: priorityId,
         priority: priority,
         typeId: typeId,
         type: type,
         checklist: checklist,
         flows: flows,
         creds: creds,
         deadline: deadline,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Ticket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Ticket copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    _i1.UuidValue? appId,
    String? ticketName,
    String? ticketBody,
    _i1.UuidValue? statusId,
    Object? status = _Undefined,
    _i1.UuidValue? priorityId,
    Object? priority = _Undefined,
    _i1.UuidValue? typeId,
    Object? type = _Undefined,
    Object? checklist = _Undefined,
    String? flows,
    int? creds,
    Object? deadline = _Undefined,
    Object? createdAt = _Undefined,
  }) {
    return Ticket(
      id: id is _i1.UuidValue? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      appId: appId ?? this.appId,
      ticketName: ticketName ?? this.ticketName,
      ticketBody: ticketBody ?? this.ticketBody,
      statusId: statusId ?? this.statusId,
      status: status is _i3.Status? ? status : this.status?.copyWith(),
      priorityId: priorityId ?? this.priorityId,
      priority: priority is _i4.Priority?
          ? priority
          : this.priority?.copyWith(),
      typeId: typeId ?? this.typeId,
      type: type is _i5.TicketType? ? type : this.type?.copyWith(),
      checklist: checklist is List<_i6.CheckModel>?
          ? checklist
          : this.checklist?.map((e0) => e0.copyWith()).toList(),
      flows: flows ?? this.flows,
      creds: creds ?? this.creds,
      deadline: deadline is DateTime? ? deadline : this.deadline,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
    );
  }
}

class TicketUpdateTable extends _i1.UpdateTable<TicketTable> {
  TicketUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> appId(_i1.UuidValue value) =>
      _i1.ColumnValue(
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

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> statusId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.statusId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> priorityId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.priorityId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> typeId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.typeId,
        value,
      );

  _i1.ColumnValue<List<_i6.CheckModel>, List<_i6.CheckModel>> checklist(
    List<_i6.CheckModel>? value,
  ) => _i1.ColumnValue(
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

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class TicketTable extends _i1.Table<_i1.UuidValue?> {
  TicketTable({super.tableRelation}) : super(tableName: 'tickets') {
    updateTable = TicketUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    appId = _i1.ColumnUuid(
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
    statusId = _i1.ColumnUuid(
      'statusId',
      this,
    );
    priorityId = _i1.ColumnUuid(
      'priorityId',
      this,
    );
    typeId = _i1.ColumnUuid(
      'typeId',
      this,
    );
    checklist = _i1.ColumnSerializable<List<_i6.CheckModel>>(
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
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final TicketUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  _i2.UserTable? _user;

  late final _i1.ColumnUuid appId;

  late final _i1.ColumnString ticketName;

  late final _i1.ColumnString ticketBody;

  late final _i1.ColumnUuid statusId;

  _i3.StatusTable? _status;

  late final _i1.ColumnUuid priorityId;

  _i4.PriorityTable? _priority;

  late final _i1.ColumnUuid typeId;

  _i5.TicketTypeTable? _type;

  late final _i1.ColumnSerializable<List<_i6.CheckModel>> checklist;

  late final _i1.ColumnString flows;

  late final _i1.ColumnInt creds;

  late final _i1.ColumnDateTime deadline;

  late final _i1.ColumnDateTime createdAt;

  _i2.UserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: Ticket.t.userId,
      foreignField: _i2.User.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  _i3.StatusTable get status {
    if (_status != null) return _status!;
    _status = _i1.createRelationTable(
      relationFieldName: 'status',
      field: Ticket.t.statusId,
      foreignField: _i3.Status.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.StatusTable(tableRelation: foreignTableRelation),
    );
    return _status!;
  }

  _i4.PriorityTable get priority {
    if (_priority != null) return _priority!;
    _priority = _i1.createRelationTable(
      relationFieldName: 'priority',
      field: Ticket.t.priorityId,
      foreignField: _i4.Priority.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.PriorityTable(tableRelation: foreignTableRelation),
    );
    return _priority!;
  }

  _i5.TicketTypeTable get type {
    if (_type != null) return _type!;
    _type = _i1.createRelationTable(
      relationFieldName: 'type',
      field: Ticket.t.typeId,
      foreignField: _i5.TicketType.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.TicketTypeTable(tableRelation: foreignTableRelation),
    );
    return _type!;
  }

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
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    if (relationField == 'status') {
      return status;
    }
    if (relationField == 'priority') {
      return priority;
    }
    if (relationField == 'type') {
      return type;
    }
    return null;
  }
}

class TicketInclude extends _i1.IncludeObject {
  TicketInclude._({
    _i2.UserInclude? user,
    _i3.StatusInclude? status,
    _i4.PriorityInclude? priority,
    _i5.TicketTypeInclude? type,
  }) {
    _user = user;
    _status = status;
    _priority = priority;
    _type = type;
  }

  _i2.UserInclude? _user;

  _i3.StatusInclude? _status;

  _i4.PriorityInclude? _priority;

  _i5.TicketTypeInclude? _type;

  @override
  Map<String, _i1.Include?> get includes => {
    'user': _user,
    'status': _status,
    'priority': _priority,
    'type': _type,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => Ticket.t;
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
  _i1.Table<_i1.UuidValue?> get table => Ticket.t;
}

class TicketRepository {
  const TicketRepository._();

  final attachRow = const TicketAttachRowRepository._();

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
    TicketInclude? include,
  }) async {
    return session.db.find<Ticket>(
      where: where?.call(Ticket.t),
      orderBy: orderBy?.call(Ticket.t),
      orderByList: orderByList?.call(Ticket.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    TicketInclude? include,
  }) async {
    return session.db.findFirstRow<Ticket>(
      where: where?.call(Ticket.t),
      orderBy: orderBy?.call(Ticket.t),
      orderByList: orderByList?.call(Ticket.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Ticket] by its [id] or null if no such row exists.
  Future<Ticket?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    TicketInclude? include,
  }) async {
    return session.db.findById<Ticket>(
      id,
      transaction: transaction,
      include: include,
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
    _i1.UuidValue id, {
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

class TicketAttachRowRepository {
  const TicketAttachRowRepository._();

  /// Creates a relation between the given [Ticket] and [User]
  /// by setting the [Ticket]'s foreign key `userId` to refer to the [User].
  Future<void> user(
    _i1.Session session,
    Ticket ticket,
    _i2.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (ticket.id == null) {
      throw ArgumentError.notNull('ticket.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $ticket = ticket.copyWith(userId: user.id);
    await session.db.updateRow<Ticket>(
      $ticket,
      columns: [Ticket.t.userId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Ticket] and [Status]
  /// by setting the [Ticket]'s foreign key `statusId` to refer to the [Status].
  Future<void> status(
    _i1.Session session,
    Ticket ticket,
    _i3.Status status, {
    _i1.Transaction? transaction,
  }) async {
    if (ticket.id == null) {
      throw ArgumentError.notNull('ticket.id');
    }
    if (status.id == null) {
      throw ArgumentError.notNull('status.id');
    }

    var $ticket = ticket.copyWith(statusId: status.id);
    await session.db.updateRow<Ticket>(
      $ticket,
      columns: [Ticket.t.statusId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Ticket] and [Priority]
  /// by setting the [Ticket]'s foreign key `priorityId` to refer to the [Priority].
  Future<void> priority(
    _i1.Session session,
    Ticket ticket,
    _i4.Priority priority, {
    _i1.Transaction? transaction,
  }) async {
    if (ticket.id == null) {
      throw ArgumentError.notNull('ticket.id');
    }
    if (priority.id == null) {
      throw ArgumentError.notNull('priority.id');
    }

    var $ticket = ticket.copyWith(priorityId: priority.id);
    await session.db.updateRow<Ticket>(
      $ticket,
      columns: [Ticket.t.priorityId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Ticket] and [TicketType]
  /// by setting the [Ticket]'s foreign key `typeId` to refer to the [TicketType].
  Future<void> type(
    _i1.Session session,
    Ticket ticket,
    _i5.TicketType type, {
    _i1.Transaction? transaction,
  }) async {
    if (ticket.id == null) {
      throw ArgumentError.notNull('ticket.id');
    }
    if (type.id == null) {
      throw ArgumentError.notNull('type.id');
    }

    var $ticket = ticket.copyWith(typeId: type.id);
    await session.db.updateRow<Ticket>(
      $ticket,
      columns: [Ticket.t.typeId],
      transaction: transaction,
    );
  }
}
