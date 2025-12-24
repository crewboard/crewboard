import 'package:serverpod/serverpod.dart';
import 'generated/protocol.dart';
import 'database/planner_seed.dart';
import 'dart:io';

Future<void> seedDatabase(Session session) async {
  // 1. Seed SystemColor
  final colors = await SystemColor.db.find(session);
  SystemColor defaultColor;

  if (colors.length < 4) {
    stdout.writeln('Seeding additional SystemColors...');
    final existingColors = colors.map((c) => c.color).toSet();
    final defaultColors = [
      SystemColor(colorName: 'Primary Blue', color: '#3498DB', isDefault: true),
      SystemColor(colorName: 'Red', color: '#E74C3C', isDefault: false),
      SystemColor(colorName: 'Green', color: '#2ECC71', isDefault: false),
      SystemColor(colorName: 'Yellow', color: '#F1C40F', isDefault: false),
    ];

    for (final color in defaultColors) {
      if (!existingColors.contains(color.color)) {
        await SystemColor.db.insertRow(session, color);
      }
    }

    // Refresh colors list
    final refreshedColors = await SystemColor.db.find(session);
    defaultColor = refreshedColors.firstWhere((c) => c.isDefault);
  } else {
    defaultColor = colors.firstWhere(
      (c) => c.isDefault,
      orElse: () => colors.first,
    );
  }

  // 2. Seed UserTypes
  var adminType = await UserTypes.db.findFirstRow(
    session,
    where: (t) => t.userType.equals('admin'),
  );

  if (adminType == null) {
    stdout.writeln('Seeding admin UserType...');
    adminType = UserTypes(
      userType: 'admin',
      isAdmin: true,
      permissions: 'all',
      colorId: defaultColor.id!,
    );
    adminType = await UserTypes.db.insertRow(session, adminType);
  }

  var userType = await UserTypes.db.findFirstRow(
    session,
    where: (t) => t.userType.equals('user'),
  );

  if (userType == null) {
    stdout.writeln('Seeding user UserType...');
    userType = UserTypes(
      userType: 'user',
      isAdmin: false,
      permissions: 'limited',
      colorId: defaultColor.id!,
    );
    await UserTypes.db.insertRow(session, userType);
  }

  // 3. Seed LeaveConfig
  var leaveConfig = await LeaveConfig.db.findFirstRow(session);
  if (leaveConfig == null) {
    stdout.writeln('Seeding default LeaveConfig...');
    leaveConfig = LeaveConfig(
      configName: 'Default Policy',
      fullDay: 8,
      halfDay: 4,
      config: '{}',
    );
    await LeaveConfig.db.insertRow(session, leaveConfig);
  }

  // 4. Seed ChatRoom and UserRoomMap for testing
  var testRoom = await ChatRoom.db.findFirstRow(session);
  if (testRoom == null) {
    stdout.writeln('Seeding test ChatRoom...');
    testRoom = ChatRoom(
      roomName: 'General',
      roomType: 'public',
      messageCount: 0,
    );
    testRoom = await ChatRoom.db.insertRow(session, testRoom);

    // Seed a map for possible userId 1
    await UserRoomMap.db.insertRow(
      session,
      UserRoomMap(
        roomId: testRoom.id!,
        userId: 1,
      ),
    );
  }

  // 5. Seed Planner data
  try {
    await PlannerSeed.seedAll(session);
  } catch (e) {
    stdout.writeln('Error seeding planner data: $e');
  }

  stdout.writeln('Database seeding completed.');
}
