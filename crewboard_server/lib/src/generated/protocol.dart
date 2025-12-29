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
import 'add_bucket_request.dart' as _i6;
import 'add_comment_request.dart' as _i7;
import 'add_ticket_dto.dart' as _i8;
import 'add_ticket_request.dart' as _i9;
import 'attachment_model.dart' as _i10;
import 'attendance.dart' as _i11;
import 'bucket.dart' as _i12;
import 'bucket_model.dart' as _i13;
import 'bucket_ticket_map.dart' as _i14;
import 'change_bucket_request.dart' as _i15;
import 'chat_message.dart' as _i16;
import 'chat_room.dart' as _i17;
import 'check_model.dart' as _i18;
import 'check_organization_response.dart' as _i19;
import 'check_username_response.dart' as _i20;
import 'comment_model.dart' as _i21;
import 'device_type.dart' as _i22;
import 'doc.dart' as _i23;
import 'flow_model.dart' as _i24;
import 'get_add_ticket_data_response.dart' as _i25;
import 'get_all_tickets_response.dart' as _i26;
import 'get_attendance_data_response.dart' as _i27;
import 'get_planner_data_response.dart' as _i28;
import 'get_ticket_comments_response.dart' as _i29;
import 'get_ticket_data_response.dart' as _i30;
import 'greetings/greeting.dart' as _i31;
import 'leave_config.dart' as _i32;
import 'leave_request.dart' as _i33;
import 'message_type.dart' as _i34;
import 'organization.dart' as _i35;
import 'planner_app.dart' as _i36;
import 'planner_assignee.dart' as _i37;
import 'planner_bucket.dart' as _i38;
import 'planner_notification.dart' as _i39;
import 'planner_ticket.dart' as _i40;
import 'priority.dart' as _i41;
import 'priority_model.dart' as _i42;
import 'register_admin_response.dart' as _i43;
import 'sign_in_response.dart' as _i44;
import 'status.dart' as _i45;
import 'status_model.dart' as _i46;
import 'system_color.dart' as _i47;
import 'system_variables.dart' as _i48;
import 'ticket.dart' as _i49;
import 'ticket_assignee.dart' as _i50;
import 'ticket_attachment.dart' as _i51;
import 'ticket_attachment_dto.dart' as _i52;
import 'ticket_comment.dart' as _i53;
import 'ticket_model.dart' as _i54;
import 'ticket_status_change.dart' as _i55;
import 'ticket_type.dart' as _i56;
import 'type_model.dart' as _i57;
import 'user.dart' as _i58;
import 'user_break.dart' as _i59;
import 'user_device.dart' as _i60;
import 'user_model.dart' as _i61;
import 'user_room_map.dart' as _i62;
import 'user_types.dart' as _i63;
import 'package:crewboard_server/src/generated/planner_app.dart' as _i64;
import 'package:crewboard_server/src/generated/user.dart' as _i65;
import 'package:crewboard_server/src/generated/user_types.dart' as _i66;
import 'package:crewboard_server/src/generated/attendance.dart' as _i67;
import 'package:crewboard_server/src/generated/leave_config.dart' as _i68;
import 'package:crewboard_server/src/generated/system_color.dart' as _i69;
import 'package:crewboard_server/src/generated/chat_room.dart' as _i70;
import 'package:crewboard_server/src/generated/chat_message.dart' as _i71;
import 'package:crewboard_server/src/generated/flow_model.dart' as _i72;
import 'package:crewboard_server/src/generated/doc.dart' as _i73;
export 'add_bucket_request.dart';
export 'add_comment_request.dart';
export 'add_ticket_dto.dart';
export 'add_ticket_request.dart';
export 'attachment_model.dart';
export 'attendance.dart';
export 'bucket.dart';
export 'bucket_model.dart';
export 'bucket_ticket_map.dart';
export 'change_bucket_request.dart';
export 'chat_message.dart';
export 'chat_room.dart';
export 'check_model.dart';
export 'check_organization_response.dart';
export 'check_username_response.dart';
export 'comment_model.dart';
export 'device_type.dart';
export 'doc.dart';
export 'flow_model.dart';
export 'get_add_ticket_data_response.dart';
export 'get_all_tickets_response.dart';
export 'get_attendance_data_response.dart';
export 'get_planner_data_response.dart';
export 'get_ticket_comments_response.dart';
export 'get_ticket_data_response.dart';
export 'greetings/greeting.dart';
export 'leave_config.dart';
export 'leave_request.dart';
export 'message_type.dart';
export 'organization.dart';
export 'planner_app.dart';
export 'planner_assignee.dart';
export 'planner_bucket.dart';
export 'planner_notification.dart';
export 'planner_ticket.dart';
export 'priority.dart';
export 'priority_model.dart';
export 'register_admin_response.dart';
export 'sign_in_response.dart';
export 'status.dart';
export 'status_model.dart';
export 'system_color.dart';
export 'system_variables.dart';
export 'ticket.dart';
export 'ticket_assignee.dart';
export 'ticket_attachment.dart';
export 'ticket_attachment_dto.dart';
export 'ticket_comment.dart';
export 'ticket_model.dart';
export 'ticket_status_change.dart';
export 'ticket_type.dart';
export 'type_model.dart';
export 'user.dart';
export 'user_break.dart';
export 'user_device.dart';
export 'user_model.dart';
export 'user_room_map.dart';
export 'user_types.dart';

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
          isNullable: false,
          dartType: 'UuidValue',
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

    if (t == _i6.AddBucketRequest) {
      return _i6.AddBucketRequest.fromJson(data) as T;
    }
    if (t == _i7.AddCommentRequest) {
      return _i7.AddCommentRequest.fromJson(data) as T;
    }
    if (t == _i8.AddTicketDTO) {
      return _i8.AddTicketDTO.fromJson(data) as T;
    }
    if (t == _i9.AddTicketRequest) {
      return _i9.AddTicketRequest.fromJson(data) as T;
    }
    if (t == _i10.AttachmentModel) {
      return _i10.AttachmentModel.fromJson(data) as T;
    }
    if (t == _i11.Attendance) {
      return _i11.Attendance.fromJson(data) as T;
    }
    if (t == _i12.Bucket) {
      return _i12.Bucket.fromJson(data) as T;
    }
    if (t == _i13.BucketModel) {
      return _i13.BucketModel.fromJson(data) as T;
    }
    if (t == _i14.BucketTicketMap) {
      return _i14.BucketTicketMap.fromJson(data) as T;
    }
    if (t == _i15.ChangeBucketRequest) {
      return _i15.ChangeBucketRequest.fromJson(data) as T;
    }
    if (t == _i16.ChatMessage) {
      return _i16.ChatMessage.fromJson(data) as T;
    }
    if (t == _i17.ChatRoom) {
      return _i17.ChatRoom.fromJson(data) as T;
    }
    if (t == _i18.CheckModel) {
      return _i18.CheckModel.fromJson(data) as T;
    }
    if (t == _i19.CheckOrganizationResponse) {
      return _i19.CheckOrganizationResponse.fromJson(data) as T;
    }
    if (t == _i20.CheckUsernameResponse) {
      return _i20.CheckUsernameResponse.fromJson(data) as T;
    }
    if (t == _i21.CommentModel) {
      return _i21.CommentModel.fromJson(data) as T;
    }
    if (t == _i22.DeviceType) {
      return _i22.DeviceType.fromJson(data) as T;
    }
    if (t == _i23.Doc) {
      return _i23.Doc.fromJson(data) as T;
    }
    if (t == _i24.FlowModel) {
      return _i24.FlowModel.fromJson(data) as T;
    }
    if (t == _i25.GetAddTicketDataResponse) {
      return _i25.GetAddTicketDataResponse.fromJson(data) as T;
    }
    if (t == _i26.GetAllTicketsResponse) {
      return _i26.GetAllTicketsResponse.fromJson(data) as T;
    }
    if (t == _i27.GetAttendanceDataResponse) {
      return _i27.GetAttendanceDataResponse.fromJson(data) as T;
    }
    if (t == _i28.GetPlannerDataResponse) {
      return _i28.GetPlannerDataResponse.fromJson(data) as T;
    }
    if (t == _i29.GetTicketCommentsResponse) {
      return _i29.GetTicketCommentsResponse.fromJson(data) as T;
    }
    if (t == _i30.GetTicketDataResponse) {
      return _i30.GetTicketDataResponse.fromJson(data) as T;
    }
    if (t == _i31.Greeting) {
      return _i31.Greeting.fromJson(data) as T;
    }
    if (t == _i32.LeaveConfig) {
      return _i32.LeaveConfig.fromJson(data) as T;
    }
    if (t == _i33.LeaveRequest) {
      return _i33.LeaveRequest.fromJson(data) as T;
    }
    if (t == _i34.MessageType) {
      return _i34.MessageType.fromJson(data) as T;
    }
    if (t == _i35.Organization) {
      return _i35.Organization.fromJson(data) as T;
    }
    if (t == _i36.PlannerApp) {
      return _i36.PlannerApp.fromJson(data) as T;
    }
    if (t == _i37.PlannerAssignee) {
      return _i37.PlannerAssignee.fromJson(data) as T;
    }
    if (t == _i38.PlannerBucket) {
      return _i38.PlannerBucket.fromJson(data) as T;
    }
    if (t == _i39.PlannerNotification) {
      return _i39.PlannerNotification.fromJson(data) as T;
    }
    if (t == _i40.PlannerTicket) {
      return _i40.PlannerTicket.fromJson(data) as T;
    }
    if (t == _i41.Priority) {
      return _i41.Priority.fromJson(data) as T;
    }
    if (t == _i42.PriorityModel) {
      return _i42.PriorityModel.fromJson(data) as T;
    }
    if (t == _i43.RegisterAdminResponse) {
      return _i43.RegisterAdminResponse.fromJson(data) as T;
    }
    if (t == _i44.SignInResponse) {
      return _i44.SignInResponse.fromJson(data) as T;
    }
    if (t == _i45.Status) {
      return _i45.Status.fromJson(data) as T;
    }
    if (t == _i46.StatusModel) {
      return _i46.StatusModel.fromJson(data) as T;
    }
    if (t == _i47.SystemColor) {
      return _i47.SystemColor.fromJson(data) as T;
    }
    if (t == _i48.SystemVariables) {
      return _i48.SystemVariables.fromJson(data) as T;
    }
    if (t == _i49.Ticket) {
      return _i49.Ticket.fromJson(data) as T;
    }
    if (t == _i50.TicketAssignee) {
      return _i50.TicketAssignee.fromJson(data) as T;
    }
    if (t == _i51.TicketAttachment) {
      return _i51.TicketAttachment.fromJson(data) as T;
    }
    if (t == _i52.TicketAttachmentDTO) {
      return _i52.TicketAttachmentDTO.fromJson(data) as T;
    }
    if (t == _i53.TicketComment) {
      return _i53.TicketComment.fromJson(data) as T;
    }
    if (t == _i54.TicketModel) {
      return _i54.TicketModel.fromJson(data) as T;
    }
    if (t == _i55.TicketStatusChange) {
      return _i55.TicketStatusChange.fromJson(data) as T;
    }
    if (t == _i56.TicketType) {
      return _i56.TicketType.fromJson(data) as T;
    }
    if (t == _i57.TypeModel) {
      return _i57.TypeModel.fromJson(data) as T;
    }
    if (t == _i58.User) {
      return _i58.User.fromJson(data) as T;
    }
    if (t == _i59.UserBreak) {
      return _i59.UserBreak.fromJson(data) as T;
    }
    if (t == _i60.UserDevice) {
      return _i60.UserDevice.fromJson(data) as T;
    }
    if (t == _i61.UserModel) {
      return _i61.UserModel.fromJson(data) as T;
    }
    if (t == _i62.UserRoomMap) {
      return _i62.UserRoomMap.fromJson(data) as T;
    }
    if (t == _i63.UserTypes) {
      return _i63.UserTypes.fromJson(data) as T;
    }
    if (t == _i1.getType<_i6.AddBucketRequest?>()) {
      return (data != null ? _i6.AddBucketRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AddCommentRequest?>()) {
      return (data != null ? _i7.AddCommentRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AddTicketDTO?>()) {
      return (data != null ? _i8.AddTicketDTO.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.AddTicketRequest?>()) {
      return (data != null ? _i9.AddTicketRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.AttachmentModel?>()) {
      return (data != null ? _i10.AttachmentModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Attendance?>()) {
      return (data != null ? _i11.Attendance.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Bucket?>()) {
      return (data != null ? _i12.Bucket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.BucketModel?>()) {
      return (data != null ? _i13.BucketModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.BucketTicketMap?>()) {
      return (data != null ? _i14.BucketTicketMap.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.ChangeBucketRequest?>()) {
      return (data != null ? _i15.ChangeBucketRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.ChatMessage?>()) {
      return (data != null ? _i16.ChatMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.ChatRoom?>()) {
      return (data != null ? _i17.ChatRoom.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.CheckModel?>()) {
      return (data != null ? _i18.CheckModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.CheckOrganizationResponse?>()) {
      return (data != null
              ? _i19.CheckOrganizationResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i20.CheckUsernameResponse?>()) {
      return (data != null ? _i20.CheckUsernameResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.CommentModel?>()) {
      return (data != null ? _i21.CommentModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.DeviceType?>()) {
      return (data != null ? _i22.DeviceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.Doc?>()) {
      return (data != null ? _i23.Doc.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.FlowModel?>()) {
      return (data != null ? _i24.FlowModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.GetAddTicketDataResponse?>()) {
      return (data != null
              ? _i25.GetAddTicketDataResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i26.GetAllTicketsResponse?>()) {
      return (data != null ? _i26.GetAllTicketsResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.GetAttendanceDataResponse?>()) {
      return (data != null
              ? _i27.GetAttendanceDataResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i28.GetPlannerDataResponse?>()) {
      return (data != null ? _i28.GetPlannerDataResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.GetTicketCommentsResponse?>()) {
      return (data != null
              ? _i29.GetTicketCommentsResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i30.GetTicketDataResponse?>()) {
      return (data != null ? _i30.GetTicketDataResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.Greeting?>()) {
      return (data != null ? _i31.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.LeaveConfig?>()) {
      return (data != null ? _i32.LeaveConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.LeaveRequest?>()) {
      return (data != null ? _i33.LeaveRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.MessageType?>()) {
      return (data != null ? _i34.MessageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.Organization?>()) {
      return (data != null ? _i35.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.PlannerApp?>()) {
      return (data != null ? _i36.PlannerApp.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.PlannerAssignee?>()) {
      return (data != null ? _i37.PlannerAssignee.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.PlannerBucket?>()) {
      return (data != null ? _i38.PlannerBucket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.PlannerNotification?>()) {
      return (data != null ? _i39.PlannerNotification.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.PlannerTicket?>()) {
      return (data != null ? _i40.PlannerTicket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.Priority?>()) {
      return (data != null ? _i41.Priority.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.PriorityModel?>()) {
      return (data != null ? _i42.PriorityModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.RegisterAdminResponse?>()) {
      return (data != null ? _i43.RegisterAdminResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.SignInResponse?>()) {
      return (data != null ? _i44.SignInResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.Status?>()) {
      return (data != null ? _i45.Status.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.StatusModel?>()) {
      return (data != null ? _i46.StatusModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.SystemColor?>()) {
      return (data != null ? _i47.SystemColor.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.SystemVariables?>()) {
      return (data != null ? _i48.SystemVariables.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.Ticket?>()) {
      return (data != null ? _i49.Ticket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.TicketAssignee?>()) {
      return (data != null ? _i50.TicketAssignee.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.TicketAttachment?>()) {
      return (data != null ? _i51.TicketAttachment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.TicketAttachmentDTO?>()) {
      return (data != null ? _i52.TicketAttachmentDTO.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i53.TicketComment?>()) {
      return (data != null ? _i53.TicketComment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.TicketModel?>()) {
      return (data != null ? _i54.TicketModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.TicketStatusChange?>()) {
      return (data != null ? _i55.TicketStatusChange.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i56.TicketType?>()) {
      return (data != null ? _i56.TicketType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.TypeModel?>()) {
      return (data != null ? _i57.TypeModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.User?>()) {
      return (data != null ? _i58.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.UserBreak?>()) {
      return (data != null ? _i59.UserBreak.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.UserDevice?>()) {
      return (data != null ? _i60.UserDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.UserModel?>()) {
      return (data != null ? _i61.UserModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.UserRoomMap?>()) {
      return (data != null ? _i62.UserRoomMap.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.UserTypes?>()) {
      return (data != null ? _i63.UserTypes.fromJson(data) : null) as T;
    }
    if (t == List<_i52.TicketAttachmentDTO>) {
      return (data as List)
              .map((e) => deserialize<_i52.TicketAttachmentDTO>(e))
              .toList()
          as T;
    }
    if (t == List<_i37.PlannerAssignee>) {
      return (data as List)
              .map((e) => deserialize<_i37.PlannerAssignee>(e))
              .toList()
          as T;
    }
    if (t == List<_i40.PlannerTicket>) {
      return (data as List)
              .map((e) => deserialize<_i40.PlannerTicket>(e))
              .toList()
          as T;
    }
    if (t == List<_i1.UuidValue>) {
      return (data as List).map((e) => deserialize<_i1.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<_i61.UserModel>) {
      return (data as List).map((e) => deserialize<_i61.UserModel>(e)).toList()
          as T;
    }
    if (t == List<_i46.StatusModel>) {
      return (data as List)
              .map((e) => deserialize<_i46.StatusModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i42.PriorityModel>) {
      return (data as List)
              .map((e) => deserialize<_i42.PriorityModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i57.TypeModel>) {
      return (data as List).map((e) => deserialize<_i57.TypeModel>(e)).toList()
          as T;
    }
    if (t == List<_i24.FlowModel>) {
      return (data as List).map((e) => deserialize<_i24.FlowModel>(e)).toList()
          as T;
    }
    if (t == List<_i58.User>) {
      return (data as List).map((e) => deserialize<_i58.User>(e)).toList() as T;
    }
    if (t == List<_i11.Attendance>) {
      return (data as List).map((e) => deserialize<_i11.Attendance>(e)).toList()
          as T;
    }
    if (t == List<_i32.LeaveConfig>) {
      return (data as List)
              .map((e) => deserialize<_i32.LeaveConfig>(e))
              .toList()
          as T;
    }
    if (t == List<_i33.LeaveRequest>) {
      return (data as List)
              .map((e) => deserialize<_i33.LeaveRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.BucketModel>) {
      return (data as List)
              .map((e) => deserialize<_i13.BucketModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.CommentModel>) {
      return (data as List)
              .map((e) => deserialize<_i21.CommentModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i18.CheckModel>) {
      return (data as List).map((e) => deserialize<_i18.CheckModel>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i18.CheckModel>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i18.CheckModel>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i10.AttachmentModel>) {
      return (data as List)
              .map((e) => deserialize<_i10.AttachmentModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i64.PlannerApp>) {
      return (data as List).map((e) => deserialize<_i64.PlannerApp>(e)).toList()
          as T;
    }
    if (t == List<_i65.User>) {
      return (data as List).map((e) => deserialize<_i65.User>(e)).toList() as T;
    }
    if (t == List<_i66.UserTypes>) {
      return (data as List).map((e) => deserialize<_i66.UserTypes>(e)).toList()
          as T;
    }
    if (t == List<_i67.Attendance>) {
      return (data as List).map((e) => deserialize<_i67.Attendance>(e)).toList()
          as T;
    }
    if (t == List<_i68.LeaveConfig>) {
      return (data as List)
              .map((e) => deserialize<_i68.LeaveConfig>(e))
              .toList()
          as T;
    }
    if (t == List<_i69.SystemColor>) {
      return (data as List)
              .map((e) => deserialize<_i69.SystemColor>(e))
              .toList()
          as T;
    }
    if (t == List<_i70.ChatRoom>) {
      return (data as List).map((e) => deserialize<_i70.ChatRoom>(e)).toList()
          as T;
    }
    if (t == List<_i71.ChatMessage>) {
      return (data as List)
              .map((e) => deserialize<_i71.ChatMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_i72.FlowModel>) {
      return (data as List).map((e) => deserialize<_i72.FlowModel>(e)).toList()
          as T;
    }
    if (t == List<_i73.Doc>) {
      return (data as List).map((e) => deserialize<_i73.Doc>(e)).toList() as T;
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
      _i6.AddBucketRequest => 'AddBucketRequest',
      _i7.AddCommentRequest => 'AddCommentRequest',
      _i8.AddTicketDTO => 'AddTicketDTO',
      _i9.AddTicketRequest => 'AddTicketRequest',
      _i10.AttachmentModel => 'AttachmentModel',
      _i11.Attendance => 'Attendance',
      _i12.Bucket => 'Bucket',
      _i13.BucketModel => 'BucketModel',
      _i14.BucketTicketMap => 'BucketTicketMap',
      _i15.ChangeBucketRequest => 'ChangeBucketRequest',
      _i16.ChatMessage => 'ChatMessage',
      _i17.ChatRoom => 'ChatRoom',
      _i18.CheckModel => 'CheckModel',
      _i19.CheckOrganizationResponse => 'CheckOrganizationResponse',
      _i20.CheckUsernameResponse => 'CheckUsernameResponse',
      _i21.CommentModel => 'CommentModel',
      _i22.DeviceType => 'DeviceType',
      _i23.Doc => 'Doc',
      _i24.FlowModel => 'FlowModel',
      _i25.GetAddTicketDataResponse => 'GetAddTicketDataResponse',
      _i26.GetAllTicketsResponse => 'GetAllTicketsResponse',
      _i27.GetAttendanceDataResponse => 'GetAttendanceDataResponse',
      _i28.GetPlannerDataResponse => 'GetPlannerDataResponse',
      _i29.GetTicketCommentsResponse => 'GetTicketCommentsResponse',
      _i30.GetTicketDataResponse => 'GetTicketDataResponse',
      _i31.Greeting => 'Greeting',
      _i32.LeaveConfig => 'LeaveConfig',
      _i33.LeaveRequest => 'LeaveRequest',
      _i34.MessageType => 'MessageType',
      _i35.Organization => 'Organization',
      _i36.PlannerApp => 'PlannerApp',
      _i37.PlannerAssignee => 'PlannerAssignee',
      _i38.PlannerBucket => 'PlannerBucket',
      _i39.PlannerNotification => 'PlannerNotification',
      _i40.PlannerTicket => 'PlannerTicket',
      _i41.Priority => 'Priority',
      _i42.PriorityModel => 'PriorityModel',
      _i43.RegisterAdminResponse => 'RegisterAdminResponse',
      _i44.SignInResponse => 'SignInResponse',
      _i45.Status => 'Status',
      _i46.StatusModel => 'StatusModel',
      _i47.SystemColor => 'SystemColor',
      _i48.SystemVariables => 'SystemVariables',
      _i49.Ticket => 'Ticket',
      _i50.TicketAssignee => 'TicketAssignee',
      _i51.TicketAttachment => 'TicketAttachment',
      _i52.TicketAttachmentDTO => 'TicketAttachmentDTO',
      _i53.TicketComment => 'TicketComment',
      _i54.TicketModel => 'TicketModel',
      _i55.TicketStatusChange => 'TicketStatusChange',
      _i56.TicketType => 'TicketType',
      _i57.TypeModel => 'TypeModel',
      _i58.User => 'User',
      _i59.UserBreak => 'UserBreak',
      _i60.UserDevice => 'UserDevice',
      _i61.UserModel => 'UserModel',
      _i62.UserRoomMap => 'UserRoomMap',
      _i63.UserTypes => 'UserTypes',
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
      case _i6.AddBucketRequest():
        return 'AddBucketRequest';
      case _i7.AddCommentRequest():
        return 'AddCommentRequest';
      case _i8.AddTicketDTO():
        return 'AddTicketDTO';
      case _i9.AddTicketRequest():
        return 'AddTicketRequest';
      case _i10.AttachmentModel():
        return 'AttachmentModel';
      case _i11.Attendance():
        return 'Attendance';
      case _i12.Bucket():
        return 'Bucket';
      case _i13.BucketModel():
        return 'BucketModel';
      case _i14.BucketTicketMap():
        return 'BucketTicketMap';
      case _i15.ChangeBucketRequest():
        return 'ChangeBucketRequest';
      case _i16.ChatMessage():
        return 'ChatMessage';
      case _i17.ChatRoom():
        return 'ChatRoom';
      case _i18.CheckModel():
        return 'CheckModel';
      case _i19.CheckOrganizationResponse():
        return 'CheckOrganizationResponse';
      case _i20.CheckUsernameResponse():
        return 'CheckUsernameResponse';
      case _i21.CommentModel():
        return 'CommentModel';
      case _i22.DeviceType():
        return 'DeviceType';
      case _i23.Doc():
        return 'Doc';
      case _i24.FlowModel():
        return 'FlowModel';
      case _i25.GetAddTicketDataResponse():
        return 'GetAddTicketDataResponse';
      case _i26.GetAllTicketsResponse():
        return 'GetAllTicketsResponse';
      case _i27.GetAttendanceDataResponse():
        return 'GetAttendanceDataResponse';
      case _i28.GetPlannerDataResponse():
        return 'GetPlannerDataResponse';
      case _i29.GetTicketCommentsResponse():
        return 'GetTicketCommentsResponse';
      case _i30.GetTicketDataResponse():
        return 'GetTicketDataResponse';
      case _i31.Greeting():
        return 'Greeting';
      case _i32.LeaveConfig():
        return 'LeaveConfig';
      case _i33.LeaveRequest():
        return 'LeaveRequest';
      case _i34.MessageType():
        return 'MessageType';
      case _i35.Organization():
        return 'Organization';
      case _i36.PlannerApp():
        return 'PlannerApp';
      case _i37.PlannerAssignee():
        return 'PlannerAssignee';
      case _i38.PlannerBucket():
        return 'PlannerBucket';
      case _i39.PlannerNotification():
        return 'PlannerNotification';
      case _i40.PlannerTicket():
        return 'PlannerTicket';
      case _i41.Priority():
        return 'Priority';
      case _i42.PriorityModel():
        return 'PriorityModel';
      case _i43.RegisterAdminResponse():
        return 'RegisterAdminResponse';
      case _i44.SignInResponse():
        return 'SignInResponse';
      case _i45.Status():
        return 'Status';
      case _i46.StatusModel():
        return 'StatusModel';
      case _i47.SystemColor():
        return 'SystemColor';
      case _i48.SystemVariables():
        return 'SystemVariables';
      case _i49.Ticket():
        return 'Ticket';
      case _i50.TicketAssignee():
        return 'TicketAssignee';
      case _i51.TicketAttachment():
        return 'TicketAttachment';
      case _i52.TicketAttachmentDTO():
        return 'TicketAttachmentDTO';
      case _i53.TicketComment():
        return 'TicketComment';
      case _i54.TicketModel():
        return 'TicketModel';
      case _i55.TicketStatusChange():
        return 'TicketStatusChange';
      case _i56.TicketType():
        return 'TicketType';
      case _i57.TypeModel():
        return 'TypeModel';
      case _i58.User():
        return 'User';
      case _i59.UserBreak():
        return 'UserBreak';
      case _i60.UserDevice():
        return 'UserDevice';
      case _i61.UserModel():
        return 'UserModel';
      case _i62.UserRoomMap():
        return 'UserRoomMap';
      case _i63.UserTypes():
        return 'UserTypes';
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
    if (dataClassName == 'AddBucketRequest') {
      return deserialize<_i6.AddBucketRequest>(data['data']);
    }
    if (dataClassName == 'AddCommentRequest') {
      return deserialize<_i7.AddCommentRequest>(data['data']);
    }
    if (dataClassName == 'AddTicketDTO') {
      return deserialize<_i8.AddTicketDTO>(data['data']);
    }
    if (dataClassName == 'AddTicketRequest') {
      return deserialize<_i9.AddTicketRequest>(data['data']);
    }
    if (dataClassName == 'AttachmentModel') {
      return deserialize<_i10.AttachmentModel>(data['data']);
    }
    if (dataClassName == 'Attendance') {
      return deserialize<_i11.Attendance>(data['data']);
    }
    if (dataClassName == 'Bucket') {
      return deserialize<_i12.Bucket>(data['data']);
    }
    if (dataClassName == 'BucketModel') {
      return deserialize<_i13.BucketModel>(data['data']);
    }
    if (dataClassName == 'BucketTicketMap') {
      return deserialize<_i14.BucketTicketMap>(data['data']);
    }
    if (dataClassName == 'ChangeBucketRequest') {
      return deserialize<_i15.ChangeBucketRequest>(data['data']);
    }
    if (dataClassName == 'ChatMessage') {
      return deserialize<_i16.ChatMessage>(data['data']);
    }
    if (dataClassName == 'ChatRoom') {
      return deserialize<_i17.ChatRoom>(data['data']);
    }
    if (dataClassName == 'CheckModel') {
      return deserialize<_i18.CheckModel>(data['data']);
    }
    if (dataClassName == 'CheckOrganizationResponse') {
      return deserialize<_i19.CheckOrganizationResponse>(data['data']);
    }
    if (dataClassName == 'CheckUsernameResponse') {
      return deserialize<_i20.CheckUsernameResponse>(data['data']);
    }
    if (dataClassName == 'CommentModel') {
      return deserialize<_i21.CommentModel>(data['data']);
    }
    if (dataClassName == 'DeviceType') {
      return deserialize<_i22.DeviceType>(data['data']);
    }
    if (dataClassName == 'Doc') {
      return deserialize<_i23.Doc>(data['data']);
    }
    if (dataClassName == 'FlowModel') {
      return deserialize<_i24.FlowModel>(data['data']);
    }
    if (dataClassName == 'GetAddTicketDataResponse') {
      return deserialize<_i25.GetAddTicketDataResponse>(data['data']);
    }
    if (dataClassName == 'GetAllTicketsResponse') {
      return deserialize<_i26.GetAllTicketsResponse>(data['data']);
    }
    if (dataClassName == 'GetAttendanceDataResponse') {
      return deserialize<_i27.GetAttendanceDataResponse>(data['data']);
    }
    if (dataClassName == 'GetPlannerDataResponse') {
      return deserialize<_i28.GetPlannerDataResponse>(data['data']);
    }
    if (dataClassName == 'GetTicketCommentsResponse') {
      return deserialize<_i29.GetTicketCommentsResponse>(data['data']);
    }
    if (dataClassName == 'GetTicketDataResponse') {
      return deserialize<_i30.GetTicketDataResponse>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i31.Greeting>(data['data']);
    }
    if (dataClassName == 'LeaveConfig') {
      return deserialize<_i32.LeaveConfig>(data['data']);
    }
    if (dataClassName == 'LeaveRequest') {
      return deserialize<_i33.LeaveRequest>(data['data']);
    }
    if (dataClassName == 'MessageType') {
      return deserialize<_i34.MessageType>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i35.Organization>(data['data']);
    }
    if (dataClassName == 'PlannerApp') {
      return deserialize<_i36.PlannerApp>(data['data']);
    }
    if (dataClassName == 'PlannerAssignee') {
      return deserialize<_i37.PlannerAssignee>(data['data']);
    }
    if (dataClassName == 'PlannerBucket') {
      return deserialize<_i38.PlannerBucket>(data['data']);
    }
    if (dataClassName == 'PlannerNotification') {
      return deserialize<_i39.PlannerNotification>(data['data']);
    }
    if (dataClassName == 'PlannerTicket') {
      return deserialize<_i40.PlannerTicket>(data['data']);
    }
    if (dataClassName == 'Priority') {
      return deserialize<_i41.Priority>(data['data']);
    }
    if (dataClassName == 'PriorityModel') {
      return deserialize<_i42.PriorityModel>(data['data']);
    }
    if (dataClassName == 'RegisterAdminResponse') {
      return deserialize<_i43.RegisterAdminResponse>(data['data']);
    }
    if (dataClassName == 'SignInResponse') {
      return deserialize<_i44.SignInResponse>(data['data']);
    }
    if (dataClassName == 'Status') {
      return deserialize<_i45.Status>(data['data']);
    }
    if (dataClassName == 'StatusModel') {
      return deserialize<_i46.StatusModel>(data['data']);
    }
    if (dataClassName == 'SystemColor') {
      return deserialize<_i47.SystemColor>(data['data']);
    }
    if (dataClassName == 'SystemVariables') {
      return deserialize<_i48.SystemVariables>(data['data']);
    }
    if (dataClassName == 'Ticket') {
      return deserialize<_i49.Ticket>(data['data']);
    }
    if (dataClassName == 'TicketAssignee') {
      return deserialize<_i50.TicketAssignee>(data['data']);
    }
    if (dataClassName == 'TicketAttachment') {
      return deserialize<_i51.TicketAttachment>(data['data']);
    }
    if (dataClassName == 'TicketAttachmentDTO') {
      return deserialize<_i52.TicketAttachmentDTO>(data['data']);
    }
    if (dataClassName == 'TicketComment') {
      return deserialize<_i53.TicketComment>(data['data']);
    }
    if (dataClassName == 'TicketModel') {
      return deserialize<_i54.TicketModel>(data['data']);
    }
    if (dataClassName == 'TicketStatusChange') {
      return deserialize<_i55.TicketStatusChange>(data['data']);
    }
    if (dataClassName == 'TicketType') {
      return deserialize<_i56.TicketType>(data['data']);
    }
    if (dataClassName == 'TypeModel') {
      return deserialize<_i57.TypeModel>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i58.User>(data['data']);
    }
    if (dataClassName == 'UserBreak') {
      return deserialize<_i59.UserBreak>(data['data']);
    }
    if (dataClassName == 'UserDevice') {
      return deserialize<_i60.UserDevice>(data['data']);
    }
    if (dataClassName == 'UserModel') {
      return deserialize<_i61.UserModel>(data['data']);
    }
    if (dataClassName == 'UserRoomMap') {
      return deserialize<_i62.UserRoomMap>(data['data']);
    }
    if (dataClassName == 'UserTypes') {
      return deserialize<_i63.UserTypes>(data['data']);
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
      case _i11.Attendance:
        return _i11.Attendance.t;
      case _i12.Bucket:
        return _i12.Bucket.t;
      case _i14.BucketTicketMap:
        return _i14.BucketTicketMap.t;
      case _i16.ChatMessage:
        return _i16.ChatMessage.t;
      case _i17.ChatRoom:
        return _i17.ChatRoom.t;
      case _i23.Doc:
        return _i23.Doc.t;
      case _i24.FlowModel:
        return _i24.FlowModel.t;
      case _i32.LeaveConfig:
        return _i32.LeaveConfig.t;
      case _i33.LeaveRequest:
        return _i33.LeaveRequest.t;
      case _i35.Organization:
        return _i35.Organization.t;
      case _i36.PlannerApp:
        return _i36.PlannerApp.t;
      case _i39.PlannerNotification:
        return _i39.PlannerNotification.t;
      case _i41.Priority:
        return _i41.Priority.t;
      case _i45.Status:
        return _i45.Status.t;
      case _i47.SystemColor:
        return _i47.SystemColor.t;
      case _i48.SystemVariables:
        return _i48.SystemVariables.t;
      case _i49.Ticket:
        return _i49.Ticket.t;
      case _i50.TicketAssignee:
        return _i50.TicketAssignee.t;
      case _i51.TicketAttachment:
        return _i51.TicketAttachment.t;
      case _i53.TicketComment:
        return _i53.TicketComment.t;
      case _i55.TicketStatusChange:
        return _i55.TicketStatusChange.t;
      case _i56.TicketType:
        return _i56.TicketType.t;
      case _i58.User:
        return _i58.User.t;
      case _i59.UserBreak:
        return _i59.UserBreak.t;
      case _i60.UserDevice:
        return _i60.UserDevice.t;
      case _i62.UserRoomMap:
        return _i62.UserRoomMap.t;
      case _i63.UserTypes:
        return _i63.UserTypes.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'crewboard';
}
