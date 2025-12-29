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

abstract class Priority
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Priority._({
    this.id,
    required this.priorityName,
    required this.priority,
  });

  factory Priority({
    _i1.UuidValue? id,
    required String priorityName,
    required int priority,
  }) = _PriorityImpl;

  factory Priority.fromJson(Map<String, dynamic> jsonSerialization) {
    return Priority(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      priorityName: jsonSerialization['priorityName'] as String,
      priority: jsonSerialization['priority'] as int,
    );
  }

  static final t = PriorityTable();

  static const db = PriorityRepository._();

  @override
  _i1.UuidValue? id;

  String priorityName;

  int priority;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Priority]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Priority copyWith({
    _i1.UuidValue? id,
    String? priorityName,
    int? priority,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Priority',
      if (id != null) 'id': id?.toJson(),
      'priorityName': priorityName,
      'priority': priority,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Priority',
      if (id != null) 'id': id?.toJson(),
      'priorityName': priorityName,
      'priority': priority,
    };
  }

  static PriorityInclude include() {
    return PriorityInclude._();
  }

  static PriorityIncludeList includeList({
    _i1.WhereExpressionBuilder<PriorityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PriorityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PriorityTable>? orderByList,
    PriorityInclude? include,
  }) {
    return PriorityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Priority.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Priority.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PriorityImpl extends Priority {
  _PriorityImpl({
    _i1.UuidValue? id,
    required String priorityName,
    required int priority,
  }) : super._(
         id: id,
         priorityName: priorityName,
         priority: priority,
       );

  /// Returns a shallow copy of this [Priority]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Priority copyWith({
    Object? id = _Undefined,
    String? priorityName,
    int? priority,
  }) {
    return Priority(
      id: id is _i1.UuidValue? ? id : this.id,
      priorityName: priorityName ?? this.priorityName,
      priority: priority ?? this.priority,
    );
  }
}

class PriorityUpdateTable extends _i1.UpdateTable<PriorityTable> {
  PriorityUpdateTable(super.table);

  _i1.ColumnValue<String, String> priorityName(String value) => _i1.ColumnValue(
    table.priorityName,
    value,
  );

  _i1.ColumnValue<int, int> priority(int value) => _i1.ColumnValue(
    table.priority,
    value,
  );
}

class PriorityTable extends _i1.Table<_i1.UuidValue?> {
  PriorityTable({super.tableRelation}) : super(tableName: 'priority') {
    updateTable = PriorityUpdateTable(this);
    priorityName = _i1.ColumnString(
      'priorityName',
      this,
    );
    priority = _i1.ColumnInt(
      'priority',
      this,
    );
  }

  late final PriorityUpdateTable updateTable;

  late final _i1.ColumnString priorityName;

  late final _i1.ColumnInt priority;

  @override
  List<_i1.Column> get columns => [
    id,
    priorityName,
    priority,
  ];
}

class PriorityInclude extends _i1.IncludeObject {
  PriorityInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Priority.t;
}

class PriorityIncludeList extends _i1.IncludeList {
  PriorityIncludeList._({
    _i1.WhereExpressionBuilder<PriorityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Priority.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Priority.t;
}

class PriorityRepository {
  const PriorityRepository._();

  /// Returns a list of [Priority]s matching the given query parameters.
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
  Future<List<Priority>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PriorityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PriorityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PriorityTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Priority>(
      where: where?.call(Priority.t),
      orderBy: orderBy?.call(Priority.t),
      orderByList: orderByList?.call(Priority.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Priority] matching the given query parameters.
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
  Future<Priority?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PriorityTable>? where,
    int? offset,
    _i1.OrderByBuilder<PriorityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PriorityTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Priority>(
      where: where?.call(Priority.t),
      orderBy: orderBy?.call(Priority.t),
      orderByList: orderByList?.call(Priority.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Priority] by its [id] or null if no such row exists.
  Future<Priority?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Priority>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Priority]s in the list and returns the inserted rows.
  ///
  /// The returned [Priority]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Priority>> insert(
    _i1.Session session,
    List<Priority> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Priority>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Priority] and returns the inserted row.
  ///
  /// The returned [Priority] will have its `id` field set.
  Future<Priority> insertRow(
    _i1.Session session,
    Priority row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Priority>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Priority]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Priority>> update(
    _i1.Session session,
    List<Priority> rows, {
    _i1.ColumnSelections<PriorityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Priority>(
      rows,
      columns: columns?.call(Priority.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Priority]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Priority> updateRow(
    _i1.Session session,
    Priority row, {
    _i1.ColumnSelections<PriorityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Priority>(
      row,
      columns: columns?.call(Priority.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Priority] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Priority?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<PriorityUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Priority>(
      id,
      columnValues: columnValues(Priority.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Priority]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Priority>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<PriorityUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PriorityTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PriorityTable>? orderBy,
    _i1.OrderByListBuilder<PriorityTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Priority>(
      columnValues: columnValues(Priority.t.updateTable),
      where: where(Priority.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Priority.t),
      orderByList: orderByList?.call(Priority.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Priority]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Priority>> delete(
    _i1.Session session,
    List<Priority> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Priority>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Priority].
  Future<Priority> deleteRow(
    _i1.Session session,
    Priority row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Priority>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Priority>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PriorityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Priority>(
      where: where(Priority.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PriorityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Priority>(
      where: where?.call(Priority.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
