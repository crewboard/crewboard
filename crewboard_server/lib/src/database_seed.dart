import 'package:serverpod/serverpod.dart';
import 'generated/protocol.dart';
import 'database/planner_seed.dart';
import 'services/user_service.dart';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> seedDatabase(Session session) async {
  // 0. Seed Organization
  var defaultOrg = await Organization.db.findFirstRow(session);
  if (defaultOrg == null) {
    stdout.writeln('Seeding default Organization...');
    defaultOrg = Organization(name: 'Default Organization');
    defaultOrg = await Organization.db.insertRow(session, defaultOrg);
  }

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
    final days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];
    final configMap = {
      for (var day in days)
        day: {
          "in": "09:00",
          "inType": "am",
          "out": "05:00",
          "outType": "pm",
          "buffer": "15",
          "bufferType": "min",
          "leave": day == "Sunday",
        },
    };

    leaveConfig = LeaveConfig(
      configName: 'Default',
      fullDay: 8,
      halfDay: 4,
      config: jsonEncode(configMap),
    );
    leaveConfig = await LeaveConfig.db.insertRow(session, leaveConfig);
  }

  // 3.5 Seed Default Admin User
  final existingAdmin = await User.db.findFirstRow(
    session,
    where: (t) => t.email.equals('admin@crewboard.com'),
  );
  if (existingAdmin == null) {
    stdout.writeln('Seeding default Admin user...');

    // Create default admin user using unified service
    final newUser = User(
      userName: 'admin',
      email: 'admin@crewboard.com',
      organizationId: defaultOrg.id!,
      colorId: defaultColor.id!,
      userTypeId: adminType.id!,
      leaveConfigId: leaveConfig.id!,
      firstName: 'Admin',
      lastName: 'User',
      gender: 'unspecified',
      phone: '',
      performance: 0,
      online: false,
      onsite: false,
      deleted: false,
    );

    await UserService.createUserWithAuth(
      session,
      newUser,
      'password',
    );

    stdout.writeln('Default Admin created: admin@crewboard.com / password');
  }

  // 4. Seed SystemVariables
  var systemVars = await SystemVariables.db.findFirstRow(session);
  if (systemVars == null) {
    stdout.writeln('Seeding default SystemVariables...');
    systemVars = SystemVariables(
      punchingMode: 'manual_user',
      lineHeight: 25,
      processWidth: 100,
      conditionWidth: 100,
      terminalWidth: 100,
      allowEdit: true,
      showEdit: true,
      allowDelete: true,
      showDelete: true,
    );
    await SystemVariables.db.insertRow(session, systemVars);
  }

  // 5. Seed ChatRoom for testing
  var testRoom = await ChatRoom.db.findFirstRow(session);
  if (testRoom == null) {
    stdout.writeln('Seeding test ChatRoom...');
    testRoom = ChatRoom(
      roomName: 'General',
      roomType: 'public',
      messageCount: 0,
    );
    testRoom = await ChatRoom.db.insertRow(session, testRoom);

    // TODO: Seed UserRoomMap once actual users are seeded
    // UserRoomMap requires a valid UuidValue for userId, not an int
    // await UserRoomMap.db.insertRow(
    //   session,
    //   UserRoomMap(
    //     roomId: testRoom.id!,
    //     userId: <valid-uuid-value>,
    //   ),
    // );
  }

  // 5. Seed Planner data
  try {
    await PlannerSeed.seedAll(session);
  } catch (e) {
    stdout.writeln('Error seeding planner data: $e');
  }

  // 6. Seed Emojis
  var emojiCount = await Emoji.db.count(session);
  if (emojiCount == 0) {
    stdout.writeln('Seeding emojis from external API...');
    try {
      final response = await http.get(Uri.parse('https://www.emoji.family/api/emojis'));
      if (response.statusCode == 200) {
        final List<dynamic> emojiList = jsonDecode(response.body);
        stdout.writeln('Fetched ${emojiList.length} emojis. Inserting into database...');

        var batch = <Emoji>[];
        for (var item in emojiList) {
          batch.add(Emoji(
            emoji: item['emoji'] ?? '',
            hexcode: item['hexcode'] ?? '',
            group: item['group'] ?? '',
            subgroup: item['subgroup'] ?? '',
            annotation: item['annotation'] ?? '',
            tags: (item['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
            shortcodes: (item['shortcodes'] as List?)?.map((e) => e.toString()).toList() ?? [],
            emoticons: (item['emoticons'] as List?)?.map((e) => e.toString()).toList() ?? [],
          ));

          if (batch.length >= 100) {
             await Emoji.db.insert(session, batch);
             batch.clear();
          }
        }
        if (batch.isNotEmpty) {
           await Emoji.db.insert(session, batch);
        }
        stdout.writeln('Emoji seeding completed.');
      } else {
        stdout.writeln('Failed to fetch emojis: ${response.statusCode}');
      }
    } catch (e) {
      stdout.writeln('Error seeding emojis: $e');
    }
  } else {
    stdout.writeln('Emojis already seeded ($emojiCount found).');
  }

  stdout.writeln('Database seeding completed.');
}
