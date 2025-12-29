import 'package:serverpod/serverpod.dart';
import 'dart:io';
import '../generated/protocol.dart';
import '../services/user_service.dart';
import '../utils.dart';

class AdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<PlannerApp>> getApps(Session session) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    return await PlannerApp.db.find(
      session,
      where: (t) => t.organizationId.equals(user.organizationId),
    );
  }

  Future<SystemVariables?> getSystemVariables(Session session) async {
    return await SystemVariables.db.findFirstRow(session);
  }

  Future<PlannerApp> addApp(
    Session session,
    String name,
    UuidValue colorId,
  ) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    final app = PlannerApp(
      appName: name,
      colorId: colorId,
      organizationId: user.organizationId,
    );
    return await PlannerApp.db.insertRow(session, app);
  }

  Future<List<User>> getUsers(Session session) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    return await User.db.find(
      session,
      where: (t) => t.organizationId.equals(user.organizationId),
      include: User.include(
        userType: UserTypes.include(color: SystemColor.include()),
        color: SystemColor.include(),
        leaveConfig: LeaveConfig.include(),
        organization: Organization.include(),
      ),
    );
  }

  Future<List<UserTypes>> getUserTypes(Session session) async {
    return await UserTypes.db.find(
      session,
      include: UserTypes.include(color: SystemColor.include()),
    );
  }

  Future<void> addUserType(Session session, UserTypes type) async {
    await UserTypes.db.insertRow(session, type);
  }

  Future<List<Attendance>> getAttendance(Session session, DateTime date) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(Duration(days: 1));

    return await Attendance.db.find(
      session,
      where: (t) =>
          (t.date >= startOfDay) &
          (t.date < endOfDay) &
          t.user.organizationId.equals(user.organizationId),
      include: Attendance.include(
        user: User.include(color: SystemColor.include()),
      ),
    );
  }

  Future<void> punch(Session session, String mode) async {
    final user = await AuthHelper.getAuthenticatedUser(session);

    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(Duration(days: 1));

    final existingAttendance = await Attendance.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(user.id!) &
          (t.date >= startOfDay) &
          (t.date < endOfDay),
    );

    if (existingAttendance == null) {
      // Punch In
      await Attendance.db.insertRow(
        session,
        Attendance(
          userId: user.id!,
          date: now,
          inTime: now.toIso8601String(),
          inTimeStatus: 'ontime',
        ),
      );
    } else {
      // Punch Out
      if (existingAttendance.outTime == null) {
        existingAttendance.outTime = now.toIso8601String();
        existingAttendance.outTimeStatus = 'ontime';
        await Attendance.db.updateRow(session, existingAttendance);
      } else {
        throw Exception('Already punched out for today');
      }
    }
  }

  Future<List<LeaveConfig>> getLeaveConfigs(Session session) async {
    return await LeaveConfig.db.find(session);
  }

  Future<List<SystemColor>> getColors(Session session) async {
    return await SystemColor.db.find(session);
  }

  Future<SystemColor> addColor(Session session, String hex) async {
    final color = SystemColor(
      color: hex,
      isDefault: false,
    );
    return await SystemColor.db.insertRow(session, color);
  }

  Future<RegisterAdminResponse> createUser(
    Session session,
    User user,
    String password,
  ) async {
    try {
      final AuthenticationInfo? authInfo = session.authenticated;
      if (authInfo == null) {
        return RegisterAdminResponse(
          success: false,
          message: 'Not authenticated',
        );
      }

      // 1. Set Organization ID from the creator
      final currentUser = await AuthHelper.getAuthenticatedUser(session);
      user.organizationId = currentUser.organizationId;

      // 2. Create user with auth integration using unified service
      final insertedUser = await UserService.createUserWithAuth(
        session,
        user,
        password,
      );

      return RegisterAdminResponse(
        success: true,
        message: 'User created successfully',
        userId: insertedUser.id.toString(),
      );
    } catch (e) {
      stdout.writeln('Error in AdminEndpoint.createUser: $e');
      return RegisterAdminResponse(
        success: false,
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<GetAttendanceDataResponse> getAttendanceData(
    Session session,
    DateTime date,
  ) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(Duration(days: 1));

    final users = await User.db.find(
      session,
      where: (t) => t.organizationId.equals(user.organizationId),
      include: User.include(
        color: SystemColor.include(),
        leaveConfig: LeaveConfig.include(),
      ),
    );

    final attendance = await Attendance.db.find(
      session,
      where: (t) =>
          (t.date >= startOfDay) &
          (t.date < endOfDay) &
          t.user.organizationId.equals(user.organizationId),
    );

    final configs = await LeaveConfig.db.find(session);
    final requests = await LeaveRequest.db.find(
      session,
      where: (t) => t.user.organizationId.equals(user.organizationId),
      include: LeaveRequest.include(
        user: User.include(color: SystemColor.include()),
      ),
    );

    return GetAttendanceDataResponse(
      users: users,
      attendance: attendance,
      configs: configs,
      requests: requests,
    );
  }

  Future<LeaveConfig> saveLeaveConfig(
    Session session,
    LeaveConfig config,
  ) async {
    if (config.id == null) {
      return await LeaveConfig.db.insertRow(session, config);
    } else {
      return await LeaveConfig.db.updateRow(session, config);
    }
  }

  Future<LeaveRequest> saveLeaveRequest(
    Session session,
    LeaveRequest request,
  ) async {
    if (request.id == null) {
      return await LeaveRequest.db.insertRow(session, request);
    } else {
      return await LeaveRequest.db.updateRow(session, request);
    }
  }
}
