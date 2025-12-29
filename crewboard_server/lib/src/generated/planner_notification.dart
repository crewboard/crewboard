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

abstract class PlannerNotification
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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

  static final t = PlannerNotificationTable();

  static const db = PlannerNotificationRepository._();

  @override
  _i1.UuidValue? id;

  String notification;

  String notificationType;

  _i1.UuidValue ticketId;

  _i2.Ticket? ticket;

  _i1.UuidValue userId;

  _i3.User? user;

  List<_i1.UuidValue> seenUserList;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlannerNotification',
      if (id != null) 'id': id?.toJson(),
      'notification': notification,
      'notificationType': notificationType,
      'ticketId': ticketId.toJson(),
      if (ticket != null) 'ticket': ticket?.toJsonForProtocol(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      'seenUserList': seenUserList.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  static PlannerNotificationInclude include({
    _i2.TicketInclude? ticket,
    _i3.UserInclude? user,
  }) {
    return PlannerNotificationInclude._(
      ticket: ticket,
      user: user,
    );
  }

  static PlannerNotificationIncludeList includeList({
    _i1.WhereExpressionBuilder<PlannerNotificationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlannerNotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlannerNotificationTable>? orderByList,
    PlannerNotificationInclude? include,
  }) {
    return PlannerNotificationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlannerNotification.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PlannerNotification.t),
      include: include,
    );
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

class PlannerNotificationUpdateTable
    extends _i1.UpdateTable<PlannerNotificationTable> {
  PlannerNotificationUpdateTable(super.table);

  _i1.ColumnValue<String, String> notification(String value) => _i1.ColumnValue(
    table.notification,
    value,
  );

  _i1.ColumnValue<String, String> notificationType(String value) =>
      _i1.ColumnValue(
        table.notificationType,
        value,
      );

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

  _i1.ColumnValue<List<_i1.UuidValue>, List<_i1.UuidValue>> seenUserList(
    List<_i1.UuidValue> value,
  ) => _i1.ColumnValue(
    table.seenUserList,
    value,
  );
}

class PlannerNotificationTable extends _i1.Table<_i1.UuidValue?> {
  PlannerNotificationTable({super.tableRelation})
    : super(tableName: 'planner_notifications') {
    updateTable = PlannerNotificationUpdateTable(this);
    notification = _i1.ColumnString(
      'notification',
      this,
    );
    notificationType = _i1.ColumnString(
      'notificationType',
      this,
    );
    ticketId = _i1.ColumnUuid(
      'ticketId',
      this,
    );
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    seenUserList = _i1.ColumnSerializable<List<_i1.UuidValue>>(
      'seenUserList',
      this,
    );
  }

  late final PlannerNotificationUpdateTable updateTable;

  late final _i1.ColumnString notification;

  late final _i1.ColumnString notificationType;

  late final _i1.ColumnUuid ticketId;

  _i2.TicketTable? _ticket;

  late final _i1.ColumnUuid userId;

  _i3.UserTable? _user;

  late final _i1.ColumnSerializable<List<_i1.UuidValue>> seenUserList;

  _i2.TicketTable get ticket {
    if (_ticket != null) return _ticket!;
    _ticket = _i1.createRelationTable(
      relationFieldName: 'ticket',
      field: PlannerNotification.t.ticketId,
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
      field: PlannerNotification.t.userId,
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
    notification,
    notificationType,
    ticketId,
    userId,
    seenUserList,
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

class PlannerNotificationInclude extends _i1.IncludeObject {
  PlannerNotificationInclude._({
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
  _i1.Table<_i1.UuidValue?> get table => PlannerNotification.t;
}

class PlannerNotificationIncludeList extends _i1.IncludeList {
  PlannerNotificationIncludeList._({
    _i1.WhereExpressionBuilder<PlannerNotificationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PlannerNotification.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PlannerNotification.t;
}

class PlannerNotificationRepository {
  const PlannerNotificationRepository._();

  final attachRow = const PlannerNotificationAttachRowRepository._();

  /// Returns a list of [PlannerNotification]s matching the given query parameters.
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
  Future<List<PlannerNotification>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlannerNotificationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlannerNotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlannerNotificationTable>? orderByList,
    _i1.Transaction? transaction,
    PlannerNotificationInclude? include,
  }) async {
    return session.db.find<PlannerNotification>(
      where: where?.call(PlannerNotification.t),
      orderBy: orderBy?.call(PlannerNotification.t),
      orderByList: orderByList?.call(PlannerNotification.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [PlannerNotification] matching the given query parameters.
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
  Future<PlannerNotification?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlannerNotificationTable>? where,
    int? offset,
    _i1.OrderByBuilder<PlannerNotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlannerNotificationTable>? orderByList,
    _i1.Transaction? transaction,
    PlannerNotificationInclude? include,
  }) async {
    return session.db.findFirstRow<PlannerNotification>(
      where: where?.call(PlannerNotification.t),
      orderBy: orderBy?.call(PlannerNotification.t),
      orderByList: orderByList?.call(PlannerNotification.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [PlannerNotification] by its [id] or null if no such row exists.
  Future<PlannerNotification?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    PlannerNotificationInclude? include,
  }) async {
    return session.db.findById<PlannerNotification>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [PlannerNotification]s in the list and returns the inserted rows.
  ///
  /// The returned [PlannerNotification]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PlannerNotification>> insert(
    _i1.Session session,
    List<PlannerNotification> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PlannerNotification>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PlannerNotification] and returns the inserted row.
  ///
  /// The returned [PlannerNotification] will have its `id` field set.
  Future<PlannerNotification> insertRow(
    _i1.Session session,
    PlannerNotification row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PlannerNotification>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PlannerNotification]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PlannerNotification>> update(
    _i1.Session session,
    List<PlannerNotification> rows, {
    _i1.ColumnSelections<PlannerNotificationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PlannerNotification>(
      rows,
      columns: columns?.call(PlannerNotification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlannerNotification]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PlannerNotification> updateRow(
    _i1.Session session,
    PlannerNotification row, {
    _i1.ColumnSelections<PlannerNotificationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PlannerNotification>(
      row,
      columns: columns?.call(PlannerNotification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlannerNotification] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PlannerNotification?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<PlannerNotificationUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PlannerNotification>(
      id,
      columnValues: columnValues(PlannerNotification.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PlannerNotification]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PlannerNotification>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<PlannerNotificationUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<PlannerNotificationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlannerNotificationTable>? orderBy,
    _i1.OrderByListBuilder<PlannerNotificationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PlannerNotification>(
      columnValues: columnValues(PlannerNotification.t.updateTable),
      where: where(PlannerNotification.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlannerNotification.t),
      orderByList: orderByList?.call(PlannerNotification.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PlannerNotification]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PlannerNotification>> delete(
    _i1.Session session,
    List<PlannerNotification> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PlannerNotification>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PlannerNotification].
  Future<PlannerNotification> deleteRow(
    _i1.Session session,
    PlannerNotification row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PlannerNotification>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PlannerNotification>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PlannerNotificationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PlannerNotification>(
      where: where(PlannerNotification.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlannerNotificationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PlannerNotification>(
      where: where?.call(PlannerNotification.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class PlannerNotificationAttachRowRepository {
  const PlannerNotificationAttachRowRepository._();

  /// Creates a relation between the given [PlannerNotification] and [Ticket]
  /// by setting the [PlannerNotification]'s foreign key `ticketId` to refer to the [Ticket].
  Future<void> ticket(
    _i1.Session session,
    PlannerNotification plannerNotification,
    _i2.Ticket ticket, {
    _i1.Transaction? transaction,
  }) async {
    if (plannerNotification.id == null) {
      throw ArgumentError.notNull('plannerNotification.id');
    }
    if (ticket.id == null) {
      throw ArgumentError.notNull('ticket.id');
    }

    var $plannerNotification = plannerNotification.copyWith(
      ticketId: ticket.id,
    );
    await session.db.updateRow<PlannerNotification>(
      $plannerNotification,
      columns: [PlannerNotification.t.ticketId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [PlannerNotification] and [User]
  /// by setting the [PlannerNotification]'s foreign key `userId` to refer to the [User].
  Future<void> user(
    _i1.Session session,
    PlannerNotification plannerNotification,
    _i3.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (plannerNotification.id == null) {
      throw ArgumentError.notNull('plannerNotification.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $plannerNotification = plannerNotification.copyWith(userId: user.id);
    await session.db.updateRow<PlannerNotification>(
      $plannerNotification,
      columns: [PlannerNotification.t.userId],
      transaction: transaction,
    );
  }
}
