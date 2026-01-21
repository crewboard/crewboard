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
import 'package:crewboard_server/src/generated/protocol.dart' as _i2;

abstract class Emoji implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Emoji._({
    this.id,
    required this.emoji,
    required this.hexcode,
    required this.group,
    required this.subgroup,
    required this.annotation,
    required this.tags,
    required this.shortcodes,
    required this.emoticons,
  });

  factory Emoji({
    int? id,
    required String emoji,
    required String hexcode,
    required String group,
    required String subgroup,
    required String annotation,
    required List<String> tags,
    required List<String> shortcodes,
    required List<String> emoticons,
  }) = _EmojiImpl;

  factory Emoji.fromJson(Map<String, dynamic> jsonSerialization) {
    return Emoji(
      id: jsonSerialization['id'] as int?,
      emoji: jsonSerialization['emoji'] as String,
      hexcode: jsonSerialization['hexcode'] as String,
      group: jsonSerialization['group'] as String,
      subgroup: jsonSerialization['subgroup'] as String,
      annotation: jsonSerialization['annotation'] as String,
      tags: _i2.Protocol().deserialize<List<String>>(jsonSerialization['tags']),
      shortcodes: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['shortcodes'],
      ),
      emoticons: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['emoticons'],
      ),
    );
  }

  static final t = EmojiTable();

  static const db = EmojiRepository._();

  @override
  int? id;

  String emoji;

  String hexcode;

  String group;

  String subgroup;

  String annotation;

  List<String> tags;

  List<String> shortcodes;

  List<String> emoticons;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Emoji]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Emoji copyWith({
    int? id,
    String? emoji,
    String? hexcode,
    String? group,
    String? subgroup,
    String? annotation,
    List<String>? tags,
    List<String>? shortcodes,
    List<String>? emoticons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Emoji',
      if (id != null) 'id': id,
      'emoji': emoji,
      'hexcode': hexcode,
      'group': group,
      'subgroup': subgroup,
      'annotation': annotation,
      'tags': tags.toJson(),
      'shortcodes': shortcodes.toJson(),
      'emoticons': emoticons.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Emoji',
      if (id != null) 'id': id,
      'emoji': emoji,
      'hexcode': hexcode,
      'group': group,
      'subgroup': subgroup,
      'annotation': annotation,
      'tags': tags.toJson(),
      'shortcodes': shortcodes.toJson(),
      'emoticons': emoticons.toJson(),
    };
  }

  static EmojiInclude include() {
    return EmojiInclude._();
  }

  static EmojiIncludeList includeList({
    _i1.WhereExpressionBuilder<EmojiTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EmojiTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EmojiTable>? orderByList,
    EmojiInclude? include,
  }) {
    return EmojiIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Emoji.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Emoji.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EmojiImpl extends Emoji {
  _EmojiImpl({
    int? id,
    required String emoji,
    required String hexcode,
    required String group,
    required String subgroup,
    required String annotation,
    required List<String> tags,
    required List<String> shortcodes,
    required List<String> emoticons,
  }) : super._(
         id: id,
         emoji: emoji,
         hexcode: hexcode,
         group: group,
         subgroup: subgroup,
         annotation: annotation,
         tags: tags,
         shortcodes: shortcodes,
         emoticons: emoticons,
       );

  /// Returns a shallow copy of this [Emoji]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Emoji copyWith({
    Object? id = _Undefined,
    String? emoji,
    String? hexcode,
    String? group,
    String? subgroup,
    String? annotation,
    List<String>? tags,
    List<String>? shortcodes,
    List<String>? emoticons,
  }) {
    return Emoji(
      id: id is int? ? id : this.id,
      emoji: emoji ?? this.emoji,
      hexcode: hexcode ?? this.hexcode,
      group: group ?? this.group,
      subgroup: subgroup ?? this.subgroup,
      annotation: annotation ?? this.annotation,
      tags: tags ?? this.tags.map((e0) => e0).toList(),
      shortcodes: shortcodes ?? this.shortcodes.map((e0) => e0).toList(),
      emoticons: emoticons ?? this.emoticons.map((e0) => e0).toList(),
    );
  }
}

class EmojiUpdateTable extends _i1.UpdateTable<EmojiTable> {
  EmojiUpdateTable(super.table);

  _i1.ColumnValue<String, String> emoji(String value) => _i1.ColumnValue(
    table.emoji,
    value,
  );

  _i1.ColumnValue<String, String> hexcode(String value) => _i1.ColumnValue(
    table.hexcode,
    value,
  );

  _i1.ColumnValue<String, String> group(String value) => _i1.ColumnValue(
    table.group,
    value,
  );

  _i1.ColumnValue<String, String> subgroup(String value) => _i1.ColumnValue(
    table.subgroup,
    value,
  );

  _i1.ColumnValue<String, String> annotation(String value) => _i1.ColumnValue(
    table.annotation,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> tags(List<String> value) =>
      _i1.ColumnValue(
        table.tags,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> shortcodes(List<String> value) =>
      _i1.ColumnValue(
        table.shortcodes,
        value,
      );

  _i1.ColumnValue<List<String>, List<String>> emoticons(List<String> value) =>
      _i1.ColumnValue(
        table.emoticons,
        value,
      );
}

class EmojiTable extends _i1.Table<int?> {
  EmojiTable({super.tableRelation}) : super(tableName: 'emoji') {
    updateTable = EmojiUpdateTable(this);
    emoji = _i1.ColumnString(
      'emoji',
      this,
    );
    hexcode = _i1.ColumnString(
      'hexcode',
      this,
    );
    group = _i1.ColumnString(
      'group',
      this,
    );
    subgroup = _i1.ColumnString(
      'subgroup',
      this,
    );
    annotation = _i1.ColumnString(
      'annotation',
      this,
    );
    tags = _i1.ColumnSerializable<List<String>>(
      'tags',
      this,
    );
    shortcodes = _i1.ColumnSerializable<List<String>>(
      'shortcodes',
      this,
    );
    emoticons = _i1.ColumnSerializable<List<String>>(
      'emoticons',
      this,
    );
  }

  late final EmojiUpdateTable updateTable;

  late final _i1.ColumnString emoji;

  late final _i1.ColumnString hexcode;

  late final _i1.ColumnString group;

  late final _i1.ColumnString subgroup;

  late final _i1.ColumnString annotation;

  late final _i1.ColumnSerializable<List<String>> tags;

  late final _i1.ColumnSerializable<List<String>> shortcodes;

  late final _i1.ColumnSerializable<List<String>> emoticons;

  @override
  List<_i1.Column> get columns => [
    id,
    emoji,
    hexcode,
    group,
    subgroup,
    annotation,
    tags,
    shortcodes,
    emoticons,
  ];
}

class EmojiInclude extends _i1.IncludeObject {
  EmojiInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Emoji.t;
}

class EmojiIncludeList extends _i1.IncludeList {
  EmojiIncludeList._({
    _i1.WhereExpressionBuilder<EmojiTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Emoji.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Emoji.t;
}

class EmojiRepository {
  const EmojiRepository._();

  /// Returns a list of [Emoji]s matching the given query parameters.
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
  Future<List<Emoji>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EmojiTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EmojiTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EmojiTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Emoji>(
      where: where?.call(Emoji.t),
      orderBy: orderBy?.call(Emoji.t),
      orderByList: orderByList?.call(Emoji.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Emoji] matching the given query parameters.
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
  Future<Emoji?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EmojiTable>? where,
    int? offset,
    _i1.OrderByBuilder<EmojiTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EmojiTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Emoji>(
      where: where?.call(Emoji.t),
      orderBy: orderBy?.call(Emoji.t),
      orderByList: orderByList?.call(Emoji.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Emoji] by its [id] or null if no such row exists.
  Future<Emoji?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Emoji>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Emoji]s in the list and returns the inserted rows.
  ///
  /// The returned [Emoji]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Emoji>> insert(
    _i1.Session session,
    List<Emoji> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Emoji>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Emoji] and returns the inserted row.
  ///
  /// The returned [Emoji] will have its `id` field set.
  Future<Emoji> insertRow(
    _i1.Session session,
    Emoji row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Emoji>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Emoji]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Emoji>> update(
    _i1.Session session,
    List<Emoji> rows, {
    _i1.ColumnSelections<EmojiTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Emoji>(
      rows,
      columns: columns?.call(Emoji.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Emoji]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Emoji> updateRow(
    _i1.Session session,
    Emoji row, {
    _i1.ColumnSelections<EmojiTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Emoji>(
      row,
      columns: columns?.call(Emoji.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Emoji] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Emoji?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<EmojiUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Emoji>(
      id,
      columnValues: columnValues(Emoji.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Emoji]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Emoji>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<EmojiUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<EmojiTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EmojiTable>? orderBy,
    _i1.OrderByListBuilder<EmojiTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Emoji>(
      columnValues: columnValues(Emoji.t.updateTable),
      where: where(Emoji.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Emoji.t),
      orderByList: orderByList?.call(Emoji.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Emoji]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Emoji>> delete(
    _i1.Session session,
    List<Emoji> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Emoji>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Emoji].
  Future<Emoji> deleteRow(
    _i1.Session session,
    Emoji row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Emoji>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Emoji>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<EmojiTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Emoji>(
      where: where(Emoji.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<EmojiTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Emoji>(
      where: where?.call(Emoji.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
