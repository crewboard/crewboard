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

abstract class PlannerActivity
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  PlannerActivity._({
    this.id,
    required this.ticketId,
    required this.ticketName,
    required this.userName,
    this.userColor,
    required this.action,
    this.details,
    required this.createdAt,
  });

  factory PlannerActivity({
    _i1.UuidValue? id,
    required _i1.UuidValue ticketId,
    required String ticketName,
    required String userName,
    String? userColor,
    required String action,
    String? details,
    required DateTime createdAt,
  }) = _PlannerActivityImpl;

  factory PlannerActivity.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlannerActivity(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      ticketId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['ticketId'],
      ),
      ticketName: jsonSerialization['ticketName'] as String,
      userName: jsonSerialization['userName'] as String,
      userColor: jsonSerialization['userColor'] as String?,
      action: jsonSerialization['action'] as String,
      details: jsonSerialization['details'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = PlannerActivityTable();

  static const db = PlannerActivityRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue ticketId;

  String ticketName;

  String userName;

  String? userColor;

  String action;

  String? details;

  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [PlannerActivity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlannerActivity copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? ticketId,
    String? ticketName,
    String? userName,
    String? userColor,
    String? action,
    String? details,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlannerActivity',
      if (id != null) 'id': id?.toJson(),
      'ticketId': ticketId.toJson(),
      'ticketName': ticketName,
      'userName': userName,
      if (userColor != null) 'userColor': userColor,
      'action': action,
      if (details != null) 'details': details,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlannerActivity',
      if (id != null) 'id': id?.toJson(),
      'ticketId': ticketId.toJson(),
      'ticketName': ticketName,
      'userName': userName,
      if (userColor != null) 'userColor': userColor,
      'action': action,
      if (details != null) 'details': details,
      'createdAt': createdAt.toJson(),
    };
  }

  static PlannerActivityInclude include() {
    return PlannerActivityInclude._();
  }

  static PlannerActivityIncludeList includeList({
    _i1.WhereExpressionBuilder<PlannerActivityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlannerActivityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlannerActivityTable>? orderByList,
    PlannerActivityInclude? include,
  }) {
    return PlannerActivityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlannerActivity.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PlannerActivity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlannerActivityImpl extends PlannerActivity {
  _PlannerActivityImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue ticketId,
    required String ticketName,
    required String userName,
    String? userColor,
    required String action,
    String? details,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ticketId: ticketId,
         ticketName: ticketName,
         userName: userName,
         userColor: userColor,
         action: action,
         details: details,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PlannerActivity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlannerActivity copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? ticketId,
    String? ticketName,
    String? userName,
    Object? userColor = _Undefined,
    String? action,
    Object? details = _Undefined,
    DateTime? createdAt,
  }) {
    return PlannerActivity(
      id: id is _i1.UuidValue? ? id : this.id,
      ticketId: ticketId ?? this.ticketId,
      ticketName: ticketName ?? this.ticketName,
      userName: userName ?? this.userName,
      userColor: userColor is String? ? userColor : this.userColor,
      action: action ?? this.action,
      details: details is String? ? details : this.details,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PlannerActivityUpdateTable extends _i1.UpdateTable<PlannerActivityTable> {
  PlannerActivityUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> ticketId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.ticketId,
        value,
      );

  _i1.ColumnValue<String, String> ticketName(String value) => _i1.ColumnValue(
    table.ticketName,
    value,
  );

  _i1.ColumnValue<String, String> userName(String value) => _i1.ColumnValue(
    table.userName,
    value,
  );

  _i1.ColumnValue<String, String> userColor(String? value) => _i1.ColumnValue(
    table.userColor,
    value,
  );

  _i1.ColumnValue<String, String> action(String value) => _i1.ColumnValue(
    table.action,
    value,
  );

  _i1.ColumnValue<String, String> details(String? value) => _i1.ColumnValue(
    table.details,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class PlannerActivityTable extends _i1.Table<_i1.UuidValue?> {
  PlannerActivityTable({super.tableRelation})
    : super(tableName: 'planner_activities') {
    updateTable = PlannerActivityUpdateTable(this);
    ticketId = _i1.ColumnUuid(
      'ticketId',
      this,
    );
    ticketName = _i1.ColumnString(
      'ticketName',
      this,
    );
    userName = _i1.ColumnString(
      'userName',
      this,
    );
    userColor = _i1.ColumnString(
      'userColor',
      this,
    );
    action = _i1.ColumnString(
      'action',
      this,
    );
    details = _i1.ColumnString(
      'details',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PlannerActivityUpdateTable updateTable;

  late final _i1.ColumnUuid ticketId;

  late final _i1.ColumnString ticketName;

  late final _i1.ColumnString userName;

  late final _i1.ColumnString userColor;

  late final _i1.ColumnString action;

  late final _i1.ColumnString details;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    ticketId,
    ticketName,
    userName,
    userColor,
    action,
    details,
    createdAt,
  ];
}

class PlannerActivityInclude extends _i1.IncludeObject {
  PlannerActivityInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PlannerActivity.t;
}

class PlannerActivityIncludeList extends _i1.IncludeList {
  PlannerActivityIncludeList._({
    _i1.WhereExpressionBuilder<PlannerActivityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PlannerActivity.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PlannerActivity.t;
}

class PlannerActivityRepository {
  const PlannerActivityRepository._();

  /// Returns a list of [PlannerActivity]s matching the given query parameters.
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
  Future<List<PlannerActivity>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlannerActivityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlannerActivityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlannerActivityTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<PlannerActivity>(
      where: where?.call(PlannerActivity.t),
      orderBy: orderBy?.call(PlannerActivity.t),
      orderByList: orderByList?.call(PlannerActivity.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [PlannerActivity] matching the given query parameters.
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
  Future<PlannerActivity?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlannerActivityTable>? where,
    int? offset,
    _i1.OrderByBuilder<PlannerActivityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlannerActivityTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<PlannerActivity>(
      where: where?.call(PlannerActivity.t),
      orderBy: orderBy?.call(PlannerActivity.t),
      orderByList: orderByList?.call(PlannerActivity.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [PlannerActivity] by its [id] or null if no such row exists.
  Future<PlannerActivity?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<PlannerActivity>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [PlannerActivity]s in the list and returns the inserted rows.
  ///
  /// The returned [PlannerActivity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<PlannerActivity>> insert(
    _i1.Session session,
    List<PlannerActivity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<PlannerActivity>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [PlannerActivity] and returns the inserted row.
  ///
  /// The returned [PlannerActivity] will have its `id` field set.
  Future<PlannerActivity> insertRow(
    _i1.Session session,
    PlannerActivity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PlannerActivity>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PlannerActivity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PlannerActivity>> update(
    _i1.Session session,
    List<PlannerActivity> rows, {
    _i1.ColumnSelections<PlannerActivityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PlannerActivity>(
      rows,
      columns: columns?.call(PlannerActivity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlannerActivity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PlannerActivity> updateRow(
    _i1.Session session,
    PlannerActivity row, {
    _i1.ColumnSelections<PlannerActivityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PlannerActivity>(
      row,
      columns: columns?.call(PlannerActivity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlannerActivity] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PlannerActivity?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<PlannerActivityUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PlannerActivity>(
      id,
      columnValues: columnValues(PlannerActivity.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PlannerActivity]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PlannerActivity>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<PlannerActivityUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<PlannerActivityTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlannerActivityTable>? orderBy,
    _i1.OrderByListBuilder<PlannerActivityTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PlannerActivity>(
      columnValues: columnValues(PlannerActivity.t.updateTable),
      where: where(PlannerActivity.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlannerActivity.t),
      orderByList: orderByList?.call(PlannerActivity.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PlannerActivity]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PlannerActivity>> delete(
    _i1.Session session,
    List<PlannerActivity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PlannerActivity>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PlannerActivity].
  Future<PlannerActivity> deleteRow(
    _i1.Session session,
    PlannerActivity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PlannerActivity>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PlannerActivity>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PlannerActivityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PlannerActivity>(
      where: where(PlannerActivity.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PlannerActivityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PlannerActivity>(
      where: where?.call(PlannerActivity.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
