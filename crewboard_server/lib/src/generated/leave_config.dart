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

abstract class LeaveConfig
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LeaveConfig._({
    this.id,
    required this.configName,
    required this.fullDay,
    required this.halfDay,
    this.config,
  });

  factory LeaveConfig({
    int? id,
    required String configName,
    required int fullDay,
    required int halfDay,
    String? config,
  }) = _LeaveConfigImpl;

  factory LeaveConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeaveConfig(
      id: jsonSerialization['id'] as int?,
      configName: jsonSerialization['configName'] as String,
      fullDay: jsonSerialization['fullDay'] as int,
      halfDay: jsonSerialization['halfDay'] as int,
      config: jsonSerialization['config'] as String?,
    );
  }

  static final t = LeaveConfigTable();

  static const db = LeaveConfigRepository._();

  @override
  int? id;

  String configName;

  int fullDay;

  int halfDay;

  String? config;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LeaveConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LeaveConfig copyWith({
    int? id,
    String? configName,
    int? fullDay,
    int? halfDay,
    String? config,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeaveConfig',
      if (id != null) 'id': id,
      'configName': configName,
      'fullDay': fullDay,
      'halfDay': halfDay,
      if (config != null) 'config': config,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LeaveConfig',
      if (id != null) 'id': id,
      'configName': configName,
      'fullDay': fullDay,
      'halfDay': halfDay,
      if (config != null) 'config': config,
    };
  }

  static LeaveConfigInclude include() {
    return LeaveConfigInclude._();
  }

  static LeaveConfigIncludeList includeList({
    _i1.WhereExpressionBuilder<LeaveConfigTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LeaveConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LeaveConfigTable>? orderByList,
    LeaveConfigInclude? include,
  }) {
    return LeaveConfigIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LeaveConfig.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LeaveConfig.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LeaveConfigImpl extends LeaveConfig {
  _LeaveConfigImpl({
    int? id,
    required String configName,
    required int fullDay,
    required int halfDay,
    String? config,
  }) : super._(
         id: id,
         configName: configName,
         fullDay: fullDay,
         halfDay: halfDay,
         config: config,
       );

  /// Returns a shallow copy of this [LeaveConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LeaveConfig copyWith({
    Object? id = _Undefined,
    String? configName,
    int? fullDay,
    int? halfDay,
    Object? config = _Undefined,
  }) {
    return LeaveConfig(
      id: id is int? ? id : this.id,
      configName: configName ?? this.configName,
      fullDay: fullDay ?? this.fullDay,
      halfDay: halfDay ?? this.halfDay,
      config: config is String? ? config : this.config,
    );
  }
}

class LeaveConfigUpdateTable extends _i1.UpdateTable<LeaveConfigTable> {
  LeaveConfigUpdateTable(super.table);

  _i1.ColumnValue<String, String> configName(String value) => _i1.ColumnValue(
    table.configName,
    value,
  );

  _i1.ColumnValue<int, int> fullDay(int value) => _i1.ColumnValue(
    table.fullDay,
    value,
  );

  _i1.ColumnValue<int, int> halfDay(int value) => _i1.ColumnValue(
    table.halfDay,
    value,
  );

  _i1.ColumnValue<String, String> config(String? value) => _i1.ColumnValue(
    table.config,
    value,
  );
}

class LeaveConfigTable extends _i1.Table<int?> {
  LeaveConfigTable({super.tableRelation}) : super(tableName: 'leave_config') {
    updateTable = LeaveConfigUpdateTable(this);
    configName = _i1.ColumnString(
      'configName',
      this,
    );
    fullDay = _i1.ColumnInt(
      'fullDay',
      this,
    );
    halfDay = _i1.ColumnInt(
      'halfDay',
      this,
    );
    config = _i1.ColumnString(
      'config',
      this,
    );
  }

  late final LeaveConfigUpdateTable updateTable;

  late final _i1.ColumnString configName;

  late final _i1.ColumnInt fullDay;

  late final _i1.ColumnInt halfDay;

  late final _i1.ColumnString config;

  @override
  List<_i1.Column> get columns => [
    id,
    configName,
    fullDay,
    halfDay,
    config,
  ];
}

class LeaveConfigInclude extends _i1.IncludeObject {
  LeaveConfigInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => LeaveConfig.t;
}

class LeaveConfigIncludeList extends _i1.IncludeList {
  LeaveConfigIncludeList._({
    _i1.WhereExpressionBuilder<LeaveConfigTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LeaveConfig.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LeaveConfig.t;
}

class LeaveConfigRepository {
  const LeaveConfigRepository._();

  /// Returns a list of [LeaveConfig]s matching the given query parameters.
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
  Future<List<LeaveConfig>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LeaveConfigTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LeaveConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LeaveConfigTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<LeaveConfig>(
      where: where?.call(LeaveConfig.t),
      orderBy: orderBy?.call(LeaveConfig.t),
      orderByList: orderByList?.call(LeaveConfig.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [LeaveConfig] matching the given query parameters.
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
  Future<LeaveConfig?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LeaveConfigTable>? where,
    int? offset,
    _i1.OrderByBuilder<LeaveConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LeaveConfigTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<LeaveConfig>(
      where: where?.call(LeaveConfig.t),
      orderBy: orderBy?.call(LeaveConfig.t),
      orderByList: orderByList?.call(LeaveConfig.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [LeaveConfig] by its [id] or null if no such row exists.
  Future<LeaveConfig?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<LeaveConfig>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [LeaveConfig]s in the list and returns the inserted rows.
  ///
  /// The returned [LeaveConfig]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<LeaveConfig>> insert(
    _i1.Session session,
    List<LeaveConfig> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<LeaveConfig>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [LeaveConfig] and returns the inserted row.
  ///
  /// The returned [LeaveConfig] will have its `id` field set.
  Future<LeaveConfig> insertRow(
    _i1.Session session,
    LeaveConfig row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LeaveConfig>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LeaveConfig]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LeaveConfig>> update(
    _i1.Session session,
    List<LeaveConfig> rows, {
    _i1.ColumnSelections<LeaveConfigTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LeaveConfig>(
      rows,
      columns: columns?.call(LeaveConfig.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LeaveConfig]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LeaveConfig> updateRow(
    _i1.Session session,
    LeaveConfig row, {
    _i1.ColumnSelections<LeaveConfigTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LeaveConfig>(
      row,
      columns: columns?.call(LeaveConfig.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LeaveConfig] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LeaveConfig?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<LeaveConfigUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<LeaveConfig>(
      id,
      columnValues: columnValues(LeaveConfig.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LeaveConfig]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<LeaveConfig>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<LeaveConfigUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<LeaveConfigTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LeaveConfigTable>? orderBy,
    _i1.OrderByListBuilder<LeaveConfigTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<LeaveConfig>(
      columnValues: columnValues(LeaveConfig.t.updateTable),
      where: where(LeaveConfig.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LeaveConfig.t),
      orderByList: orderByList?.call(LeaveConfig.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [LeaveConfig]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LeaveConfig>> delete(
    _i1.Session session,
    List<LeaveConfig> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LeaveConfig>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LeaveConfig].
  Future<LeaveConfig> deleteRow(
    _i1.Session session,
    LeaveConfig row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LeaveConfig>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LeaveConfig>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LeaveConfigTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LeaveConfig>(
      where: where(LeaveConfig.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LeaveConfigTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LeaveConfig>(
      where: where?.call(LeaveConfig.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
