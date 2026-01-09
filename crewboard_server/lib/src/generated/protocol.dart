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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i4;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i5;
import 'entities/attendance.dart' as _i6;
import 'entities/bucket.dart' as _i7;
import 'entities/bucket_ticket_map.dart' as _i8;
import 'entities/chat_message.dart' as _i9;
import 'entities/chat_room.dart' as _i10;
import 'entities/doc.dart' as _i11;
import 'entities/flow_model.dart' as _i12;
import 'entities/leave_config.dart' as _i13;
import 'entities/leave_request.dart' as _i14;
import 'entities/memory.dart' as _i15;
import 'entities/organization.dart' as _i16;
import 'entities/planner_app.dart' as _i17;
import 'entities/planner_notification.dart' as _i18;
import 'entities/priority.dart' as _i19;
import 'entities/status.dart' as _i20;
import 'entities/system_color.dart' as _i21;
import 'entities/system_variables.dart' as _i22;
import 'entities/ticket.dart' as _i23;
import 'entities/ticket_assignee.dart' as _i24;
import 'entities/ticket_attachment.dart' as _i25;
import 'entities/ticket_comment.dart' as _i26;
import 'entities/ticket_status_change.dart' as _i27;
import 'entities/ticket_type.dart' as _i28;
import 'entities/user.dart' as _i29;
import 'entities/user_break.dart' as _i30;
import 'entities/user_device.dart' as _i31;
import 'entities/user_room_map.dart' as _i32;
import 'entities/user_types.dart' as _i33;
import 'enums/device_type.dart' as _i34;
import 'enums/message_type.dart' as _i35;
import 'greetings/greeting.dart' as _i36;
import 'protocols/add_bucket_request.dart' as _i37;
import 'protocols/add_comment_request.dart' as _i38;
import 'protocols/add_ticket_dto.dart' as _i39;
import 'protocols/add_ticket_request.dart' as _i40;
import 'protocols/attachment_model.dart' as _i41;
import 'protocols/bucket_model.dart' as _i42;
import 'protocols/change_bucket_request.dart' as _i43;
import 'protocols/check_model.dart' as _i44;
import 'protocols/check_organization_response.dart' as _i45;
import 'protocols/check_username_response.dart' as _i46;
import 'protocols/comment_model.dart' as _i47;
import 'protocols/get_add_ticket_data_response.dart' as _i48;
import 'protocols/get_all_tickets_response.dart' as _i49;
import 'protocols/get_attendance_data_response.dart' as _i50;
import 'protocols/get_planner_data_response.dart' as _i51;
import 'protocols/get_ticket_comments_response.dart' as _i52;
import 'protocols/get_ticket_data_response.dart' as _i53;
import 'protocols/get_ticket_thread_response.dart' as _i54;
import 'protocols/planner_assignee.dart' as _i55;
import 'protocols/planner_bucket.dart' as _i56;
import 'protocols/planner_ticket.dart' as _i57;
import 'protocols/priority_model.dart' as _i58;
import 'protocols/register_admin_response.dart' as _i59;
import 'protocols/sign_in_response.dart' as _i60;
import 'protocols/status_model.dart' as _i61;
import 'protocols/thread_item_model.dart' as _i62;
import 'protocols/ticket_attachment_dto.dart' as _i63;
import 'protocols/ticket_model.dart' as _i64;
import 'protocols/type_model.dart' as _i65;
import 'protocols/user_model.dart' as _i66;
import 'package:crewboard_server/src/generated/entities/planner_app.dart'
    as _i67;
import 'package:crewboard_server/src/generated/entities/user.dart' as _i68;
import 'package:crewboard_server/src/generated/entities/user_types.dart'
    as _i69;
import 'package:crewboard_server/src/generated/entities/attendance.dart'
    as _i70;
import 'package:crewboard_server/src/generated/entities/leave_config.dart'
    as _i71;
import 'package:crewboard_server/src/generated/entities/system_color.dart'
    as _i72;
import 'package:crewboard_server/src/generated/entities/chat_room.dart' as _i73;
import 'package:crewboard_server/src/generated/entities/chat_message.dart'
    as _i74;
import 'package:crewboard_server/src/generated/entities/flow_model.dart'
    as _i75;
import 'package:crewboard_server/src/generated/entities/doc.dart' as _i76;
export 'entities/attendance.dart';
export 'entities/bucket.dart';
export 'entities/bucket_ticket_map.dart';
export 'entities/chat_message.dart';
export 'entities/chat_room.dart';
export 'entities/doc.dart';
export 'entities/flow_model.dart';
export 'entities/leave_config.dart';
export 'entities/leave_request.dart';
export 'entities/memory.dart';
export 'entities/organization.dart';
export 'entities/planner_app.dart';
export 'entities/planner_notification.dart';
export 'entities/priority.dart';
export 'entities/status.dart';
export 'entities/system_color.dart';
export 'entities/system_variables.dart';
export 'entities/ticket.dart';
export 'entities/ticket_assignee.dart';
export 'entities/ticket_attachment.dart';
export 'entities/ticket_comment.dart';
export 'entities/ticket_status_change.dart';
export 'entities/ticket_type.dart';
export 'entities/user.dart';
export 'entities/user_break.dart';
export 'entities/user_device.dart';
export 'entities/user_room_map.dart';
export 'entities/user_types.dart';
export 'enums/device_type.dart';
export 'enums/message_type.dart';
export 'greetings/greeting.dart';
export 'protocols/add_bucket_request.dart';
export 'protocols/add_comment_request.dart';
export 'protocols/add_ticket_dto.dart';
export 'protocols/add_ticket_request.dart';
export 'protocols/attachment_model.dart';
export 'protocols/bucket_model.dart';
export 'protocols/change_bucket_request.dart';
export 'protocols/check_model.dart';
export 'protocols/check_organization_response.dart';
export 'protocols/check_username_response.dart';
export 'protocols/comment_model.dart';
export 'protocols/get_add_ticket_data_response.dart';
export 'protocols/get_all_tickets_response.dart';
export 'protocols/get_attendance_data_response.dart';
export 'protocols/get_planner_data_response.dart';
export 'protocols/get_ticket_comments_response.dart';
export 'protocols/get_ticket_data_response.dart';
export 'protocols/get_ticket_thread_response.dart';
export 'protocols/planner_assignee.dart';
export 'protocols/planner_bucket.dart';
export 'protocols/planner_ticket.dart';
export 'protocols/priority_model.dart';
export 'protocols/register_admin_response.dart';
export 'protocols/sign_in_response.dart';
export 'protocols/status_model.dart';
export 'protocols/thread_item_model.dart';
export 'protocols/ticket_attachment_dto.dart';
export 'protocols/ticket_model.dart';
export 'protocols/type_model.dart';
export 'protocols/user_model.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'attendance',
      dartName: 'Attendance',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'inTime',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'outTime',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'inTimeStatus',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'outTimeStatus',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'overTime',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'earlyTime',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'attendance_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'attendance_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'breaks',
      dartName: 'UserBreak',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'breakStart',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'breakEnd',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'breakTime',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'breaks_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'breaks_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'bucket_ticket_map',
      dartName: 'BucketTicketMap',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'bucketId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'ticketId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'order',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'bucket_ticket_map_fk_0',
          columns: ['bucketId'],
          referenceTable: 'buckets',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'bucket_ticket_map_fk_1',
          columns: ['ticketId'],
          referenceTable: 'tickets',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'bucket_ticket_map_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'buckets',
      dartName: 'Bucket',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'appId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'bucketName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isDefault',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'buckets_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'buckets_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'chat_message',
      dartName: 'ChatMessage',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'roomId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'parentMessageId',
          columnType: _i2.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'message',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'messageType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MessageType',
        ),
        _i2.ColumnDefinition(
          name: 'seenUserList',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<UuidValue>',
        ),
        _i2.ColumnDefinition(
          name: 'sameUser',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'deleted',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'chat_message_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'chat_room',
      dartName: 'ChatRoom',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'roomName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'roomType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'lastMessageId',
          columnType: _i2.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _i2.ColumnDefinition(
          name: 'messageCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'chat_room_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'doc',
      dartName: 'Doc',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'appId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'doc',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'outline',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'lastUpdated',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'doc_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'flow',
      dartName: 'FlowModel',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'appId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'flow',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'lastUpdated',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'flow_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'leave_config',
      dartName: 'LeaveConfig',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'configName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'fullDay',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'halfDay',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'config',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'leave_config_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'leave_request',
      dartName: 'LeaveRequest',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'request',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'accepted',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'date',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'leave_request_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'leave_request_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'organization',
      dartName: 'Organization',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'organization_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'planner_apps',
      dartName: 'PlannerApp',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'appName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'colorId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'planner_apps_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'planner_notifications',
      dartName: 'PlannerNotification',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'notification',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'notificationType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'ticketId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'seenUserList',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<UuidValue>',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'planner_notifications_fk_0',
          columns: ['ticketId'],
          referenceTable: 'tickets',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'planner_notifications_fk_1',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'planner_notifications_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'priority',
      dartName: 'Priority',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'priorityName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'priority',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'priority_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'status',
      dartName: 'Status',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'statusName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'status_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'system_color',
      dartName: 'SystemColor',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'colorName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'color',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isDefault',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'system_color_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'system_variables',
      dartName: 'SystemVariables',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'system_variables_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'punchingMode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'lineHeight',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'processWidth',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'conditionWidth',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'terminalWidth',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'allowEdit',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'showEdit',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'allowDelete',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'showDelete',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'system_variables_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'ticket_assignee',
      dartName: 'TicketAssignee',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'ticket_assignee_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'ticketId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'ticket_assignee_fk_0',
          columns: ['ticketId'],
          referenceTable: 'tickets',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'ticket_assignee_fk_1',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'ticket_assignee_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'ticket_attachments',
      dartName: 'TicketAttachment',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'ticketId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'attachmentName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'attachmentSize',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'attachmentUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'attachmentType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'ticket_attachments_fk_0',
          columns: ['ticketId'],
          referenceTable: 'tickets',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'ticket_attachments_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'ticket_comments',
      dartName: 'TicketComment',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'ticketId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'message',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'ticket_comments_fk_0',
          columns: ['ticketId'],
          referenceTable: 'tickets',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'ticket_comments_fk_1',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'ticket_comments_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'ticket_status_change',
      dartName: 'TicketStatusChange',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'ticketId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'oldStatusId',
          columnType: _i2.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _i2.ColumnDefinition(
          name: 'newStatusId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'changedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'ticket_status_change_fk_0',
          columns: ['ticketId'],
          referenceTable: 'tickets',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'ticket_status_change_fk_1',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'ticket_status_change_fk_2',
          columns: ['oldStatusId'],
          referenceTable: 'status',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'ticket_status_change_fk_3',
          columns: ['newStatusId'],
          referenceTable: 'status',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'ticket_status_change_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'ticket_type',
      dartName: 'TicketType',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'typeName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'colorId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'ticket_type_fk_0',
          columns: ['colorId'],
          referenceTable: 'system_color',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'ticket_type_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'tickets',
      dartName: 'Ticket',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'appId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'ticketName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'ticketBody',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'statusId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'priorityId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'typeId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'checklist',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:CheckModel>?',
        ),
        _i2.ColumnDefinition(
          name: 'flows',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'creds',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'deadline',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'tickets_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'tickets_fk_1',
          columns: ['statusId'],
          referenceTable: 'status',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'tickets_fk_2',
          columns: ['priorityId'],
          referenceTable: 'priority',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'tickets_fk_3',
          columns: ['typeId'],
          referenceTable: 'ticket_type',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'tickets_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_devices',
      dartName: 'UserDevice',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'deviceType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DeviceType',
        ),
        _i2.ColumnDefinition(
          name: 'hardwareId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'socketId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_devices_fk_0',
          columns: ['userId'],
          referenceTable: 'users',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_devices_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_memory_map',
      dartName: 'Memory',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_memory_map_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'body',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_memory_map_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_room_map',
      dartName: 'UserRoomMap',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'roomId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'lastSeenMessageId',
          columnType: _i2.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_room_map_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_types',
      dartName: 'UserTypes',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'userType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'colorId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'permissions',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isAdmin',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_types_fk_0',
          columns: ['colorId'],
          referenceTable: 'system_color',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_types_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'users',
      dartName: 'User',
      schema: 'public',
      module: 'crewboard',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid()',
        ),
        _i2.ColumnDefinition(
          name: 'userName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'password',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'image',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'colorId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'userTypeId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'leaveConfigId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'performanceConfigId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'firstName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'lastName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'gender',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'dateOfBirth',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'phone',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'bloodGroup',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'salary',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'experience',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'punchId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'attachments',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'performance',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'plannerVariables',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'online',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'onsite',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'deleted',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'users_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'users_fk_1',
          columns: ['colorId'],
          referenceTable: 'system_color',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'users_fk_2',
          columns: ['userTypeId'],
          referenceTable: 'user_types',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'users_fk_3',
          columns: ['leaveConfigId'],
          referenceTable: 'leave_config',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'users_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i5.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i6.Attendance) {
      return _i6.Attendance.fromJson(data) as T;
    }
    if (t == _i7.Bucket) {
      return _i7.Bucket.fromJson(data) as T;
    }
    if (t == _i8.BucketTicketMap) {
      return _i8.BucketTicketMap.fromJson(data) as T;
    }
    if (t == _i9.ChatMessage) {
      return _i9.ChatMessage.fromJson(data) as T;
    }
    if (t == _i10.ChatRoom) {
      return _i10.ChatRoom.fromJson(data) as T;
    }
    if (t == _i11.Doc) {
      return _i11.Doc.fromJson(data) as T;
    }
    if (t == _i12.FlowModel) {
      return _i12.FlowModel.fromJson(data) as T;
    }
    if (t == _i13.LeaveConfig) {
      return _i13.LeaveConfig.fromJson(data) as T;
    }
    if (t == _i14.LeaveRequest) {
      return _i14.LeaveRequest.fromJson(data) as T;
    }
    if (t == _i15.Memory) {
      return _i15.Memory.fromJson(data) as T;
    }
    if (t == _i16.Organization) {
      return _i16.Organization.fromJson(data) as T;
    }
    if (t == _i17.PlannerApp) {
      return _i17.PlannerApp.fromJson(data) as T;
    }
    if (t == _i18.PlannerNotification) {
      return _i18.PlannerNotification.fromJson(data) as T;
    }
    if (t == _i19.Priority) {
      return _i19.Priority.fromJson(data) as T;
    }
    if (t == _i20.Status) {
      return _i20.Status.fromJson(data) as T;
    }
    if (t == _i21.SystemColor) {
      return _i21.SystemColor.fromJson(data) as T;
    }
    if (t == _i22.SystemVariables) {
      return _i22.SystemVariables.fromJson(data) as T;
    }
    if (t == _i23.Ticket) {
      return _i23.Ticket.fromJson(data) as T;
    }
    if (t == _i24.TicketAssignee) {
      return _i24.TicketAssignee.fromJson(data) as T;
    }
    if (t == _i25.TicketAttachment) {
      return _i25.TicketAttachment.fromJson(data) as T;
    }
    if (t == _i26.TicketComment) {
      return _i26.TicketComment.fromJson(data) as T;
    }
    if (t == _i27.TicketStatusChange) {
      return _i27.TicketStatusChange.fromJson(data) as T;
    }
    if (t == _i28.TicketType) {
      return _i28.TicketType.fromJson(data) as T;
    }
    if (t == _i29.User) {
      return _i29.User.fromJson(data) as T;
    }
    if (t == _i30.UserBreak) {
      return _i30.UserBreak.fromJson(data) as T;
    }
    if (t == _i31.UserDevice) {
      return _i31.UserDevice.fromJson(data) as T;
    }
    if (t == _i32.UserRoomMap) {
      return _i32.UserRoomMap.fromJson(data) as T;
    }
    if (t == _i33.UserTypes) {
      return _i33.UserTypes.fromJson(data) as T;
    }
    if (t == _i34.DeviceType) {
      return _i34.DeviceType.fromJson(data) as T;
    }
    if (t == _i35.MessageType) {
      return _i35.MessageType.fromJson(data) as T;
    }
    if (t == _i36.Greeting) {
      return _i36.Greeting.fromJson(data) as T;
    }
    if (t == _i37.AddBucketRequest) {
      return _i37.AddBucketRequest.fromJson(data) as T;
    }
    if (t == _i38.AddCommentRequest) {
      return _i38.AddCommentRequest.fromJson(data) as T;
    }
    if (t == _i39.AddTicketDTO) {
      return _i39.AddTicketDTO.fromJson(data) as T;
    }
    if (t == _i40.AddTicketRequest) {
      return _i40.AddTicketRequest.fromJson(data) as T;
    }
    if (t == _i41.AttachmentModel) {
      return _i41.AttachmentModel.fromJson(data) as T;
    }
    if (t == _i42.BucketModel) {
      return _i42.BucketModel.fromJson(data) as T;
    }
    if (t == _i43.ChangeBucketRequest) {
      return _i43.ChangeBucketRequest.fromJson(data) as T;
    }
    if (t == _i44.CheckModel) {
      return _i44.CheckModel.fromJson(data) as T;
    }
    if (t == _i45.CheckOrganizationResponse) {
      return _i45.CheckOrganizationResponse.fromJson(data) as T;
    }
    if (t == _i46.CheckUsernameResponse) {
      return _i46.CheckUsernameResponse.fromJson(data) as T;
    }
    if (t == _i47.CommentModel) {
      return _i47.CommentModel.fromJson(data) as T;
    }
    if (t == _i48.GetAddTicketDataResponse) {
      return _i48.GetAddTicketDataResponse.fromJson(data) as T;
    }
    if (t == _i49.GetAllTicketsResponse) {
      return _i49.GetAllTicketsResponse.fromJson(data) as T;
    }
    if (t == _i50.GetAttendanceDataResponse) {
      return _i50.GetAttendanceDataResponse.fromJson(data) as T;
    }
    if (t == _i51.GetPlannerDataResponse) {
      return _i51.GetPlannerDataResponse.fromJson(data) as T;
    }
    if (t == _i52.GetTicketCommentsResponse) {
      return _i52.GetTicketCommentsResponse.fromJson(data) as T;
    }
    if (t == _i53.GetTicketDataResponse) {
      return _i53.GetTicketDataResponse.fromJson(data) as T;
    }
    if (t == _i54.GetTicketThreadResponse) {
      return _i54.GetTicketThreadResponse.fromJson(data) as T;
    }
    if (t == _i55.PlannerAssignee) {
      return _i55.PlannerAssignee.fromJson(data) as T;
    }
    if (t == _i56.PlannerBucket) {
      return _i56.PlannerBucket.fromJson(data) as T;
    }
    if (t == _i57.PlannerTicket) {
      return _i57.PlannerTicket.fromJson(data) as T;
    }
    if (t == _i58.PriorityModel) {
      return _i58.PriorityModel.fromJson(data) as T;
    }
    if (t == _i59.RegisterAdminResponse) {
      return _i59.RegisterAdminResponse.fromJson(data) as T;
    }
    if (t == _i60.SignInResponse) {
      return _i60.SignInResponse.fromJson(data) as T;
    }
    if (t == _i61.StatusModel) {
      return _i61.StatusModel.fromJson(data) as T;
    }
    if (t == _i62.ThreadItemModel) {
      return _i62.ThreadItemModel.fromJson(data) as T;
    }
    if (t == _i63.TicketAttachmentDTO) {
      return _i63.TicketAttachmentDTO.fromJson(data) as T;
    }
    if (t == _i64.TicketModel) {
      return _i64.TicketModel.fromJson(data) as T;
    }
    if (t == _i65.TypeModel) {
      return _i65.TypeModel.fromJson(data) as T;
    }
    if (t == _i66.UserModel) {
      return _i66.UserModel.fromJson(data) as T;
    }
    if (t == _i1.getType<_i6.Attendance?>()) {
      return (data != null ? _i6.Attendance.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Bucket?>()) {
      return (data != null ? _i7.Bucket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.BucketTicketMap?>()) {
      return (data != null ? _i8.BucketTicketMap.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.ChatMessage?>()) {
      return (data != null ? _i9.ChatMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.ChatRoom?>()) {
      return (data != null ? _i10.ChatRoom.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Doc?>()) {
      return (data != null ? _i11.Doc.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.FlowModel?>()) {
      return (data != null ? _i12.FlowModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.LeaveConfig?>()) {
      return (data != null ? _i13.LeaveConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.LeaveRequest?>()) {
      return (data != null ? _i14.LeaveRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Memory?>()) {
      return (data != null ? _i15.Memory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.Organization?>()) {
      return (data != null ? _i16.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.PlannerApp?>()) {
      return (data != null ? _i17.PlannerApp.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.PlannerNotification?>()) {
      return (data != null ? _i18.PlannerNotification.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.Priority?>()) {
      return (data != null ? _i19.Priority.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.Status?>()) {
      return (data != null ? _i20.Status.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.SystemColor?>()) {
      return (data != null ? _i21.SystemColor.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.SystemVariables?>()) {
      return (data != null ? _i22.SystemVariables.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.Ticket?>()) {
      return (data != null ? _i23.Ticket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.TicketAssignee?>()) {
      return (data != null ? _i24.TicketAssignee.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.TicketAttachment?>()) {
      return (data != null ? _i25.TicketAttachment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.TicketComment?>()) {
      return (data != null ? _i26.TicketComment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.TicketStatusChange?>()) {
      return (data != null ? _i27.TicketStatusChange.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.TicketType?>()) {
      return (data != null ? _i28.TicketType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.User?>()) {
      return (data != null ? _i29.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.UserBreak?>()) {
      return (data != null ? _i30.UserBreak.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.UserDevice?>()) {
      return (data != null ? _i31.UserDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.UserRoomMap?>()) {
      return (data != null ? _i32.UserRoomMap.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.UserTypes?>()) {
      return (data != null ? _i33.UserTypes.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.DeviceType?>()) {
      return (data != null ? _i34.DeviceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.MessageType?>()) {
      return (data != null ? _i35.MessageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.Greeting?>()) {
      return (data != null ? _i36.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.AddBucketRequest?>()) {
      return (data != null ? _i37.AddBucketRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.AddCommentRequest?>()) {
      return (data != null ? _i38.AddCommentRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.AddTicketDTO?>()) {
      return (data != null ? _i39.AddTicketDTO.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.AddTicketRequest?>()) {
      return (data != null ? _i40.AddTicketRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.AttachmentModel?>()) {
      return (data != null ? _i41.AttachmentModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.BucketModel?>()) {
      return (data != null ? _i42.BucketModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.ChangeBucketRequest?>()) {
      return (data != null ? _i43.ChangeBucketRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.CheckModel?>()) {
      return (data != null ? _i44.CheckModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.CheckOrganizationResponse?>()) {
      return (data != null
              ? _i45.CheckOrganizationResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i46.CheckUsernameResponse?>()) {
      return (data != null ? _i46.CheckUsernameResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i47.CommentModel?>()) {
      return (data != null ? _i47.CommentModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.GetAddTicketDataResponse?>()) {
      return (data != null
              ? _i48.GetAddTicketDataResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i49.GetAllTicketsResponse?>()) {
      return (data != null ? _i49.GetAllTicketsResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i50.GetAttendanceDataResponse?>()) {
      return (data != null
              ? _i50.GetAttendanceDataResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i51.GetPlannerDataResponse?>()) {
      return (data != null ? _i51.GetPlannerDataResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i52.GetTicketCommentsResponse?>()) {
      return (data != null
              ? _i52.GetTicketCommentsResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i53.GetTicketDataResponse?>()) {
      return (data != null ? _i53.GetTicketDataResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.GetTicketThreadResponse?>()) {
      return (data != null ? _i54.GetTicketThreadResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.PlannerAssignee?>()) {
      return (data != null ? _i55.PlannerAssignee.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.PlannerBucket?>()) {
      return (data != null ? _i56.PlannerBucket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.PlannerTicket?>()) {
      return (data != null ? _i57.PlannerTicket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.PriorityModel?>()) {
      return (data != null ? _i58.PriorityModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.RegisterAdminResponse?>()) {
      return (data != null ? _i59.RegisterAdminResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i60.SignInResponse?>()) {
      return (data != null ? _i60.SignInResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.StatusModel?>()) {
      return (data != null ? _i61.StatusModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.ThreadItemModel?>()) {
      return (data != null ? _i62.ThreadItemModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.TicketAttachmentDTO?>()) {
      return (data != null ? _i63.TicketAttachmentDTO.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i64.TicketModel?>()) {
      return (data != null ? _i64.TicketModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.TypeModel?>()) {
      return (data != null ? _i65.TypeModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i66.UserModel?>()) {
      return (data != null ? _i66.UserModel.fromJson(data) : null) as T;
    }
    if (t == List<_i1.UuidValue>) {
      return (data as List).map((e) => deserialize<_i1.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<_i44.CheckModel>) {
      return (data as List).map((e) => deserialize<_i44.CheckModel>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i44.CheckModel>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i44.CheckModel>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i63.TicketAttachmentDTO>) {
      return (data as List)
              .map((e) => deserialize<_i63.TicketAttachmentDTO>(e))
              .toList()
          as T;
    }
    if (t == List<_i55.PlannerAssignee>) {
      return (data as List)
              .map((e) => deserialize<_i55.PlannerAssignee>(e))
              .toList()
          as T;
    }
    if (t == List<_i57.PlannerTicket>) {
      return (data as List)
              .map((e) => deserialize<_i57.PlannerTicket>(e))
              .toList()
          as T;
    }
    if (t == List<_i66.UserModel>) {
      return (data as List).map((e) => deserialize<_i66.UserModel>(e)).toList()
          as T;
    }
    if (t == List<_i61.StatusModel>) {
      return (data as List)
              .map((e) => deserialize<_i61.StatusModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i58.PriorityModel>) {
      return (data as List)
              .map((e) => deserialize<_i58.PriorityModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i65.TypeModel>) {
      return (data as List).map((e) => deserialize<_i65.TypeModel>(e)).toList()
          as T;
    }
    if (t == List<_i12.FlowModel>) {
      return (data as List).map((e) => deserialize<_i12.FlowModel>(e)).toList()
          as T;
    }
    if (t == List<_i29.User>) {
      return (data as List).map((e) => deserialize<_i29.User>(e)).toList() as T;
    }
    if (t == List<_i6.Attendance>) {
      return (data as List).map((e) => deserialize<_i6.Attendance>(e)).toList()
          as T;
    }
    if (t == List<_i13.LeaveConfig>) {
      return (data as List)
              .map((e) => deserialize<_i13.LeaveConfig>(e))
              .toList()
          as T;
    }
    if (t == List<_i14.LeaveRequest>) {
      return (data as List)
              .map((e) => deserialize<_i14.LeaveRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i42.BucketModel>) {
      return (data as List)
              .map((e) => deserialize<_i42.BucketModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i47.CommentModel>) {
      return (data as List)
              .map((e) => deserialize<_i47.CommentModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i62.ThreadItemModel>) {
      return (data as List)
              .map((e) => deserialize<_i62.ThreadItemModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i41.AttachmentModel>) {
      return (data as List)
              .map((e) => deserialize<_i41.AttachmentModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i67.PlannerApp>) {
      return (data as List).map((e) => deserialize<_i67.PlannerApp>(e)).toList()
          as T;
    }
    if (t == List<_i68.User>) {
      return (data as List).map((e) => deserialize<_i68.User>(e)).toList() as T;
    }
    if (t == List<_i69.UserTypes>) {
      return (data as List).map((e) => deserialize<_i69.UserTypes>(e)).toList()
          as T;
    }
    if (t == List<_i70.Attendance>) {
      return (data as List).map((e) => deserialize<_i70.Attendance>(e)).toList()
          as T;
    }
    if (t == List<_i71.LeaveConfig>) {
      return (data as List)
              .map((e) => deserialize<_i71.LeaveConfig>(e))
              .toList()
          as T;
    }
    if (t == List<_i72.SystemColor>) {
      return (data as List)
              .map((e) => deserialize<_i72.SystemColor>(e))
              .toList()
          as T;
    }
    if (t == List<_i73.ChatRoom>) {
      return (data as List).map((e) => deserialize<_i73.ChatRoom>(e)).toList()
          as T;
    }
    if (t == List<_i74.ChatMessage>) {
      return (data as List)
              .map((e) => deserialize<_i74.ChatMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_i75.FlowModel>) {
      return (data as List).map((e) => deserialize<_i75.FlowModel>(e)).toList()
          as T;
    }
    if (t == List<_i76.Doc>) {
      return (data as List).map((e) => deserialize<_i76.Doc>(e)).toList() as T;
    }
    if (t == List<Map<String, dynamic>>) {
      return (data as List)
              .map((e) => deserialize<Map<String, dynamic>>(e))
              .toList()
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i5.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i6.Attendance => 'Attendance',
      _i7.Bucket => 'Bucket',
      _i8.BucketTicketMap => 'BucketTicketMap',
      _i9.ChatMessage => 'ChatMessage',
      _i10.ChatRoom => 'ChatRoom',
      _i11.Doc => 'Doc',
      _i12.FlowModel => 'FlowModel',
      _i13.LeaveConfig => 'LeaveConfig',
      _i14.LeaveRequest => 'LeaveRequest',
      _i15.Memory => 'Memory',
      _i16.Organization => 'Organization',
      _i17.PlannerApp => 'PlannerApp',
      _i18.PlannerNotification => 'PlannerNotification',
      _i19.Priority => 'Priority',
      _i20.Status => 'Status',
      _i21.SystemColor => 'SystemColor',
      _i22.SystemVariables => 'SystemVariables',
      _i23.Ticket => 'Ticket',
      _i24.TicketAssignee => 'TicketAssignee',
      _i25.TicketAttachment => 'TicketAttachment',
      _i26.TicketComment => 'TicketComment',
      _i27.TicketStatusChange => 'TicketStatusChange',
      _i28.TicketType => 'TicketType',
      _i29.User => 'User',
      _i30.UserBreak => 'UserBreak',
      _i31.UserDevice => 'UserDevice',
      _i32.UserRoomMap => 'UserRoomMap',
      _i33.UserTypes => 'UserTypes',
      _i34.DeviceType => 'DeviceType',
      _i35.MessageType => 'MessageType',
      _i36.Greeting => 'Greeting',
      _i37.AddBucketRequest => 'AddBucketRequest',
      _i38.AddCommentRequest => 'AddCommentRequest',
      _i39.AddTicketDTO => 'AddTicketDTO',
      _i40.AddTicketRequest => 'AddTicketRequest',
      _i41.AttachmentModel => 'AttachmentModel',
      _i42.BucketModel => 'BucketModel',
      _i43.ChangeBucketRequest => 'ChangeBucketRequest',
      _i44.CheckModel => 'CheckModel',
      _i45.CheckOrganizationResponse => 'CheckOrganizationResponse',
      _i46.CheckUsernameResponse => 'CheckUsernameResponse',
      _i47.CommentModel => 'CommentModel',
      _i48.GetAddTicketDataResponse => 'GetAddTicketDataResponse',
      _i49.GetAllTicketsResponse => 'GetAllTicketsResponse',
      _i50.GetAttendanceDataResponse => 'GetAttendanceDataResponse',
      _i51.GetPlannerDataResponse => 'GetPlannerDataResponse',
      _i52.GetTicketCommentsResponse => 'GetTicketCommentsResponse',
      _i53.GetTicketDataResponse => 'GetTicketDataResponse',
      _i54.GetTicketThreadResponse => 'GetTicketThreadResponse',
      _i55.PlannerAssignee => 'PlannerAssignee',
      _i56.PlannerBucket => 'PlannerBucket',
      _i57.PlannerTicket => 'PlannerTicket',
      _i58.PriorityModel => 'PriorityModel',
      _i59.RegisterAdminResponse => 'RegisterAdminResponse',
      _i60.SignInResponse => 'SignInResponse',
      _i61.StatusModel => 'StatusModel',
      _i62.ThreadItemModel => 'ThreadItemModel',
      _i63.TicketAttachmentDTO => 'TicketAttachmentDTO',
      _i64.TicketModel => 'TicketModel',
      _i65.TypeModel => 'TypeModel',
      _i66.UserModel => 'UserModel',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('crewboard.', '');
    }

    switch (data) {
      case _i6.Attendance():
        return 'Attendance';
      case _i7.Bucket():
        return 'Bucket';
      case _i8.BucketTicketMap():
        return 'BucketTicketMap';
      case _i9.ChatMessage():
        return 'ChatMessage';
      case _i10.ChatRoom():
        return 'ChatRoom';
      case _i11.Doc():
        return 'Doc';
      case _i12.FlowModel():
        return 'FlowModel';
      case _i13.LeaveConfig():
        return 'LeaveConfig';
      case _i14.LeaveRequest():
        return 'LeaveRequest';
      case _i15.Memory():
        return 'Memory';
      case _i16.Organization():
        return 'Organization';
      case _i17.PlannerApp():
        return 'PlannerApp';
      case _i18.PlannerNotification():
        return 'PlannerNotification';
      case _i19.Priority():
        return 'Priority';
      case _i20.Status():
        return 'Status';
      case _i21.SystemColor():
        return 'SystemColor';
      case _i22.SystemVariables():
        return 'SystemVariables';
      case _i23.Ticket():
        return 'Ticket';
      case _i24.TicketAssignee():
        return 'TicketAssignee';
      case _i25.TicketAttachment():
        return 'TicketAttachment';
      case _i26.TicketComment():
        return 'TicketComment';
      case _i27.TicketStatusChange():
        return 'TicketStatusChange';
      case _i28.TicketType():
        return 'TicketType';
      case _i29.User():
        return 'User';
      case _i30.UserBreak():
        return 'UserBreak';
      case _i31.UserDevice():
        return 'UserDevice';
      case _i32.UserRoomMap():
        return 'UserRoomMap';
      case _i33.UserTypes():
        return 'UserTypes';
      case _i34.DeviceType():
        return 'DeviceType';
      case _i35.MessageType():
        return 'MessageType';
      case _i36.Greeting():
        return 'Greeting';
      case _i37.AddBucketRequest():
        return 'AddBucketRequest';
      case _i38.AddCommentRequest():
        return 'AddCommentRequest';
      case _i39.AddTicketDTO():
        return 'AddTicketDTO';
      case _i40.AddTicketRequest():
        return 'AddTicketRequest';
      case _i41.AttachmentModel():
        return 'AttachmentModel';
      case _i42.BucketModel():
        return 'BucketModel';
      case _i43.ChangeBucketRequest():
        return 'ChangeBucketRequest';
      case _i44.CheckModel():
        return 'CheckModel';
      case _i45.CheckOrganizationResponse():
        return 'CheckOrganizationResponse';
      case _i46.CheckUsernameResponse():
        return 'CheckUsernameResponse';
      case _i47.CommentModel():
        return 'CommentModel';
      case _i48.GetAddTicketDataResponse():
        return 'GetAddTicketDataResponse';
      case _i49.GetAllTicketsResponse():
        return 'GetAllTicketsResponse';
      case _i50.GetAttendanceDataResponse():
        return 'GetAttendanceDataResponse';
      case _i51.GetPlannerDataResponse():
        return 'GetPlannerDataResponse';
      case _i52.GetTicketCommentsResponse():
        return 'GetTicketCommentsResponse';
      case _i53.GetTicketDataResponse():
        return 'GetTicketDataResponse';
      case _i54.GetTicketThreadResponse():
        return 'GetTicketThreadResponse';
      case _i55.PlannerAssignee():
        return 'PlannerAssignee';
      case _i56.PlannerBucket():
        return 'PlannerBucket';
      case _i57.PlannerTicket():
        return 'PlannerTicket';
      case _i58.PriorityModel():
        return 'PriorityModel';
      case _i59.RegisterAdminResponse():
        return 'RegisterAdminResponse';
      case _i60.SignInResponse():
        return 'SignInResponse';
      case _i61.StatusModel():
        return 'StatusModel';
      case _i62.ThreadItemModel():
        return 'ThreadItemModel';
      case _i63.TicketAttachmentDTO():
        return 'TicketAttachmentDTO';
      case _i64.TicketModel():
        return 'TicketModel';
      case _i65.TypeModel():
        return 'TypeModel';
      case _i66.UserModel():
        return 'UserModel';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    className = _i5.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Attendance') {
      return deserialize<_i6.Attendance>(data['data']);
    }
    if (dataClassName == 'Bucket') {
      return deserialize<_i7.Bucket>(data['data']);
    }
    if (dataClassName == 'BucketTicketMap') {
      return deserialize<_i8.BucketTicketMap>(data['data']);
    }
    if (dataClassName == 'ChatMessage') {
      return deserialize<_i9.ChatMessage>(data['data']);
    }
    if (dataClassName == 'ChatRoom') {
      return deserialize<_i10.ChatRoom>(data['data']);
    }
    if (dataClassName == 'Doc') {
      return deserialize<_i11.Doc>(data['data']);
    }
    if (dataClassName == 'FlowModel') {
      return deserialize<_i12.FlowModel>(data['data']);
    }
    if (dataClassName == 'LeaveConfig') {
      return deserialize<_i13.LeaveConfig>(data['data']);
    }
    if (dataClassName == 'LeaveRequest') {
      return deserialize<_i14.LeaveRequest>(data['data']);
    }
    if (dataClassName == 'Memory') {
      return deserialize<_i15.Memory>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i16.Organization>(data['data']);
    }
    if (dataClassName == 'PlannerApp') {
      return deserialize<_i17.PlannerApp>(data['data']);
    }
    if (dataClassName == 'PlannerNotification') {
      return deserialize<_i18.PlannerNotification>(data['data']);
    }
    if (dataClassName == 'Priority') {
      return deserialize<_i19.Priority>(data['data']);
    }
    if (dataClassName == 'Status') {
      return deserialize<_i20.Status>(data['data']);
    }
    if (dataClassName == 'SystemColor') {
      return deserialize<_i21.SystemColor>(data['data']);
    }
    if (dataClassName == 'SystemVariables') {
      return deserialize<_i22.SystemVariables>(data['data']);
    }
    if (dataClassName == 'Ticket') {
      return deserialize<_i23.Ticket>(data['data']);
    }
    if (dataClassName == 'TicketAssignee') {
      return deserialize<_i24.TicketAssignee>(data['data']);
    }
    if (dataClassName == 'TicketAttachment') {
      return deserialize<_i25.TicketAttachment>(data['data']);
    }
    if (dataClassName == 'TicketComment') {
      return deserialize<_i26.TicketComment>(data['data']);
    }
    if (dataClassName == 'TicketStatusChange') {
      return deserialize<_i27.TicketStatusChange>(data['data']);
    }
    if (dataClassName == 'TicketType') {
      return deserialize<_i28.TicketType>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i29.User>(data['data']);
    }
    if (dataClassName == 'UserBreak') {
      return deserialize<_i30.UserBreak>(data['data']);
    }
    if (dataClassName == 'UserDevice') {
      return deserialize<_i31.UserDevice>(data['data']);
    }
    if (dataClassName == 'UserRoomMap') {
      return deserialize<_i32.UserRoomMap>(data['data']);
    }
    if (dataClassName == 'UserTypes') {
      return deserialize<_i33.UserTypes>(data['data']);
    }
    if (dataClassName == 'DeviceType') {
      return deserialize<_i34.DeviceType>(data['data']);
    }
    if (dataClassName == 'MessageType') {
      return deserialize<_i35.MessageType>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i36.Greeting>(data['data']);
    }
    if (dataClassName == 'AddBucketRequest') {
      return deserialize<_i37.AddBucketRequest>(data['data']);
    }
    if (dataClassName == 'AddCommentRequest') {
      return deserialize<_i38.AddCommentRequest>(data['data']);
    }
    if (dataClassName == 'AddTicketDTO') {
      return deserialize<_i39.AddTicketDTO>(data['data']);
    }
    if (dataClassName == 'AddTicketRequest') {
      return deserialize<_i40.AddTicketRequest>(data['data']);
    }
    if (dataClassName == 'AttachmentModel') {
      return deserialize<_i41.AttachmentModel>(data['data']);
    }
    if (dataClassName == 'BucketModel') {
      return deserialize<_i42.BucketModel>(data['data']);
    }
    if (dataClassName == 'ChangeBucketRequest') {
      return deserialize<_i43.ChangeBucketRequest>(data['data']);
    }
    if (dataClassName == 'CheckModel') {
      return deserialize<_i44.CheckModel>(data['data']);
    }
    if (dataClassName == 'CheckOrganizationResponse') {
      return deserialize<_i45.CheckOrganizationResponse>(data['data']);
    }
    if (dataClassName == 'CheckUsernameResponse') {
      return deserialize<_i46.CheckUsernameResponse>(data['data']);
    }
    if (dataClassName == 'CommentModel') {
      return deserialize<_i47.CommentModel>(data['data']);
    }
    if (dataClassName == 'GetAddTicketDataResponse') {
      return deserialize<_i48.GetAddTicketDataResponse>(data['data']);
    }
    if (dataClassName == 'GetAllTicketsResponse') {
      return deserialize<_i49.GetAllTicketsResponse>(data['data']);
    }
    if (dataClassName == 'GetAttendanceDataResponse') {
      return deserialize<_i50.GetAttendanceDataResponse>(data['data']);
    }
    if (dataClassName == 'GetPlannerDataResponse') {
      return deserialize<_i51.GetPlannerDataResponse>(data['data']);
    }
    if (dataClassName == 'GetTicketCommentsResponse') {
      return deserialize<_i52.GetTicketCommentsResponse>(data['data']);
    }
    if (dataClassName == 'GetTicketDataResponse') {
      return deserialize<_i53.GetTicketDataResponse>(data['data']);
    }
    if (dataClassName == 'GetTicketThreadResponse') {
      return deserialize<_i54.GetTicketThreadResponse>(data['data']);
    }
    if (dataClassName == 'PlannerAssignee') {
      return deserialize<_i55.PlannerAssignee>(data['data']);
    }
    if (dataClassName == 'PlannerBucket') {
      return deserialize<_i56.PlannerBucket>(data['data']);
    }
    if (dataClassName == 'PlannerTicket') {
      return deserialize<_i57.PlannerTicket>(data['data']);
    }
    if (dataClassName == 'PriorityModel') {
      return deserialize<_i58.PriorityModel>(data['data']);
    }
    if (dataClassName == 'RegisterAdminResponse') {
      return deserialize<_i59.RegisterAdminResponse>(data['data']);
    }
    if (dataClassName == 'SignInResponse') {
      return deserialize<_i60.SignInResponse>(data['data']);
    }
    if (dataClassName == 'StatusModel') {
      return deserialize<_i61.StatusModel>(data['data']);
    }
    if (dataClassName == 'ThreadItemModel') {
      return deserialize<_i62.ThreadItemModel>(data['data']);
    }
    if (dataClassName == 'TicketAttachmentDTO') {
      return deserialize<_i63.TicketAttachmentDTO>(data['data']);
    }
    if (dataClassName == 'TicketModel') {
      return deserialize<_i64.TicketModel>(data['data']);
    }
    if (dataClassName == 'TypeModel') {
      return deserialize<_i65.TypeModel>(data['data']);
    }
    if (dataClassName == 'UserModel') {
      return deserialize<_i66.UserModel>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i4.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i5.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i5.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i6.Attendance:
        return _i6.Attendance.t;
      case _i7.Bucket:
        return _i7.Bucket.t;
      case _i8.BucketTicketMap:
        return _i8.BucketTicketMap.t;
      case _i9.ChatMessage:
        return _i9.ChatMessage.t;
      case _i10.ChatRoom:
        return _i10.ChatRoom.t;
      case _i11.Doc:
        return _i11.Doc.t;
      case _i12.FlowModel:
        return _i12.FlowModel.t;
      case _i13.LeaveConfig:
        return _i13.LeaveConfig.t;
      case _i14.LeaveRequest:
        return _i14.LeaveRequest.t;
      case _i15.Memory:
        return _i15.Memory.t;
      case _i16.Organization:
        return _i16.Organization.t;
      case _i17.PlannerApp:
        return _i17.PlannerApp.t;
      case _i18.PlannerNotification:
        return _i18.PlannerNotification.t;
      case _i19.Priority:
        return _i19.Priority.t;
      case _i20.Status:
        return _i20.Status.t;
      case _i21.SystemColor:
        return _i21.SystemColor.t;
      case _i22.SystemVariables:
        return _i22.SystemVariables.t;
      case _i23.Ticket:
        return _i23.Ticket.t;
      case _i24.TicketAssignee:
        return _i24.TicketAssignee.t;
      case _i25.TicketAttachment:
        return _i25.TicketAttachment.t;
      case _i26.TicketComment:
        return _i26.TicketComment.t;
      case _i27.TicketStatusChange:
        return _i27.TicketStatusChange.t;
      case _i28.TicketType:
        return _i28.TicketType.t;
      case _i29.User:
        return _i29.User.t;
      case _i30.UserBreak:
        return _i30.UserBreak.t;
      case _i31.UserDevice:
        return _i31.UserDevice.t;
      case _i32.UserRoomMap:
        return _i32.UserRoomMap.t;
      case _i33.UserTypes:
        return _i33.UserTypes.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'crewboard';
}
