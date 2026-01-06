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

abstract class Doc
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Doc._({
    this.id,
    required this.appId,
    required this.name,
    this.doc,
    this.outline,
    required this.lastUpdated,
  });

  factory Doc({
    _i1.UuidValue? id,
    required _i1.UuidValue appId,
    required String name,
    String? doc,
    String? outline,
    required DateTime lastUpdated,
  }) = _DocImpl;

  factory Doc.fromJson(Map<String, dynamic> jsonSerialization) {
    return Doc(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      appId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['appId']),
      name: jsonSerialization['name'] as String,
      doc: jsonSerialization['doc'] as String?,
      outline: jsonSerialization['outline'] as String?,
      lastUpdated: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastUpdated'],
      ),
    );
  }

  static final t = DocTable();

  static const db = DocRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue appId;

  String name;

  String? doc;

  String? outline;

  DateTime lastUpdated;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Doc]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Doc copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? appId,
    String? name,
    String? doc,
    String? outline,
    DateTime? lastUpdated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Doc',
      if (id != null) 'id': id?.toJson(),
      'appId': appId.toJson(),
      'name': name,
      if (doc != null) 'doc': doc,
      if (outline != null) 'outline': outline,
      'lastUpdated': lastUpdated.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Doc',
      if (id != null) 'id': id?.toJson(),
      'appId': appId.toJson(),
      'name': name,
      if (doc != null) 'doc': doc,
      if (outline != null) 'outline': outline,
      'lastUpdated': lastUpdated.toJson(),
    };
  }

  static DocInclude include() {
    return DocInclude._();
  }

  static DocIncludeList includeList({
    _i1.WhereExpressionBuilder<DocTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocTable>? orderByList,
    DocInclude? include,
  }) {
    return DocIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Doc.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Doc.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DocImpl extends Doc {
  _DocImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue appId,
    required String name,
    String? doc,
    String? outline,
    required DateTime lastUpdated,
  }) : super._(
         id: id,
         appId: appId,
         name: name,
         doc: doc,
         outline: outline,
         lastUpdated: lastUpdated,
       );

  /// Returns a shallow copy of this [Doc]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Doc copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? appId,
    String? name,
    Object? doc = _Undefined,
    Object? outline = _Undefined,
    DateTime? lastUpdated,
  }) {
    return Doc(
      id: id is _i1.UuidValue? ? id : this.id,
      appId: appId ?? this.appId,
      name: name ?? this.name,
      doc: doc is String? ? doc : this.doc,
      outline: outline is String? ? outline : this.outline,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class DocUpdateTable extends _i1.UpdateTable<DocTable> {
  DocUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> appId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.appId,
        value,
      );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> doc(String? value) => _i1.ColumnValue(
    table.doc,
    value,
  );

  _i1.ColumnValue<String, String> outline(String? value) => _i1.ColumnValue(
    table.outline,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastUpdated(DateTime value) =>
      _i1.ColumnValue(
        table.lastUpdated,
        value,
      );
}

class DocTable extends _i1.Table<_i1.UuidValue?> {
  DocTable({super.tableRelation}) : super(tableName: 'doc') {
    updateTable = DocUpdateTable(this);
    appId = _i1.ColumnUuid(
      'appId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    doc = _i1.ColumnString(
      'doc',
      this,
    );
    outline = _i1.ColumnString(
      'outline',
      this,
    );
    lastUpdated = _i1.ColumnDateTime(
      'lastUpdated',
      this,
    );
  }

  late final DocUpdateTable updateTable;

  late final _i1.ColumnUuid appId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString doc;

  late final _i1.ColumnString outline;

  late final _i1.ColumnDateTime lastUpdated;

  @override
  List<_i1.Column> get columns => [
    id,
    appId,
    name,
    doc,
    outline,
    lastUpdated,
  ];
}

class DocInclude extends _i1.IncludeObject {
  DocInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Doc.t;
}

class DocIncludeList extends _i1.IncludeList {
  DocIncludeList._({
    _i1.WhereExpressionBuilder<DocTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Doc.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Doc.t;
}

class DocRepository {
  const DocRepository._();

  /// Returns a list of [Doc]s matching the given query parameters.
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
  Future<List<Doc>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DocTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Doc>(
      where: where?.call(Doc.t),
      orderBy: orderBy?.call(Doc.t),
      orderByList: orderByList?.call(Doc.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Doc] matching the given query parameters.
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
  Future<Doc?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DocTable>? where,
    int? offset,
    _i1.OrderByBuilder<DocTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DocTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Doc>(
      where: where?.call(Doc.t),
      orderBy: orderBy?.call(Doc.t),
      orderByList: orderByList?.call(Doc.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Doc] by its [id] or null if no such row exists.
  Future<Doc?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Doc>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Doc]s in the list and returns the inserted rows.
  ///
  /// The returned [Doc]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Doc>> insert(
    _i1.Session session,
    List<Doc> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Doc>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Doc] and returns the inserted row.
  ///
  /// The returned [Doc] will have its `id` field set.
  Future<Doc> insertRow(
    _i1.Session session,
    Doc row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Doc>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Doc]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Doc>> update(
    _i1.Session session,
    List<Doc> rows, {
    _i1.ColumnSelections<DocTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Doc>(
      rows,
      columns: columns?.call(Doc.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Doc]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Doc> updateRow(
    _i1.Session session,
    Doc row, {
    _i1.ColumnSelections<DocTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Doc>(
      row,
      columns: columns?.call(Doc.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Doc] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Doc?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<DocUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Doc>(
      id,
      columnValues: columnValues(Doc.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Doc]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Doc>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<DocUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DocTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DocTable>? orderBy,
    _i1.OrderByListBuilder<DocTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Doc>(
      columnValues: columnValues(Doc.t.updateTable),
      where: where(Doc.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Doc.t),
      orderByList: orderByList?.call(Doc.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Doc]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Doc>> delete(
    _i1.Session session,
    List<Doc> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Doc>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Doc].
  Future<Doc> deleteRow(
    _i1.Session session,
    Doc row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Doc>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Doc>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DocTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Doc>(
      where: where(Doc.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DocTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Doc>(
      where: where?.call(Doc.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
