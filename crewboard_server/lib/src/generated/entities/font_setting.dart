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

abstract class FontSetting
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FontSetting._({
    this.id,
    required this.name,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.color,
    this.lineHeight,
    this.headerLevel,
  });

  factory FontSetting({
    int? id,
    required String name,
    double? fontSize,
    String? fontFamily,
    String? fontWeight,
    String? color,
    double? lineHeight,
    int? headerLevel,
  }) = _FontSettingImpl;

  factory FontSetting.fromJson(Map<String, dynamic> jsonSerialization) {
    return FontSetting(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      fontSize: (jsonSerialization['fontSize'] as num?)?.toDouble(),
      fontFamily: jsonSerialization['fontFamily'] as String?,
      fontWeight: jsonSerialization['fontWeight'] as String?,
      color: jsonSerialization['color'] as String?,
      lineHeight: (jsonSerialization['lineHeight'] as num?)?.toDouble(),
      headerLevel: jsonSerialization['headerLevel'] as int?,
    );
  }

  static final t = FontSettingTable();

  static const db = FontSettingRepository._();

  @override
  int? id;

  String name;

  double? fontSize;

  String? fontFamily;

  String? fontWeight;

  String? color;

  double? lineHeight;

  int? headerLevel;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FontSetting]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FontSetting copyWith({
    int? id,
    String? name,
    double? fontSize,
    String? fontFamily,
    String? fontWeight,
    String? color,
    double? lineHeight,
    int? headerLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FontSetting',
      if (id != null) 'id': id,
      'name': name,
      if (fontSize != null) 'fontSize': fontSize,
      if (fontFamily != null) 'fontFamily': fontFamily,
      if (fontWeight != null) 'fontWeight': fontWeight,
      if (color != null) 'color': color,
      if (lineHeight != null) 'lineHeight': lineHeight,
      if (headerLevel != null) 'headerLevel': headerLevel,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FontSetting',
      if (id != null) 'id': id,
      'name': name,
      if (fontSize != null) 'fontSize': fontSize,
      if (fontFamily != null) 'fontFamily': fontFamily,
      if (fontWeight != null) 'fontWeight': fontWeight,
      if (color != null) 'color': color,
      if (lineHeight != null) 'lineHeight': lineHeight,
      if (headerLevel != null) 'headerLevel': headerLevel,
    };
  }

  static FontSettingInclude include() {
    return FontSettingInclude._();
  }

  static FontSettingIncludeList includeList({
    _i1.WhereExpressionBuilder<FontSettingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FontSettingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FontSettingTable>? orderByList,
    FontSettingInclude? include,
  }) {
    return FontSettingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FontSetting.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FontSetting.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FontSettingImpl extends FontSetting {
  _FontSettingImpl({
    int? id,
    required String name,
    double? fontSize,
    String? fontFamily,
    String? fontWeight,
    String? color,
    double? lineHeight,
    int? headerLevel,
  }) : super._(
         id: id,
         name: name,
         fontSize: fontSize,
         fontFamily: fontFamily,
         fontWeight: fontWeight,
         color: color,
         lineHeight: lineHeight,
         headerLevel: headerLevel,
       );

  /// Returns a shallow copy of this [FontSetting]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FontSetting copyWith({
    Object? id = _Undefined,
    String? name,
    Object? fontSize = _Undefined,
    Object? fontFamily = _Undefined,
    Object? fontWeight = _Undefined,
    Object? color = _Undefined,
    Object? lineHeight = _Undefined,
    Object? headerLevel = _Undefined,
  }) {
    return FontSetting(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      fontSize: fontSize is double? ? fontSize : this.fontSize,
      fontFamily: fontFamily is String? ? fontFamily : this.fontFamily,
      fontWeight: fontWeight is String? ? fontWeight : this.fontWeight,
      color: color is String? ? color : this.color,
      lineHeight: lineHeight is double? ? lineHeight : this.lineHeight,
      headerLevel: headerLevel is int? ? headerLevel : this.headerLevel,
    );
  }
}

class FontSettingUpdateTable extends _i1.UpdateTable<FontSettingTable> {
  FontSettingUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<double, double> fontSize(double? value) => _i1.ColumnValue(
    table.fontSize,
    value,
  );

  _i1.ColumnValue<String, String> fontFamily(String? value) => _i1.ColumnValue(
    table.fontFamily,
    value,
  );

  _i1.ColumnValue<String, String> fontWeight(String? value) => _i1.ColumnValue(
    table.fontWeight,
    value,
  );

  _i1.ColumnValue<String, String> color(String? value) => _i1.ColumnValue(
    table.color,
    value,
  );

  _i1.ColumnValue<double, double> lineHeight(double? value) => _i1.ColumnValue(
    table.lineHeight,
    value,
  );

  _i1.ColumnValue<int, int> headerLevel(int? value) => _i1.ColumnValue(
    table.headerLevel,
    value,
  );
}

class FontSettingTable extends _i1.Table<int?> {
  FontSettingTable({super.tableRelation}) : super(tableName: 'font_setting') {
    updateTable = FontSettingUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    fontSize = _i1.ColumnDouble(
      'fontSize',
      this,
    );
    fontFamily = _i1.ColumnString(
      'fontFamily',
      this,
    );
    fontWeight = _i1.ColumnString(
      'fontWeight',
      this,
    );
    color = _i1.ColumnString(
      'color',
      this,
    );
    lineHeight = _i1.ColumnDouble(
      'lineHeight',
      this,
    );
    headerLevel = _i1.ColumnInt(
      'headerLevel',
      this,
    );
  }

  late final FontSettingUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnDouble fontSize;

  late final _i1.ColumnString fontFamily;

  late final _i1.ColumnString fontWeight;

  late final _i1.ColumnString color;

  late final _i1.ColumnDouble lineHeight;

  late final _i1.ColumnInt headerLevel;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    fontSize,
    fontFamily,
    fontWeight,
    color,
    lineHeight,
    headerLevel,
  ];
}

class FontSettingInclude extends _i1.IncludeObject {
  FontSettingInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FontSetting.t;
}

class FontSettingIncludeList extends _i1.IncludeList {
  FontSettingIncludeList._({
    _i1.WhereExpressionBuilder<FontSettingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FontSetting.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FontSetting.t;
}

class FontSettingRepository {
  const FontSettingRepository._();

  /// Returns a list of [FontSetting]s matching the given query parameters.
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
  Future<List<FontSetting>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FontSettingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FontSettingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FontSettingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<FontSetting>(
      where: where?.call(FontSetting.t),
      orderBy: orderBy?.call(FontSetting.t),
      orderByList: orderByList?.call(FontSetting.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [FontSetting] matching the given query parameters.
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
  Future<FontSetting?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FontSettingTable>? where,
    int? offset,
    _i1.OrderByBuilder<FontSettingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FontSettingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<FontSetting>(
      where: where?.call(FontSetting.t),
      orderBy: orderBy?.call(FontSetting.t),
      orderByList: orderByList?.call(FontSetting.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [FontSetting] by its [id] or null if no such row exists.
  Future<FontSetting?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<FontSetting>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [FontSetting]s in the list and returns the inserted rows.
  ///
  /// The returned [FontSetting]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FontSetting>> insert(
    _i1.Session session,
    List<FontSetting> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FontSetting>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FontSetting] and returns the inserted row.
  ///
  /// The returned [FontSetting] will have its `id` field set.
  Future<FontSetting> insertRow(
    _i1.Session session,
    FontSetting row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FontSetting>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FontSetting]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FontSetting>> update(
    _i1.Session session,
    List<FontSetting> rows, {
    _i1.ColumnSelections<FontSettingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FontSetting>(
      rows,
      columns: columns?.call(FontSetting.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FontSetting]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FontSetting> updateRow(
    _i1.Session session,
    FontSetting row, {
    _i1.ColumnSelections<FontSettingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FontSetting>(
      row,
      columns: columns?.call(FontSetting.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FontSetting] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FontSetting?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<FontSettingUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FontSetting>(
      id,
      columnValues: columnValues(FontSetting.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FontSetting]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FontSetting>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<FontSettingUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FontSettingTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FontSettingTable>? orderBy,
    _i1.OrderByListBuilder<FontSettingTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FontSetting>(
      columnValues: columnValues(FontSetting.t.updateTable),
      where: where(FontSetting.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FontSetting.t),
      orderByList: orderByList?.call(FontSetting.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FontSetting]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FontSetting>> delete(
    _i1.Session session,
    List<FontSetting> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FontSetting>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FontSetting].
  Future<FontSetting> deleteRow(
    _i1.Session session,
    FontSetting row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FontSetting>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FontSetting>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FontSettingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FontSetting>(
      where: where(FontSetting.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FontSettingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FontSetting>(
      where: where?.call(FontSetting.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
