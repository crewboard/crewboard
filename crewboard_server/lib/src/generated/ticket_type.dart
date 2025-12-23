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

abstract class TicketType
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TicketType._({
    this.id,
    required this.typeName,
    required this.colorId,
  });

  factory TicketType({
    int? id,
    required String typeName,
    required int colorId,
  }) = _TicketTypeImpl;

  factory TicketType.fromJson(Map<String, dynamic> jsonSerialization) {
    return TicketType(
      id: jsonSerialization['id'] as int?,
      typeName: jsonSerialization['typeName'] as String,
      colorId: jsonSerialization['colorId'] as int,
    );
  }

  static final t = TicketTypeTable();

  static const db = TicketTypeRepository._();

  @override
  int? id;

  String typeName;

  int colorId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TicketType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TicketType copyWith({
    int? id,
    String? typeName,
    int? colorId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TicketType',
      if (id != null) 'id': id,
      'typeName': typeName,
      'colorId': colorId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TicketType',
      if (id != null) 'id': id,
      'typeName': typeName,
      'colorId': colorId,
    };
  }

  static TicketTypeInclude include() {
    return TicketTypeInclude._();
  }

  static TicketTypeIncludeList includeList({
    _i1.WhereExpressionBuilder<TicketTypeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketTypeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketTypeTable>? orderByList,
    TicketTypeInclude? include,
  }) {
    return TicketTypeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TicketType.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TicketType.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TicketTypeImpl extends TicketType {
  _TicketTypeImpl({
    int? id,
    required String typeName,
    required int colorId,
  }) : super._(
         id: id,
         typeName: typeName,
         colorId: colorId,
       );

  /// Returns a shallow copy of this [TicketType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TicketType copyWith({
    Object? id = _Undefined,
    String? typeName,
    int? colorId,
  }) {
    return TicketType(
      id: id is int? ? id : this.id,
      typeName: typeName ?? this.typeName,
      colorId: colorId ?? this.colorId,
    );
  }
}

class TicketTypeUpdateTable extends _i1.UpdateTable<TicketTypeTable> {
  TicketTypeUpdateTable(super.table);

  _i1.ColumnValue<String, String> typeName(String value) => _i1.ColumnValue(
    table.typeName,
    value,
  );

  _i1.ColumnValue<int, int> colorId(int value) => _i1.ColumnValue(
    table.colorId,
    value,
  );
}

class TicketTypeTable extends _i1.Table<int?> {
  TicketTypeTable({super.tableRelation}) : super(tableName: 'ticket_type') {
    updateTable = TicketTypeUpdateTable(this);
    typeName = _i1.ColumnString(
      'typeName',
      this,
    );
    colorId = _i1.ColumnInt(
      'colorId',
      this,
    );
  }

  late final TicketTypeUpdateTable updateTable;

  late final _i1.ColumnString typeName;

  late final _i1.ColumnInt colorId;

  @override
  List<_i1.Column> get columns => [
    id,
    typeName,
    colorId,
  ];
}

class TicketTypeInclude extends _i1.IncludeObject {
  TicketTypeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => TicketType.t;
}

class TicketTypeIncludeList extends _i1.IncludeList {
  TicketTypeIncludeList._({
    _i1.WhereExpressionBuilder<TicketTypeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TicketType.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TicketType.t;
}

class TicketTypeRepository {
  const TicketTypeRepository._();

  /// Returns a list of [TicketType]s matching the given query parameters.
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
  Future<List<TicketType>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketTypeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketTypeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketTypeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<TicketType>(
      where: where?.call(TicketType.t),
      orderBy: orderBy?.call(TicketType.t),
      orderByList: orderByList?.call(TicketType.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [TicketType] matching the given query parameters.
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
  Future<TicketType?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketTypeTable>? where,
    int? offset,
    _i1.OrderByBuilder<TicketTypeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TicketTypeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<TicketType>(
      where: where?.call(TicketType.t),
      orderBy: orderBy?.call(TicketType.t),
      orderByList: orderByList?.call(TicketType.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [TicketType] by its [id] or null if no such row exists.
  Future<TicketType?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<TicketType>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [TicketType]s in the list and returns the inserted rows.
  ///
  /// The returned [TicketType]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<TicketType>> insert(
    _i1.Session session,
    List<TicketType> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<TicketType>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [TicketType] and returns the inserted row.
  ///
  /// The returned [TicketType] will have its `id` field set.
  Future<TicketType> insertRow(
    _i1.Session session,
    TicketType row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TicketType>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TicketType]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TicketType>> update(
    _i1.Session session,
    List<TicketType> rows, {
    _i1.ColumnSelections<TicketTypeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TicketType>(
      rows,
      columns: columns?.call(TicketType.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TicketType]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TicketType> updateRow(
    _i1.Session session,
    TicketType row, {
    _i1.ColumnSelections<TicketTypeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TicketType>(
      row,
      columns: columns?.call(TicketType.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TicketType] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TicketType?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<TicketTypeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TicketType>(
      id,
      columnValues: columnValues(TicketType.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TicketType]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TicketType>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<TicketTypeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TicketTypeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TicketTypeTable>? orderBy,
    _i1.OrderByListBuilder<TicketTypeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TicketType>(
      columnValues: columnValues(TicketType.t.updateTable),
      where: where(TicketType.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TicketType.t),
      orderByList: orderByList?.call(TicketType.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TicketType]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TicketType>> delete(
    _i1.Session session,
    List<TicketType> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TicketType>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TicketType].
  Future<TicketType> deleteRow(
    _i1.Session session,
    TicketType row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TicketType>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TicketType>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<TicketTypeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TicketType>(
      where: where(TicketType.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<TicketTypeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TicketType>(
      where: where?.call(TicketType.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
