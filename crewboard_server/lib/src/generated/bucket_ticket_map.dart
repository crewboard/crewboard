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
import 'bucket.dart' as _i2;
import 'ticket.dart' as _i3;
import 'package:crewboard_server/src/generated/protocol.dart' as _i4;

abstract class BucketTicketMap
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  BucketTicketMap._({
    this.id,
    required this.bucketId,
    this.bucket,
    required this.ticketId,
    this.ticket,
    required this.order,
  });

  factory BucketTicketMap({
    _i1.UuidValue? id,
    required _i1.UuidValue bucketId,
    _i2.Bucket? bucket,
    required _i1.UuidValue ticketId,
    _i3.Ticket? ticket,
    required int order,
  }) = _BucketTicketMapImpl;

  factory BucketTicketMap.fromJson(Map<String, dynamic> jsonSerialization) {
    return BucketTicketMap(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      bucketId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['bucketId'],
      ),
      bucket: jsonSerialization['bucket'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Bucket>(jsonSerialization['bucket']),
      ticketId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['ticketId'],
      ),
      ticket: jsonSerialization['ticket'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Ticket>(jsonSerialization['ticket']),
      order: jsonSerialization['order'] as int,
    );
  }

  static final t = BucketTicketMapTable();

  static const db = BucketTicketMapRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue bucketId;

  _i2.Bucket? bucket;

  _i1.UuidValue ticketId;

  _i3.Ticket? ticket;

  int order;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [BucketTicketMap]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BucketTicketMap copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? bucketId,
    _i2.Bucket? bucket,
    _i1.UuidValue? ticketId,
    _i3.Ticket? ticket,
    int? order,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BucketTicketMap',
      if (id != null) 'id': id?.toJson(),
      'bucketId': bucketId.toJson(),
      if (bucket != null) 'bucket': bucket?.toJson(),
      'ticketId': ticketId.toJson(),
      if (ticket != null) 'ticket': ticket?.toJson(),
      'order': order,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BucketTicketMap',
      if (id != null) 'id': id?.toJson(),
      'bucketId': bucketId.toJson(),
      if (bucket != null) 'bucket': bucket?.toJsonForProtocol(),
      'ticketId': ticketId.toJson(),
      if (ticket != null) 'ticket': ticket?.toJsonForProtocol(),
      'order': order,
    };
  }

  static BucketTicketMapInclude include({
    _i2.BucketInclude? bucket,
    _i3.TicketInclude? ticket,
  }) {
    return BucketTicketMapInclude._(
      bucket: bucket,
      ticket: ticket,
    );
  }

  static BucketTicketMapIncludeList includeList({
    _i1.WhereExpressionBuilder<BucketTicketMapTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BucketTicketMapTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BucketTicketMapTable>? orderByList,
    BucketTicketMapInclude? include,
  }) {
    return BucketTicketMapIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BucketTicketMap.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BucketTicketMap.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BucketTicketMapImpl extends BucketTicketMap {
  _BucketTicketMapImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue bucketId,
    _i2.Bucket? bucket,
    required _i1.UuidValue ticketId,
    _i3.Ticket? ticket,
    required int order,
  }) : super._(
         id: id,
         bucketId: bucketId,
         bucket: bucket,
         ticketId: ticketId,
         ticket: ticket,
         order: order,
       );

  /// Returns a shallow copy of this [BucketTicketMap]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BucketTicketMap copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? bucketId,
    Object? bucket = _Undefined,
    _i1.UuidValue? ticketId,
    Object? ticket = _Undefined,
    int? order,
  }) {
    return BucketTicketMap(
      id: id is _i1.UuidValue? ? id : this.id,
      bucketId: bucketId ?? this.bucketId,
      bucket: bucket is _i2.Bucket? ? bucket : this.bucket?.copyWith(),
      ticketId: ticketId ?? this.ticketId,
      ticket: ticket is _i3.Ticket? ? ticket : this.ticket?.copyWith(),
      order: order ?? this.order,
    );
  }
}

class BucketTicketMapUpdateTable extends _i1.UpdateTable<BucketTicketMapTable> {
  BucketTicketMapUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> bucketId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.bucketId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> ticketId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.ticketId,
        value,
      );

  _i1.ColumnValue<int, int> order(int value) => _i1.ColumnValue(
    table.order,
    value,
  );
}

class BucketTicketMapTable extends _i1.Table<_i1.UuidValue?> {
  BucketTicketMapTable({super.tableRelation})
    : super(tableName: 'bucket_ticket_map') {
    updateTable = BucketTicketMapUpdateTable(this);
    bucketId = _i1.ColumnUuid(
      'bucketId',
      this,
    );
    ticketId = _i1.ColumnUuid(
      'ticketId',
      this,
    );
    order = _i1.ColumnInt(
      'order',
      this,
    );
  }

  late final BucketTicketMapUpdateTable updateTable;

  late final _i1.ColumnUuid bucketId;

  _i2.BucketTable? _bucket;

  late final _i1.ColumnUuid ticketId;

  _i3.TicketTable? _ticket;

  late final _i1.ColumnInt order;

  _i2.BucketTable get bucket {
    if (_bucket != null) return _bucket!;
    _bucket = _i1.createRelationTable(
      relationFieldName: 'bucket',
      field: BucketTicketMap.t.bucketId,
      foreignField: _i2.Bucket.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.BucketTable(tableRelation: foreignTableRelation),
    );
    return _bucket!;
  }

  _i3.TicketTable get ticket {
    if (_ticket != null) return _ticket!;
    _ticket = _i1.createRelationTable(
      relationFieldName: 'ticket',
      field: BucketTicketMap.t.ticketId,
      foreignField: _i3.Ticket.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.TicketTable(tableRelation: foreignTableRelation),
    );
    return _ticket!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    bucketId,
    ticketId,
    order,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'bucket') {
      return bucket;
    }
    if (relationField == 'ticket') {
      return ticket;
    }
    return null;
  }
}

class BucketTicketMapInclude extends _i1.IncludeObject {
  BucketTicketMapInclude._({
    _i2.BucketInclude? bucket,
    _i3.TicketInclude? ticket,
  }) {
    _bucket = bucket;
    _ticket = ticket;
  }

  _i2.BucketInclude? _bucket;

  _i3.TicketInclude? _ticket;

  @override
  Map<String, _i1.Include?> get includes => {
    'bucket': _bucket,
    'ticket': _ticket,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => BucketTicketMap.t;
}

class BucketTicketMapIncludeList extends _i1.IncludeList {
  BucketTicketMapIncludeList._({
    _i1.WhereExpressionBuilder<BucketTicketMapTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BucketTicketMap.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => BucketTicketMap.t;
}

class BucketTicketMapRepository {
  const BucketTicketMapRepository._();

  final attachRow = const BucketTicketMapAttachRowRepository._();

  /// Returns a list of [BucketTicketMap]s matching the given query parameters.
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
  Future<List<BucketTicketMap>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BucketTicketMapTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BucketTicketMapTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BucketTicketMapTable>? orderByList,
    _i1.Transaction? transaction,
    BucketTicketMapInclude? include,
  }) async {
    return session.db.find<BucketTicketMap>(
      where: where?.call(BucketTicketMap.t),
      orderBy: orderBy?.call(BucketTicketMap.t),
      orderByList: orderByList?.call(BucketTicketMap.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [BucketTicketMap] matching the given query parameters.
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
  Future<BucketTicketMap?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BucketTicketMapTable>? where,
    int? offset,
    _i1.OrderByBuilder<BucketTicketMapTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BucketTicketMapTable>? orderByList,
    _i1.Transaction? transaction,
    BucketTicketMapInclude? include,
  }) async {
    return session.db.findFirstRow<BucketTicketMap>(
      where: where?.call(BucketTicketMap.t),
      orderBy: orderBy?.call(BucketTicketMap.t),
      orderByList: orderByList?.call(BucketTicketMap.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [BucketTicketMap] by its [id] or null if no such row exists.
  Future<BucketTicketMap?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    BucketTicketMapInclude? include,
  }) async {
    return session.db.findById<BucketTicketMap>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [BucketTicketMap]s in the list and returns the inserted rows.
  ///
  /// The returned [BucketTicketMap]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<BucketTicketMap>> insert(
    _i1.Session session,
    List<BucketTicketMap> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<BucketTicketMap>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [BucketTicketMap] and returns the inserted row.
  ///
  /// The returned [BucketTicketMap] will have its `id` field set.
  Future<BucketTicketMap> insertRow(
    _i1.Session session,
    BucketTicketMap row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BucketTicketMap>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BucketTicketMap]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BucketTicketMap>> update(
    _i1.Session session,
    List<BucketTicketMap> rows, {
    _i1.ColumnSelections<BucketTicketMapTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BucketTicketMap>(
      rows,
      columns: columns?.call(BucketTicketMap.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BucketTicketMap]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BucketTicketMap> updateRow(
    _i1.Session session,
    BucketTicketMap row, {
    _i1.ColumnSelections<BucketTicketMapTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BucketTicketMap>(
      row,
      columns: columns?.call(BucketTicketMap.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BucketTicketMap] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BucketTicketMap?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<BucketTicketMapUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BucketTicketMap>(
      id,
      columnValues: columnValues(BucketTicketMap.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BucketTicketMap]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BucketTicketMap>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<BucketTicketMapUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<BucketTicketMapTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BucketTicketMapTable>? orderBy,
    _i1.OrderByListBuilder<BucketTicketMapTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BucketTicketMap>(
      columnValues: columnValues(BucketTicketMap.t.updateTable),
      where: where(BucketTicketMap.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BucketTicketMap.t),
      orderByList: orderByList?.call(BucketTicketMap.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BucketTicketMap]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BucketTicketMap>> delete(
    _i1.Session session,
    List<BucketTicketMap> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BucketTicketMap>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BucketTicketMap].
  Future<BucketTicketMap> deleteRow(
    _i1.Session session,
    BucketTicketMap row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BucketTicketMap>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BucketTicketMap>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BucketTicketMapTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BucketTicketMap>(
      where: where(BucketTicketMap.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BucketTicketMapTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BucketTicketMap>(
      where: where?.call(BucketTicketMap.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class BucketTicketMapAttachRowRepository {
  const BucketTicketMapAttachRowRepository._();

  /// Creates a relation between the given [BucketTicketMap] and [Bucket]
  /// by setting the [BucketTicketMap]'s foreign key `bucketId` to refer to the [Bucket].
  Future<void> bucket(
    _i1.Session session,
    BucketTicketMap bucketTicketMap,
    _i2.Bucket bucket, {
    _i1.Transaction? transaction,
  }) async {
    if (bucketTicketMap.id == null) {
      throw ArgumentError.notNull('bucketTicketMap.id');
    }
    if (bucket.id == null) {
      throw ArgumentError.notNull('bucket.id');
    }

    var $bucketTicketMap = bucketTicketMap.copyWith(bucketId: bucket.id);
    await session.db.updateRow<BucketTicketMap>(
      $bucketTicketMap,
      columns: [BucketTicketMap.t.bucketId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [BucketTicketMap] and [Ticket]
  /// by setting the [BucketTicketMap]'s foreign key `ticketId` to refer to the [Ticket].
  Future<void> ticket(
    _i1.Session session,
    BucketTicketMap bucketTicketMap,
    _i3.Ticket ticket, {
    _i1.Transaction? transaction,
  }) async {
    if (bucketTicketMap.id == null) {
      throw ArgumentError.notNull('bucketTicketMap.id');
    }
    if (ticket.id == null) {
      throw ArgumentError.notNull('ticket.id');
    }

    var $bucketTicketMap = bucketTicketMap.copyWith(ticketId: ticket.id);
    await session.db.updateRow<BucketTicketMap>(
      $bucketTicketMap,
      columns: [BucketTicketMap.t.ticketId],
      transaction: transaction,
    );
  }
}
