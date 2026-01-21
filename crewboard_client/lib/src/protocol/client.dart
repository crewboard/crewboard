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
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:crewboard_client/src/protocol/entities/planner_app.dart' as _i5;
import 'package:crewboard_client/src/protocol/entities/system_variables.dart'
    as _i6;
import 'package:crewboard_client/src/protocol/entities/user.dart' as _i7;
import 'package:crewboard_client/src/protocol/entities/user_types.dart' as _i8;
import 'package:crewboard_client/src/protocol/entities/attendance.dart' as _i9;
import 'package:crewboard_client/src/protocol/entities/leave_config.dart'
    as _i10;
import 'package:crewboard_client/src/protocol/entities/system_color.dart'
    as _i11;
import 'package:crewboard_client/src/protocol/protocols/register_admin_response.dart'
    as _i12;
import 'package:crewboard_client/src/protocol/protocols/get_attendance_data_response.dart'
    as _i13;
import 'package:crewboard_client/src/protocol/entities/leave_request.dart'
    as _i14;
import 'package:crewboard_client/src/protocol/protocols/check_username_response.dart'
    as _i15;
import 'package:crewboard_client/src/protocol/protocols/check_organization_response.dart'
    as _i16;
import 'package:crewboard_client/src/protocol/protocols/sign_in_response.dart'
    as _i17;
import 'package:crewboard_client/src/protocol/entities/chat_room.dart' as _i18;
import 'package:crewboard_client/src/protocol/entities/chat_message.dart'
    as _i19;
import 'package:crewboard_client/src/protocol/chat_stream_event.dart' as _i20;
import 'package:crewboard_client/src/protocol/entities/flow_model.dart' as _i21;
import 'package:crewboard_client/src/protocol/entities/doc.dart' as _i22;
import 'package:crewboard_client/src/protocol/entities/emoji.dart' as _i23;
import 'package:crewboard_client/src/protocol/gif.dart' as _i24;
import 'package:crewboard_client/src/protocol/protocols/get_planner_data_response.dart'
    as _i25;
import 'package:crewboard_client/src/protocol/protocols/get_add_ticket_data_response.dart'
    as _i26;
import 'package:crewboard_client/src/protocol/protocols/add_ticket_request.dart'
    as _i27;
import 'package:crewboard_client/src/protocol/protocols/get_all_tickets_response.dart'
    as _i28;
import 'package:crewboard_client/src/protocol/protocols/get_ticket_data_response.dart'
    as _i29;
import 'package:crewboard_client/src/protocol/protocols/get_ticket_thread_response.dart'
    as _i30;
import 'package:crewboard_client/src/protocol/protocols/get_ticket_comments_response.dart'
    as _i31;
import 'package:crewboard_client/src/protocol/protocols/add_comment_request.dart'
    as _i32;
import 'package:crewboard_client/src/protocol/protocols/add_bucket_request.dart'
    as _i33;
import 'package:crewboard_client/src/protocol/protocols/change_bucket_request.dart'
    as _i34;
import 'package:crewboard_client/src/protocol/protocols/ticket_model.dart'
    as _i35;
import 'package:crewboard_client/src/protocol/protocols/get_planner_activities_response.dart'
    as _i36;
import 'dart:typed_data' as _i37;
import 'package:crewboard_client/src/protocol/greetings/greeting.dart' as _i38;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i39;
import 'protocol.dart' as _i40;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i3.Future<_i2.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i3.Future<String> verifyRegistrationCode({
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i3.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i3.Future<_i2.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i3.Future<String> verifyPasswordResetCode({
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// {@category Endpoint}
class EndpointAdmin extends _i2.EndpointRef {
  EndpointAdmin(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _i3.Future<List<_i5.PlannerApp>> getApps() =>
      caller.callServerEndpoint<List<_i5.PlannerApp>>(
        'admin',
        'getApps',
        {},
      );

  _i3.Future<_i6.SystemVariables?> getSystemVariables() =>
      caller.callServerEndpoint<_i6.SystemVariables?>(
        'admin',
        'getSystemVariables',
        {},
      );

  _i3.Future<_i5.PlannerApp> addApp(
    String name,
    _i2.UuidValue colorId,
  ) => caller.callServerEndpoint<_i5.PlannerApp>(
    'admin',
    'addApp',
    {
      'name': name,
      'colorId': colorId,
    },
  );

  _i3.Future<List<_i7.User>> getUsers() =>
      caller.callServerEndpoint<List<_i7.User>>(
        'admin',
        'getUsers',
        {},
      );

  _i3.Future<List<_i8.UserTypes>> getUserTypes() =>
      caller.callServerEndpoint<List<_i8.UserTypes>>(
        'admin',
        'getUserTypes',
        {},
      );

  _i3.Future<void> addUserType(_i8.UserTypes type) =>
      caller.callServerEndpoint<void>(
        'admin',
        'addUserType',
        {'type': type},
      );

  _i3.Future<List<_i9.Attendance>> getAttendance(DateTime date) =>
      caller.callServerEndpoint<List<_i9.Attendance>>(
        'admin',
        'getAttendance',
        {'date': date},
      );

  _i3.Future<void> punch(String mode) => caller.callServerEndpoint<void>(
    'admin',
    'punch',
    {'mode': mode},
  );

  _i3.Future<List<_i10.LeaveConfig>> getLeaveConfigs() =>
      caller.callServerEndpoint<List<_i10.LeaveConfig>>(
        'admin',
        'getLeaveConfigs',
        {},
      );

  _i3.Future<List<_i11.SystemColor>> getColors() =>
      caller.callServerEndpoint<List<_i11.SystemColor>>(
        'admin',
        'getColors',
        {},
      );

  _i3.Future<_i11.SystemColor> addColor(String hex) =>
      caller.callServerEndpoint<_i11.SystemColor>(
        'admin',
        'addColor',
        {'hex': hex},
      );

  _i3.Future<_i12.RegisterAdminResponse> createUser(
    _i7.User user,
    String password,
  ) => caller.callServerEndpoint<_i12.RegisterAdminResponse>(
    'admin',
    'createUser',
    {
      'user': user,
      'password': password,
    },
  );

  _i3.Future<_i13.GetAttendanceDataResponse> getAttendanceData(DateTime date) =>
      caller.callServerEndpoint<_i13.GetAttendanceDataResponse>(
        'admin',
        'getAttendanceData',
        {'date': date},
      );

  _i3.Future<_i10.LeaveConfig> saveLeaveConfig(_i10.LeaveConfig config) =>
      caller.callServerEndpoint<_i10.LeaveConfig>(
        'admin',
        'saveLeaveConfig',
        {'config': config},
      );

  _i3.Future<_i14.LeaveRequest> saveLeaveRequest(_i14.LeaveRequest request) =>
      caller.callServerEndpoint<_i14.LeaveRequest>(
        'admin',
        'saveLeaveRequest',
        {'request': request},
      );
}

/// {@category Endpoint}
class EndpointAuth extends _i2.EndpointRef {
  EndpointAuth(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  _i3.Future<_i15.CheckUsernameResponse> checkUsername(String userName) =>
      caller.callServerEndpoint<_i15.CheckUsernameResponse>(
        'auth',
        'checkUsername',
        {'userName': userName},
      );

  _i3.Future<_i16.CheckOrganizationResponse> checkOrganization(String name) =>
      caller.callServerEndpoint<_i16.CheckOrganizationResponse>(
        'auth',
        'checkOrganization',
        {'name': name},
      );

  _i3.Future<_i12.RegisterAdminResponse> registerAdmin(
    String email,
    String username,
    String password,
    String signupType,
    String? organizationName,
    _i2.UuidValue? organizationId,
  ) => caller.callServerEndpoint<_i12.RegisterAdminResponse>(
    'auth',
    'registerAdmin',
    {
      'email': email,
      'username': username,
      'password': password,
      'signupType': signupType,
      'organizationName': organizationName,
      'organizationId': organizationId,
    },
  );

  _i3.Future<_i17.SignInResponse> simpleLogin(
    String username,
    String password,
  ) => caller.callServerEndpoint<_i17.SignInResponse>(
    'auth',
    'simpleLogin',
    {
      'username': username,
      'password': password,
    },
  );
}

/// {@category Endpoint}
class EndpointChat extends _i2.EndpointRef {
  EndpointChat(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'chat';

  _i3.Future<List<_i18.ChatRoom>> getRooms() =>
      caller.callServerEndpoint<List<_i18.ChatRoom>>(
        'chat',
        'getRooms',
        {},
      );

  _i3.Future<List<_i7.User>> searchUsers(String query) =>
      caller.callServerEndpoint<List<_i7.User>>(
        'chat',
        'searchUsers',
        {'query': query},
      );

  _i3.Future<_i18.ChatRoom> createDirectRoom(_i2.UuidValue otherUserId) =>
      caller.callServerEndpoint<_i18.ChatRoom>(
        'chat',
        'createDirectRoom',
        {'otherUserId': otherUserId},
      );

  _i3.Future<List<_i19.ChatMessage>> getMessages(
    _i2.UuidValue roomId, {
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i19.ChatMessage>>(
    'chat',
    'getMessages',
    {
      'roomId': roomId,
      'limit': limit,
      'offset': offset,
    },
  );

  _i3.Future<void> sendMessage(_i19.ChatMessage message) =>
      caller.callServerEndpoint<void>(
        'chat',
        'sendMessage',
        {'message': message},
      );

  _i3.Stream<_i20.ChatStreamEvent> subscribeToRoom(_i2.UuidValue roomId) =>
      caller.callStreamingServerEndpoint<
        _i3.Stream<_i20.ChatStreamEvent>,
        _i20.ChatStreamEvent
      >(
        'chat',
        'subscribeToRoom',
        {'roomId': roomId},
        {},
      );

  _i3.Future<void> sendTyping(
    bool isTyping,
    _i2.UuidValue roomId,
  ) => caller.callServerEndpoint<void>(
    'chat',
    'sendTyping',
    {
      'isTyping': isTyping,
      'roomId': roomId,
    },
  );

  _i3.Future<void> markAsRead(_i2.UuidValue roomId) =>
      caller.callServerEndpoint<void>(
        'chat',
        'markAsRead',
        {'roomId': roomId},
      );
}

/// {@category Endpoint}
class EndpointDocs extends _i2.EndpointRef {
  EndpointDocs(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'docs';

  _i3.Future<bool> createFlow(_i21.FlowModel flow) =>
      caller.callServerEndpoint<bool>(
        'docs',
        'createFlow',
        {'flow': flow},
      );

  _i3.Future<bool> updateFlow(_i21.FlowModel flow) =>
      caller.callServerEndpoint<bool>(
        'docs',
        'updateFlow',
        {'flow': flow},
      );

  _i3.Future<List<_i21.FlowModel>> getFlows(_i2.UuidValue appId) =>
      caller.callServerEndpoint<List<_i21.FlowModel>>(
        'docs',
        'getFlows',
        {'appId': appId},
      );

  _i3.Future<_i21.FlowModel?> getFlow(_i2.UuidValue flowId) =>
      caller.callServerEndpoint<_i21.FlowModel?>(
        'docs',
        'getFlow',
        {'flowId': flowId},
      );

  _i3.Future<bool> deleteFlow(_i2.UuidValue flowId) =>
      caller.callServerEndpoint<bool>(
        'docs',
        'deleteFlow',
        {'flowId': flowId},
      );

  _i3.Future<List<_i22.Doc>> getDocs(_i2.UuidValue appId) =>
      caller.callServerEndpoint<List<_i22.Doc>>(
        'docs',
        'getDocs',
        {'appId': appId},
      );

  _i3.Future<bool> addDoc(
    _i2.UuidValue appId,
    String name,
  ) => caller.callServerEndpoint<bool>(
    'docs',
    'addDoc',
    {
      'appId': appId,
      'name': name,
    },
  );

  _i3.Future<bool> saveDoc(
    _i2.UuidValue docId,
    String? docContent,
    String? outline,
  ) => caller.callServerEndpoint<bool>(
    'docs',
    'saveDoc',
    {
      'docId': docId,
      'docContent': docContent,
      'outline': outline,
    },
  );
}

/// {@category Endpoint}
class EndpointEmoji extends _i2.EndpointRef {
  EndpointEmoji(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emoji';

  _i3.Future<int> getEmojiCount() => caller.callServerEndpoint<int>(
    'emoji',
    'getEmojiCount',
    {},
  );

  _i3.Future<List<_i23.Emoji>> getEmojis({
    int? limit,
    int? offset,
  }) => caller.callServerEndpoint<List<_i23.Emoji>>(
    'emoji',
    'getEmojis',
    {
      'limit': limit,
      'offset': offset,
    },
  );
}

/// {@category Endpoint}
class EndpointGiphy extends _i2.EndpointRef {
  EndpointGiphy(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'giphy';

  _i3.Future<String?> getApiKey() => caller.callServerEndpoint<String?>(
    'giphy',
    'getApiKey',
    {},
  );

  _i3.Future<List<_i24.Gif>> getGifs({
    String? query,
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i24.Gif>>(
    'giphy',
    'getGifs',
    {
      'query': query,
      'limit': limit,
      'offset': offset,
    },
  );
}

/// {@category Endpoint}
class EndpointPlanner extends _i2.EndpointRef {
  EndpointPlanner(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'planner';

  /// Get planner data (buckets with tickets) for an app
  _i3.Future<_i25.GetPlannerDataResponse> getPlannerData(_i2.UuidValue appId) =>
      caller.callServerEndpoint<_i25.GetPlannerDataResponse>(
        'planner',
        'getPlannerData',
        {'appId': appId},
      );

  /// Fetch initial data for "Add Ticket" form
  _i3.Future<_i26.GetAddTicketDataResponse> getAddTicketData() =>
      caller.callServerEndpoint<_i26.GetAddTicketDataResponse>(
        'planner',
        'getAddTicketData',
        {},
      );

  /// Create a new ticket
  _i3.Future<bool> addTicket(_i27.AddTicketRequest request) =>
      caller.callServerEndpoint<bool>(
        'planner',
        'addTicket',
        {'request': request},
      );

  /// Search/list all tickets in project
  _i3.Future<_i28.GetAllTicketsResponse> getAllTickets(_i2.UuidValue appId) =>
      caller.callServerEndpoint<_i28.GetAllTicketsResponse>(
        'planner',
        'getAllTickets',
        {'appId': appId},
      );

  /// Get detailed ticket data
  _i3.Future<_i29.GetTicketDataResponse> getTicketData(
    _i2.UuidValue ticketId,
  ) => caller.callServerEndpoint<_i29.GetTicketDataResponse>(
    'planner',
    'getTicketData',
    {'ticketId': ticketId},
  );

  /// Get thread (comments + status changes) for a ticket
  _i3.Future<_i30.GetTicketThreadResponse> getTicketThread(
    _i2.UuidValue ticketId,
  ) => caller.callServerEndpoint<_i30.GetTicketThreadResponse>(
    'planner',
    'getTicketThread',
    {'ticketId': ticketId},
  );

  /// Get comments for a ticket
  _i3.Future<_i31.GetTicketCommentsResponse> getTicketComments(
    _i2.UuidValue ticketId,
  ) => caller.callServerEndpoint<_i31.GetTicketCommentsResponse>(
    'planner',
    'getTicketComments',
    {'ticketId': ticketId},
  );

  /// Add a comment to a ticket
  _i3.Future<bool> addComment(_i32.AddCommentRequest request) =>
      caller.callServerEndpoint<bool>(
        'planner',
        'addComment',
        {'request': request},
      );

  /// Add a new bucket
  _i3.Future<bool> addBucket(_i33.AddBucketRequest request) =>
      caller.callServerEndpoint<bool>(
        'planner',
        'addBucket',
        {'request': request},
      );

  /// Move ticket between buckets
  _i3.Future<bool> changeBucket(_i34.ChangeBucketRequest request) =>
      caller.callServerEndpoint<bool>(
        'planner',
        'changeBucket',
        {'request': request},
      );

  /// Update ticket fields
  _i3.Future<bool> updateTicket(_i35.TicketModel updatedTicket) =>
      caller.callServerEndpoint<bool>(
        'planner',
        'updateTicket',
        {'updatedTicket': updatedTicket},
      );

  /// Get all planner activities for an app
  _i3.Future<_i36.GetPlannerActivitiesResponse> getPlannerActivities(
    _i2.UuidValue appId,
  ) => caller.callServerEndpoint<_i36.GetPlannerActivitiesResponse>(
    'planner',
    'getPlannerActivities',
    {'appId': appId},
  );
}

/// {@category Endpoint}
class EndpointUpload extends _i2.EndpointRef {
  EndpointUpload(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'upload';

  _i3.Future<String?> uploadFile(
    String path,
    _i37.ByteData data,
  ) => caller.callServerEndpoint<String?>(
    'upload',
    'uploadFile',
    {
      'path': path,
      'data': data,
    },
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i2.EndpointRef {
  EndpointGreeting(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i3.Future<_i38.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i38.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i1.Caller(client);
    auth = _i39.Caller(client);
    serverpod_auth_core = _i4.Caller(client);
  }

  late final _i1.Caller serverpod_auth_idp;

  late final _i39.Caller auth;

  late final _i4.Caller serverpod_auth_core;
}

class Client extends _i2.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i2.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i2.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i40.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    admin = EndpointAdmin(this);
    auth = EndpointAuth(this);
    chat = EndpointChat(this);
    docs = EndpointDocs(this);
    emoji = EndpointEmoji(this);
    giphy = EndpointGiphy(this);
    planner = EndpointPlanner(this);
    upload = EndpointUpload(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointAdmin admin;

  late final EndpointAuth auth;

  late final EndpointChat chat;

  late final EndpointDocs docs;

  late final EndpointEmoji emoji;

  late final EndpointGiphy giphy;

  late final EndpointPlanner planner;

  late final EndpointUpload upload;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'admin': admin,
    'auth': auth,
    'chat': chat,
    'docs': docs,
    'emoji': emoji,
    'giphy': giphy,
    'planner': planner,
    'upload': upload,
    'greeting': greeting,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'auth': modules.auth,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
