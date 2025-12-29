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

abstract class FlowModel
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  FlowModel._({
    this.id,
    required this.appId,
    required this.name,
    required this.flow,
    required this.lastUpdated,
  });

  factory FlowModel({
    _i1.UuidValue? id,
    required _i1.UuidValue appId,
    required String name,
    required String flow,
    required DateTime lastUpdated,
  }) = _FlowModelImpl;

  factory FlowModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return FlowModel(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      appId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['appId']),
      name: jsonSerialization['name'] as String,
      flow: jsonSerialization['flow'] as String,
      lastUpdated: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastUpdated'],
      ),
    );
  }

  static final t = FlowModelTable();

  static const db = FlowModelRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue appId;

  String name;

  String flow;

  DateTime lastUpdated;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [FlowModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FlowModel copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? appId,
    String? name,
    String? flow,
    DateTime? lastUpdated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FlowModel',
      if (id != null) 'id': id?.toJson(),
      'appId': appId.toJson(),
      'name': name,
      'flow': flow,
      'lastUpdated': lastUpdated.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FlowModel',
      if (id != null) 'id': id?.toJson(),
      'appId': appId.toJson(),
      'name': name,
      'flow': flow,
      'lastUpdated': lastUpdated.toJson(),
    };
  }

  static FlowModelInclude include() {
    return FlowModelInclude._();
  }

  static FlowModelIncludeList includeList({
    _i1.WhereExpressionBuilder<FlowModelTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FlowModelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FlowModelTable>? orderByList,
    FlowModelInclude? include,
  }) {
    return FlowModelIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FlowModel.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FlowModel.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FlowModelImpl extends FlowModel {
  _FlowModelImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue appId,
    required String name,
    required String flow,
    required DateTime lastUpdated,
  }) : super._(
         id: id,
         appId: appId,
         name: name,
         flow: flow,
         lastUpdated: lastUpdated,
       );

  /// Returns a shallow copy of this [FlowModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FlowModel copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? appId,
    String? name,
    String? flow,
    DateTime? lastUpdated,
  }) {
    return FlowModel(
      id: id is _i1.UuidValue? ? id : this.id,
      appId: appId ?? this.appId,
      name: name ?? this.name,
      flow: flow ?? this.flow,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class FlowModelUpdateTable extends _i1.UpdateTable<FlowModelTable> {
  FlowModelUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> appId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.appId,
        value,
      );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> flow(String value) => _i1.ColumnValue(
    table.flow,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastUpdated(DateTime value) =>
      _i1.ColumnValue(
        table.lastUpdated,
        value,
      );
}

class FlowModelTable extends _i1.Table<_i1.UuidValue?> {
  FlowModelTable({super.tableRelation}) : super(tableName: 'flow') {
    updateTable = FlowModelUpdateTable(this);
    appId = _i1.ColumnUuid(
      'appId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    flow = _i1.ColumnString(
      'flow',
      this,
    );
    lastUpdated = _i1.ColumnDateTime(
      'lastUpdated',
      this,
    );
  }

  late final FlowModelUpdateTable updateTable;

  late final _i1.ColumnUuid appId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString flow;

  late final _i1.ColumnDateTime lastUpdated;

  @override
  List<_i1.Column> get columns => [
    id,
    appId,
    name,
    flow,
    lastUpdated,
  ];
}

class FlowModelInclude extends _i1.IncludeObject {
  FlowModelInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => FlowModel.t;
}

class FlowModelIncludeList extends _i1.IncludeList {
  FlowModelIncludeList._({
    _i1.WhereExpressionBuilder<FlowModelTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FlowModel.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => FlowModel.t;
}

class FlowModelRepository {
  const FlowModelRepository._();

  /// Returns a list of [FlowModel]s matching the given query parameters.
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
  Future<List<FlowModel>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FlowModelTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FlowModelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FlowModelTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<FlowModel>(
      where: where?.call(FlowModel.t),
      orderBy: orderBy?.call(FlowModel.t),
      orderByList: orderByList?.call(FlowModel.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [FlowModel] matching the given query parameters.
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
  Future<FlowModel?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FlowModelTable>? where,
    int? offset,
    _i1.OrderByBuilder<FlowModelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FlowModelTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<FlowModel>(
      where: where?.call(FlowModel.t),
      orderBy: orderBy?.call(FlowModel.t),
      orderByList: orderByList?.call(FlowModel.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [FlowModel] by its [id] or null if no such row exists.
  Future<FlowModel?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<FlowModel>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [FlowModel]s in the list and returns the inserted rows.
  ///
  /// The returned [FlowModel]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FlowModel>> insert(
    _i1.Session session,
    List<FlowModel> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FlowModel>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FlowModel] and returns the inserted row.
  ///
  /// The returned [FlowModel] will have its `id` field set.
  Future<FlowModel> insertRow(
    _i1.Session session,
    FlowModel row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FlowModel>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FlowModel]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FlowModel>> update(
    _i1.Session session,
    List<FlowModel> rows, {
    _i1.ColumnSelections<FlowModelTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FlowModel>(
      rows,
      columns: columns?.call(FlowModel.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FlowModel]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FlowModel> updateRow(
    _i1.Session session,
    FlowModel row, {
    _i1.ColumnSelections<FlowModelTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FlowModel>(
      row,
      columns: columns?.call(FlowModel.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FlowModel] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FlowModel?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<FlowModelUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FlowModel>(
      id,
      columnValues: columnValues(FlowModel.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FlowModel]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FlowModel>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<FlowModelUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FlowModelTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FlowModelTable>? orderBy,
    _i1.OrderByListBuilder<FlowModelTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FlowModel>(
      columnValues: columnValues(FlowModel.t.updateTable),
      where: where(FlowModel.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FlowModel.t),
      orderByList: orderByList?.call(FlowModel.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FlowModel]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FlowModel>> delete(
    _i1.Session session,
    List<FlowModel> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FlowModel>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FlowModel].
  Future<FlowModel> deleteRow(
    _i1.Session session,
    FlowModel row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FlowModel>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FlowModel>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FlowModelTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FlowModel>(
      where: where(FlowModel.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FlowModelTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FlowModel>(
      where: where?.call(FlowModel.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
