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

abstract class Bucket
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Bucket._({
    this.id,
    required this.userId,
    this.user,
    required this.appId,
    required this.bucketName,
    bool? isDefault,
  }) : isDefault = isDefault ?? false;

  factory Bucket({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    required _i1.UuidValue appId,
    required String bucketName,
    bool? isDefault,
  }) = _BucketImpl;

  factory Bucket.fromJson(Map<String, dynamic> jsonSerialization) {
    return Bucket(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      user: jsonSerialization['user'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.User>(jsonSerialization['user']),
      appId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['appId']),
      bucketName: jsonSerialization['bucketName'] as String,
      isDefault: jsonSerialization['isDefault'] as bool,
    );
  }

  static final t = BucketTable();

  static const db = BucketRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue userId;

  _i2.User? user;

  _i1.UuidValue appId;

  String bucketName;

  bool isDefault;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Bucket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Bucket copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? userId,
    _i2.User? user,
    _i1.UuidValue? appId,
    String? bucketName,
    bool? isDefault,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Bucket',
      if (id != null) 'id': id?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJson(),
      'appId': appId.toJson(),
      'bucketName': bucketName,
      'isDefault': isDefault,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Bucket',
      if (id != null) 'id': id?.toJson(),
      'userId': userId.toJson(),
      if (user != null) 'user': user?.toJsonForProtocol(),
      'appId': appId.toJson(),
      'bucketName': bucketName,
      'isDefault': isDefault,
    };
  }

  static BucketInclude include({_i2.UserInclude? user}) {
    return BucketInclude._(user: user);
  }

  static BucketIncludeList includeList({
    _i1.WhereExpressionBuilder<BucketTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BucketTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BucketTable>? orderByList,
    BucketInclude? include,
  }) {
    return BucketIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Bucket.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Bucket.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BucketImpl extends Bucket {
  _BucketImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue userId,
    _i2.User? user,
    required _i1.UuidValue appId,
    required String bucketName,
    bool? isDefault,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         appId: appId,
         bucketName: bucketName,
         isDefault: isDefault,
       );

  /// Returns a shallow copy of this [Bucket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Bucket copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? user = _Undefined,
    _i1.UuidValue? appId,
    String? bucketName,
    bool? isDefault,
  }) {
    return Bucket(
      id: id is _i1.UuidValue? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      appId: appId ?? this.appId,
      bucketName: bucketName ?? this.bucketName,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

class BucketUpdateTable extends _i1.UpdateTable<BucketTable> {
  BucketUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> appId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.appId,
        value,
      );

  _i1.ColumnValue<String, String> bucketName(String value) => _i1.ColumnValue(
    table.bucketName,
    value,
  );

  _i1.ColumnValue<bool, bool> isDefault(bool value) => _i1.ColumnValue(
    table.isDefault,
    value,
  );
}

class BucketTable extends _i1.Table<_i1.UuidValue?> {
  BucketTable({super.tableRelation}) : super(tableName: 'buckets') {
    updateTable = BucketUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    appId = _i1.ColumnUuid(
      'appId',
      this,
    );
    bucketName = _i1.ColumnString(
      'bucketName',
      this,
    );
    isDefault = _i1.ColumnBool(
      'isDefault',
      this,
      hasDefault: true,
    );
  }

  late final BucketUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  _i2.UserTable? _user;

  late final _i1.ColumnUuid appId;

  late final _i1.ColumnString bucketName;

  late final _i1.ColumnBool isDefault;

  _i2.UserTable get user {
    if (_user != null) return _user!;
    _user = _i1.createRelationTable(
      relationFieldName: 'user',
      field: Bucket.t.userId,
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
    appId,
    bucketName,
    isDefault,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'user') {
      return user;
    }
    return null;
  }
}

class BucketInclude extends _i1.IncludeObject {
  BucketInclude._({_i2.UserInclude? user}) {
    _user = user;
  }

  _i2.UserInclude? _user;

  @override
  Map<String, _i1.Include?> get includes => {'user': _user};

  @override
  _i1.Table<_i1.UuidValue?> get table => Bucket.t;
}

class BucketIncludeList extends _i1.IncludeList {
  BucketIncludeList._({
    _i1.WhereExpressionBuilder<BucketTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Bucket.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Bucket.t;
}

class BucketRepository {
  const BucketRepository._();

  final attachRow = const BucketAttachRowRepository._();

  /// Returns a list of [Bucket]s matching the given query parameters.
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
  Future<List<Bucket>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BucketTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BucketTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BucketTable>? orderByList,
    _i1.Transaction? transaction,
    BucketInclude? include,
  }) async {
    return session.db.find<Bucket>(
      where: where?.call(Bucket.t),
      orderBy: orderBy?.call(Bucket.t),
      orderByList: orderByList?.call(Bucket.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Bucket] matching the given query parameters.
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
  Future<Bucket?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BucketTable>? where,
    int? offset,
    _i1.OrderByBuilder<BucketTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BucketTable>? orderByList,
    _i1.Transaction? transaction,
    BucketInclude? include,
  }) async {
    return session.db.findFirstRow<Bucket>(
      where: where?.call(Bucket.t),
      orderBy: orderBy?.call(Bucket.t),
      orderByList: orderByList?.call(Bucket.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Bucket] by its [id] or null if no such row exists.
  Future<Bucket?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    BucketInclude? include,
  }) async {
    return session.db.findById<Bucket>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Bucket]s in the list and returns the inserted rows.
  ///
  /// The returned [Bucket]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Bucket>> insert(
    _i1.Session session,
    List<Bucket> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Bucket>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Bucket] and returns the inserted row.
  ///
  /// The returned [Bucket] will have its `id` field set.
  Future<Bucket> insertRow(
    _i1.Session session,
    Bucket row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Bucket>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Bucket]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Bucket>> update(
    _i1.Session session,
    List<Bucket> rows, {
    _i1.ColumnSelections<BucketTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Bucket>(
      rows,
      columns: columns?.call(Bucket.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Bucket]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Bucket> updateRow(
    _i1.Session session,
    Bucket row, {
    _i1.ColumnSelections<BucketTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Bucket>(
      row,
      columns: columns?.call(Bucket.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Bucket] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Bucket?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<BucketUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Bucket>(
      id,
      columnValues: columnValues(Bucket.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Bucket]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Bucket>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<BucketUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<BucketTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BucketTable>? orderBy,
    _i1.OrderByListBuilder<BucketTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Bucket>(
      columnValues: columnValues(Bucket.t.updateTable),
      where: where(Bucket.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Bucket.t),
      orderByList: orderByList?.call(Bucket.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Bucket]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Bucket>> delete(
    _i1.Session session,
    List<Bucket> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Bucket>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Bucket].
  Future<Bucket> deleteRow(
    _i1.Session session,
    Bucket row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Bucket>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Bucket>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BucketTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Bucket>(
      where: where(Bucket.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BucketTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Bucket>(
      where: where?.call(Bucket.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class BucketAttachRowRepository {
  const BucketAttachRowRepository._();

  /// Creates a relation between the given [Bucket] and [User]
  /// by setting the [Bucket]'s foreign key `userId` to refer to the [User].
  Future<void> user(
    _i1.Session session,
    Bucket bucket,
    _i2.User user, {
    _i1.Transaction? transaction,
  }) async {
    if (bucket.id == null) {
      throw ArgumentError.notNull('bucket.id');
    }
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }

    var $bucket = bucket.copyWith(userId: user.id);
    await session.db.updateRow<Bucket>(
      $bucket,
      columns: [Bucket.t.userId],
      transaction: transaction,
    );
  }
}
