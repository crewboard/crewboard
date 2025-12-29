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

abstract class Status
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Status._({
    this.id,
    required this.statusName,
  });

  factory Status({
    _i1.UuidValue? id,
    required String statusName,
  }) = _StatusImpl;

  factory Status.fromJson(Map<String, dynamic> jsonSerialization) {
    return Status(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      statusName: jsonSerialization['statusName'] as String,
    );
  }

  static final t = StatusTable();

  static const db = StatusRepository._();

  @override
  _i1.UuidValue? id;

  String statusName;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Status]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Status copyWith({
    _i1.UuidValue? id,
    String? statusName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Status',
      if (id != null) 'id': id?.toJson(),
      'statusName': statusName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Status',
      if (id != null) 'id': id?.toJson(),
      'statusName': statusName,
    };
  }

  static StatusInclude include() {
    return StatusInclude._();
  }

  static StatusIncludeList includeList({
    _i1.WhereExpressionBuilder<StatusTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StatusTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StatusTable>? orderByList,
    StatusInclude? include,
  }) {
    return StatusIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Status.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Status.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StatusImpl extends Status {
  _StatusImpl({
    _i1.UuidValue? id,
    required String statusName,
  }) : super._(
         id: id,
         statusName: statusName,
       );

  /// Returns a shallow copy of this [Status]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Status copyWith({
    Object? id = _Undefined,
    String? statusName,
  }) {
    return Status(
      id: id is _i1.UuidValue? ? id : this.id,
      statusName: statusName ?? this.statusName,
    );
  }
}

class StatusUpdateTable extends _i1.UpdateTable<StatusTable> {
  StatusUpdateTable(super.table);

  _i1.ColumnValue<String, String> statusName(String value) => _i1.ColumnValue(
    table.statusName,
    value,
  );
}

class StatusTable extends _i1.Table<_i1.UuidValue?> {
  StatusTable({super.tableRelation}) : super(tableName: 'status') {
    updateTable = StatusUpdateTable(this);
    statusName = _i1.ColumnString(
      'statusName',
      this,
    );
  }

  late final StatusUpdateTable updateTable;

  late final _i1.ColumnString statusName;

  @override
  List<_i1.Column> get columns => [
    id,
    statusName,
  ];
}

class StatusInclude extends _i1.IncludeObject {
  StatusInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Status.t;
}

class StatusIncludeList extends _i1.IncludeList {
  StatusIncludeList._({
    _i1.WhereExpressionBuilder<StatusTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Status.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Status.t;
}

class StatusRepository {
  const StatusRepository._();

  /// Returns a list of [Status]s matching the given query parameters.
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
  Future<List<Status>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StatusTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StatusTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StatusTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Status>(
      where: where?.call(Status.t),
      orderBy: orderBy?.call(Status.t),
      orderByList: orderByList?.call(Status.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Status] matching the given query parameters.
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
  Future<Status?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StatusTable>? where,
    int? offset,
    _i1.OrderByBuilder<StatusTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StatusTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Status>(
      where: where?.call(Status.t),
      orderBy: orderBy?.call(Status.t),
      orderByList: orderByList?.call(Status.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Status] by its [id] or null if no such row exists.
  Future<Status?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Status>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Status]s in the list and returns the inserted rows.
  ///
  /// The returned [Status]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Status>> insert(
    _i1.Session session,
    List<Status> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Status>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Status] and returns the inserted row.
  ///
  /// The returned [Status] will have its `id` field set.
  Future<Status> insertRow(
    _i1.Session session,
    Status row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Status>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Status]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Status>> update(
    _i1.Session session,
    List<Status> rows, {
    _i1.ColumnSelections<StatusTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Status>(
      rows,
      columns: columns?.call(Status.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Status]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Status> updateRow(
    _i1.Session session,
    Status row, {
    _i1.ColumnSelections<StatusTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Status>(
      row,
      columns: columns?.call(Status.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Status] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Status?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<StatusUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Status>(
      id,
      columnValues: columnValues(Status.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Status]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Status>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StatusUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StatusTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StatusTable>? orderBy,
    _i1.OrderByListBuilder<StatusTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Status>(
      columnValues: columnValues(Status.t.updateTable),
      where: where(Status.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Status.t),
      orderByList: orderByList?.call(Status.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Status]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Status>> delete(
    _i1.Session session,
    List<Status> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Status>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Status].
  Future<Status> deleteRow(
    _i1.Session session,
    Status row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Status>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Status>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StatusTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Status>(
      where: where(Status.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StatusTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Status>(
      where: where?.call(Status.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
