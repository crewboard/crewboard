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

abstract class TicketComment
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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

  static final t = TicketCommentTable();

  static const db = TicketCommentRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue ticketId;

  _i2.Ticket? ticket;

  _i1.UuidValue userId;

  _i3.User? user;

  String message;

  DateTime? createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TicketComment',
      if (id != null) 'id': id?.toJson(),
      'ticketId': ticketId.toJson(),
      if (ticket != null) 'ticket': ticket?.toJsonForProtocol(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      'message': message,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  static TicketCommentInclude include({
    _i2.TicketInclude? ticket,
    _i3.UserInclude? user,
  }) {
    return TicketCommentInclude._(
      ticket: ticket,
      user: user,
    );
  }

  static TicketCommentIncludeList includeList({
    _i1.WhereExpressionBuilder<TicketCommentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketCommentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketCommentTable>? orderByList,
    TicketCommentInclude? include,
  }) {
    return TicketCommentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TicketComment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TicketComment.t),
      include: include,
    );
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

class TicketCommentUpdateTable extends _i1.UpdateTable<TicketCommentTable> {
  TicketCommentUpdateTable(super.table);

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

  _i1.ColumnValue<String, String> message(String value) => _i1.ColumnValue(
    table.message,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class TicketCommentTable extends _i1.Table<_i1.UuidValue?> {
  TicketCommentTable({super.tableRelation})
    : super(tableName: 'ticket_comments') {
    updateTable = TicketCommentUpdateTable(this);
    ticketId = _i1.ColumnUuid(
      'ticketId',
      this,
    );
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    message = _i1.ColumnString(
      'message',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final TicketCommentUpdateTable updateTable;

  late final _i1.ColumnUuid ticketId;

  _i2.TicketTable? _ticket;

  late final _i1.ColumnUuid userId;

  _i3.UserTable? _user;

  late final _i1.ColumnString message;

  late final _i1.ColumnDateTime createdAt;

  _i2.TicketTable get ticket {
    if (_ticket != null) return _ticket!;
    _ticket = _i1.createRelationTable(
      relationFieldName: 'ticket',
      field: TicketComment.t.ticketId,
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
      field: TicketComment.t.userId,
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
    message,
    createdAt,
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

class TicketCommentInclude extends _i1.IncludeObject {
  TicketCommentInclude._({
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
  _i1.Table<_i1.UuidValue?> get table => TicketComment.t;
}

class TicketCommentIncludeList extends _i1.IncludeList {
  TicketCommentIncludeList._({
    _i1.WhereExpressionBuilder<TicketCommentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TicketComment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => TicketComment.t;
}

class TicketCommentRepository {
  const TicketCommentRepository._();

  final attachRow = const TicketCommentAttachRowRepository._();

  /// Returns a list of [TicketComment]s matching the given query parameters.
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
  Future<List<TicketComment>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketCommentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketCommentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketCommentTable>? orderByList,
    _i1.Transaction? transaction,
    TicketCommentInclude? include,
  }) async {
    return session.db.find<TicketComment>(
      where: where?.call(TicketComment.t),
      orderBy: orderBy?.call(TicketComment.t),
      orderByList: orderByList?.call(TicketComment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [TicketComment] matching the given query parameters.
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
  Future<TicketComment?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketCommentTable>? where,
    int? offset,
    _i1.OrderByBuilder<TicketCommentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketCommentTable>? orderByList,
    _i1.Transaction? transaction,
    TicketCommentInclude? include,
  }) async {
    return session.db.findFirstRow<TicketComment>(
      where: where?.call(TicketComment.t),
      orderBy: orderBy?.call(TicketComment.t),
      orderByList: orderByList?.call(TicketComment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [TicketComment] by its [id] or null if no such row exists.
  Future<TicketComment?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    TicketCommentInclude? include,
  }) async {
    return session.db.findById<TicketComment>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [TicketComment]s in the list and returns the inserted rows.
  ///
  /// The returned [TicketComment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<TicketComment>> insert(
    _i1.Session session,
    List<TicketComment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<TicketComment>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [TicketComment] and returns the inserted row.
  ///
  /// The returned [TicketComment] will have its `id` field set.
  Future<TicketComment> insertRow(
    _i1.Session session,
    TicketComment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TicketComment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TicketComment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TicketComment>> update(
    _i1.Session session,
    List<TicketComment> rows, {
    _i1.ColumnSelections<TicketCommentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TicketComment>(
      rows,
      columns: columns?.call(TicketComment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TicketComment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TicketComment> updateRow(
    _i1.Session session,
    TicketComment row, {
    _i1.ColumnSelections<TicketCommentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TicketComment>(
      row,
      columns: columns?.call(TicketComment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TicketComment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TicketComment?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<TicketCommentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TicketComment>(
      id,
      columnValues: columnValues(TicketComment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TicketComment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TicketComment>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<TicketCommentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TicketCommentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketCommentTable>? orderBy,
    _i1.OrderByListBuilder<TicketCommentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TicketComment>(
      columnValues: columnValues(TicketComment.t.updateTable),
      where: where(TicketComment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TicketComment.t),
      orderByList: orderByList?.call(TicketComment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TicketComment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TicketComment>> delete(
    _i1.Session session,
    List<TicketComment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TicketComment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TicketComment].
  Future<TicketComment> deleteRow(
    _i1.Session session,
    TicketComment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TicketComment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TicketComment>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TicketCommentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TicketComment>(
      where: where(TicketComment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketCommentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TicketComment>(
      where: where?.call(TicketComment.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class TicketCommentAttachRowRepository {
  const TicketCommentAttachRowRepository._();

  /// Creates a relation between the given [TicketComment] and [Ticket]
  /// by setting the [TicketComment]'s foreign key `ticketId` to refer to the [Ticket].
  Future<void> ticket(
    _i1.Session session,
    TicketComment ticketComment,
    _i2.Ticket ticket, {
    _i1.Transaction? transaction,
  }) async {
    if (ticketComment.id == null) {
      throw ArgumentError.notNull('ticketComment.id');
    }
    if (ticket.id == null) {
      throw ArgumentError.notNull('ticket.id');
    }

    var $ticketComment = ticketComment.copyWith(ticketId: ticket.id);
    await session.db.updateRow<TicketComment>(
      $ticketComment,
      columns: [TicketComment.t.ticketId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TicketComment] and [User]
  /// by setting the [TicketComment]'s foreign key `userId` to refer to the [User].
  Future<void> user(
    _i1.Session session,
    TicketComment ticketComment,
    _i3.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (ticketComment.id == null) {
      throw ArgumentError.notNull('ticketComment.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $ticketComment = ticketComment.copyWith(userId: user.id);
    await session.db.updateRow<TicketComment>(
      $ticketComment,
      columns: [TicketComment.t.userId],
      transaction: transaction,
    );
  }
}
