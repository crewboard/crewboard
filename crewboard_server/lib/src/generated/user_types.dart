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
import 'system_color.dart' as _i2;
import 'package:crewboard_server/src/generated/protocol.dart' as _i3;

abstract class UserTypes
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserTypes._({
    this.id,
    required this.userType,
    required this.colorId,
    this.color,
    required this.permissions,
    required this.isAdmin,
  });

  factory UserTypes({
    int? id,
    required String userType,
    required int colorId,
    _i2.SystemColor? color,
    required String permissions,
    required bool isAdmin,
  }) = _UserTypesImpl;

  factory UserTypes.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserTypes(
      id: jsonSerialization['id'] as int?,
      userType: jsonSerialization['userType'] as String,
      colorId: jsonSerialization['colorId'] as int,
      color: jsonSerialization['color'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.SystemColor>(
              jsonSerialization['color'],
            ),
      permissions: jsonSerialization['permissions'] as String,
      isAdmin: jsonSerialization['isAdmin'] as bool,
    );
  }

  static final t = UserTypesTable();

  static const db = UserTypesRepository._();

  @override
  int? id;

  String userType;

  int colorId;

  _i2.SystemColor? color;

  String permissions;

  bool isAdmin;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserTypes]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserTypes copyWith({
    int? id,
    String? userType,
    int? colorId,
    _i2.SystemColor? color,
    String? permissions,
    bool? isAdmin,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserTypes',
      if (id != null) 'id': id,
      'userType': userType,
      'colorId': colorId,
      if (color != null) 'color': color?.toJson(),
      'permissions': permissions,
      'isAdmin': isAdmin,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserTypes',
      if (id != null) 'id': id,
      'userType': userType,
      'colorId': colorId,
      if (color != null) 'color': color?.toJsonForProtocol(),
      'permissions': permissions,
      'isAdmin': isAdmin,
    };
  }

  static UserTypesInclude include({_i2.SystemColorInclude? color}) {
    return UserTypesInclude._(color: color);
  }

  static UserTypesIncludeList includeList({
    _i1.WhereExpressionBuilder<UserTypesTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTypesTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTypesTable>? orderByList,
    UserTypesInclude? include,
  }) {
    return UserTypesIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserTypes.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserTypes.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserTypesImpl extends UserTypes {
  _UserTypesImpl({
    int? id,
    required String userType,
    required int colorId,
    _i2.SystemColor? color,
    required String permissions,
    required bool isAdmin,
  }) : super._(
         id: id,
         userType: userType,
         colorId: colorId,
         color: color,
         permissions: permissions,
         isAdmin: isAdmin,
       );

  /// Returns a shallow copy of this [UserTypes]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserTypes copyWith({
    Object? id = _Undefined,
    String? userType,
    int? colorId,
    Object? color = _Undefined,
    String? permissions,
    bool? isAdmin,
  }) {
    return UserTypes(
      id: id is int? ? id : this.id,
      userType: userType ?? this.userType,
      colorId: colorId ?? this.colorId,
      color: color is _i2.SystemColor? ? color : this.color?.copyWith(),
      permissions: permissions ?? this.permissions,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}

class UserTypesUpdateTable extends _i1.UpdateTable<UserTypesTable> {
  UserTypesUpdateTable(super.table);

  _i1.ColumnValue<String, String> userType(String value) => _i1.ColumnValue(
    table.userType,
    value,
  );

  _i1.ColumnValue<int, int> colorId(int value) => _i1.ColumnValue(
    table.colorId,
    value,
  );

  _i1.ColumnValue<String, String> permissions(String value) => _i1.ColumnValue(
    table.permissions,
    value,
  );

  _i1.ColumnValue<bool, bool> isAdmin(bool value) => _i1.ColumnValue(
    table.isAdmin,
    value,
  );
}

class UserTypesTable extends _i1.Table<int?> {
  UserTypesTable({super.tableRelation}) : super(tableName: 'user_types') {
    updateTable = UserTypesUpdateTable(this);
    userType = _i1.ColumnString(
      'userType',
      this,
    );
    colorId = _i1.ColumnInt(
      'colorId',
      this,
    );
    permissions = _i1.ColumnString(
      'permissions',
      this,
    );
    isAdmin = _i1.ColumnBool(
      'isAdmin',
      this,
    );
  }

  late final UserTypesUpdateTable updateTable;

  late final _i1.ColumnString userType;

  late final _i1.ColumnInt colorId;

  _i2.SystemColorTable? _color;

  late final _i1.ColumnString permissions;

  late final _i1.ColumnBool isAdmin;

  _i2.SystemColorTable get color {
    if (_color != null) return _color!;
    _color = _i1.createRelationTable(
      relationFieldName: 'color',
      field: UserTypes.t.colorId,
      foreignField: _i2.SystemColor.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SystemColorTable(tableRelation: foreignTableRelation),
    );
    return _color!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userType,
    colorId,
    permissions,
    isAdmin,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'color') {
      return color;
    }
    return null;
  }
}

class UserTypesInclude extends _i1.IncludeObject {
  UserTypesInclude._({_i2.SystemColorInclude? color}) {
    _color = color;
  }

  _i2.SystemColorInclude? _color;

  @override
  Map<String, _i1.Include?> get includes => {'color': _color};

  @override
  _i1.Table<int?> get table => UserTypes.t;
}

class UserTypesIncludeList extends _i1.IncludeList {
  UserTypesIncludeList._({
    _i1.WhereExpressionBuilder<UserTypesTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserTypes.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserTypes.t;
}

class UserTypesRepository {
  const UserTypesRepository._();

  final attachRow = const UserTypesAttachRowRepository._();

  /// Returns a list of [UserTypes]s matching the given query parameters.
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
  Future<List<UserTypes>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTypesTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTypesTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTypesTable>? orderByList,
    _i1.Transaction? transaction,
    UserTypesInclude? include,
  }) async {
    return session.db.find<UserTypes>(
      where: where?.call(UserTypes.t),
      orderBy: orderBy?.call(UserTypes.t),
      orderByList: orderByList?.call(UserTypes.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [UserTypes] matching the given query parameters.
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
  Future<UserTypes?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTypesTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserTypesTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTypesTable>? orderByList,
    _i1.Transaction? transaction,
    UserTypesInclude? include,
  }) async {
    return session.db.findFirstRow<UserTypes>(
      where: where?.call(UserTypes.t),
      orderBy: orderBy?.call(UserTypes.t),
      orderByList: orderByList?.call(UserTypes.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [UserTypes] by its [id] or null if no such row exists.
  Future<UserTypes?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    UserTypesInclude? include,
  }) async {
    return session.db.findById<UserTypes>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [UserTypes]s in the list and returns the inserted rows.
  ///
  /// The returned [UserTypes]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserTypes>> insert(
    _i1.Session session,
    List<UserTypes> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserTypes>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserTypes] and returns the inserted row.
  ///
  /// The returned [UserTypes] will have its `id` field set.
  Future<UserTypes> insertRow(
    _i1.Session session,
    UserTypes row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserTypes>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserTypes]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserTypes>> update(
    _i1.Session session,
    List<UserTypes> rows, {
    _i1.ColumnSelections<UserTypesTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserTypes>(
      rows,
      columns: columns?.call(UserTypes.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserTypes]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserTypes> updateRow(
    _i1.Session session,
    UserTypes row, {
    _i1.ColumnSelections<UserTypesTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserTypes>(
      row,
      columns: columns?.call(UserTypes.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserTypes] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserTypes?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<UserTypesUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserTypes>(
      id,
      columnValues: columnValues(UserTypes.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserTypes]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserTypes>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<UserTypesUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserTypesTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTypesTable>? orderBy,
    _i1.OrderByListBuilder<UserTypesTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserTypes>(
      columnValues: columnValues(UserTypes.t.updateTable),
      where: where(UserTypes.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserTypes.t),
      orderByList: orderByList?.call(UserTypes.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserTypes]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserTypes>> delete(
    _i1.Session session,
    List<UserTypes> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserTypes>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserTypes].
  Future<UserTypes> deleteRow(
    _i1.Session session,
    UserTypes row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserTypes>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserTypes>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserTypesTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserTypes>(
      where: where(UserTypes.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTypesTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserTypes>(
      where: where?.call(UserTypes.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class UserTypesAttachRowRepository {
  const UserTypesAttachRowRepository._();

  /// Creates a relation between the given [UserTypes] and [SystemColor]
  /// by setting the [UserTypes]'s foreign key `colorId` to refer to the [SystemColor].
  Future<void> color(
    _i1.Session session,
    UserTypes userTypes,
    _i2.SystemColor color, {
    _i1.Transaction? transaction,
  }) async {
    if (userTypes.id == null) {
      throw ArgumentError.notNull('userTypes.id');
    }
    if (color.id == null) {
      throw ArgumentError.notNull('color.id');
    }

    var $userTypes = userTypes.copyWith(colorId: color.id);
    await session.db.updateRow<UserTypes>(
      $userTypes,
      columns: [UserTypes.t.colorId],
      transaction: transaction,
    );
  }
}
