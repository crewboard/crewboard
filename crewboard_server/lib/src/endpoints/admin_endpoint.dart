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
    if (!AuthHelper.hasPermission(user, 'manage_planner')) {
      throw Exception('Permission denied: manage_planner');
    }
    return await PlannerApp.db.find(
      session,
      where: (t) => t.organizationId.equals(user.organizationId),
    );
  }

  Future<SystemVariables?> getSystemVariables(Session session) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    if (!AuthHelper.hasPermission(user, 'manage_user_data')) {
      throw Exception('Permission denied: manage_user_data');
    }
    return await SystemVariables.db.findFirstRow(session);
  }

  Future<void> updateSystemVariables(
    Session session,
    SystemVariables variables,
  ) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    if (!AuthHelper.hasPermission(user, 'manage_user_data')) {
      throw Exception('Permission denied: manage_user_data');
    }
    final existing = await SystemVariables.db.findFirstRow(session);
    if (existing == null) {
      await SystemVariables.db.insertRow(session, variables);
    } else {
      variables.id = existing.id;
      await SystemVariables.db.updateRow(session, variables);
    }
  }

  Future<PlannerApp> addApp(
    Session session,
    String name,
    UuidValue colorId,
  ) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    if (!AuthHelper.hasPermission(user, 'manage_planner')) {
      throw Exception('Permission denied: manage_planner');
    }
    final app = PlannerApp(
      appName: name,
      colorId: colorId,
      organizationId: user.organizationId,
    );
    final newApp = await PlannerApp.db.insertRow(session, app);

    // Create initial shared bucket for the organization
    await Bucket.db.insertRow(
      session,
      Bucket(
        userId: user.id!, // Initial owner
        appId: newApp.id!,
        bucketName: 'New',
        isDefault: true,
      ),
    );

    return newApp;
  }

  Future<List<User>> getUsers(Session session) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    if (!AuthHelper.hasPermission(user, 'manage_users')) {
      throw Exception('Permission denied: manage_users');
    }
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
    final user = await AuthHelper.getAuthenticatedUser(session);
    if (!AuthHelper.hasPermission(user, 'manage_users')) {
      throw Exception('Permission denied: manage_users');
    }
    return await UserTypes.db.find(
      session,
      include: UserTypes.include(color: SystemColor.include()),
    );
  }

  Future<void> addUserType(Session session, UserTypes type) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    if (!AuthHelper.hasPermission(user, 'manage_users')) {
      throw Exception('Permission denied: manage_users');
    }
    if (type.id == null) {
      await UserTypes.db.insertRow(session, type);
    } else {
      await UserTypes.db.updateRow(session, type);
    }
  }

  Future<List<Attendance>> getAttendance(Session session, DateTime date) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    if (!AuthHelper.hasPermission(user, 'manage_user_data')) {
      throw Exception('Permission denied: manage_user_data');
    }
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
    final user = await AuthHelper.getAuthenticatedUser(session);
    if (!AuthHelper.hasPermission(user, 'manage_user_data')) {
      throw Exception('Permission denied: manage_user_data');
    }
    return await LeaveConfig.db.find(session);
  }

  Future<List<SystemColor>> getColors(Session session) async {
    // Any authenticated user can read system colors (needed by color picker in various contexts)
    await AuthHelper.getAuthenticatedUser(session);
    return await SystemColor.db.find(session);
  }

  Future<SystemColor> addColor(Session session, String hex) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    if (!AuthHelper.hasPermission(user, 'manage_user_data')) {
      throw Exception('Permission denied: manage_user_data');
    }
    final color = SystemColor(
      color: hex,
      isDefault: false,
    );
    return await SystemColor.db.insertRow(session, color);
  }

  Future<void> updateUser(Session session, User user) async {
    final userRec = await AuthHelper.getAuthenticatedUser(session);
    if (!AuthHelper.hasPermission(userRec, 'manage_users')) {
      throw Exception('Permission denied: manage_users');
    }
    await User.db.updateRow(session, user);
  }

  Future<RegisterAdminResponse> createUser(
    Session session,
    User user,
    String password,
  ) async {
    try {
      final userRec = await AuthHelper.getAuthenticatedUser(session);
      if (!AuthHelper.hasPermission(userRec, 'manage_users')) {
        return RegisterAdminResponse(
          success: false,
          message: 'Permission denied: manage_users',
        );
      }

      // 1. Set Organization ID from the creator
      final currentUser = userRec;
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
    if (!AuthHelper.hasPermission(user, 'manage_user_data')) {
      throw Exception('Permission denied: manage_user_data');
    }
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
    final user = await AuthHelper.getAuthenticatedUser(session);
    if (!AuthHelper.hasPermission(user, 'manage_user_data')) {
      throw Exception('Permission denied: manage_user_data');
    }
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

  Future<List<FontSetting>> getFontSettings(Session session) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    if (!AuthHelper.hasPermission(user, 'manage_user_data')) {
      throw Exception('Permission denied: manage_user_data');
    }
    return await FontSetting.db.find(
      session,
      orderBy: (t) => t.id,
    );
  }

  Future<FontSetting> saveFontSetting(
    Session session,
    FontSetting setting,
  ) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    if (!AuthHelper.hasPermission(user, 'manage_user_data')) {
      throw Exception('Permission denied: manage_user_data');
    }
    if (setting.id == null) {
      return await FontSetting.db.insertRow(session, setting);
    } else {
      return await FontSetting.db.updateRow(session, setting);
    }
  }

  Future<void> deleteFontSetting(Session session, int id) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    if (!AuthHelper.hasPermission(user, 'manage_user_data')) {
      throw Exception('Permission denied: manage_user_data');
    }
    await FontSetting.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
