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
import '../endpoints/planner_endpoint.dart' as _i7;
import '../greetings/greeting_endpoint.dart' as _i8;
import 'package:crewboard_server/src/generated/chat_message.dart' as _i9;
import 'package:crewboard_server/src/generated/add_ticket_request.dart' as _i10;
import 'package:crewboard_server/src/generated/add_comment_request.dart'
    as _i11;
import 'package:crewboard_server/src/generated/add_bucket_request.dart' as _i12;
import 'package:crewboard_server/src/generated/change_bucket_request.dart'
    as _i13;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i14;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i15;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i16;

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
      'planner': _i7.PlannerEndpoint()
        ..initialize(
          server,
          'planner',
          null,
        ),
      'greeting': _i8.GreetingEndpoint()
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
              type: _i1.getType<int>(),
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
      },
    );
    connectors['auth'] = _i1.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
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
              type: _i1.getType<int?>(),
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
        'getMessages': _i1.MethodConnector(
          name: 'getMessages',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
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
              type: _i1.getType<_i9.ChatMessage>(),
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
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['planner'] as _i7.PlannerEndpoint).getPlannerData(
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
              ) async => (endpoints['planner'] as _i7.PlannerEndpoint)
                  .getAddTicketData(session),
        ),
        'addTicket': _i1.MethodConnector(
          name: 'addTicket',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i10.AddTicketRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['planner'] as _i7.PlannerEndpoint).addTicket(
                    session,
                    params['request'],
                  ),
        ),
        'getAllTickets': _i1.MethodConnector(
          name: 'getAllTickets',
          params: {
            'appId': _i1.ParameterDescription(
              name: 'appId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['planner'] as _i7.PlannerEndpoint).getAllTickets(
                    session,
                    params['appId'],
                  ),
        ),
        'getTicketData': _i1.MethodConnector(
          name: 'getTicketData',
          params: {
            'ticketId': _i1.ParameterDescription(
              name: 'ticketId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['planner'] as _i7.PlannerEndpoint).getTicketData(
                    session,
                    params['ticketId'],
                  ),
        ),
        'getTicketComments': _i1.MethodConnector(
          name: 'getTicketComments',
          params: {
            'ticketId': _i1.ParameterDescription(
              name: 'ticketId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['planner'] as _i7.PlannerEndpoint)
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
              type: _i1.getType<_i11.AddCommentRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['planner'] as _i7.PlannerEndpoint).addComment(
                    session,
                    params['request'],
                  ),
        ),
        'addBucket': _i1.MethodConnector(
          name: 'addBucket',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i12.AddBucketRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['planner'] as _i7.PlannerEndpoint).addBucket(
                    session,
                    params['request'],
                  ),
        ),
        'changeBucket': _i1.MethodConnector(
          name: 'changeBucket',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i13.ChangeBucketRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['planner'] as _i7.PlannerEndpoint).changeBucket(
                    session,
                    params['request'],
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
              ) async => (endpoints['greeting'] as _i8.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i14.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth'] = _i15.Endpoints()..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i16.Endpoints()
      ..initializeEndpoints(server);
  }
}
