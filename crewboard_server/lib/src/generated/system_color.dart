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

abstract class SystemColor
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SystemColor._({
    this.id,
    this.colorName,
    required this.color,
    required this.isDefault,
  });

  factory SystemColor({
    int? id,
    String? colorName,
    required String color,
    required bool isDefault,
  }) = _SystemColorImpl;

  factory SystemColor.fromJson(Map<String, dynamic> jsonSerialization) {
    return SystemColor(
      id: jsonSerialization['id'] as int?,
      colorName: jsonSerialization['colorName'] as String?,
      color: jsonSerialization['color'] as String,
      isDefault: jsonSerialization['isDefault'] as bool,
    );
  }

  static final t = SystemColorTable();

  static const db = SystemColorRepository._();

  @override
  int? id;

  String? colorName;

  String color;

  bool isDefault;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SystemColor]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SystemColor copyWith({
    int? id,
    String? colorName,
    String? color,
    bool? isDefault,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SystemColor',
      if (id != null) 'id': id,
      if (colorName != null) 'colorName': colorName,
      'color': color,
      'isDefault': isDefault,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SystemColor',
      if (id != null) 'id': id,
      if (colorName != null) 'colorName': colorName,
      'color': color,
      'isDefault': isDefault,
    };
  }

  static SystemColorInclude include() {
    return SystemColorInclude._();
  }

  static SystemColorIncludeList includeList({
    _i1.WhereExpressionBuilder<SystemColorTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemColorTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemColorTable>? orderByList,
    SystemColorInclude? include,
  }) {
    return SystemColorIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SystemColor.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SystemColor.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SystemColorImpl extends SystemColor {
  _SystemColorImpl({
    int? id,
    String? colorName,
    required String color,
    required bool isDefault,
  }) : super._(
         id: id,
         colorName: colorName,
         color: color,
         isDefault: isDefault,
       );

  /// Returns a shallow copy of this [SystemColor]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SystemColor copyWith({
    Object? id = _Undefined,
    Object? colorName = _Undefined,
    String? color,
    bool? isDefault,
  }) {
    return SystemColor(
      id: id is int? ? id : this.id,
      colorName: colorName is String? ? colorName : this.colorName,
      color: color ?? this.color,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

class SystemColorUpdateTable extends _i1.UpdateTable<SystemColorTable> {
  SystemColorUpdateTable(super.table);

  _i1.ColumnValue<String, String> colorName(String? value) => _i1.ColumnValue(
    table.colorName,
    value,
  );

  _i1.ColumnValue<String, String> color(String value) => _i1.ColumnValue(
    table.color,
    value,
  );

  _i1.ColumnValue<bool, bool> isDefault(bool value) => _i1.ColumnValue(
    table.isDefault,
    value,
  );
}

class SystemColorTable extends _i1.Table<int?> {
  SystemColorTable({super.tableRelation}) : super(tableName: 'system_color') {
    updateTable = SystemColorUpdateTable(this);
    colorName = _i1.ColumnString(
      'colorName',
      this,
    );
    color = _i1.ColumnString(
      'color',
      this,
    );
    isDefault = _i1.ColumnBool(
      'isDefault',
      this,
    );
  }

  late final SystemColorUpdateTable updateTable;

  late final _i1.ColumnString colorName;

  late final _i1.ColumnString color;

  late final _i1.ColumnBool isDefault;

  @override
  List<_i1.Column> get columns => [
    id,
    colorName,
    color,
    isDefault,
  ];
}

class SystemColorInclude extends _i1.IncludeObject {
  SystemColorInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SystemColor.t;
}

class SystemColorIncludeList extends _i1.IncludeList {
  SystemColorIncludeList._({
    _i1.WhereExpressionBuilder<SystemColorTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SystemColor.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SystemColor.t;
}

class SystemColorRepository {
  const SystemColorRepository._();

  /// Returns a list of [SystemColor]s matching the given query parameters.
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
  Future<List<SystemColor>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SystemColorTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemColorTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemColorTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SystemColor>(
      where: where?.call(SystemColor.t),
      orderBy: orderBy?.call(SystemColor.t),
      orderByList: orderByList?.call(SystemColor.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SystemColor] matching the given query parameters.
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
  Future<SystemColor?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SystemColorTable>? where,
    int? offset,
    _i1.OrderByBuilder<SystemColorTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemColorTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SystemColor>(
      where: where?.call(SystemColor.t),
      orderBy: orderBy?.call(SystemColor.t),
      orderByList: orderByList?.call(SystemColor.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SystemColor] by its [id] or null if no such row exists.
  Future<SystemColor?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SystemColor>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SystemColor]s in the list and returns the inserted rows.
  ///
  /// The returned [SystemColor]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SystemColor>> insert(
    _i1.Session session,
    List<SystemColor> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SystemColor>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SystemColor] and returns the inserted row.
  ///
  /// The returned [SystemColor] will have its `id` field set.
  Future<SystemColor> insertRow(
    _i1.Session session,
    SystemColor row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SystemColor>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SystemColor]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SystemColor>> update(
    _i1.Session session,
    List<SystemColor> rows, {
    _i1.ColumnSelections<SystemColorTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SystemColor>(
      rows,
      columns: columns?.call(SystemColor.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SystemColor]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SystemColor> updateRow(
    _i1.Session session,
    SystemColor row, {
    _i1.ColumnSelections<SystemColorTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SystemColor>(
      row,
      columns: columns?.call(SystemColor.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SystemColor] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SystemColor?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SystemColorUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SystemColor>(
      id,
      columnValues: columnValues(SystemColor.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SystemColor]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SystemColor>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SystemColorUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SystemColorTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemColorTable>? orderBy,
    _i1.OrderByListBuilder<SystemColorTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SystemColor>(
      columnValues: columnValues(SystemColor.t.updateTable),
      where: where(SystemColor.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SystemColor.t),
      orderByList: orderByList?.call(SystemColor.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SystemColor]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SystemColor>> delete(
    _i1.Session session,
    List<SystemColor> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SystemColor>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SystemColor].
  Future<SystemColor> deleteRow(
    _i1.Session session,
    SystemColor row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SystemColor>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SystemColor>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SystemColorTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SystemColor>(
      where: where(SystemColor.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SystemColorTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SystemColor>(
      where: where?.call(SystemColor.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
