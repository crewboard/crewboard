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
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../endpoints/admin_endpoint.dart' as _i4;
import '../endpoints/auth_endpoint.dart' as _i5;
import '../endpoints/chat_endpoint.dart' as _i6;
import '../endpoints/docs_endpoint.dart' as _i7;
import '../endpoints/emoji_endpoint.dart' as _i8;
import '../endpoints/giphy_endpoint.dart' as _i9;
import '../endpoints/planner_endpoint.dart' as _i10;
import '../endpoints/upload_endpoint.dart' as _i11;
import '../greetings/greeting_endpoint.dart' as _i12;
import 'package:crewboard_server/src/generated/entities/user_types.dart'
    as _i13;
import 'package:crewboard_server/src/generated/entities/user.dart' as _i14;
import 'package:crewboard_server/src/generated/entities/leave_config.dart'
    as _i15;
import 'package:crewboard_server/src/generated/entities/leave_request.dart'
    as _i16;
import 'package:crewboard_server/src/generated/entities/chat_message.dart'
    as _i17;
import 'package:crewboard_server/src/generated/entities/flow_model.dart'
    as _i18;
import 'package:crewboard_server/src/generated/protocols/add_ticket_request.dart'
    as _i19;
import 'package:crewboard_server/src/generated/protocols/add_comment_request.dart'
    as _i20;
import 'package:crewboard_server/src/generated/protocols/add_bucket_request.dart'
    as _i21;
import 'package:crewboard_server/src/generated/protocols/change_bucket_request.dart'
    as _i22;
import 'package:crewboard_server/src/generated/protocols/ticket_model.dart'
    as _i23;
import 'dart:typed_data' as _i24;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i25;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i26;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i27;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'admin': _i4.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'auth': _i5.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'chat': _i6.ChatEndpoint()
        ..initialize(
          server,
          'chat',
          null,
        ),
      'docs': _i7.DocsEndpoint()
        ..initialize(
          server,
          'docs',
          null,
        ),
      'emoji': _i8.EmojiEndpoint()
        ..initialize(
          server,
          'emoji',
          null,
        ),
      'giphy': _i9.GiphyEndpoint()
        ..initialize(
          server,
          'giphy',
          null,
        ),
      'planner': _i10.PlannerEndpoint()
        ..initialize(
          server,
          'planner',
          null,
        ),
      'upload': _i11.UploadEndpoint()
        ..initialize(
          server,
          'upload',
          null,
        ),
      'greeting': _i12.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['admin'] = _i1.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'getApps': _i1.MethodConnector(
          name: 'getApps',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).getApps(session),
        ),
        'getSystemVariables': _i1.MethodConnector(
          name: 'getSystemVariables',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
                  .getSystemVariables(session),
        ),
        'addApp': _i1.MethodConnector(
          name: 'addApp',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'colorId': _i1.ParameterDescription(
              name: 'colorId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).addApp(
                session,
                params['name'],
                params['colorId'],
              ),
        ),
        'getUsers': _i1.MethodConnector(
          name: 'getUsers',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).getUsers(session),
        ),
        'getUserTypes': _i1.MethodConnector(
          name: 'getUserTypes',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).getUserTypes(
                session,
              ),
        ),
        'addUserType': _i1.MethodConnector(
          name: 'addUserType',
          params: {
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<_i13.UserTypes>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).addUserType(
                session,
                params['type'],
              ),
        ),
        'getAttendance': _i1.MethodConnector(
          name: 'getAttendance',
          params: {
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).getAttendance(
                    session,
                    params['date'],
                  ),
        ),
        'punch': _i1.MethodConnector(
          name: 'punch',
          params: {
            'mode': _i1.ParameterDescription(
              name: 'mode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).punch(
                session,
                params['mode'],
              ),
        ),
        'getLeaveConfigs': _i1.MethodConnector(
          name: 'getLeaveConfigs',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint)
                  .getLeaveConfigs(session),
        ),
        'getColors': _i1.MethodConnector(
          name: 'getColors',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).getColors(session),
        ),
        'addColor': _i1.MethodConnector(
          name: 'addColor',
          params: {
            'hex': _i1.ParameterDescription(
              name: 'hex',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).addColor(
                session,
                params['hex'],
              ),
        ),
        'createUser': _i1.MethodConnector(
          name: 'createUser',
          params: {
            'user': _i1.ParameterDescription(
              name: 'user',
              type: _i1.getType<_i14.User>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i4.AdminEndpoint).createUser(
                session,
                params['user'],
                params['password'],
              ),
        ),
        'getAttendanceData': _i1.MethodConnector(
          name: 'getAttendanceData',
          params: {
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).getAttendanceData(
                    session,
                    params['date'],
                  ),
        ),
        'saveLeaveConfig': _i1.MethodConnector(
          name: 'saveLeaveConfig',
          params: {
            'config': _i1.ParameterDescription(
              name: 'config',
              type: _i1.getType<_i15.LeaveConfig>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).saveLeaveConfig(
                    session,
                    params['config'],
                  ),
        ),
        'saveLeaveRequest': _i1.MethodConnector(
          name: 'saveLeaveRequest',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i16.LeaveRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i4.AdminEndpoint).saveLeaveRequest(
                    session,
                    params['request'],
                  ),
        ),
      },
    );
    connectors['auth'] = _i1.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'checkUsername': _i1.MethodConnector(
          name: 'checkUsername',
          params: {
            'userName': _i1.ParameterDescription(
              name: 'userName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint).checkUsername(
                session,
                params['userName'],
              ),
        ),
        'checkOrganization': _i1.MethodConnector(
          name: 'checkOrganization',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['auth'] as _i5.AuthEndpoint).checkOrganization(
                    session,
                    params['name'],
                  ),
        ),
        'registerAdmin': _i1.MethodConnector(
          name: 'registerAdmin',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'username': _i1.ParameterDescription(
              name: 'username',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'signupType': _i1.ParameterDescription(
              name: 'signupType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'organizationName': _i1.ParameterDescription(
              name: 'organizationName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<_i1.UuidValue?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint).registerAdmin(
                session,
                params['email'],
                params['username'],
                params['password'],
                params['signupType'],
                params['organizationName'],
                params['organizationId'],
              ),
        ),
        'simpleLogin': _i1.MethodConnector(
          name: 'simpleLogin',
          params: {
            'username': _i1.ParameterDescription(
              name: 'username',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['auth'] as _i5.AuthEndpoint).simpleLogin(
                session,
                params['username'],
                params['password'],
              ),
        ),
      },
    );
    connectors['chat'] = _i1.EndpointConnector(
      name: 'chat',
      endpoint: endpoints['chat']!,
      methodConnectors: {
        'getRooms': _i1.MethodConnector(
          name: 'getRooms',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _i6.ChatEndpoint).getRooms(session),
        ),
        'searchUsers': _i1.MethodConnector(
          name: 'searchUsers',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _i6.ChatEndpoint).searchUsers(
                session,
                params['query'],
              ),
        ),
        'createDirectRoom': _i1.MethodConnector(
          name: 'createDirectRoom',
          params: {
            'otherUserId': _i1.ParameterDescription(
              name: 'otherUserId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['chat'] as _i6.ChatEndpoint).createDirectRoom(
                    session,
                    params['otherUserId'],
                  ),
        ),
        'getMessages': _i1.MethodConnector(
          name: 'getMessages',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _i6.ChatEndpoint).getMessages(
                session,
                params['roomId'],
                limit: params['limit'],
                offset: params['offset'],
              ),
        ),
        'sendMessage': _i1.MethodConnector(
          name: 'sendMessage',
          params: {
            'message': _i1.ParameterDescription(
              name: 'message',
              type: _i1.getType<_i17.ChatMessage>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _i6.ChatEndpoint).sendMessage(
                session,
                params['message'],
              ),
        ),
        'sendTyping': _i1.MethodConnector(
          name: 'sendTyping',
          params: {
            'isTyping': _i1.ParameterDescription(
              name: 'isTyping',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _i6.ChatEndpoint).sendTyping(
                session,
                params['isTyping'],
                params['roomId'],
              ),
        ),
        'markAsRead': _i1.MethodConnector(
          name: 'markAsRead',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['chat'] as _i6.ChatEndpoint).markAsRead(
                session,
                params['roomId'],
              ),
        ),
        'subscribeToRoom': _i1.MethodStreamConnector(
          name: 'subscribeToRoom',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['chat'] as _i6.ChatEndpoint).subscribeToRoom(
                session,
                params['roomId'],
              ),
        ),
      },
    );
    connectors['docs'] = _i1.EndpointConnector(
      name: 'docs',
      endpoint: endpoints['docs']!,
      methodConnectors: {
        'createFlow': _i1.MethodConnector(
          name: 'createFlow',
          params: {
            'flow': _i1.ParameterDescription(
              name: 'flow',
              type: _i1.getType<_i18.FlowModel>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['docs'] as _i7.DocsEndpoint).createFlow(
                session,
                params['flow'],
              ),
        ),
        'updateFlow': _i1.MethodConnector(
          name: 'updateFlow',
          params: {
            'flow': _i1.ParameterDescription(
              name: 'flow',
              type: _i1.getType<_i18.FlowModel>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['docs'] as _i7.DocsEndpoint).updateFlow(
                session,
                params['flow'],
              ),
        ),
        'getFlows': _i1.MethodConnector(
          name: 'getFlows',
          params: {
            'appId': _i1.ParameterDescription(
              name: 'appId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['docs'] as _i7.DocsEndpoint).getFlows(
                session,
                params['appId'],
              ),
        ),
        'getFlow': _i1.MethodConnector(
          name: 'getFlow',
          params: {
            'flowId': _i1.ParameterDescription(
              name: 'flowId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['docs'] as _i7.DocsEndpoint).getFlow(
                session,
                params['flowId'],
              ),
        ),
        'deleteFlow': _i1.MethodConnector(
          name: 'deleteFlow',
          params: {
            'flowId': _i1.ParameterDescription(
              name: 'flowId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['docs'] as _i7.DocsEndpoint).deleteFlow(
                session,
                params['flowId'],
              ),
        ),
        'getDocs': _i1.MethodConnector(
          name: 'getDocs',
          params: {
            'appId': _i1.ParameterDescription(
              name: 'appId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['docs'] as _i7.DocsEndpoint).getDocs(
                session,
                params['appId'],
              ),
        ),
        'addDoc': _i1.MethodConnector(
          name: 'addDoc',
          params: {
            'appId': _i1.ParameterDescription(
              name: 'appId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['docs'] as _i7.DocsEndpoint).addDoc(
                session,
                params['appId'],
                params['name'],
              ),
        ),
        'saveDoc': _i1.MethodConnector(
          name: 'saveDoc',
          params: {
            'docId': _i1.ParameterDescription(
              name: 'docId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'docContent': _i1.ParameterDescription(
              name: 'docContent',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'outline': _i1.ParameterDescription(
              name: 'outline',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['docs'] as _i7.DocsEndpoint).saveDoc(
                session,
                params['docId'],
                params['docContent'],
                params['outline'],
              ),
        ),
      },
    );
    connectors['emoji'] = _i1.EndpointConnector(
      name: 'emoji',
      endpoint: endpoints['emoji']!,
      methodConnectors: {
        'getEmojiCount': _i1.MethodConnector(
          name: 'getEmojiCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emoji'] as _i8.EmojiEndpoint)
                  .getEmojiCount(session),
        ),
        'getEmojis': _i1.MethodConnector(
          name: 'getEmojis',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emoji'] as _i8.EmojiEndpoint).getEmojis(
                session,
                limit: params['limit'],
                offset: params['offset'],
              ),
        ),
      },
    );
    connectors['giphy'] = _i1.EndpointConnector(
      name: 'giphy',
      endpoint: endpoints['giphy']!,
      methodConnectors: {
        'getApiKey': _i1.MethodConnector(
          name: 'getApiKey',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['giphy'] as _i9.GiphyEndpoint).getApiKey(session),
        ),
        'getGifs': _i1.MethodConnector(
          name: 'getGifs',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['giphy'] as _i9.GiphyEndpoint).getGifs(
                session,
                query: params['query'],
                limit: params['limit'],
                offset: params['offset'],
              ),
        ),
      },
    );
    connectors['planner'] = _i1.EndpointConnector(
      name: 'planner',
      endpoint: endpoints['planner']!,
      methodConnectors: {
        'getPlannerData': _i1.MethodConnector(
          name: 'getPlannerData',
          params: {
            'appId': _i1.ParameterDescription(
              name: 'appId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['planner'] as _i10.PlannerEndpoint).getPlannerData(
                    session,
                    params['appId'],
                  ),
        ),
        'getAddTicketData': _i1.MethodConnector(
          name: 'getAddTicketData',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['planner'] as _i10.PlannerEndpoint)
                  .getAddTicketData(session),
        ),
        'addTicket': _i1.MethodConnector(
          name: 'addTicket',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i19.AddTicketRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['planner'] as _i10.PlannerEndpoint).addTicket(
                    session,
                    params['request'],
                  ),
        ),
        'getAllTickets': _i1.MethodConnector(
          name: 'getAllTickets',
          params: {
            'appId': _i1.ParameterDescription(
              name: 'appId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['planner'] as _i10.PlannerEndpoint).getAllTickets(
                    session,
                    params['appId'],
                  ),
        ),
        'getTicketData': _i1.MethodConnector(
          name: 'getTicketData',
          params: {
            'ticketId': _i1.ParameterDescription(
              name: 'ticketId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['planner'] as _i10.PlannerEndpoint).getTicketData(
                    session,
                    params['ticketId'],
                  ),
        ),
        'getTicketThread': _i1.MethodConnector(
          name: 'getTicketThread',
          params: {
            'ticketId': _i1.ParameterDescription(
              name: 'ticketId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['planner'] as _i10.PlannerEndpoint)
                  .getTicketThread(
                    session,
                    params['ticketId'],
                  ),
        ),
        'getTicketComments': _i1.MethodConnector(
          name: 'getTicketComments',
          params: {
            'ticketId': _i1.ParameterDescription(
              name: 'ticketId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['planner'] as _i10.PlannerEndpoint)
                  .getTicketComments(
                    session,
                    params['ticketId'],
                  ),
        ),
        'addComment': _i1.MethodConnector(
          name: 'addComment',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i20.AddCommentRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['planner'] as _i10.PlannerEndpoint).addComment(
                    session,
                    params['request'],
                  ),
        ),
        'addBucket': _i1.MethodConnector(
          name: 'addBucket',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i21.AddBucketRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['planner'] as _i10.PlannerEndpoint).addBucket(
                    session,
                    params['request'],
                  ),
        ),
        'changeBucket': _i1.MethodConnector(
          name: 'changeBucket',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i22.ChangeBucketRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['planner'] as _i10.PlannerEndpoint).changeBucket(
                    session,
                    params['request'],
                  ),
        ),
        'updateTicket': _i1.MethodConnector(
          name: 'updateTicket',
          params: {
            'updatedTicket': _i1.ParameterDescription(
              name: 'updatedTicket',
              type: _i1.getType<_i23.TicketModel>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['planner'] as _i10.PlannerEndpoint).updateTicket(
                    session,
                    params['updatedTicket'],
                  ),
        ),
        'getPlannerActivities': _i1.MethodConnector(
          name: 'getPlannerActivities',
          params: {
            'appId': _i1.ParameterDescription(
              name: 'appId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['planner'] as _i10.PlannerEndpoint)
                  .getPlannerActivities(
                    session,
                    params['appId'],
                  ),
        ),
      },
    );
    connectors['upload'] = _i1.EndpointConnector(
      name: 'upload',
      endpoint: endpoints['upload']!,
      methodConnectors: {
        'uploadFile': _i1.MethodConnector(
          name: 'uploadFile',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'data': _i1.ParameterDescription(
              name: 'data',
              type: _i1.getType<_i24.ByteData>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['upload'] as _i11.UploadEndpoint).uploadFile(
                    session,
                    params['path'],
                    params['data'],
                  ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i12.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i25.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth'] = _i26.Endpoints()..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i27.Endpoints()
      ..initializeEndpoints(server);
  }
}
