import 'package:serverpod/serverpod.dart';
import 'generated/protocol.dart';
import 'database/planner_seed.dart';
import 'services/user_service.dart';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> seedDatabase(Session session) async {
  stdout.writeln('=========================================');
  stdout.writeln('!!! seedDatabase CALLED !!!');
  stdout.writeln('=========================================');
  // 0. Seed Organization
  var defaultOrg = await Organization.db.findFirstRow(session);
  if (defaultOrg == null) {
    stdout.writeln('Seeding default Organization...');
    defaultOrg = Organization(name: 'Default Organization');
    defaultOrg = await Organization.db.insertRow(session, defaultOrg);
  }

  // 1. Seed SystemColor
  // 1. Seed SystemColor
  var colors = await SystemColor.db.find(session);
  SystemColor defaultColor;

  final defaultColors = [
    SystemColor(colorName: 'Primary Blue', color: '#3498DB', isDefault: true),
    SystemColor(colorName: 'Red', color: '#E74C3C', isDefault: true),
    SystemColor(colorName: 'Green', color: '#2ECC71', isDefault: true),
    SystemColor(colorName: 'Yellow', color: '#F1C40F', isDefault: true),
    SystemColor(colorName: 'Purple', color: '#9B59B6', isDefault: true),
    SystemColor(colorName: 'Orange', color: '#E67E22', isDefault: true),
    SystemColor(colorName: 'Teal', color: '#1ABC9C', isDefault: true),
    SystemColor(colorName: 'Pink', color: '#E91E63', isDefault: true),
    SystemColor(colorName: 'Cyan', color: '#00BCD4', isDefault: true),
  ];

  bool colorsUpdated = false;
  for (final defColor in defaultColors) {
    SystemColor? existing;
    try {
      existing = colors.firstWhere((c) => c.color == defColor.color);
    } catch (_) {
      existing = null;
    }

    if (existing == null) {
      stdout.writeln('Seeding SystemColor: ${defColor.colorName}');
      await SystemColor.db.insertRow(session, defColor);
      colorsUpdated = true;
    } else if (!existing.isDefault) {
      stdout.writeln('Updating SystemColor ${existing.colorName} to default');
      existing.isDefault = true;
      await SystemColor.db.updateRow(session, existing);
      colorsUpdated = true;
    }
  }

  if (colorsUpdated) {
    colors = await SystemColor.db.find(session);
  }

  if (colors.isNotEmpty) {
    defaultColor = colors.firstWhere(
      (c) => c.isDefault,
      orElse: () => colors.first,
    );
  } else {
    // Should unlikely happen as we just inserted if empty
    defaultColor = defaultColors.first; 
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
  final defaultGoogleFonts = [
    'Roboto',
    'Open Sans',
    'Lato',
    'Montserrat',
    'Poppins',
    'Inter',
    'Playfair Display',
    'Merriweather',
    'Noto Sans',
    'Ubuntu',
  ];

  if (systemVars == null) {
    stdout.writeln('Seeding default SystemVariables...');
    systemVars = SystemVariables(
      punchingMode: 'manual_user',
      lineHeight: 1.5,
      processWidth: 100,
      conditionWidth: 100,
      terminalWidth: 100,
      allowEdit: true,
      showEdit: true,
      allowDelete: true,
      showDelete: true,
      googleFonts: defaultGoogleFonts,
      tabPreset1: 'heading',
      tabPreset2: 'body',
    );
    await SystemVariables.db.insertRow(session, systemVars);
  } else {
    bool updated = false;
    if (systemVars.googleFonts == null || systemVars.googleFonts!.isEmpty) {
      stdout.writeln('Updating existing SystemVariables with default googleFonts...');
      systemVars.googleFonts = defaultGoogleFonts;
      updated = true;
    }
    if (systemVars.tabPreset1 == null || systemVars.tabPreset1 == 'Heading 1') {
      systemVars.tabPreset1 = 'heading';
      updated = true;
    }
    if (systemVars.tabPreset2 == null || systemVars.tabPreset2 == 'Body') {
      systemVars.tabPreset2 = 'body';
      updated = true;
    }
    // If lineHeight is still at the old anomalous default 25, reset it to 1.5
    if (systemVars.lineHeight == 25) {
      stdout.writeln('Resetting SystemVariables.lineHeight from 25 to 1.5...');
      systemVars.lineHeight = 1.5;
      updated = true;
    }
    if (updated) {
      await SystemVariables.db.updateRow(session, systemVars);
    }
  }

  // 5. Seed ChatRoom for testing
  // ... (lines 189-216 remain Same) ...

  // 5.5 Seed Default Font Settings
  final defaultFonts = [
    FontSetting(
      name: 'title',
      fontSize: 30.0,
      fontFamily: 'Inter',
      fontWeight: 'bold',
      color: '#000000',
      lineHeight: 1.2,
      headerLevel: 1,
    ),
    FontSetting(
      name: 'heading',
      fontSize: 24.0,
      fontFamily: 'Inter',
      fontWeight: 'bold',
      color: '#000000',
      lineHeight: 1.5,
      headerLevel: 2,
    ),
    FontSetting(
      name: 'sub heading',
      fontSize: 20.0,
      fontFamily: 'Inter',
      fontWeight: 'bold',
      color: '#000000',
      lineHeight: 1.8,
      headerLevel: 3,
    ),
    FontSetting(
      name: 'body',
      fontSize: 14.0,
      fontFamily: 'Inter',
      fontWeight: 'normal',
      color: '#000000',
      lineHeight: 1.5,
      headerLevel: 0,
    ),
  ];

  final existingFonts = await FontSetting.db.find(session);
  if (existingFonts.isEmpty) {
    stdout.writeln('Seeding default FontSettings...');
    for (final font in defaultFonts) {
      await FontSetting.db.insertRow(session, font);
    }
    stdout.writeln('Default font settings created.');
  } else {
    stdout.writeln('Ensuring FontSettings consistency...');
    bool anyUpdated = false;
    for (var existing in existingFonts) {
      bool localUpdated = false;
      
      // Normalize names and fix legacy/typos
      final oldName = existing.name;
      final normalized = existing.name.toLowerCase().trim();
      
      String newName = normalized;
      if (normalized == 'sub title' || normalized == 'sub titile') {
          newName = 'sub heading';
      }

      if (oldName != newName) {
        existing.name = newName;
        stdout.writeln('Normalizing FontSetting name: $oldName -> ${existing.name}');
        localUpdated = true;
      }

      if (existing.lineHeight == null) {
        final matchingDefault = defaultFonts.firstWhere(
          (d) => d.name == existing.name,
          orElse: () => defaultFonts.firstWhere((d) => d.name == 'body'),
        );
        existing.lineHeight = matchingDefault.lineHeight;
        localUpdated = true;
      }

      if (localUpdated) {
        await FontSetting.db.updateRow(session, existing);
        anyUpdated = true;
      }
    }
    if (anyUpdated) {
      stdout.writeln('Standardized FontSettings names and content.');
    }
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

  // 7. Seed Planner Data (Statuses, Priorities, Ticket Types)
  try {
    await PlannerSeed.seedAll(session);
  } catch (e) {
    stdout.writeln('Error seeding planner data: $e');
  }

  stdout.writeln('=========================================');
  stdout.writeln('!!! seedDatabase COMPLETED !!!');
  stdout.writeln('=========================================');
  stdout.writeln('Database seeding completed.');
}
