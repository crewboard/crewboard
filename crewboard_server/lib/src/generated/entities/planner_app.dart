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

abstract class PlannerApp
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  PlannerApp._({
    this.id,
    required this.appName,
    required this.colorId,
    this.organizationId,
  });

  factory PlannerApp({
    _i1.UuidValue? id,
    required String appName,
    required _i1.UuidValue colorId,
    _i1.UuidValue? organizationId,
  }) = _PlannerAppImpl;

  factory PlannerApp.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlannerApp(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      appName: jsonSerialization['appName'] as String,
      colorId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['colorId'],
      ),
      organizationId: jsonSerialization['organizationId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['organizationId'],
            ),
    );
  }

  static final t = PlannerAppTable();

  static const db = PlannerAppRepository._();

  @override
  _i1.UuidValue? id;

  String appName;

  _i1.UuidValue colorId;

  _i1.UuidValue? organizationId;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [PlannerApp]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlannerApp copyWith({
    _i1.UuidValue? id,
    String? appName,
    _i1.UuidValue? colorId,
    _i1.UuidValue? organizationId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlannerApp',
      if (id != null) 'id': id?.toJson(),
      'appName': appName,
      'colorId': colorId.toJson(),
      if (organizationId != null) 'organizationId': organizationId?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlannerApp',
      if (id != null) 'id': id?.toJson(),
      'appName': appName,
      'colorId': colorId.toJson(),
      if (organizationId != null) 'organizationId': organizationId?.toJson(),
    };
  }

  static PlannerAppInclude include() {
    return PlannerAppInclude._();
  }

  static PlannerAppIncludeList includeList({
    _i1.WhereExpressionBuilder<PlannerAppTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlannerAppTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlannerAppTable>? orderByList,
    PlannerAppInclude? include,
  }) {
    return PlannerAppIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlannerApp.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PlannerApp.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlannerAppImpl extends PlannerApp {
  _PlannerAppImpl({
    _i1.UuidValue? id,
    required String appName,
    required _i1.UuidValue colorId,
    _i1.UuidValue? organizationId,
  }) : super._(
         id: id,
         appName: appName,
         colorId: colorId,
         organizationId: organizationId,
       );

  /// Returns a shallow copy of this [PlannerApp]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlannerApp copyWith({
    Object? id = _Undefined,
    String? appName,
    _i1.UuidValue? colorId,
    Object? organizationId = _Undefined,
  }) {
    return PlannerApp(
      id: id is _i1.UuidValue? ? id : this.id,
      appName: appName ?? this.appName,
      colorId: colorId ?? this.colorId,
      organizationId: organizationId is _i1.UuidValue?
          ? organizationId
          : this.organizationId,
    );
  }
}

class PlannerAppUpdateTable extends _i1.UpdateTable<PlannerAppTable> {
  PlannerAppUpdateTable(super.table);

  _i1.ColumnValue<String, String> appName(String value) => _i1.ColumnValue(
    table.appName,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> colorId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.colorId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> organizationId(
    _i1.UuidValue? value,
  ) => _i1.ColumnValue(
    table.organizationId,
    value,
  );
}

class PlannerAppTable extends _i1.Table<_i1.UuidValue?> {
  PlannerAppTable({super.tableRelation}) : super(tableName: 'planner_apps') {
    updateTable = PlannerAppUpdateTable(this);
    appName = _i1.ColumnString(
      'appName',
      this,
    );
    colorId = _i1.ColumnUuid(
      'colorId',
      this,
    );
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
  }

  late final PlannerAppUpdateTable updateTable;

  late final _i1.ColumnString appName;

  late final _i1.ColumnUuid colorId;

  late final _i1.ColumnUuid organizationId;

  @override
  List<_i1.Column> get columns => [
    id,
    appName,
    colorId,
    organizationId,
  ];
}

class PlannerAppInclude extends _i1.IncludeObject {
  PlannerAppInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PlannerApp.t;
}

class PlannerAppIncludeList extends _i1.IncludeList {
  PlannerAppIncludeList._({
    _i1.WhereExpressionBuilder<PlannerAppTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PlannerApp.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PlannerApp.t;
}

class PlannerAppRepository {
  const PlannerAppRepository._();

  /// Returns a list of [PlannerApp]s matching the given query parameters.
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
  Future<List<PlannerApp>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlannerAppTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlannerAppTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlannerAppTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<PlannerApp>(
      where: where?.call(PlannerApp.t),
      orderBy: orderBy?.call(PlannerApp.t),
      orderByList: orderByList?.call(PlannerApp.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [PlannerApp] matching the given query parameters.
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
  Future<PlannerApp?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlannerAppTable>? where,
    int? offset,
    _i1.OrderByBuilder<PlannerAppTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlannerAppTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<PlannerApp>(
      where: where?.call(PlannerApp.t),
      orderBy: orderBy?.call(PlannerApp.t),
      orderByList: orderByList?.call(PlannerApp.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [PlannerApp] by its [id] or null if no such row exists.
  Future<PlannerApp?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<PlannerApp>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [PlannerApp]s in the list and returns the inserted rows.
  ///
  /// The returned [PlannerApp]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PlannerApp>> insert(
    _i1.Session session,
    List<PlannerApp> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PlannerApp>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PlannerApp] and returns the inserted row.
  ///
  /// The returned [PlannerApp] will have its `id` field set.
  Future<PlannerApp> insertRow(
    _i1.Session session,
    PlannerApp row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PlannerApp>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PlannerApp]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PlannerApp>> update(
    _i1.Session session,
    List<PlannerApp> rows, {
    _i1.ColumnSelections<PlannerAppTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PlannerApp>(
      rows,
      columns: columns?.call(PlannerApp.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlannerApp]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PlannerApp> updateRow(
    _i1.Session session,
    PlannerApp row, {
    _i1.ColumnSelections<PlannerAppTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PlannerApp>(
      row,
      columns: columns?.call(PlannerApp.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlannerApp] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PlannerApp?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<PlannerAppUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PlannerApp>(
      id,
      columnValues: columnValues(PlannerApp.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PlannerApp]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PlannerApp>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<PlannerAppUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PlannerAppTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlannerAppTable>? orderBy,
    _i1.OrderByListBuilder<PlannerAppTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PlannerApp>(
      columnValues: columnValues(PlannerApp.t.updateTable),
      where: where(PlannerApp.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlannerApp.t),
      orderByList: orderByList?.call(PlannerApp.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PlannerApp]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PlannerApp>> delete(
    _i1.Session session,
    List<PlannerApp> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PlannerApp>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PlannerApp].
  Future<PlannerApp> deleteRow(
    _i1.Session session,
    PlannerApp row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PlannerApp>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PlannerApp>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PlannerAppTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PlannerApp>(
      where: where(PlannerApp.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlannerAppTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PlannerApp>(
      where: where?.call(PlannerApp.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
