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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'entities/attendance.dart' as _i2;
import 'entities/bucket.dart' as _i3;
import 'entities/bucket_ticket_map.dart' as _i4;
import 'entities/chat_message.dart' as _i5;
import 'entities/chat_room.dart' as _i6;
import 'entities/doc.dart' as _i7;
import 'entities/flow_model.dart' as _i8;
import 'entities/leave_config.dart' as _i9;
import 'entities/leave_request.dart' as _i10;
import 'entities/memory.dart' as _i11;
import 'entities/organization.dart' as _i12;
import 'entities/planner_activity.dart' as _i13;
import 'entities/planner_app.dart' as _i14;
import 'entities/planner_notification.dart' as _i15;
import 'entities/priority.dart' as _i16;
import 'entities/status.dart' as _i17;
import 'entities/system_color.dart' as _i18;
import 'entities/system_variables.dart' as _i19;
import 'entities/ticket.dart' as _i20;
import 'entities/ticket_assignee.dart' as _i21;
import 'entities/ticket_attachment.dart' as _i22;
import 'entities/ticket_comment.dart' as _i23;
import 'entities/ticket_status_change.dart' as _i24;
import 'entities/ticket_type.dart' as _i25;
import 'entities/ticket_view.dart' as _i26;
import 'entities/user.dart' as _i27;
import 'entities/user_break.dart' as _i28;
import 'entities/user_device.dart' as _i29;
import 'entities/user_room_map.dart' as _i30;
import 'entities/user_types.dart' as _i31;
import 'enums/device_type.dart' as _i32;
import 'enums/message_type.dart' as _i33;
import 'greetings/greeting.dart' as _i34;
import 'protocols/add_bucket_request.dart' as _i35;
import 'protocols/add_comment_request.dart' as _i36;
import 'protocols/add_ticket_dto.dart' as _i37;
import 'protocols/add_ticket_request.dart' as _i38;
import 'protocols/attachment_model.dart' as _i39;
import 'protocols/bucket_model.dart' as _i40;
import 'protocols/change_bucket_request.dart' as _i41;
import 'protocols/check_model.dart' as _i42;
import 'protocols/check_organization_response.dart' as _i43;
import 'protocols/check_username_response.dart' as _i44;
import 'protocols/comment_model.dart' as _i45;
import 'protocols/get_add_ticket_data_response.dart' as _i46;
import 'protocols/get_all_tickets_response.dart' as _i47;
import 'protocols/get_attendance_data_response.dart' as _i48;
import 'protocols/get_planner_activities_response.dart' as _i49;
import 'protocols/get_planner_data_response.dart' as _i50;
import 'protocols/get_ticket_comments_response.dart' as _i51;
import 'protocols/get_ticket_data_response.dart' as _i52;
import 'protocols/get_ticket_thread_response.dart' as _i53;
import 'protocols/planner_assignee.dart' as _i54;
import 'protocols/planner_bucket.dart' as _i55;
import 'protocols/planner_ticket.dart' as _i56;
import 'protocols/priority_model.dart' as _i57;
import 'protocols/register_admin_response.dart' as _i58;
import 'protocols/sign_in_response.dart' as _i59;
import 'protocols/status_model.dart' as _i60;
import 'protocols/thread_item_model.dart' as _i61;
import 'protocols/ticket_attachment_dto.dart' as _i62;
import 'protocols/ticket_model.dart' as _i63;
import 'protocols/type_model.dart' as _i64;
import 'protocols/user_model.dart' as _i65;
import 'package:crewboard_client/src/protocol/entities/planner_app.dart'
    as _i66;
import 'package:crewboard_client/src/protocol/entities/user.dart' as _i67;
import 'package:crewboard_client/src/protocol/entities/user_types.dart' as _i68;
import 'package:crewboard_client/src/protocol/entities/attendance.dart' as _i69;
import 'package:crewboard_client/src/protocol/entities/leave_config.dart'
    as _i70;
import 'package:crewboard_client/src/protocol/entities/system_color.dart'
    as _i71;
import 'package:crewboard_client/src/protocol/entities/chat_room.dart' as _i72;
import 'package:crewboard_client/src/protocol/entities/chat_message.dart'
    as _i73;
import 'package:crewboard_client/src/protocol/entities/flow_model.dart' as _i74;
import 'package:crewboard_client/src/protocol/entities/doc.dart' as _i75;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i76;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i77;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i78;
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
export 'entities/planner_activity.dart';
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
export 'entities/ticket_view.dart';
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
export 'protocols/get_planner_activities_response.dart';
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
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

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

    if (t == _i2.Attendance) {
      return _i2.Attendance.fromJson(data) as T;
    }
    if (t == _i3.Bucket) {
      return _i3.Bucket.fromJson(data) as T;
    }
    if (t == _i4.BucketTicketMap) {
      return _i4.BucketTicketMap.fromJson(data) as T;
    }
    if (t == _i5.ChatMessage) {
      return _i5.ChatMessage.fromJson(data) as T;
    }
    if (t == _i6.ChatRoom) {
      return _i6.ChatRoom.fromJson(data) as T;
    }
    if (t == _i7.Doc) {
      return _i7.Doc.fromJson(data) as T;
    }
    if (t == _i8.FlowModel) {
      return _i8.FlowModel.fromJson(data) as T;
    }
    if (t == _i9.LeaveConfig) {
      return _i9.LeaveConfig.fromJson(data) as T;
    }
    if (t == _i10.LeaveRequest) {
      return _i10.LeaveRequest.fromJson(data) as T;
    }
    if (t == _i11.Memory) {
      return _i11.Memory.fromJson(data) as T;
    }
    if (t == _i12.Organization) {
      return _i12.Organization.fromJson(data) as T;
    }
    if (t == _i13.PlannerActivity) {
      return _i13.PlannerActivity.fromJson(data) as T;
    }
    if (t == _i14.PlannerApp) {
      return _i14.PlannerApp.fromJson(data) as T;
    }
    if (t == _i15.PlannerNotification) {
      return _i15.PlannerNotification.fromJson(data) as T;
    }
    if (t == _i16.Priority) {
      return _i16.Priority.fromJson(data) as T;
    }
    if (t == _i17.Status) {
      return _i17.Status.fromJson(data) as T;
    }
    if (t == _i18.SystemColor) {
      return _i18.SystemColor.fromJson(data) as T;
    }
    if (t == _i19.SystemVariables) {
      return _i19.SystemVariables.fromJson(data) as T;
    }
    if (t == _i20.Ticket) {
      return _i20.Ticket.fromJson(data) as T;
    }
    if (t == _i21.TicketAssignee) {
      return _i21.TicketAssignee.fromJson(data) as T;
    }
    if (t == _i22.TicketAttachment) {
      return _i22.TicketAttachment.fromJson(data) as T;
    }
    if (t == _i23.TicketComment) {
      return _i23.TicketComment.fromJson(data) as T;
    }
    if (t == _i24.TicketStatusChange) {
      return _i24.TicketStatusChange.fromJson(data) as T;
    }
    if (t == _i25.TicketType) {
      return _i25.TicketType.fromJson(data) as T;
    }
    if (t == _i26.TicketView) {
      return _i26.TicketView.fromJson(data) as T;
    }
    if (t == _i27.User) {
      return _i27.User.fromJson(data) as T;
    }
    if (t == _i28.UserBreak) {
      return _i28.UserBreak.fromJson(data) as T;
    }
    if (t == _i29.UserDevice) {
      return _i29.UserDevice.fromJson(data) as T;
    }
    if (t == _i30.UserRoomMap) {
      return _i30.UserRoomMap.fromJson(data) as T;
    }
    if (t == _i31.UserTypes) {
      return _i31.UserTypes.fromJson(data) as T;
    }
    if (t == _i32.DeviceType) {
      return _i32.DeviceType.fromJson(data) as T;
    }
    if (t == _i33.MessageType) {
      return _i33.MessageType.fromJson(data) as T;
    }
    if (t == _i34.Greeting) {
      return _i34.Greeting.fromJson(data) as T;
    }
    if (t == _i35.AddBucketRequest) {
      return _i35.AddBucketRequest.fromJson(data) as T;
    }
    if (t == _i36.AddCommentRequest) {
      return _i36.AddCommentRequest.fromJson(data) as T;
    }
    if (t == _i37.AddTicketDTO) {
      return _i37.AddTicketDTO.fromJson(data) as T;
    }
    if (t == _i38.AddTicketRequest) {
      return _i38.AddTicketRequest.fromJson(data) as T;
    }
    if (t == _i39.AttachmentModel) {
      return _i39.AttachmentModel.fromJson(data) as T;
    }
    if (t == _i40.BucketModel) {
      return _i40.BucketModel.fromJson(data) as T;
    }
    if (t == _i41.ChangeBucketRequest) {
      return _i41.ChangeBucketRequest.fromJson(data) as T;
    }
    if (t == _i42.CheckModel) {
      return _i42.CheckModel.fromJson(data) as T;
    }
    if (t == _i43.CheckOrganizationResponse) {
      return _i43.CheckOrganizationResponse.fromJson(data) as T;
    }
    if (t == _i44.CheckUsernameResponse) {
      return _i44.CheckUsernameResponse.fromJson(data) as T;
    }
    if (t == _i45.CommentModel) {
      return _i45.CommentModel.fromJson(data) as T;
    }
    if (t == _i46.GetAddTicketDataResponse) {
      return _i46.GetAddTicketDataResponse.fromJson(data) as T;
    }
    if (t == _i47.GetAllTicketsResponse) {
      return _i47.GetAllTicketsResponse.fromJson(data) as T;
    }
    if (t == _i48.GetAttendanceDataResponse) {
      return _i48.GetAttendanceDataResponse.fromJson(data) as T;
    }
    if (t == _i49.GetPlannerActivitiesResponse) {
      return _i49.GetPlannerActivitiesResponse.fromJson(data) as T;
    }
    if (t == _i50.GetPlannerDataResponse) {
      return _i50.GetPlannerDataResponse.fromJson(data) as T;
    }
    if (t == _i51.GetTicketCommentsResponse) {
      return _i51.GetTicketCommentsResponse.fromJson(data) as T;
    }
    if (t == _i52.GetTicketDataResponse) {
      return _i52.GetTicketDataResponse.fromJson(data) as T;
    }
    if (t == _i53.GetTicketThreadResponse) {
      return _i53.GetTicketThreadResponse.fromJson(data) as T;
    }
    if (t == _i54.PlannerAssignee) {
      return _i54.PlannerAssignee.fromJson(data) as T;
    }
    if (t == _i55.PlannerBucket) {
      return _i55.PlannerBucket.fromJson(data) as T;
    }
    if (t == _i56.PlannerTicket) {
      return _i56.PlannerTicket.fromJson(data) as T;
    }
    if (t == _i57.PriorityModel) {
      return _i57.PriorityModel.fromJson(data) as T;
    }
    if (t == _i58.RegisterAdminResponse) {
      return _i58.RegisterAdminResponse.fromJson(data) as T;
    }
    if (t == _i59.SignInResponse) {
      return _i59.SignInResponse.fromJson(data) as T;
    }
    if (t == _i60.StatusModel) {
      return _i60.StatusModel.fromJson(data) as T;
    }
    if (t == _i61.ThreadItemModel) {
      return _i61.ThreadItemModel.fromJson(data) as T;
    }
    if (t == _i62.TicketAttachmentDTO) {
      return _i62.TicketAttachmentDTO.fromJson(data) as T;
    }
    if (t == _i63.TicketModel) {
      return _i63.TicketModel.fromJson(data) as T;
    }
    if (t == _i64.TypeModel) {
      return _i64.TypeModel.fromJson(data) as T;
    }
    if (t == _i65.UserModel) {
      return _i65.UserModel.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Attendance?>()) {
      return (data != null ? _i2.Attendance.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Bucket?>()) {
      return (data != null ? _i3.Bucket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.BucketTicketMap?>()) {
      return (data != null ? _i4.BucketTicketMap.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ChatMessage?>()) {
      return (data != null ? _i5.ChatMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ChatRoom?>()) {
      return (data != null ? _i6.ChatRoom.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Doc?>()) {
      return (data != null ? _i7.Doc.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.FlowModel?>()) {
      return (data != null ? _i8.FlowModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.LeaveConfig?>()) {
      return (data != null ? _i9.LeaveConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.LeaveRequest?>()) {
      return (data != null ? _i10.LeaveRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Memory?>()) {
      return (data != null ? _i11.Memory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Organization?>()) {
      return (data != null ? _i12.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.PlannerActivity?>()) {
      return (data != null ? _i13.PlannerActivity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.PlannerApp?>()) {
      return (data != null ? _i14.PlannerApp.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.PlannerNotification?>()) {
      return (data != null ? _i15.PlannerNotification.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.Priority?>()) {
      return (data != null ? _i16.Priority.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Status?>()) {
      return (data != null ? _i17.Status.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.SystemColor?>()) {
      return (data != null ? _i18.SystemColor.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.SystemVariables?>()) {
      return (data != null ? _i19.SystemVariables.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.Ticket?>()) {
      return (data != null ? _i20.Ticket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.TicketAssignee?>()) {
      return (data != null ? _i21.TicketAssignee.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.TicketAttachment?>()) {
      return (data != null ? _i22.TicketAttachment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.TicketComment?>()) {
      return (data != null ? _i23.TicketComment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.TicketStatusChange?>()) {
      return (data != null ? _i24.TicketStatusChange.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.TicketType?>()) {
      return (data != null ? _i25.TicketType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.TicketView?>()) {
      return (data != null ? _i26.TicketView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.User?>()) {
      return (data != null ? _i27.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.UserBreak?>()) {
      return (data != null ? _i28.UserBreak.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.UserDevice?>()) {
      return (data != null ? _i29.UserDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.UserRoomMap?>()) {
      return (data != null ? _i30.UserRoomMap.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.UserTypes?>()) {
      return (data != null ? _i31.UserTypes.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.DeviceType?>()) {
      return (data != null ? _i32.DeviceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.MessageType?>()) {
      return (data != null ? _i33.MessageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.Greeting?>()) {
      return (data != null ? _i34.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.AddBucketRequest?>()) {
      return (data != null ? _i35.AddBucketRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.AddCommentRequest?>()) {
      return (data != null ? _i36.AddCommentRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.AddTicketDTO?>()) {
      return (data != null ? _i37.AddTicketDTO.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.AddTicketRequest?>()) {
      return (data != null ? _i38.AddTicketRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.AttachmentModel?>()) {
      return (data != null ? _i39.AttachmentModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.BucketModel?>()) {
      return (data != null ? _i40.BucketModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.ChangeBucketRequest?>()) {
      return (data != null ? _i41.ChangeBucketRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i42.CheckModel?>()) {
      return (data != null ? _i42.CheckModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.CheckOrganizationResponse?>()) {
      return (data != null
              ? _i43.CheckOrganizationResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i44.CheckUsernameResponse?>()) {
      return (data != null ? _i44.CheckUsernameResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i45.CommentModel?>()) {
      return (data != null ? _i45.CommentModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.GetAddTicketDataResponse?>()) {
      return (data != null
              ? _i46.GetAddTicketDataResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i47.GetAllTicketsResponse?>()) {
      return (data != null ? _i47.GetAllTicketsResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i48.GetAttendanceDataResponse?>()) {
      return (data != null
              ? _i48.GetAttendanceDataResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i49.GetPlannerActivitiesResponse?>()) {
      return (data != null
              ? _i49.GetPlannerActivitiesResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i50.GetPlannerDataResponse?>()) {
      return (data != null ? _i50.GetPlannerDataResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i51.GetTicketCommentsResponse?>()) {
      return (data != null
              ? _i51.GetTicketCommentsResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i52.GetTicketDataResponse?>()) {
      return (data != null ? _i52.GetTicketDataResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i53.GetTicketThreadResponse?>()) {
      return (data != null ? _i53.GetTicketThreadResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.PlannerAssignee?>()) {
      return (data != null ? _i54.PlannerAssignee.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.PlannerBucket?>()) {
      return (data != null ? _i55.PlannerBucket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.PlannerTicket?>()) {
      return (data != null ? _i56.PlannerTicket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.PriorityModel?>()) {
      return (data != null ? _i57.PriorityModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.RegisterAdminResponse?>()) {
      return (data != null ? _i58.RegisterAdminResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i59.SignInResponse?>()) {
      return (data != null ? _i59.SignInResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.StatusModel?>()) {
      return (data != null ? _i60.StatusModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.ThreadItemModel?>()) {
      return (data != null ? _i61.ThreadItemModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.TicketAttachmentDTO?>()) {
      return (data != null ? _i62.TicketAttachmentDTO.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i63.TicketModel?>()) {
      return (data != null ? _i63.TicketModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.TypeModel?>()) {
      return (data != null ? _i64.TypeModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.UserModel?>()) {
      return (data != null ? _i65.UserModel.fromJson(data) : null) as T;
    }
    if (t == List<_i1.UuidValue>) {
      return (data as List).map((e) => deserialize<_i1.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<_i42.CheckModel>) {
      return (data as List).map((e) => deserialize<_i42.CheckModel>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<_i42.CheckModel>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i42.CheckModel>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i62.TicketAttachmentDTO>) {
      return (data as List)
              .map((e) => deserialize<_i62.TicketAttachmentDTO>(e))
              .toList()
          as T;
    }
    if (t == List<_i54.PlannerAssignee>) {
      return (data as List)
              .map((e) => deserialize<_i54.PlannerAssignee>(e))
              .toList()
          as T;
    }
    if (t == List<_i56.PlannerTicket>) {
      return (data as List)
              .map((e) => deserialize<_i56.PlannerTicket>(e))
              .toList()
          as T;
    }
    if (t == List<_i65.UserModel>) {
      return (data as List).map((e) => deserialize<_i65.UserModel>(e)).toList()
          as T;
    }
    if (t == List<_i60.StatusModel>) {
      return (data as List)
              .map((e) => deserialize<_i60.StatusModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i57.PriorityModel>) {
      return (data as List)
              .map((e) => deserialize<_i57.PriorityModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i64.TypeModel>) {
      return (data as List).map((e) => deserialize<_i64.TypeModel>(e)).toList()
          as T;
    }
    if (t == List<_i8.FlowModel>) {
      return (data as List).map((e) => deserialize<_i8.FlowModel>(e)).toList()
          as T;
    }
    if (t == List<_i27.User>) {
      return (data as List).map((e) => deserialize<_i27.User>(e)).toList() as T;
    }
    if (t == List<_i2.Attendance>) {
      return (data as List).map((e) => deserialize<_i2.Attendance>(e)).toList()
          as T;
    }
    if (t == List<_i9.LeaveConfig>) {
      return (data as List).map((e) => deserialize<_i9.LeaveConfig>(e)).toList()
          as T;
    }
    if (t == List<_i10.LeaveRequest>) {
      return (data as List)
              .map((e) => deserialize<_i10.LeaveRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.PlannerActivity>) {
      return (data as List)
              .map((e) => deserialize<_i13.PlannerActivity>(e))
              .toList()
          as T;
    }
    if (t == List<_i40.BucketModel>) {
      return (data as List)
              .map((e) => deserialize<_i40.BucketModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i45.CommentModel>) {
      return (data as List)
              .map((e) => deserialize<_i45.CommentModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i61.ThreadItemModel>) {
      return (data as List)
              .map((e) => deserialize<_i61.ThreadItemModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i39.AttachmentModel>) {
      return (data as List)
              .map((e) => deserialize<_i39.AttachmentModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i66.PlannerApp>) {
      return (data as List).map((e) => deserialize<_i66.PlannerApp>(e)).toList()
          as T;
    }
    if (t == List<_i67.User>) {
      return (data as List).map((e) => deserialize<_i67.User>(e)).toList() as T;
    }
    if (t == List<_i68.UserTypes>) {
      return (data as List).map((e) => deserialize<_i68.UserTypes>(e)).toList()
          as T;
    }
    if (t == List<_i69.Attendance>) {
      return (data as List).map((e) => deserialize<_i69.Attendance>(e)).toList()
          as T;
    }
    if (t == List<_i70.LeaveConfig>) {
      return (data as List)
              .map((e) => deserialize<_i70.LeaveConfig>(e))
              .toList()
          as T;
    }
    if (t == List<_i71.SystemColor>) {
      return (data as List)
              .map((e) => deserialize<_i71.SystemColor>(e))
              .toList()
          as T;
    }
    if (t == List<_i72.ChatRoom>) {
      return (data as List).map((e) => deserialize<_i72.ChatRoom>(e)).toList()
          as T;
    }
    if (t == List<_i73.ChatMessage>) {
      return (data as List)
              .map((e) => deserialize<_i73.ChatMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_i74.FlowModel>) {
      return (data as List).map((e) => deserialize<_i74.FlowModel>(e)).toList()
          as T;
    }
    if (t == List<_i75.Doc>) {
      return (data as List).map((e) => deserialize<_i75.Doc>(e)).toList() as T;
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
      return _i76.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i77.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i78.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Attendance => 'Attendance',
      _i3.Bucket => 'Bucket',
      _i4.BucketTicketMap => 'BucketTicketMap',
      _i5.ChatMessage => 'ChatMessage',
      _i6.ChatRoom => 'ChatRoom',
      _i7.Doc => 'Doc',
      _i8.FlowModel => 'FlowModel',
      _i9.LeaveConfig => 'LeaveConfig',
      _i10.LeaveRequest => 'LeaveRequest',
      _i11.Memory => 'Memory',
      _i12.Organization => 'Organization',
      _i13.PlannerActivity => 'PlannerActivity',
      _i14.PlannerApp => 'PlannerApp',
      _i15.PlannerNotification => 'PlannerNotification',
      _i16.Priority => 'Priority',
      _i17.Status => 'Status',
      _i18.SystemColor => 'SystemColor',
      _i19.SystemVariables => 'SystemVariables',
      _i20.Ticket => 'Ticket',
      _i21.TicketAssignee => 'TicketAssignee',
      _i22.TicketAttachment => 'TicketAttachment',
      _i23.TicketComment => 'TicketComment',
      _i24.TicketStatusChange => 'TicketStatusChange',
      _i25.TicketType => 'TicketType',
      _i26.TicketView => 'TicketView',
      _i27.User => 'User',
      _i28.UserBreak => 'UserBreak',
      _i29.UserDevice => 'UserDevice',
      _i30.UserRoomMap => 'UserRoomMap',
      _i31.UserTypes => 'UserTypes',
      _i32.DeviceType => 'DeviceType',
      _i33.MessageType => 'MessageType',
      _i34.Greeting => 'Greeting',
      _i35.AddBucketRequest => 'AddBucketRequest',
      _i36.AddCommentRequest => 'AddCommentRequest',
      _i37.AddTicketDTO => 'AddTicketDTO',
      _i38.AddTicketRequest => 'AddTicketRequest',
      _i39.AttachmentModel => 'AttachmentModel',
      _i40.BucketModel => 'BucketModel',
      _i41.ChangeBucketRequest => 'ChangeBucketRequest',
      _i42.CheckModel => 'CheckModel',
      _i43.CheckOrganizationResponse => 'CheckOrganizationResponse',
      _i44.CheckUsernameResponse => 'CheckUsernameResponse',
      _i45.CommentModel => 'CommentModel',
      _i46.GetAddTicketDataResponse => 'GetAddTicketDataResponse',
      _i47.GetAllTicketsResponse => 'GetAllTicketsResponse',
      _i48.GetAttendanceDataResponse => 'GetAttendanceDataResponse',
      _i49.GetPlannerActivitiesResponse => 'GetPlannerActivitiesResponse',
      _i50.GetPlannerDataResponse => 'GetPlannerDataResponse',
      _i51.GetTicketCommentsResponse => 'GetTicketCommentsResponse',
      _i52.GetTicketDataResponse => 'GetTicketDataResponse',
      _i53.GetTicketThreadResponse => 'GetTicketThreadResponse',
      _i54.PlannerAssignee => 'PlannerAssignee',
      _i55.PlannerBucket => 'PlannerBucket',
      _i56.PlannerTicket => 'PlannerTicket',
      _i57.PriorityModel => 'PriorityModel',
      _i58.RegisterAdminResponse => 'RegisterAdminResponse',
      _i59.SignInResponse => 'SignInResponse',
      _i60.StatusModel => 'StatusModel',
      _i61.ThreadItemModel => 'ThreadItemModel',
      _i62.TicketAttachmentDTO => 'TicketAttachmentDTO',
      _i63.TicketModel => 'TicketModel',
      _i64.TypeModel => 'TypeModel',
      _i65.UserModel => 'UserModel',
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
      case _i2.Attendance():
        return 'Attendance';
      case _i3.Bucket():
        return 'Bucket';
      case _i4.BucketTicketMap():
        return 'BucketTicketMap';
      case _i5.ChatMessage():
        return 'ChatMessage';
      case _i6.ChatRoom():
        return 'ChatRoom';
      case _i7.Doc():
        return 'Doc';
      case _i8.FlowModel():
        return 'FlowModel';
      case _i9.LeaveConfig():
        return 'LeaveConfig';
      case _i10.LeaveRequest():
        return 'LeaveRequest';
      case _i11.Memory():
        return 'Memory';
      case _i12.Organization():
        return 'Organization';
      case _i13.PlannerActivity():
        return 'PlannerActivity';
      case _i14.PlannerApp():
        return 'PlannerApp';
      case _i15.PlannerNotification():
        return 'PlannerNotification';
      case _i16.Priority():
        return 'Priority';
      case _i17.Status():
        return 'Status';
      case _i18.SystemColor():
        return 'SystemColor';
      case _i19.SystemVariables():
        return 'SystemVariables';
      case _i20.Ticket():
        return 'Ticket';
      case _i21.TicketAssignee():
        return 'TicketAssignee';
      case _i22.TicketAttachment():
        return 'TicketAttachment';
      case _i23.TicketComment():
        return 'TicketComment';
      case _i24.TicketStatusChange():
        return 'TicketStatusChange';
      case _i25.TicketType():
        return 'TicketType';
      case _i26.TicketView():
        return 'TicketView';
      case _i27.User():
        return 'User';
      case _i28.UserBreak():
        return 'UserBreak';
      case _i29.UserDevice():
        return 'UserDevice';
      case _i30.UserRoomMap():
        return 'UserRoomMap';
      case _i31.UserTypes():
        return 'UserTypes';
      case _i32.DeviceType():
        return 'DeviceType';
      case _i33.MessageType():
        return 'MessageType';
      case _i34.Greeting():
        return 'Greeting';
      case _i35.AddBucketRequest():
        return 'AddBucketRequest';
      case _i36.AddCommentRequest():
        return 'AddCommentRequest';
      case _i37.AddTicketDTO():
        return 'AddTicketDTO';
      case _i38.AddTicketRequest():
        return 'AddTicketRequest';
      case _i39.AttachmentModel():
        return 'AttachmentModel';
      case _i40.BucketModel():
        return 'BucketModel';
      case _i41.ChangeBucketRequest():
        return 'ChangeBucketRequest';
      case _i42.CheckModel():
        return 'CheckModel';
      case _i43.CheckOrganizationResponse():
        return 'CheckOrganizationResponse';
      case _i44.CheckUsernameResponse():
        return 'CheckUsernameResponse';
      case _i45.CommentModel():
        return 'CommentModel';
      case _i46.GetAddTicketDataResponse():
        return 'GetAddTicketDataResponse';
      case _i47.GetAllTicketsResponse():
        return 'GetAllTicketsResponse';
      case _i48.GetAttendanceDataResponse():
        return 'GetAttendanceDataResponse';
      case _i49.GetPlannerActivitiesResponse():
        return 'GetPlannerActivitiesResponse';
      case _i50.GetPlannerDataResponse():
        return 'GetPlannerDataResponse';
      case _i51.GetTicketCommentsResponse():
        return 'GetTicketCommentsResponse';
      case _i52.GetTicketDataResponse():
        return 'GetTicketDataResponse';
      case _i53.GetTicketThreadResponse():
        return 'GetTicketThreadResponse';
      case _i54.PlannerAssignee():
        return 'PlannerAssignee';
      case _i55.PlannerBucket():
        return 'PlannerBucket';
      case _i56.PlannerTicket():
        return 'PlannerTicket';
      case _i57.PriorityModel():
        return 'PriorityModel';
      case _i58.RegisterAdminResponse():
        return 'RegisterAdminResponse';
      case _i59.SignInResponse():
        return 'SignInResponse';
      case _i60.StatusModel():
        return 'StatusModel';
      case _i61.ThreadItemModel():
        return 'ThreadItemModel';
      case _i62.TicketAttachmentDTO():
        return 'TicketAttachmentDTO';
      case _i63.TicketModel():
        return 'TicketModel';
      case _i64.TypeModel():
        return 'TypeModel';
      case _i65.UserModel():
        return 'UserModel';
    }
    className = _i76.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i77.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    className = _i78.Protocol().getClassNameForObject(data);
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
      return deserialize<_i2.Attendance>(data['data']);
    }
    if (dataClassName == 'Bucket') {
      return deserialize<_i3.Bucket>(data['data']);
    }
    if (dataClassName == 'BucketTicketMap') {
      return deserialize<_i4.BucketTicketMap>(data['data']);
    }
    if (dataClassName == 'ChatMessage') {
      return deserialize<_i5.ChatMessage>(data['data']);
    }
    if (dataClassName == 'ChatRoom') {
      return deserialize<_i6.ChatRoom>(data['data']);
    }
    if (dataClassName == 'Doc') {
      return deserialize<_i7.Doc>(data['data']);
    }
    if (dataClassName == 'FlowModel') {
      return deserialize<_i8.FlowModel>(data['data']);
    }
    if (dataClassName == 'LeaveConfig') {
      return deserialize<_i9.LeaveConfig>(data['data']);
    }
    if (dataClassName == 'LeaveRequest') {
      return deserialize<_i10.LeaveRequest>(data['data']);
    }
    if (dataClassName == 'Memory') {
      return deserialize<_i11.Memory>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i12.Organization>(data['data']);
    }
    if (dataClassName == 'PlannerActivity') {
      return deserialize<_i13.PlannerActivity>(data['data']);
    }
    if (dataClassName == 'PlannerApp') {
      return deserialize<_i14.PlannerApp>(data['data']);
    }
    if (dataClassName == 'PlannerNotification') {
      return deserialize<_i15.PlannerNotification>(data['data']);
    }
    if (dataClassName == 'Priority') {
      return deserialize<_i16.Priority>(data['data']);
    }
    if (dataClassName == 'Status') {
      return deserialize<_i17.Status>(data['data']);
    }
    if (dataClassName == 'SystemColor') {
      return deserialize<_i18.SystemColor>(data['data']);
    }
    if (dataClassName == 'SystemVariables') {
      return deserialize<_i19.SystemVariables>(data['data']);
    }
    if (dataClassName == 'Ticket') {
      return deserialize<_i20.Ticket>(data['data']);
    }
    if (dataClassName == 'TicketAssignee') {
      return deserialize<_i21.TicketAssignee>(data['data']);
    }
    if (dataClassName == 'TicketAttachment') {
      return deserialize<_i22.TicketAttachment>(data['data']);
    }
    if (dataClassName == 'TicketComment') {
      return deserialize<_i23.TicketComment>(data['data']);
    }
    if (dataClassName == 'TicketStatusChange') {
      return deserialize<_i24.TicketStatusChange>(data['data']);
    }
    if (dataClassName == 'TicketType') {
      return deserialize<_i25.TicketType>(data['data']);
    }
    if (dataClassName == 'TicketView') {
      return deserialize<_i26.TicketView>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i27.User>(data['data']);
    }
    if (dataClassName == 'UserBreak') {
      return deserialize<_i28.UserBreak>(data['data']);
    }
    if (dataClassName == 'UserDevice') {
      return deserialize<_i29.UserDevice>(data['data']);
    }
    if (dataClassName == 'UserRoomMap') {
      return deserialize<_i30.UserRoomMap>(data['data']);
    }
    if (dataClassName == 'UserTypes') {
      return deserialize<_i31.UserTypes>(data['data']);
    }
    if (dataClassName == 'DeviceType') {
      return deserialize<_i32.DeviceType>(data['data']);
    }
    if (dataClassName == 'MessageType') {
      return deserialize<_i33.MessageType>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i34.Greeting>(data['data']);
    }
    if (dataClassName == 'AddBucketRequest') {
      return deserialize<_i35.AddBucketRequest>(data['data']);
    }
    if (dataClassName == 'AddCommentRequest') {
      return deserialize<_i36.AddCommentRequest>(data['data']);
    }
    if (dataClassName == 'AddTicketDTO') {
      return deserialize<_i37.AddTicketDTO>(data['data']);
    }
    if (dataClassName == 'AddTicketRequest') {
      return deserialize<_i38.AddTicketRequest>(data['data']);
    }
    if (dataClassName == 'AttachmentModel') {
      return deserialize<_i39.AttachmentModel>(data['data']);
    }
    if (dataClassName == 'BucketModel') {
      return deserialize<_i40.BucketModel>(data['data']);
    }
    if (dataClassName == 'ChangeBucketRequest') {
      return deserialize<_i41.ChangeBucketRequest>(data['data']);
    }
    if (dataClassName == 'CheckModel') {
      return deserialize<_i42.CheckModel>(data['data']);
    }
    if (dataClassName == 'CheckOrganizationResponse') {
      return deserialize<_i43.CheckOrganizationResponse>(data['data']);
    }
    if (dataClassName == 'CheckUsernameResponse') {
      return deserialize<_i44.CheckUsernameResponse>(data['data']);
    }
    if (dataClassName == 'CommentModel') {
      return deserialize<_i45.CommentModel>(data['data']);
    }
    if (dataClassName == 'GetAddTicketDataResponse') {
      return deserialize<_i46.GetAddTicketDataResponse>(data['data']);
    }
    if (dataClassName == 'GetAllTicketsResponse') {
      return deserialize<_i47.GetAllTicketsResponse>(data['data']);
    }
    if (dataClassName == 'GetAttendanceDataResponse') {
      return deserialize<_i48.GetAttendanceDataResponse>(data['data']);
    }
    if (dataClassName == 'GetPlannerActivitiesResponse') {
      return deserialize<_i49.GetPlannerActivitiesResponse>(data['data']);
    }
    if (dataClassName == 'GetPlannerDataResponse') {
      return deserialize<_i50.GetPlannerDataResponse>(data['data']);
    }
    if (dataClassName == 'GetTicketCommentsResponse') {
      return deserialize<_i51.GetTicketCommentsResponse>(data['data']);
    }
    if (dataClassName == 'GetTicketDataResponse') {
      return deserialize<_i52.GetTicketDataResponse>(data['data']);
    }
    if (dataClassName == 'GetTicketThreadResponse') {
      return deserialize<_i53.GetTicketThreadResponse>(data['data']);
    }
    if (dataClassName == 'PlannerAssignee') {
      return deserialize<_i54.PlannerAssignee>(data['data']);
    }
    if (dataClassName == 'PlannerBucket') {
      return deserialize<_i55.PlannerBucket>(data['data']);
    }
    if (dataClassName == 'PlannerTicket') {
      return deserialize<_i56.PlannerTicket>(data['data']);
    }
    if (dataClassName == 'PriorityModel') {
      return deserialize<_i57.PriorityModel>(data['data']);
    }
    if (dataClassName == 'RegisterAdminResponse') {
      return deserialize<_i58.RegisterAdminResponse>(data['data']);
    }
    if (dataClassName == 'SignInResponse') {
      return deserialize<_i59.SignInResponse>(data['data']);
    }
    if (dataClassName == 'StatusModel') {
      return deserialize<_i60.StatusModel>(data['data']);
    }
    if (dataClassName == 'ThreadItemModel') {
      return deserialize<_i61.ThreadItemModel>(data['data']);
    }
    if (dataClassName == 'TicketAttachmentDTO') {
      return deserialize<_i62.TicketAttachmentDTO>(data['data']);
    }
    if (dataClassName == 'TicketModel') {
      return deserialize<_i63.TicketModel>(data['data']);
    }
    if (dataClassName == 'TypeModel') {
      return deserialize<_i64.TypeModel>(data['data']);
    }
    if (dataClassName == 'UserModel') {
      return deserialize<_i65.UserModel>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i76.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i77.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i78.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
