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

abstract class Memory implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Memory._({
    this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory Memory({
    int? id,
    required _i1.UuidValue userId,
    required String title,
    required String body,
    required DateTime createdAt,
  }) = _MemoryImpl;

  factory Memory.fromJson(Map<String, dynamic> jsonSerialization) {
    return Memory(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = MemoryTable();

  static const db = MemoryRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  String title;

  String body;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Memory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Memory copyWith({
    int? id,
    _i1.UuidValue? userId,
    String? title,
    String? body,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Memory',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'title': title,
      'body': body,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Memory',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'title': title,
      'body': body,
      'createdAt': createdAt.toJson(),
    };
  }

  static MemoryInclude include() {
    return MemoryInclude._();
  }

  static MemoryIncludeList includeList({
    _i1.WhereExpressionBuilder<MemoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MemoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MemoryTable>? orderByList,
    MemoryInclude? include,
  }) {
    return MemoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Memory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Memory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MemoryImpl extends Memory {
  _MemoryImpl({
    int? id,
    required _i1.UuidValue userId,
    required String title,
    required String body,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         title: title,
         body: body,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Memory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Memory copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    String? title,
    String? body,
    DateTime? createdAt,
  }) {
    return Memory(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class MemoryUpdateTable extends _i1.UpdateTable<MemoryTable> {
  MemoryUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> body(String value) => _i1.ColumnValue(
    table.body,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class MemoryTable extends _i1.Table<int?> {
  MemoryTable({super.tableRelation}) : super(tableName: 'user_memory_map') {
    updateTable = MemoryUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    body = _i1.ColumnString(
      'body',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final MemoryUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString body;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    title,
    body,
    createdAt,
  ];
}

class MemoryInclude extends _i1.IncludeObject {
  MemoryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Memory.t;
}

class MemoryIncludeList extends _i1.IncludeList {
  MemoryIncludeList._({
    _i1.WhereExpressionBuilder<MemoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Memory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Memory.t;
}

class MemoryRepository {
  const MemoryRepository._();

  /// Returns a list of [Memory]s matching the given query parameters.
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
  Future<List<Memory>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MemoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MemoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MemoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Memory>(
      where: where?.call(Memory.t),
      orderBy: orderBy?.call(Memory.t),
      orderByList: orderByList?.call(Memory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Memory] matching the given query parameters.
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
  Future<Memory?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MemoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<MemoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MemoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Memory>(
      where: where?.call(Memory.t),
      orderBy: orderBy?.call(Memory.t),
      orderByList: orderByList?.call(Memory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Memory] by its [id] or null if no such row exists.
  Future<Memory?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Memory>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Memory]s in the list and returns the inserted rows.
  ///
  /// The returned [Memory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Memory>> insert(
    _i1.Session session,
    List<Memory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Memory>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Memory] and returns the inserted row.
  ///
  /// The returned [Memory] will have its `id` field set.
  Future<Memory> insertRow(
    _i1.Session session,
    Memory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Memory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Memory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Memory>> update(
    _i1.Session session,
    List<Memory> rows, {
    _i1.ColumnSelections<MemoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Memory>(
      rows,
      columns: columns?.call(Memory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Memory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Memory> updateRow(
    _i1.Session session,
    Memory row, {
    _i1.ColumnSelections<MemoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Memory>(
      row,
      columns: columns?.call(Memory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Memory] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Memory?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<MemoryUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Memory>(
      id,
      columnValues: columnValues(Memory.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Memory]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Memory>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<MemoryUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MemoryTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MemoryTable>? orderBy,
    _i1.OrderByListBuilder<MemoryTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Memory>(
      columnValues: columnValues(Memory.t.updateTable),
      where: where(Memory.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Memory.t),
      orderByList: orderByList?.call(Memory.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Memory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Memory>> delete(
    _i1.Session session,
    List<Memory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Memory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Memory].
  Future<Memory> deleteRow(
    _i1.Session session,
    Memory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Memory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Memory>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MemoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Memory>(
      where: where(Memory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MemoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Memory>(
      where: where?.call(Memory.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
