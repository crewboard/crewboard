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

abstract class SystemVariables
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SystemVariables._({
    this.id,
    required this.punchingMode,
    this.lineHeight,
    this.processWidth,
    this.conditionWidth,
    this.terminalWidth,
    this.allowEdit,
    this.showEdit,
    this.allowDelete,
    this.showDelete,
  });

  factory SystemVariables({
    int? id,
    required String punchingMode,
    double? lineHeight,
    double? processWidth,
    double? conditionWidth,
    double? terminalWidth,
    bool? allowEdit,
    bool? showEdit,
    bool? allowDelete,
    bool? showDelete,
  }) = _SystemVariablesImpl;

  factory SystemVariables.fromJson(Map<String, dynamic> jsonSerialization) {
    return SystemVariables(
      id: jsonSerialization['id'] as int?,
      punchingMode: jsonSerialization['punchingMode'] as String,
      lineHeight: (jsonSerialization['lineHeight'] as num?)?.toDouble(),
      processWidth: (jsonSerialization['processWidth'] as num?)?.toDouble(),
      conditionWidth: (jsonSerialization['conditionWidth'] as num?)?.toDouble(),
      terminalWidth: (jsonSerialization['terminalWidth'] as num?)?.toDouble(),
      allowEdit: jsonSerialization['allowEdit'] as bool?,
      showEdit: jsonSerialization['showEdit'] as bool?,
      allowDelete: jsonSerialization['allowDelete'] as bool?,
      showDelete: jsonSerialization['showDelete'] as bool?,
    );
  }

  static final t = SystemVariablesTable();

  static const db = SystemVariablesRepository._();

  @override
  int? id;

  String punchingMode;

  double? lineHeight;

  double? processWidth;

  double? conditionWidth;

  double? terminalWidth;

  bool? allowEdit;

  bool? showEdit;

  bool? allowDelete;

  bool? showDelete;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SystemVariables]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SystemVariables copyWith({
    int? id,
    String? punchingMode,
    double? lineHeight,
    double? processWidth,
    double? conditionWidth,
    double? terminalWidth,
    bool? allowEdit,
    bool? showEdit,
    bool? allowDelete,
    bool? showDelete,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SystemVariables',
      if (id != null) 'id': id,
      'punchingMode': punchingMode,
      if (lineHeight != null) 'lineHeight': lineHeight,
      if (processWidth != null) 'processWidth': processWidth,
      if (conditionWidth != null) 'conditionWidth': conditionWidth,
      if (terminalWidth != null) 'terminalWidth': terminalWidth,
      if (allowEdit != null) 'allowEdit': allowEdit,
      if (showEdit != null) 'showEdit': showEdit,
      if (allowDelete != null) 'allowDelete': allowDelete,
      if (showDelete != null) 'showDelete': showDelete,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SystemVariables',
      if (id != null) 'id': id,
      'punchingMode': punchingMode,
      if (lineHeight != null) 'lineHeight': lineHeight,
      if (processWidth != null) 'processWidth': processWidth,
      if (conditionWidth != null) 'conditionWidth': conditionWidth,
      if (terminalWidth != null) 'terminalWidth': terminalWidth,
      if (allowEdit != null) 'allowEdit': allowEdit,
      if (showEdit != null) 'showEdit': showEdit,
      if (allowDelete != null) 'allowDelete': allowDelete,
      if (showDelete != null) 'showDelete': showDelete,
    };
  }

  static SystemVariablesInclude include() {
    return SystemVariablesInclude._();
  }

  static SystemVariablesIncludeList includeList({
    _i1.WhereExpressionBuilder<SystemVariablesTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemVariablesTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemVariablesTable>? orderByList,
    SystemVariablesInclude? include,
  }) {
    return SystemVariablesIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SystemVariables.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SystemVariables.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SystemVariablesImpl extends SystemVariables {
  _SystemVariablesImpl({
    int? id,
    required String punchingMode,
    double? lineHeight,
    double? processWidth,
    double? conditionWidth,
    double? terminalWidth,
    bool? allowEdit,
    bool? showEdit,
    bool? allowDelete,
    bool? showDelete,
  }) : super._(
         id: id,
         punchingMode: punchingMode,
         lineHeight: lineHeight,
         processWidth: processWidth,
         conditionWidth: conditionWidth,
         terminalWidth: terminalWidth,
         allowEdit: allowEdit,
         showEdit: showEdit,
         allowDelete: allowDelete,
         showDelete: showDelete,
       );

  /// Returns a shallow copy of this [SystemVariables]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SystemVariables copyWith({
    Object? id = _Undefined,
    String? punchingMode,
    Object? lineHeight = _Undefined,
    Object? processWidth = _Undefined,
    Object? conditionWidth = _Undefined,
    Object? terminalWidth = _Undefined,
    Object? allowEdit = _Undefined,
    Object? showEdit = _Undefined,
    Object? allowDelete = _Undefined,
    Object? showDelete = _Undefined,
  }) {
    return SystemVariables(
      id: id is int? ? id : this.id,
      punchingMode: punchingMode ?? this.punchingMode,
      lineHeight: lineHeight is double? ? lineHeight : this.lineHeight,
      processWidth: processWidth is double? ? processWidth : this.processWidth,
      conditionWidth: conditionWidth is double?
          ? conditionWidth
          : this.conditionWidth,
      terminalWidth: terminalWidth is double?
          ? terminalWidth
          : this.terminalWidth,
      allowEdit: allowEdit is bool? ? allowEdit : this.allowEdit,
      showEdit: showEdit is bool? ? showEdit : this.showEdit,
      allowDelete: allowDelete is bool? ? allowDelete : this.allowDelete,
      showDelete: showDelete is bool? ? showDelete : this.showDelete,
    );
  }
}

class SystemVariablesUpdateTable extends _i1.UpdateTable<SystemVariablesTable> {
  SystemVariablesUpdateTable(super.table);

  _i1.ColumnValue<String, String> punchingMode(String value) => _i1.ColumnValue(
    table.punchingMode,
    value,
  );

  _i1.ColumnValue<double, double> lineHeight(double? value) => _i1.ColumnValue(
    table.lineHeight,
    value,
  );

  _i1.ColumnValue<double, double> processWidth(double? value) =>
      _i1.ColumnValue(
        table.processWidth,
        value,
      );

  _i1.ColumnValue<double, double> conditionWidth(double? value) =>
      _i1.ColumnValue(
        table.conditionWidth,
        value,
      );

  _i1.ColumnValue<double, double> terminalWidth(double? value) =>
      _i1.ColumnValue(
        table.terminalWidth,
        value,
      );

  _i1.ColumnValue<bool, bool> allowEdit(bool? value) => _i1.ColumnValue(
    table.allowEdit,
    value,
  );

  _i1.ColumnValue<bool, bool> showEdit(bool? value) => _i1.ColumnValue(
    table.showEdit,
    value,
  );

  _i1.ColumnValue<bool, bool> allowDelete(bool? value) => _i1.ColumnValue(
    table.allowDelete,
    value,
  );

  _i1.ColumnValue<bool, bool> showDelete(bool? value) => _i1.ColumnValue(
    table.showDelete,
    value,
  );
}

class SystemVariablesTable extends _i1.Table<int?> {
  SystemVariablesTable({super.tableRelation})
    : super(tableName: 'system_variables') {
    updateTable = SystemVariablesUpdateTable(this);
    punchingMode = _i1.ColumnString(
      'punchingMode',
      this,
    );
    lineHeight = _i1.ColumnDouble(
      'lineHeight',
      this,
    );
    processWidth = _i1.ColumnDouble(
      'processWidth',
      this,
    );
    conditionWidth = _i1.ColumnDouble(
      'conditionWidth',
      this,
    );
    terminalWidth = _i1.ColumnDouble(
      'terminalWidth',
      this,
    );
    allowEdit = _i1.ColumnBool(
      'allowEdit',
      this,
    );
    showEdit = _i1.ColumnBool(
      'showEdit',
      this,
    );
    allowDelete = _i1.ColumnBool(
      'allowDelete',
      this,
    );
    showDelete = _i1.ColumnBool(
      'showDelete',
      this,
    );
  }

  late final SystemVariablesUpdateTable updateTable;

  late final _i1.ColumnString punchingMode;

  late final _i1.ColumnDouble lineHeight;

  late final _i1.ColumnDouble processWidth;

  late final _i1.ColumnDouble conditionWidth;

  late final _i1.ColumnDouble terminalWidth;

  late final _i1.ColumnBool allowEdit;

  late final _i1.ColumnBool showEdit;

  late final _i1.ColumnBool allowDelete;

  late final _i1.ColumnBool showDelete;

  @override
  List<_i1.Column> get columns => [
    id,
    punchingMode,
    lineHeight,
    processWidth,
    conditionWidth,
    terminalWidth,
    allowEdit,
    showEdit,
    allowDelete,
    showDelete,
  ];
}

class SystemVariablesInclude extends _i1.IncludeObject {
  SystemVariablesInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SystemVariables.t;
}

class SystemVariablesIncludeList extends _i1.IncludeList {
  SystemVariablesIncludeList._({
    _i1.WhereExpressionBuilder<SystemVariablesTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SystemVariables.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SystemVariables.t;
}

class SystemVariablesRepository {
  const SystemVariablesRepository._();

  /// Returns a list of [SystemVariables]s matching the given query parameters.
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
  Future<List<SystemVariables>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SystemVariablesTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemVariablesTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemVariablesTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SystemVariables>(
      where: where?.call(SystemVariables.t),
      orderBy: orderBy?.call(SystemVariables.t),
      orderByList: orderByList?.call(SystemVariables.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SystemVariables] matching the given query parameters.
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
  Future<SystemVariables?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SystemVariablesTable>? where,
    int? offset,
    _i1.OrderByBuilder<SystemVariablesTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemVariablesTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SystemVariables>(
      where: where?.call(SystemVariables.t),
      orderBy: orderBy?.call(SystemVariables.t),
      orderByList: orderByList?.call(SystemVariables.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SystemVariables] by its [id] or null if no such row exists.
  Future<SystemVariables?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SystemVariables>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SystemVariables]s in the list and returns the inserted rows.
  ///
  /// The returned [SystemVariables]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SystemVariables>> insert(
    _i1.Session session,
    List<SystemVariables> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SystemVariables>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SystemVariables] and returns the inserted row.
  ///
  /// The returned [SystemVariables] will have its `id` field set.
  Future<SystemVariables> insertRow(
    _i1.Session session,
    SystemVariables row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SystemVariables>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SystemVariables]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SystemVariables>> update(
    _i1.Session session,
    List<SystemVariables> rows, {
    _i1.ColumnSelections<SystemVariablesTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SystemVariables>(
      rows,
      columns: columns?.call(SystemVariables.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SystemVariables]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SystemVariables> updateRow(
    _i1.Session session,
    SystemVariables row, {
    _i1.ColumnSelections<SystemVariablesTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SystemVariables>(
      row,
      columns: columns?.call(SystemVariables.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SystemVariables] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SystemVariables?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SystemVariablesUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SystemVariables>(
      id,
      columnValues: columnValues(SystemVariables.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SystemVariables]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SystemVariables>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SystemVariablesUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<SystemVariablesTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemVariablesTable>? orderBy,
    _i1.OrderByListBuilder<SystemVariablesTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SystemVariables>(
      columnValues: columnValues(SystemVariables.t.updateTable),
      where: where(SystemVariables.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SystemVariables.t),
      orderByList: orderByList?.call(SystemVariables.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SystemVariables]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SystemVariables>> delete(
    _i1.Session session,
    List<SystemVariables> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SystemVariables>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SystemVariables].
  Future<SystemVariables> deleteRow(
    _i1.Session session,
    SystemVariables row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SystemVariables>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SystemVariables>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SystemVariablesTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SystemVariables>(
      where: where(SystemVariables.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SystemVariablesTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SystemVariables>(
      where: where?.call(SystemVariables.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
