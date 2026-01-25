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
import '../entities/chat_message.dart' as _i2;
import '../entities/user.dart' as _i3;
import 'package:crewboard_server/src/generated/protocol.dart' as _i4;

abstract class ChatRoom
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  ChatRoom._({
    this.id,
    this.roomName,
    required this.roomType,
    this.lastMessageId,
    this.lastMessage,
    required this.messageCount,
    this.roomUsers,
  });

  factory ChatRoom({
    _i1.UuidValue? id,
    String? roomName,
    required String roomType,
    _i1.UuidValue? lastMessageId,
    _i2.ChatMessage? lastMessage,
    required int messageCount,
    List<_i3.User>? roomUsers,
  }) = _ChatRoomImpl;

  factory ChatRoom.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatRoom(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      roomName: jsonSerialization['roomName'] as String?,
      roomType: jsonSerialization['roomType'] as String,
      lastMessageId: jsonSerialization['lastMessageId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['lastMessageId'],
            ),
      lastMessage: jsonSerialization['lastMessage'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.ChatMessage>(
              jsonSerialization['lastMessage'],
            ),
      messageCount: jsonSerialization['messageCount'] as int,
      roomUsers: jsonSerialization['roomUsers'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.User>>(
              jsonSerialization['roomUsers'],
            ),
    );
  }

  static final t = ChatRoomTable();

  static const db = ChatRoomRepository._();

  @override
  _i1.UuidValue? id;

  String? roomName;

  String roomType;

  _i1.UuidValue? lastMessageId;

  _i2.ChatMessage? lastMessage;

  int messageCount;

  List<_i3.User>? roomUsers;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [ChatRoom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatRoom copyWith({
    _i1.UuidValue? id,
    String? roomName,
    String? roomType,
    _i1.UuidValue? lastMessageId,
    _i2.ChatMessage? lastMessage,
    int? messageCount,
    List<_i3.User>? roomUsers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatRoom',
      if (id != null) 'id': id?.toJson(),
      if (roomName != null) 'roomName': roomName,
      'roomType': roomType,
      if (lastMessageId != null) 'lastMessageId': lastMessageId?.toJson(),
      if (lastMessage != null) 'lastMessage': lastMessage?.toJson(),
      'messageCount': messageCount,
      if (roomUsers != null)
        'roomUsers': roomUsers?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatRoom',
      if (id != null) 'id': id?.toJson(),
      if (roomName != null) 'roomName': roomName,
      'roomType': roomType,
      if (lastMessageId != null) 'lastMessageId': lastMessageId?.toJson(),
      if (lastMessage != null) 'lastMessage': lastMessage?.toJsonForProtocol(),
      'messageCount': messageCount,
      if (roomUsers != null)
        'roomUsers': roomUsers?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  static ChatRoomInclude include({_i2.ChatMessageInclude? lastMessage}) {
    return ChatRoomInclude._(lastMessage: lastMessage);
  }

  static ChatRoomIncludeList includeList({
    _i1.WhereExpressionBuilder<ChatRoomTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChatRoomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatRoomTable>? orderByList,
    ChatRoomInclude? include,
  }) {
    return ChatRoomIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChatRoom.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChatRoom.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatRoomImpl extends ChatRoom {
  _ChatRoomImpl({
    _i1.UuidValue? id,
    String? roomName,
    required String roomType,
    _i1.UuidValue? lastMessageId,
    _i2.ChatMessage? lastMessage,
    required int messageCount,
    List<_i3.User>? roomUsers,
  }) : super._(
         id: id,
         roomName: roomName,
         roomType: roomType,
         lastMessageId: lastMessageId,
         lastMessage: lastMessage,
         messageCount: messageCount,
         roomUsers: roomUsers,
       );

  /// Returns a shallow copy of this [ChatRoom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatRoom copyWith({
    Object? id = _Undefined,
    Object? roomName = _Undefined,
    String? roomType,
    Object? lastMessageId = _Undefined,
    Object? lastMessage = _Undefined,
    int? messageCount,
    Object? roomUsers = _Undefined,
  }) {
    return ChatRoom(
      id: id is _i1.UuidValue? ? id : this.id,
      roomName: roomName is String? ? roomName : this.roomName,
      roomType: roomType ?? this.roomType,
      lastMessageId: lastMessageId is _i1.UuidValue?
          ? lastMessageId
          : this.lastMessageId,
      lastMessage: lastMessage is _i2.ChatMessage?
          ? lastMessage
          : this.lastMessage?.copyWith(),
      messageCount: messageCount ?? this.messageCount,
      roomUsers: roomUsers is List<_i3.User>?
          ? roomUsers
          : this.roomUsers?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class ChatRoomUpdateTable extends _i1.UpdateTable<ChatRoomTable> {
  ChatRoomUpdateTable(super.table);

  _i1.ColumnValue<String, String> roomName(String? value) => _i1.ColumnValue(
    table.roomName,
    value,
  );

  _i1.ColumnValue<String, String> roomType(String value) => _i1.ColumnValue(
    table.roomType,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> lastMessageId(
    _i1.UuidValue? value,
  ) => _i1.ColumnValue(
    table.lastMessageId,
    value,
  );

  _i1.ColumnValue<int, int> messageCount(int value) => _i1.ColumnValue(
    table.messageCount,
    value,
  );
}

class ChatRoomTable extends _i1.Table<_i1.UuidValue?> {
  ChatRoomTable({super.tableRelation}) : super(tableName: 'chat_room') {
    updateTable = ChatRoomUpdateTable(this);
    roomName = _i1.ColumnString(
      'roomName',
      this,
    );
    roomType = _i1.ColumnString(
      'roomType',
      this,
    );
    lastMessageId = _i1.ColumnUuid(
      'lastMessageId',
      this,
    );
    messageCount = _i1.ColumnInt(
      'messageCount',
      this,
    );
  }

  late final ChatRoomUpdateTable updateTable;

  late final _i1.ColumnString roomName;

  late final _i1.ColumnString roomType;

  late final _i1.ColumnUuid lastMessageId;

  _i2.ChatMessageTable? _lastMessage;

  late final _i1.ColumnInt messageCount;

  _i2.ChatMessageTable get lastMessage {
    if (_lastMessage != null) return _lastMessage!;
    _lastMessage = _i1.createRelationTable(
      relationFieldName: 'lastMessage',
      field: ChatRoom.t.lastMessageId,
      foreignField: _i2.ChatMessage.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ChatMessageTable(tableRelation: foreignTableRelation),
    );
    return _lastMessage!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    roomName,
    roomType,
    lastMessageId,
    messageCount,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'lastMessage') {
      return lastMessage;
    }
    return null;
  }
}

class ChatRoomInclude extends _i1.IncludeObject {
  ChatRoomInclude._({_i2.ChatMessageInclude? lastMessage}) {
    _lastMessage = lastMessage;
  }

  _i2.ChatMessageInclude? _lastMessage;

  @override
  Map<String, _i1.Include?> get includes => {'lastMessage': _lastMessage};

  @override
  _i1.Table<_i1.UuidValue?> get table => ChatRoom.t;
}

class ChatRoomIncludeList extends _i1.IncludeList {
  ChatRoomIncludeList._({
    _i1.WhereExpressionBuilder<ChatRoomTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChatRoom.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ChatRoom.t;
}

class ChatRoomRepository {
  const ChatRoomRepository._();

  final attachRow = const ChatRoomAttachRowRepository._();

  final detachRow = const ChatRoomDetachRowRepository._();

  /// Returns a list of [ChatRoom]s matching the given query parameters.
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
  Future<List<ChatRoom>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatRoomTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChatRoomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatRoomTable>? orderByList,
    _i1.Transaction? transaction,
    ChatRoomInclude? include,
  }) async {
    return session.db.find<ChatRoom>(
      where: where?.call(ChatRoom.t),
      orderBy: orderBy?.call(ChatRoom.t),
      orderByList: orderByList?.call(ChatRoom.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [ChatRoom] matching the given query parameters.
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
  Future<ChatRoom?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatRoomTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChatRoomTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatRoomTable>? orderByList,
    _i1.Transaction? transaction,
    ChatRoomInclude? include,
  }) async {
    return session.db.findFirstRow<ChatRoom>(
      where: where?.call(ChatRoom.t),
      orderBy: orderBy?.call(ChatRoom.t),
      orderByList: orderByList?.call(ChatRoom.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ChatRoom] by its [id] or null if no such row exists.
  Future<ChatRoom?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    ChatRoomInclude? include,
  }) async {
    return session.db.findById<ChatRoom>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ChatRoom]s in the list and returns the inserted rows.
  ///
  /// The returned [ChatRoom]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ChatRoom>> insert(
    _i1.Session session,
    List<ChatRoom> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ChatRoom>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ChatRoom] and returns the inserted row.
  ///
  /// The returned [ChatRoom] will have its `id` field set.
  Future<ChatRoom> insertRow(
    _i1.Session session,
    ChatRoom row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChatRoom>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ChatRoom]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ChatRoom>> update(
    _i1.Session session,
    List<ChatRoom> rows, {
    _i1.ColumnSelections<ChatRoomTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ChatRoom>(
      rows,
      columns: columns?.call(ChatRoom.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChatRoom]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChatRoom> updateRow(
    _i1.Session session,
    ChatRoom row, {
    _i1.ColumnSelections<ChatRoomTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChatRoom>(
      row,
      columns: columns?.call(ChatRoom.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChatRoom] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChatRoom?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<ChatRoomUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ChatRoom>(
      id,
      columnValues: columnValues(ChatRoom.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChatRoom]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ChatRoom>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ChatRoomUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ChatRoomTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChatRoomTable>? orderBy,
    _i1.OrderByListBuilder<ChatRoomTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ChatRoom>(
      columnValues: columnValues(ChatRoom.t.updateTable),
      where: where(ChatRoom.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChatRoom.t),
      orderByList: orderByList?.call(ChatRoom.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ChatRoom]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ChatRoom>> delete(
    _i1.Session session,
    List<ChatRoom> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChatRoom>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ChatRoom].
  Future<ChatRoom> deleteRow(
    _i1.Session session,
    ChatRoom row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChatRoom>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ChatRoom>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ChatRoomTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ChatRoom>(
      where: where(ChatRoom.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChatRoomTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChatRoom>(
      where: where?.call(ChatRoom.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ChatRoomAttachRowRepository {
  const ChatRoomAttachRowRepository._();

  /// Creates a relation between the given [ChatRoom] and [ChatMessage]
  /// by setting the [ChatRoom]'s foreign key `lastMessageId` to refer to the [ChatMessage].
  Future<void> lastMessage(
    _i1.Session session,
    ChatRoom chatRoom,
    _i2.ChatMessage lastMessage, {
    _i1.Transaction? transaction,
  }) async {
    if (chatRoom.id == null) {
      throw ArgumentError.notNull('chatRoom.id');
    }
    if (lastMessage.id == null) {
      throw ArgumentError.notNull('lastMessage.id');
    }

    var $chatRoom = chatRoom.copyWith(lastMessageId: lastMessage.id);
    await session.db.updateRow<ChatRoom>(
      $chatRoom,
      columns: [ChatRoom.t.lastMessageId],
      transaction: transaction,
    );
  }
}

class ChatRoomDetachRowRepository {
  const ChatRoomDetachRowRepository._();

  /// Detaches the relation between this [ChatRoom] and the [ChatMessage] set in `lastMessage`
  /// by setting the [ChatRoom]'s foreign key `lastMessageId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> lastMessage(
    _i1.Session session,
    ChatRoom chatRoom, {
    _i1.Transaction? transaction,
  }) async {
    if (chatRoom.id == null) {
      throw ArgumentError.notNull('chatRoom.id');
    }

    var $chatRoom = chatRoom.copyWith(lastMessageId: null);
    await session.db.updateRow<ChatRoom>(
      $chatRoom,
      columns: [ChatRoom.t.lastMessageId],
      transaction: transaction,
    );
  }
}
