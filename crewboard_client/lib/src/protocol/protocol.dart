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
import 'add_bucket_request.dart' as _i2;
import 'add_comment_request.dart' as _i3;
import 'add_ticket_dto.dart' as _i4;
import 'add_ticket_request.dart' as _i5;
import 'attachment_model.dart' as _i6;
import 'attendance.dart' as _i7;
import 'bucket.dart' as _i8;
import 'bucket_model.dart' as _i9;
import 'bucket_ticket_map.dart' as _i10;
import 'change_bucket_request.dart' as _i11;
import 'chat_message.dart' as _i12;
import 'chat_room.dart' as _i13;
import 'check_model.dart' as _i14;
import 'check_organization_response.dart' as _i15;
import 'check_username_response.dart' as _i16;
import 'comment_model.dart' as _i17;
import 'device_type.dart' as _i18;
import 'flow_model.dart' as _i19;
import 'get_add_ticket_data_response.dart' as _i20;
import 'get_all_tickets_response.dart' as _i21;
import 'get_planner_data_response.dart' as _i22;
import 'get_ticket_comments_response.dart' as _i23;
import 'get_ticket_data_response.dart' as _i24;
import 'greetings/greeting.dart' as _i25;
import 'leave_config.dart' as _i26;
import 'leave_request.dart' as _i27;
import 'message_type.dart' as _i28;
import 'organization.dart' as _i29;
import 'planner_app.dart' as _i30;
import 'planner_assignee.dart' as _i31;
import 'planner_bucket.dart' as _i32;
import 'planner_notification.dart' as _i33;
import 'planner_ticket.dart' as _i34;
import 'priority.dart' as _i35;
import 'priority_model.dart' as _i36;
import 'register_admin_response.dart' as _i37;
import 'sign_in_response.dart' as _i38;
import 'status.dart' as _i39;
import 'status_model.dart' as _i40;
import 'system_color.dart' as _i41;
import 'ticket.dart' as _i42;
import 'ticket_assignee.dart' as _i43;
import 'ticket_attachment.dart' as _i44;
import 'ticket_attachment_dto.dart' as _i45;
import 'ticket_comment.dart' as _i46;
import 'ticket_model.dart' as _i47;
import 'ticket_status_change.dart' as _i48;
import 'ticket_type.dart' as _i49;
import 'type_model.dart' as _i50;
import 'user.dart' as _i51;
import 'user_break.dart' as _i52;
import 'user_device.dart' as _i53;
import 'user_model.dart' as _i54;
import 'user_room_map.dart' as _i55;
import 'user_types.dart' as _i56;
import 'package:crewboard_client/src/protocol/planner_app.dart' as _i57;
import 'package:crewboard_client/src/protocol/chat_room.dart' as _i58;
import 'package:crewboard_client/src/protocol/chat_message.dart' as _i59;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i60;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i61;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i62;
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
export 'flow_model.dart';
export 'get_add_ticket_data_response.dart';
export 'get_all_tickets_response.dart';
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

    if (t == _i2.AddBucketRequest) {
      return _i2.AddBucketRequest.fromJson(data) as T;
    }
    if (t == _i3.AddCommentRequest) {
      return _i3.AddCommentRequest.fromJson(data) as T;
    }
    if (t == _i4.AddTicketDTO) {
      return _i4.AddTicketDTO.fromJson(data) as T;
    }
    if (t == _i5.AddTicketRequest) {
      return _i5.AddTicketRequest.fromJson(data) as T;
    }
    if (t == _i6.AttachmentModel) {
      return _i6.AttachmentModel.fromJson(data) as T;
    }
    if (t == _i7.Attendance) {
      return _i7.Attendance.fromJson(data) as T;
    }
    if (t == _i8.Bucket) {
      return _i8.Bucket.fromJson(data) as T;
    }
    if (t == _i9.BucketModel) {
      return _i9.BucketModel.fromJson(data) as T;
    }
    if (t == _i10.BucketTicketMap) {
      return _i10.BucketTicketMap.fromJson(data) as T;
    }
    if (t == _i11.ChangeBucketRequest) {
      return _i11.ChangeBucketRequest.fromJson(data) as T;
    }
    if (t == _i12.ChatMessage) {
      return _i12.ChatMessage.fromJson(data) as T;
    }
    if (t == _i13.ChatRoom) {
      return _i13.ChatRoom.fromJson(data) as T;
    }
    if (t == _i14.CheckModel) {
      return _i14.CheckModel.fromJson(data) as T;
    }
    if (t == _i15.CheckOrganizationResponse) {
      return _i15.CheckOrganizationResponse.fromJson(data) as T;
    }
    if (t == _i16.CheckUsernameResponse) {
      return _i16.CheckUsernameResponse.fromJson(data) as T;
    }
    if (t == _i17.CommentModel) {
      return _i17.CommentModel.fromJson(data) as T;
    }
    if (t == _i18.DeviceType) {
      return _i18.DeviceType.fromJson(data) as T;
    }
    if (t == _i19.FlowModel) {
      return _i19.FlowModel.fromJson(data) as T;
    }
    if (t == _i20.GetAddTicketDataResponse) {
      return _i20.GetAddTicketDataResponse.fromJson(data) as T;
    }
    if (t == _i21.GetAllTicketsResponse) {
      return _i21.GetAllTicketsResponse.fromJson(data) as T;
    }
    if (t == _i22.GetPlannerDataResponse) {
      return _i22.GetPlannerDataResponse.fromJson(data) as T;
    }
    if (t == _i23.GetTicketCommentsResponse) {
      return _i23.GetTicketCommentsResponse.fromJson(data) as T;
    }
    if (t == _i24.GetTicketDataResponse) {
      return _i24.GetTicketDataResponse.fromJson(data) as T;
    }
    if (t == _i25.Greeting) {
      return _i25.Greeting.fromJson(data) as T;
    }
    if (t == _i26.LeaveConfig) {
      return _i26.LeaveConfig.fromJson(data) as T;
    }
    if (t == _i27.LeaveRequest) {
      return _i27.LeaveRequest.fromJson(data) as T;
    }
    if (t == _i28.MessageType) {
      return _i28.MessageType.fromJson(data) as T;
    }
    if (t == _i29.Organization) {
      return _i29.Organization.fromJson(data) as T;
    }
    if (t == _i30.PlannerApp) {
      return _i30.PlannerApp.fromJson(data) as T;
    }
    if (t == _i31.PlannerAssignee) {
      return _i31.PlannerAssignee.fromJson(data) as T;
    }
    if (t == _i32.PlannerBucket) {
      return _i32.PlannerBucket.fromJson(data) as T;
    }
    if (t == _i33.PlannerNotification) {
      return _i33.PlannerNotification.fromJson(data) as T;
    }
    if (t == _i34.PlannerTicket) {
      return _i34.PlannerTicket.fromJson(data) as T;
    }
    if (t == _i35.Priority) {
      return _i35.Priority.fromJson(data) as T;
    }
    if (t == _i36.PriorityModel) {
      return _i36.PriorityModel.fromJson(data) as T;
    }
    if (t == _i37.RegisterAdminResponse) {
      return _i37.RegisterAdminResponse.fromJson(data) as T;
    }
    if (t == _i38.SignInResponse) {
      return _i38.SignInResponse.fromJson(data) as T;
    }
    if (t == _i39.Status) {
      return _i39.Status.fromJson(data) as T;
    }
    if (t == _i40.StatusModel) {
      return _i40.StatusModel.fromJson(data) as T;
    }
    if (t == _i41.SystemColor) {
      return _i41.SystemColor.fromJson(data) as T;
    }
    if (t == _i42.Ticket) {
      return _i42.Ticket.fromJson(data) as T;
    }
    if (t == _i43.TicketAssignee) {
      return _i43.TicketAssignee.fromJson(data) as T;
    }
    if (t == _i44.TicketAttachment) {
      return _i44.TicketAttachment.fromJson(data) as T;
    }
    if (t == _i45.TicketAttachmentDTO) {
      return _i45.TicketAttachmentDTO.fromJson(data) as T;
    }
    if (t == _i46.TicketComment) {
      return _i46.TicketComment.fromJson(data) as T;
    }
    if (t == _i47.TicketModel) {
      return _i47.TicketModel.fromJson(data) as T;
    }
    if (t == _i48.TicketStatusChange) {
      return _i48.TicketStatusChange.fromJson(data) as T;
    }
    if (t == _i49.TicketType) {
      return _i49.TicketType.fromJson(data) as T;
    }
    if (t == _i50.TypeModel) {
      return _i50.TypeModel.fromJson(data) as T;
    }
    if (t == _i51.User) {
      return _i51.User.fromJson(data) as T;
    }
    if (t == _i52.UserBreak) {
      return _i52.UserBreak.fromJson(data) as T;
    }
    if (t == _i53.UserDevice) {
      return _i53.UserDevice.fromJson(data) as T;
    }
    if (t == _i54.UserModel) {
      return _i54.UserModel.fromJson(data) as T;
    }
    if (t == _i55.UserRoomMap) {
      return _i55.UserRoomMap.fromJson(data) as T;
    }
    if (t == _i56.UserTypes) {
      return _i56.UserTypes.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AddBucketRequest?>()) {
      return (data != null ? _i2.AddBucketRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AddCommentRequest?>()) {
      return (data != null ? _i3.AddCommentRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AddTicketDTO?>()) {
      return (data != null ? _i4.AddTicketDTO.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AddTicketRequest?>()) {
      return (data != null ? _i5.AddTicketRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AttachmentModel?>()) {
      return (data != null ? _i6.AttachmentModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Attendance?>()) {
      return (data != null ? _i7.Attendance.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Bucket?>()) {
      return (data != null ? _i8.Bucket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.BucketModel?>()) {
      return (data != null ? _i9.BucketModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.BucketTicketMap?>()) {
      return (data != null ? _i10.BucketTicketMap.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ChangeBucketRequest?>()) {
      return (data != null ? _i11.ChangeBucketRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.ChatMessage?>()) {
      return (data != null ? _i12.ChatMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.ChatRoom?>()) {
      return (data != null ? _i13.ChatRoom.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.CheckModel?>()) {
      return (data != null ? _i14.CheckModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.CheckOrganizationResponse?>()) {
      return (data != null
              ? _i15.CheckOrganizationResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i16.CheckUsernameResponse?>()) {
      return (data != null ? _i16.CheckUsernameResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.CommentModel?>()) {
      return (data != null ? _i17.CommentModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.DeviceType?>()) {
      return (data != null ? _i18.DeviceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.FlowModel?>()) {
      return (data != null ? _i19.FlowModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.GetAddTicketDataResponse?>()) {
      return (data != null
              ? _i20.GetAddTicketDataResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i21.GetAllTicketsResponse?>()) {
      return (data != null ? _i21.GetAllTicketsResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.GetPlannerDataResponse?>()) {
      return (data != null ? _i22.GetPlannerDataResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.GetTicketCommentsResponse?>()) {
      return (data != null
              ? _i23.GetTicketCommentsResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i24.GetTicketDataResponse?>()) {
      return (data != null ? _i24.GetTicketDataResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.Greeting?>()) {
      return (data != null ? _i25.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.LeaveConfig?>()) {
      return (data != null ? _i26.LeaveConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.LeaveRequest?>()) {
      return (data != null ? _i27.LeaveRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.MessageType?>()) {
      return (data != null ? _i28.MessageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.Organization?>()) {
      return (data != null ? _i29.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.PlannerApp?>()) {
      return (data != null ? _i30.PlannerApp.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.PlannerAssignee?>()) {
      return (data != null ? _i31.PlannerAssignee.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.PlannerBucket?>()) {
      return (data != null ? _i32.PlannerBucket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.PlannerNotification?>()) {
      return (data != null ? _i33.PlannerNotification.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i34.PlannerTicket?>()) {
      return (data != null ? _i34.PlannerTicket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.Priority?>()) {
      return (data != null ? _i35.Priority.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.PriorityModel?>()) {
      return (data != null ? _i36.PriorityModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.RegisterAdminResponse?>()) {
      return (data != null ? _i37.RegisterAdminResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i38.SignInResponse?>()) {
      return (data != null ? _i38.SignInResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.Status?>()) {
      return (data != null ? _i39.Status.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.StatusModel?>()) {
      return (data != null ? _i40.StatusModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.SystemColor?>()) {
      return (data != null ? _i41.SystemColor.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.Ticket?>()) {
      return (data != null ? _i42.Ticket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.TicketAssignee?>()) {
      return (data != null ? _i43.TicketAssignee.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.TicketAttachment?>()) {
      return (data != null ? _i44.TicketAttachment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.TicketAttachmentDTO?>()) {
      return (data != null ? _i45.TicketAttachmentDTO.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i46.TicketComment?>()) {
      return (data != null ? _i46.TicketComment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.TicketModel?>()) {
      return (data != null ? _i47.TicketModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.TicketStatusChange?>()) {
      return (data != null ? _i48.TicketStatusChange.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i49.TicketType?>()) {
      return (data != null ? _i49.TicketType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.TypeModel?>()) {
      return (data != null ? _i50.TypeModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.User?>()) {
      return (data != null ? _i51.User.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.UserBreak?>()) {
      return (data != null ? _i52.UserBreak.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.UserDevice?>()) {
      return (data != null ? _i53.UserDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.UserModel?>()) {
      return (data != null ? _i54.UserModel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.UserRoomMap?>()) {
      return (data != null ? _i55.UserRoomMap.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.UserTypes?>()) {
      return (data != null ? _i56.UserTypes.fromJson(data) : null) as T;
    }
    if (t == List<_i45.TicketAttachmentDTO>) {
      return (data as List)
              .map((e) => deserialize<_i45.TicketAttachmentDTO>(e))
              .toList()
          as T;
    }
    if (t == List<_i31.PlannerAssignee>) {
      return (data as List)
              .map((e) => deserialize<_i31.PlannerAssignee>(e))
              .toList()
          as T;
    }
    if (t == List<_i34.PlannerTicket>) {
      return (data as List)
              .map((e) => deserialize<_i34.PlannerTicket>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i54.UserModel>) {
      return (data as List).map((e) => deserialize<_i54.UserModel>(e)).toList()
          as T;
    }
    if (t == List<_i40.StatusModel>) {
      return (data as List)
              .map((e) => deserialize<_i40.StatusModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i36.PriorityModel>) {
      return (data as List)
              .map((e) => deserialize<_i36.PriorityModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i50.TypeModel>) {
      return (data as List).map((e) => deserialize<_i50.TypeModel>(e)).toList()
          as T;
    }
    if (t == List<_i19.FlowModel>) {
      return (data as List).map((e) => deserialize<_i19.FlowModel>(e)).toList()
          as T;
    }
    if (t == List<_i9.BucketModel>) {
      return (data as List).map((e) => deserialize<_i9.BucketModel>(e)).toList()
          as T;
    }
    if (t == List<_i17.CommentModel>) {
      return (data as List)
              .map((e) => deserialize<_i17.CommentModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i14.CheckModel>) {
      return (data as List).map((e) => deserialize<_i14.CheckModel>(e)).toList()
          as T;
    }
    if (t == List<_i6.AttachmentModel>) {
      return (data as List)
              .map((e) => deserialize<_i6.AttachmentModel>(e))
              .toList()
          as T;
    }
    if (t == List<_i57.PlannerApp>) {
      return (data as List).map((e) => deserialize<_i57.PlannerApp>(e)).toList()
          as T;
    }
    if (t == List<_i58.ChatRoom>) {
      return (data as List).map((e) => deserialize<_i58.ChatRoom>(e)).toList()
          as T;
    }
    if (t == List<_i59.ChatMessage>) {
      return (data as List)
              .map((e) => deserialize<_i59.ChatMessage>(e))
              .toList()
          as T;
    }
    try {
      return _i60.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i61.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i62.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AddBucketRequest => 'AddBucketRequest',
      _i3.AddCommentRequest => 'AddCommentRequest',
      _i4.AddTicketDTO => 'AddTicketDTO',
      _i5.AddTicketRequest => 'AddTicketRequest',
      _i6.AttachmentModel => 'AttachmentModel',
      _i7.Attendance => 'Attendance',
      _i8.Bucket => 'Bucket',
      _i9.BucketModel => 'BucketModel',
      _i10.BucketTicketMap => 'BucketTicketMap',
      _i11.ChangeBucketRequest => 'ChangeBucketRequest',
      _i12.ChatMessage => 'ChatMessage',
      _i13.ChatRoom => 'ChatRoom',
      _i14.CheckModel => 'CheckModel',
      _i15.CheckOrganizationResponse => 'CheckOrganizationResponse',
      _i16.CheckUsernameResponse => 'CheckUsernameResponse',
      _i17.CommentModel => 'CommentModel',
      _i18.DeviceType => 'DeviceType',
      _i19.FlowModel => 'FlowModel',
      _i20.GetAddTicketDataResponse => 'GetAddTicketDataResponse',
      _i21.GetAllTicketsResponse => 'GetAllTicketsResponse',
      _i22.GetPlannerDataResponse => 'GetPlannerDataResponse',
      _i23.GetTicketCommentsResponse => 'GetTicketCommentsResponse',
      _i24.GetTicketDataResponse => 'GetTicketDataResponse',
      _i25.Greeting => 'Greeting',
      _i26.LeaveConfig => 'LeaveConfig',
      _i27.LeaveRequest => 'LeaveRequest',
      _i28.MessageType => 'MessageType',
      _i29.Organization => 'Organization',
      _i30.PlannerApp => 'PlannerApp',
      _i31.PlannerAssignee => 'PlannerAssignee',
      _i32.PlannerBucket => 'PlannerBucket',
      _i33.PlannerNotification => 'PlannerNotification',
      _i34.PlannerTicket => 'PlannerTicket',
      _i35.Priority => 'Priority',
      _i36.PriorityModel => 'PriorityModel',
      _i37.RegisterAdminResponse => 'RegisterAdminResponse',
      _i38.SignInResponse => 'SignInResponse',
      _i39.Status => 'Status',
      _i40.StatusModel => 'StatusModel',
      _i41.SystemColor => 'SystemColor',
      _i42.Ticket => 'Ticket',
      _i43.TicketAssignee => 'TicketAssignee',
      _i44.TicketAttachment => 'TicketAttachment',
      _i45.TicketAttachmentDTO => 'TicketAttachmentDTO',
      _i46.TicketComment => 'TicketComment',
      _i47.TicketModel => 'TicketModel',
      _i48.TicketStatusChange => 'TicketStatusChange',
      _i49.TicketType => 'TicketType',
      _i50.TypeModel => 'TypeModel',
      _i51.User => 'User',
      _i52.UserBreak => 'UserBreak',
      _i53.UserDevice => 'UserDevice',
      _i54.UserModel => 'UserModel',
      _i55.UserRoomMap => 'UserRoomMap',
      _i56.UserTypes => 'UserTypes',
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
      case _i2.AddBucketRequest():
        return 'AddBucketRequest';
      case _i3.AddCommentRequest():
        return 'AddCommentRequest';
      case _i4.AddTicketDTO():
        return 'AddTicketDTO';
      case _i5.AddTicketRequest():
        return 'AddTicketRequest';
      case _i6.AttachmentModel():
        return 'AttachmentModel';
      case _i7.Attendance():
        return 'Attendance';
      case _i8.Bucket():
        return 'Bucket';
      case _i9.BucketModel():
        return 'BucketModel';
      case _i10.BucketTicketMap():
        return 'BucketTicketMap';
      case _i11.ChangeBucketRequest():
        return 'ChangeBucketRequest';
      case _i12.ChatMessage():
        return 'ChatMessage';
      case _i13.ChatRoom():
        return 'ChatRoom';
      case _i14.CheckModel():
        return 'CheckModel';
      case _i15.CheckOrganizationResponse():
        return 'CheckOrganizationResponse';
      case _i16.CheckUsernameResponse():
        return 'CheckUsernameResponse';
      case _i17.CommentModel():
        return 'CommentModel';
      case _i18.DeviceType():
        return 'DeviceType';
      case _i19.FlowModel():
        return 'FlowModel';
      case _i20.GetAddTicketDataResponse():
        return 'GetAddTicketDataResponse';
      case _i21.GetAllTicketsResponse():
        return 'GetAllTicketsResponse';
      case _i22.GetPlannerDataResponse():
        return 'GetPlannerDataResponse';
      case _i23.GetTicketCommentsResponse():
        return 'GetTicketCommentsResponse';
      case _i24.GetTicketDataResponse():
        return 'GetTicketDataResponse';
      case _i25.Greeting():
        return 'Greeting';
      case _i26.LeaveConfig():
        return 'LeaveConfig';
      case _i27.LeaveRequest():
        return 'LeaveRequest';
      case _i28.MessageType():
        return 'MessageType';
      case _i29.Organization():
        return 'Organization';
      case _i30.PlannerApp():
        return 'PlannerApp';
      case _i31.PlannerAssignee():
        return 'PlannerAssignee';
      case _i32.PlannerBucket():
        return 'PlannerBucket';
      case _i33.PlannerNotification():
        return 'PlannerNotification';
      case _i34.PlannerTicket():
        return 'PlannerTicket';
      case _i35.Priority():
        return 'Priority';
      case _i36.PriorityModel():
        return 'PriorityModel';
      case _i37.RegisterAdminResponse():
        return 'RegisterAdminResponse';
      case _i38.SignInResponse():
        return 'SignInResponse';
      case _i39.Status():
        return 'Status';
      case _i40.StatusModel():
        return 'StatusModel';
      case _i41.SystemColor():
        return 'SystemColor';
      case _i42.Ticket():
        return 'Ticket';
      case _i43.TicketAssignee():
        return 'TicketAssignee';
      case _i44.TicketAttachment():
        return 'TicketAttachment';
      case _i45.TicketAttachmentDTO():
        return 'TicketAttachmentDTO';
      case _i46.TicketComment():
        return 'TicketComment';
      case _i47.TicketModel():
        return 'TicketModel';
      case _i48.TicketStatusChange():
        return 'TicketStatusChange';
      case _i49.TicketType():
        return 'TicketType';
      case _i50.TypeModel():
        return 'TypeModel';
      case _i51.User():
        return 'User';
      case _i52.UserBreak():
        return 'UserBreak';
      case _i53.UserDevice():
        return 'UserDevice';
      case _i54.UserModel():
        return 'UserModel';
      case _i55.UserRoomMap():
        return 'UserRoomMap';
      case _i56.UserTypes():
        return 'UserTypes';
    }
    className = _i60.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i61.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    className = _i62.Protocol().getClassNameForObject(data);
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
      return deserialize<_i2.AddBucketRequest>(data['data']);
    }
    if (dataClassName == 'AddCommentRequest') {
      return deserialize<_i3.AddCommentRequest>(data['data']);
    }
    if (dataClassName == 'AddTicketDTO') {
      return deserialize<_i4.AddTicketDTO>(data['data']);
    }
    if (dataClassName == 'AddTicketRequest') {
      return deserialize<_i5.AddTicketRequest>(data['data']);
    }
    if (dataClassName == 'AttachmentModel') {
      return deserialize<_i6.AttachmentModel>(data['data']);
    }
    if (dataClassName == 'Attendance') {
      return deserialize<_i7.Attendance>(data['data']);
    }
    if (dataClassName == 'Bucket') {
      return deserialize<_i8.Bucket>(data['data']);
    }
    if (dataClassName == 'BucketModel') {
      return deserialize<_i9.BucketModel>(data['data']);
    }
    if (dataClassName == 'BucketTicketMap') {
      return deserialize<_i10.BucketTicketMap>(data['data']);
    }
    if (dataClassName == 'ChangeBucketRequest') {
      return deserialize<_i11.ChangeBucketRequest>(data['data']);
    }
    if (dataClassName == 'ChatMessage') {
      return deserialize<_i12.ChatMessage>(data['data']);
    }
    if (dataClassName == 'ChatRoom') {
      return deserialize<_i13.ChatRoom>(data['data']);
    }
    if (dataClassName == 'CheckModel') {
      return deserialize<_i14.CheckModel>(data['data']);
    }
    if (dataClassName == 'CheckOrganizationResponse') {
      return deserialize<_i15.CheckOrganizationResponse>(data['data']);
    }
    if (dataClassName == 'CheckUsernameResponse') {
      return deserialize<_i16.CheckUsernameResponse>(data['data']);
    }
    if (dataClassName == 'CommentModel') {
      return deserialize<_i17.CommentModel>(data['data']);
    }
    if (dataClassName == 'DeviceType') {
      return deserialize<_i18.DeviceType>(data['data']);
    }
    if (dataClassName == 'FlowModel') {
      return deserialize<_i19.FlowModel>(data['data']);
    }
    if (dataClassName == 'GetAddTicketDataResponse') {
      return deserialize<_i20.GetAddTicketDataResponse>(data['data']);
    }
    if (dataClassName == 'GetAllTicketsResponse') {
      return deserialize<_i21.GetAllTicketsResponse>(data['data']);
    }
    if (dataClassName == 'GetPlannerDataResponse') {
      return deserialize<_i22.GetPlannerDataResponse>(data['data']);
    }
    if (dataClassName == 'GetTicketCommentsResponse') {
      return deserialize<_i23.GetTicketCommentsResponse>(data['data']);
    }
    if (dataClassName == 'GetTicketDataResponse') {
      return deserialize<_i24.GetTicketDataResponse>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i25.Greeting>(data['data']);
    }
    if (dataClassName == 'LeaveConfig') {
      return deserialize<_i26.LeaveConfig>(data['data']);
    }
    if (dataClassName == 'LeaveRequest') {
      return deserialize<_i27.LeaveRequest>(data['data']);
    }
    if (dataClassName == 'MessageType') {
      return deserialize<_i28.MessageType>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i29.Organization>(data['data']);
    }
    if (dataClassName == 'PlannerApp') {
      return deserialize<_i30.PlannerApp>(data['data']);
    }
    if (dataClassName == 'PlannerAssignee') {
      return deserialize<_i31.PlannerAssignee>(data['data']);
    }
    if (dataClassName == 'PlannerBucket') {
      return deserialize<_i32.PlannerBucket>(data['data']);
    }
    if (dataClassName == 'PlannerNotification') {
      return deserialize<_i33.PlannerNotification>(data['data']);
    }
    if (dataClassName == 'PlannerTicket') {
      return deserialize<_i34.PlannerTicket>(data['data']);
    }
    if (dataClassName == 'Priority') {
      return deserialize<_i35.Priority>(data['data']);
    }
    if (dataClassName == 'PriorityModel') {
      return deserialize<_i36.PriorityModel>(data['data']);
    }
    if (dataClassName == 'RegisterAdminResponse') {
      return deserialize<_i37.RegisterAdminResponse>(data['data']);
    }
    if (dataClassName == 'SignInResponse') {
      return deserialize<_i38.SignInResponse>(data['data']);
    }
    if (dataClassName == 'Status') {
      return deserialize<_i39.Status>(data['data']);
    }
    if (dataClassName == 'StatusModel') {
      return deserialize<_i40.StatusModel>(data['data']);
    }
    if (dataClassName == 'SystemColor') {
      return deserialize<_i41.SystemColor>(data['data']);
    }
    if (dataClassName == 'Ticket') {
      return deserialize<_i42.Ticket>(data['data']);
    }
    if (dataClassName == 'TicketAssignee') {
      return deserialize<_i43.TicketAssignee>(data['data']);
    }
    if (dataClassName == 'TicketAttachment') {
      return deserialize<_i44.TicketAttachment>(data['data']);
    }
    if (dataClassName == 'TicketAttachmentDTO') {
      return deserialize<_i45.TicketAttachmentDTO>(data['data']);
    }
    if (dataClassName == 'TicketComment') {
      return deserialize<_i46.TicketComment>(data['data']);
    }
    if (dataClassName == 'TicketModel') {
      return deserialize<_i47.TicketModel>(data['data']);
    }
    if (dataClassName == 'TicketStatusChange') {
      return deserialize<_i48.TicketStatusChange>(data['data']);
    }
    if (dataClassName == 'TicketType') {
      return deserialize<_i49.TicketType>(data['data']);
    }
    if (dataClassName == 'TypeModel') {
      return deserialize<_i50.TypeModel>(data['data']);
    }
    if (dataClassName == 'User') {
      return deserialize<_i51.User>(data['data']);
    }
    if (dataClassName == 'UserBreak') {
      return deserialize<_i52.UserBreak>(data['data']);
    }
    if (dataClassName == 'UserDevice') {
      return deserialize<_i53.UserDevice>(data['data']);
    }
    if (dataClassName == 'UserModel') {
      return deserialize<_i54.UserModel>(data['data']);
    }
    if (dataClassName == 'UserRoomMap') {
      return deserialize<_i55.UserRoomMap>(data['data']);
    }
    if (dataClassName == 'UserTypes') {
      return deserialize<_i56.UserTypes>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i60.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i61.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i62.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
