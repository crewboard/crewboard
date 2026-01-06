/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../entities/user.dart' as _i2;
import 'package:crewboard_server/src/generated/protocol.dart' as _i3;

abstract class Attendance
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Attendance._({
    this.id,
    required this.userId,
    this.user,
    this.inTime,
    this.outTime,
    this.inTimeStatus,
    this.outTimeStatus,
    this.overTime,
    this.earlyTime,
    required this.date,
  });

  factory Attendance({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    String? inTime,
    String? outTime,
    String? inTimeStatus,
    String? outTimeStatus,
    String? overTime,
    String? earlyTime,
    required DateTime date,
  }) = _AttendanceImpl;

  factory Attendance.fromJson(Map<String, dynamic> jsonSerialization) {
    return Attendance(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.User>(jsonSerialization['user']),
      inTime: jsonSerialization['inTime'] as String?,
      outTime: jsonSerialization['outTime'] as String?,
      inTimeStatus: jsonSerialization['inTimeStatus'] as String?,
      outTimeStatus: jsonSerialization['outTimeStatus'] as String?,
      overTime: jsonSerialization['overTime'] as String?,
      earlyTime: jsonSerialization['earlyTime'] as String?,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
    );
  }

  static final t = AttendanceTable();

  static const db = AttendanceRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue userId;

  _i2.User? user;

  String? inTime;

  String? outTime;

  String? inTimeStatus;

  String? outTimeStatus;

  String? overTime;

  String? earlyTime;

  DateTime date;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Attendance]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Attendance copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? userId,
    _i2.User? user,
    String? inTime,
    String? outTime,
    String? inTimeStatus,
    String? outTimeStatus,
    String? overTime,
    String? earlyTime,
    DateTime? date,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Attendance',
      if (id != null) 'id': id?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      if (inTime != null) 'inTime': inTime,
      if (outTime != null) 'outTime': outTime,
      if (inTimeStatus != null) 'inTimeStatus': inTimeStatus,
      if (outTimeStatus != null) 'outTimeStatus': outTimeStatus,
      if (overTime != null) 'overTime': overTime,
      if (earlyTime != null) 'earlyTime': earlyTime,
      'date': date.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Attendance',
      if (id != null) 'id': id?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      if (inTime != null) 'inTime': inTime,
      if (outTime != null) 'outTime': outTime,
      if (inTimeStatus != null) 'inTimeStatus': inTimeStatus,
      if (outTimeStatus != null) 'outTimeStatus': outTimeStatus,
      if (overTime != null) 'overTime': overTime,
      if (earlyTime != null) 'earlyTime': earlyTime,
      'date': date.toJson(),
    };
  }

  static AttendanceInclude include({_i2.UserInclude? user}) {
    return AttendanceInclude._(user: user);
  }

  static AttendanceIncludeList includeList({
    _i1.WhereExpressionBuilder<AttendanceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AttendanceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AttendanceTable>? orderByList,
    AttendanceInclude? include,
  }) {
    return AttendanceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Attendance.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Attendance.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AttendanceImpl extends Attendance {
  _AttendanceImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    String? inTime,
    String? outTime,
    String? inTimeStatus,
    String? outTimeStatus,
    String? overTime,
    String? earlyTime,
    required DateTime date,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         inTime: inTime,
         outTime: outTime,
         inTimeStatus: inTimeStatus,
         outTimeStatus: outTimeStatus,
         overTime: overTime,
         earlyTime: earlyTime,
         date: date,
       );

  /// Returns a shallow copy of this [Attendance]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Attendance copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    Object? inTime = _Undefined,
    Object? outTime = _Undefined,
    Object? inTimeStatus = _Undefined,
    Object? outTimeStatus = _Undefined,
    Object? overTime = _Undefined,
    Object? earlyTime = _Undefined,
    DateTime? date,
  }) {
    return Attendance(
      id: id is _i1.UuidValue? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      inTime: inTime is String? ? inTime : this.inTime,
      outTime: outTime is String? ? outTime : this.outTime,
      inTimeStatus: inTimeStatus is String? ? inTimeStatus : this.inTimeStatus,
      outTimeStatus: outTimeStatus is String?
          ? outTimeStatus
          : this.outTimeStatus,
      overTime: overTime is String? ? overTime : this.overTime,
      earlyTime: earlyTime is String? ? earlyTime : this.earlyTime,
      date: date ?? this.date,
    );
  }
}

class AttendanceUpdateTable extends _i1.UpdateTable<AttendanceTable> {
  AttendanceUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> inTime(String? value) => _i1.ColumnValue(
    table.inTime,
    value,
  );

  _i1.ColumnValue<String, String> outTime(String? value) => _i1.ColumnValue(
    table.outTime,
    value,
  );

  _i1.ColumnValue<String, String> inTimeStatus(String? value) =>
      _i1.ColumnValue(
        table.inTimeStatus,
        value,
      );

  _i1.ColumnValue<String, String> outTimeStatus(String? value) =>
      _i1.ColumnValue(
        table.outTimeStatus,
        value,
      );

  _i1.ColumnValue<String, String> overTime(String? value) => _i1.ColumnValue(
    table.overTime,
    value,
  );

  _i1.ColumnValue<String, String> earlyTime(String? value) => _i1.ColumnValue(
    table.earlyTime,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> date(DateTime value) => _i1.ColumnValue(
    table.date,
    value,
  );
}

class AttendanceTable extends _i1.Table<_i1.UuidValue?> {
  AttendanceTable({super.tableRelation}) : super(tableName: 'attendance') {
    updateTable = AttendanceUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    inTime = _i1.ColumnString(
      'inTime',
      this,
    );
    outTime = _i1.ColumnString(
      'outTime',
      this,
    );
    inTimeStatus = _i1.ColumnString(
      'inTimeStatus',
      this,
    );
    outTimeStatus = _i1.ColumnString(
      'outTimeStatus',
      this,
    );
    overTime = _i1.ColumnString(
      'overTime',
      this,
    );
    earlyTime = _i1.ColumnString(
      'earlyTime',
      this,
    );
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
  }

  late final AttendanceUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  _i2.UserTable? _user;

  late final _i1.ColumnString inTime;

  late final _i1.ColumnString outTime;

  late final _i1.ColumnString inTimeStatus;

  late final _i1.ColumnString outTimeStatus;

  late final _i1.ColumnString overTime;

  late final _i1.ColumnString earlyTime;

  late final _i1.ColumnDateTime date;

  _i2.UserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: Attendance.t.userId,
      foreignField: _i2.User.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.UserTable(tableRelation: foreignTableRelation),
    );
    return _user!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    inTime,
    outTime,
    inTimeStatus,
    outTimeStatus,
    overTime,
    earlyTime,
    date,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class AttendanceInclude extends _i1.IncludeObject {
  AttendanceInclude._({_i2.UserInclude? user}) {
    _user = user;
  }

  _i2.UserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {'user': _user};

  @override
  _i1.Table<_i1.UuidValue?> get table => Attendance.t;
}

class AttendanceIncludeList extends _i1.IncludeList {
  AttendanceIncludeList._({
    _i1.WhereExpressionBuilder<AttendanceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Attendance.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Attendance.t;
}

class AttendanceRepository {
  const AttendanceRepository._();

  final attachRow = const AttendanceAttachRowRepository._();

  /// Returns a list of [Attendance]s matching the given query parameters.
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
  Future<List<Attendance>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AttendanceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AttendanceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AttendanceTable>? orderByList,
    _i1.Transaction? transaction,
    AttendanceInclude? include,
  }) async {
    return session.db.find<Attendance>(
      where: where?.call(Attendance.t),
      orderBy: orderBy?.call(Attendance.t),
      orderByList: orderByList?.call(Attendance.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Attendance] matching the given query parameters.
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
  Future<Attendance?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AttendanceTable>? where,
    int? offset,
    _i1.OrderByBuilder<AttendanceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AttendanceTable>? orderByList,
    _i1.Transaction? transaction,
    AttendanceInclude? include,
  }) async {
    return session.db.findFirstRow<Attendance>(
      where: where?.call(Attendance.t),
      orderBy: orderBy?.call(Attendance.t),
      orderByList: orderByList?.call(Attendance.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Attendance] by its [id] or null if no such row exists.
  Future<Attendance?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    AttendanceInclude? include,
  }) async {
    return session.db.findById<Attendance>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Attendance]s in the list and returns the inserted rows.
  ///
  /// The returned [Attendance]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Attendance>> insert(
    _i1.Session session,
    List<Attendance> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Attendance>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Attendance] and returns the inserted row.
  ///
  /// The returned [Attendance] will have its `id` field set.
  Future<Attendance> insertRow(
    _i1.Session session,
    Attendance row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Attendance>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Attendance]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Attendance>> update(
    _i1.Session session,
    List<Attendance> rows, {
    _i1.ColumnSelections<AttendanceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Attendance>(
      rows,
      columns: columns?.call(Attendance.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Attendance]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Attendance> updateRow(
    _i1.Session session,
    Attendance row, {
    _i1.ColumnSelections<AttendanceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Attendance>(
      row,
      columns: columns?.call(Attendance.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Attendance] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Attendance?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<AttendanceUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Attendance>(
      id,
      columnValues: columnValues(Attendance.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Attendance]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Attendance>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<AttendanceUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AttendanceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AttendanceTable>? orderBy,
    _i1.OrderByListBuilder<AttendanceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Attendance>(
      columnValues: columnValues(Attendance.t.updateTable),
      where: where(Attendance.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Attendance.t),
      orderByList: orderByList?.call(Attendance.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Attendance]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Attendance>> delete(
    _i1.Session session,
    List<Attendance> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Attendance>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Attendance].
  Future<Attendance> deleteRow(
    _i1.Session session,
    Attendance row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Attendance>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Attendance>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<AttendanceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Attendance>(
      where: where(Attendance.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<AttendanceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Attendance>(
      where: where?.call(Attendance.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class AttendanceAttachRowRepository {
  const AttendanceAttachRowRepository._();

  /// Creates a relation between the given [Attendance] and [User]
  /// by setting the [Attendance]'s foreign key `userId` to refer to the [User].
  Future<void> user(
    _i1.Session session,
    Attendance attendance,
    _i2.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (attendance.id == null) {
      throw ArgumentError.notNull('attendance.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $attendance = attendance.copyWith(userId: user.id);
    await session.db.updateRow<Attendance>(
      $attendance,
      columns: [Attendance.t.userId],
      transaction: transaction,
    );
  }
}
