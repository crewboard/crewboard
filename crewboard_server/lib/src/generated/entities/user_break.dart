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

abstract class UserBreak
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  UserBreak._({
    this.id,
    required this.userId,
    this.user,
    this.breakStart,
    this.breakEnd,
    this.breakTime,
    required this.date,
  });

  factory UserBreak({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    String? breakStart,
    String? breakEnd,
    int? breakTime,
    required DateTime date,
  }) = _UserBreakImpl;

  factory UserBreak.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserBreak(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.User>(jsonSerialization['user']),
      breakStart: jsonSerialization['breakStart'] as String?,
      breakEnd: jsonSerialization['breakEnd'] as String?,
      breakTime: jsonSerialization['breakTime'] as int?,
      date: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['date']),
    );
  }

  static final t = UserBreakTable();

  static const db = UserBreakRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue userId;

  _i2.User? user;

  String? breakStart;

  String? breakEnd;

  int? breakTime;

  DateTime date;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [UserBreak]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserBreak copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? userId,
    _i2.User? user,
    String? breakStart,
    String? breakEnd,
    int? breakTime,
    DateTime? date,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserBreak',
      if (id != null) 'id': id?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      if (breakStart != null) 'breakStart': breakStart,
      if (breakEnd != null) 'breakEnd': breakEnd,
      if (breakTime != null) 'breakTime': breakTime,
      'date': date.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserBreak',
      if (id != null) 'id': id?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      if (breakStart != null) 'breakStart': breakStart,
      if (breakEnd != null) 'breakEnd': breakEnd,
      if (breakTime != null) 'breakTime': breakTime,
      'date': date.toJson(),
    };
  }

  static UserBreakInclude include({_i2.UserInclude? user}) {
    return UserBreakInclude._(user: user);
  }

  static UserBreakIncludeList includeList({
    _i1.WhereExpressionBuilder<UserBreakTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserBreakTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserBreakTable>? orderByList,
    UserBreakInclude? include,
  }) {
    return UserBreakIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserBreak.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserBreak.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserBreakImpl extends UserBreak {
  _UserBreakImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    String? breakStart,
    String? breakEnd,
    int? breakTime,
    required DateTime date,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         breakStart: breakStart,
         breakEnd: breakEnd,
         breakTime: breakTime,
         date: date,
       );

  /// Returns a shallow copy of this [UserBreak]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserBreak copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    Object? breakStart = _Undefined,
    Object? breakEnd = _Undefined,
    Object? breakTime = _Undefined,
    DateTime? date,
  }) {
    return UserBreak(
      id: id is _i1.UuidValue? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      breakStart: breakStart is String? ? breakStart : this.breakStart,
      breakEnd: breakEnd is String? ? breakEnd : this.breakEnd,
      breakTime: breakTime is int? ? breakTime : this.breakTime,
      date: date ?? this.date,
    );
  }
}

class UserBreakUpdateTable extends _i1.UpdateTable<UserBreakTable> {
  UserBreakUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> breakStart(String? value) => _i1.ColumnValue(
    table.breakStart,
    value,
  );

  _i1.ColumnValue<String, String> breakEnd(String? value) => _i1.ColumnValue(
    table.breakEnd,
    value,
  );

  _i1.ColumnValue<int, int> breakTime(int? value) => _i1.ColumnValue(
    table.breakTime,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> date(DateTime value) => _i1.ColumnValue(
    table.date,
    value,
  );
}

class UserBreakTable extends _i1.Table<_i1.UuidValue?> {
  UserBreakTable({super.tableRelation}) : super(tableName: 'breaks') {
    updateTable = UserBreakUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    breakStart = _i1.ColumnString(
      'breakStart',
      this,
    );
    breakEnd = _i1.ColumnString(
      'breakEnd',
      this,
    );
    breakTime = _i1.ColumnInt(
      'breakTime',
      this,
    );
    date = _i1.ColumnDateTime(
      'date',
      this,
    );
  }

  late final UserBreakUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  _i2.UserTable? _user;

  late final _i1.ColumnString breakStart;

  late final _i1.ColumnString breakEnd;

  late final _i1.ColumnInt breakTime;

  late final _i1.ColumnDateTime date;

  _i2.UserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: UserBreak.t.userId,
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
    breakStart,
    breakEnd,
    breakTime,
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

class UserBreakInclude extends _i1.IncludeObject {
  UserBreakInclude._({_i2.UserInclude? user}) {
    _user = user;
  }

  _i2.UserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {'user': _user};

  @override
  _i1.Table<_i1.UuidValue?> get table => UserBreak.t;
}

class UserBreakIncludeList extends _i1.IncludeList {
  UserBreakIncludeList._({
    _i1.WhereExpressionBuilder<UserBreakTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserBreak.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => UserBreak.t;
}

class UserBreakRepository {
  const UserBreakRepository._();

  final attachRow = const UserBreakAttachRowRepository._();

  /// Returns a list of [UserBreak]s matching the given query parameters.
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
  Future<List<UserBreak>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserBreakTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserBreakTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserBreakTable>? orderByList,
    _i1.Transaction? transaction,
    UserBreakInclude? include,
  }) async {
    return session.db.find<UserBreak>(
      where: where?.call(UserBreak.t),
      orderBy: orderBy?.call(UserBreak.t),
      orderByList: orderByList?.call(UserBreak.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [UserBreak] matching the given query parameters.
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
  Future<UserBreak?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserBreakTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserBreakTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserBreakTable>? orderByList,
    _i1.Transaction? transaction,
    UserBreakInclude? include,
  }) async {
    return session.db.findFirstRow<UserBreak>(
      where: where?.call(UserBreak.t),
      orderBy: orderBy?.call(UserBreak.t),
      orderByList: orderByList?.call(UserBreak.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [UserBreak] by its [id] or null if no such row exists.
  Future<UserBreak?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    UserBreakInclude? include,
  }) async {
    return session.db.findById<UserBreak>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [UserBreak]s in the list and returns the inserted rows.
  ///
  /// The returned [UserBreak]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserBreak>> insert(
    _i1.Session session,
    List<UserBreak> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserBreak>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserBreak] and returns the inserted row.
  ///
  /// The returned [UserBreak] will have its `id` field set.
  Future<UserBreak> insertRow(
    _i1.Session session,
    UserBreak row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserBreak>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserBreak]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserBreak>> update(
    _i1.Session session,
    List<UserBreak> rows, {
    _i1.ColumnSelections<UserBreakTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserBreak>(
      rows,
      columns: columns?.call(UserBreak.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserBreak]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserBreak> updateRow(
    _i1.Session session,
    UserBreak row, {
    _i1.ColumnSelections<UserBreakTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserBreak>(
      row,
      columns: columns?.call(UserBreak.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserBreak] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserBreak?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<UserBreakUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserBreak>(
      id,
      columnValues: columnValues(UserBreak.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserBreak]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserBreak>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<UserBreakUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserBreakTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserBreakTable>? orderBy,
    _i1.OrderByListBuilder<UserBreakTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserBreak>(
      columnValues: columnValues(UserBreak.t.updateTable),
      where: where(UserBreak.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserBreak.t),
      orderByList: orderByList?.call(UserBreak.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserBreak]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserBreak>> delete(
    _i1.Session session,
    List<UserBreak> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserBreak>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserBreak].
  Future<UserBreak> deleteRow(
    _i1.Session session,
    UserBreak row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserBreak>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserBreak>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserBreakTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserBreak>(
      where: where(UserBreak.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserBreakTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserBreak>(
      where: where?.call(UserBreak.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class UserBreakAttachRowRepository {
  const UserBreakAttachRowRepository._();

  /// Creates a relation between the given [UserBreak] and [User]
  /// by setting the [UserBreak]'s foreign key `userId` to refer to the [User].
  Future<void> user(
    _i1.Session session,
    UserBreak userBreak,
    _i2.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (userBreak.id == null) {
      throw ArgumentError.notNull('userBreak.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $userBreak = userBreak.copyWith(userId: user.id);
    await session.db.updateRow<UserBreak>(
      $userBreak,
      columns: [UserBreak.t.userId],
      transaction: transaction,
    );
  }
}
