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

abstract class UserRoomMap
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  UserRoomMap._({
    this.id,
    required this.roomId,
    required this.userId,
    this.lastSeenMessageId,
  });

  factory UserRoomMap({
    _i1.UuidValue? id,
    required _i1.UuidValue roomId,
    required _i1.UuidValue userId,
    _i1.UuidValue? lastSeenMessageId,
  }) = _UserRoomMapImpl;

  factory UserRoomMap.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserRoomMap(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      roomId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['roomId']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      lastSeenMessageId: jsonSerialization['lastSeenMessageId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['lastSeenMessageId'],
            ),
    );
  }

  static final t = UserRoomMapTable();

  static const db = UserRoomMapRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue roomId;

  _i1.UuidValue userId;

  _i1.UuidValue? lastSeenMessageId;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [UserRoomMap]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserRoomMap copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? roomId,
    _i1.UuidValue? userId,
    _i1.UuidValue? lastSeenMessageId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserRoomMap',
      if (id != null) 'id': id?.toJson(),
      'roomId': roomId.toJson(),
      'userId': userId.toJson(),
      if (lastSeenMessageId != null)
        'lastSeenMessageId': lastSeenMessageId?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserRoomMap',
      if (id != null) 'id': id?.toJson(),
      'roomId': roomId.toJson(),
      'userId': userId.toJson(),
      if (lastSeenMessageId != null)
        'lastSeenMessageId': lastSeenMessageId?.toJson(),
    };
  }

  static UserRoomMapInclude include() {
    return UserRoomMapInclude._();
  }

  static UserRoomMapIncludeList includeList({
    _i1.WhereExpressionBuilder<UserRoomMapTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserRoomMapTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserRoomMapTable>? orderByList,
    UserRoomMapInclude? include,
  }) {
    return UserRoomMapIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserRoomMap.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserRoomMap.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserRoomMapImpl extends UserRoomMap {
  _UserRoomMapImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue roomId,
    required _i1.UuidValue userId,
    _i1.UuidValue? lastSeenMessageId,
  }) : super._(
         id: id,
         roomId: roomId,
         userId: userId,
         lastSeenMessageId: lastSeenMessageId,
       );

  /// Returns a shallow copy of this [UserRoomMap]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserRoomMap copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? roomId,
    _i1.UuidValue? userId,
    Object? lastSeenMessageId = _Undefined,
  }) {
    return UserRoomMap(
      id: id is _i1.UuidValue? ? id : this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      lastSeenMessageId: lastSeenMessageId is _i1.UuidValue?
          ? lastSeenMessageId
          : this.lastSeenMessageId,
    );
  }
}

class UserRoomMapUpdateTable extends _i1.UpdateTable<UserRoomMapTable> {
  UserRoomMapUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> roomId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.roomId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> lastSeenMessageId(
    _i1.UuidValue? value,
  ) => _i1.ColumnValue(
    table.lastSeenMessageId,
    value,
  );
}

class UserRoomMapTable extends _i1.Table<_i1.UuidValue?> {
  UserRoomMapTable({super.tableRelation}) : super(tableName: 'user_room_map') {
    updateTable = UserRoomMapUpdateTable(this);
    roomId = _i1.ColumnUuid(
      'roomId',
      this,
    );
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    lastSeenMessageId = _i1.ColumnUuid(
      'lastSeenMessageId',
      this,
    );
  }

  late final UserRoomMapUpdateTable updateTable;

  late final _i1.ColumnUuid roomId;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnUuid lastSeenMessageId;

  @override
  List<_i1.Column> get columns => [
    id,
    roomId,
    userId,
    lastSeenMessageId,
  ];
}

class UserRoomMapInclude extends _i1.IncludeObject {
  UserRoomMapInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => UserRoomMap.t;
}

class UserRoomMapIncludeList extends _i1.IncludeList {
  UserRoomMapIncludeList._({
    _i1.WhereExpressionBuilder<UserRoomMapTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserRoomMap.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => UserRoomMap.t;
}

class UserRoomMapRepository {
  const UserRoomMapRepository._();

  /// Returns a list of [UserRoomMap]s matching the given query parameters.
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
  Future<List<UserRoomMap>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserRoomMapTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserRoomMapTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserRoomMapTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserRoomMap>(
      where: where?.call(UserRoomMap.t),
      orderBy: orderBy?.call(UserRoomMap.t),
      orderByList: orderByList?.call(UserRoomMap.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UserRoomMap] matching the given query parameters.
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
  Future<UserRoomMap?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserRoomMapTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserRoomMapTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserRoomMapTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserRoomMap>(
      where: where?.call(UserRoomMap.t),
      orderBy: orderBy?.call(UserRoomMap.t),
      orderByList: orderByList?.call(UserRoomMap.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UserRoomMap] by its [id] or null if no such row exists.
  Future<UserRoomMap?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserRoomMap>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UserRoomMap]s in the list and returns the inserted rows.
  ///
  /// The returned [UserRoomMap]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserRoomMap>> insert(
    _i1.Session session,
    List<UserRoomMap> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserRoomMap>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserRoomMap] and returns the inserted row.
  ///
  /// The returned [UserRoomMap] will have its `id` field set.
  Future<UserRoomMap> insertRow(
    _i1.Session session,
    UserRoomMap row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserRoomMap>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserRoomMap]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserRoomMap>> update(
    _i1.Session session,
    List<UserRoomMap> rows, {
    _i1.ColumnSelections<UserRoomMapTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserRoomMap>(
      rows,
      columns: columns?.call(UserRoomMap.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserRoomMap]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserRoomMap> updateRow(
    _i1.Session session,
    UserRoomMap row, {
    _i1.ColumnSelections<UserRoomMapTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserRoomMap>(
      row,
      columns: columns?.call(UserRoomMap.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserRoomMap] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserRoomMap?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<UserRoomMapUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserRoomMap>(
      id,
      columnValues: columnValues(UserRoomMap.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserRoomMap]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserRoomMap>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<UserRoomMapUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserRoomMapTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserRoomMapTable>? orderBy,
    _i1.OrderByListBuilder<UserRoomMapTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserRoomMap>(
      columnValues: columnValues(UserRoomMap.t.updateTable),
      where: where(UserRoomMap.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserRoomMap.t),
      orderByList: orderByList?.call(UserRoomMap.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserRoomMap]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserRoomMap>> delete(
    _i1.Session session,
    List<UserRoomMap> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserRoomMap>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserRoomMap].
  Future<UserRoomMap> deleteRow(
    _i1.Session session,
    UserRoomMap row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserRoomMap>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserRoomMap>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserRoomMapTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserRoomMap>(
      where: where(UserRoomMap.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserRoomMapTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserRoomMap>(
      where: where?.call(UserRoomMap.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
