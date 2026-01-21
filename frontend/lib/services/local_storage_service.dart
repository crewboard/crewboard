import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class LocalStorageService {
  static const String _userIdKey = 'user_id';
  static const String _legacyUserIdKey = 'userId';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _authTokenKey = 'auth_token';
  static const String _deviceIdKey = 'device_id';
  static const String _organizationIdKey = 'organization_id';
  static const String _codecPackInstalledKey = 'codec_pack_installed';

  static Future<void> ensureCodecPackInstalled() async {
    final isInstalled = await LocalStorageService.isCodecPackInstalled();
    if (!isInstalled) {
      final tempDir = Directory.systemTemp.path;
      final installerPath = p.join(tempDir, 'K-Lite_Codec_Pack_Basic.exe');

      const downloadUrl =
          'https://files3.codecguide.com/K-Lite_Codec_Pack_1730_Basic.exe';

      print('Downloading K-Lite Codec Pack...');
      try {
        final response = await http.get(Uri.parse(downloadUrl));
        if (response.statusCode == 200) {
          final file = File(installerPath);
          await file.writeAsBytes(response.bodyBytes);
          print('Downloaded to $installerPath');

          // Run installer silently
          final result = await Process.run(installerPath, ['/silent']);
          if (result.exitCode == 0) {
            print('Installation successful');
            await LocalStorageService.setCodecPackInstalled(true);
          } else {
            print('Installation failed: ${result.stderr}');
          }

          // Optionally delete the installer after installation
          try {
            await file.delete();
          } catch (_) {}
        } else {
          print('Failed to download codec pack: HTTP ${response.statusCode}');
        }
      } catch (e) {
        print('Error downloading codec pack: $e');
      }
    } else {
      print('Codec pack already installed.');
    }
  }

  // Check if codec pack is installed
  static Future<bool> isCodecPackInstalled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_codecPackInstalledKey) ?? false;
  }

  // Set codec pack installation status
  static Future<void> setCodecPackInstalled(bool installed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_codecPackInstalledKey, installed);
  }

  // Save user data to local storage
  static Future<void> saveUserData({
    required String userId,
    required String userName,
    required String userEmail,
    required String authToken,
    String? organizationId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_userNameKey, userName);
    await prefs.setString(_userEmailKey, userEmail);
    await prefs.setString(_authTokenKey, authToken);
    if (organizationId != null) {
      await prefs.setString(_organizationIdKey, organizationId);
    }
  }

  // Get user ID from local storage
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getString(_userIdKey);
    if (v != null && v.isNotEmpty) return v;
    return prefs.getString(_legacyUserIdKey);
  }

  // Save only userId (compat: writes both keys)
  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_legacyUserIdKey, userId);
  }

  // Get user name from local storage
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  // Get user email from local storage
  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  // Get auth token from local storage
  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  // Get organization ID from local storage
  static Future<String?> getOrganizationId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_organizationIdKey);
  }

  // Save organization ID to local storage
  static Future<void> saveOrganizationId(String organizationId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_organizationIdKey, organizationId);
  }

  // Check if user is authenticated
  static Future<bool> isUserAuthenticated() async {
    final userId = await getUserId();
    final authToken = await getAuthToken();
    return userId != null && authToken != null;
  }

  // Clear all user data (logout)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.remove(_legacyUserIdKey);
    await prefs.remove(_userNameKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_authTokenKey);
    await prefs.remove(_organizationIdKey);
    // do not remove device id on logout
  }

  // Get all user data as a map
  static Future<Map<String, String?>> getAllUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'userId': prefs.getString(_userIdKey),
      'userName': prefs.getString(_userNameKey),
      'userEmail': prefs.getString(_userEmailKey),
      'authToken': prefs.getString(_authTokenKey),
      'organizationId': prefs.getString(_organizationIdKey),
    };
  }

  // Ensure a stable device id in local storage
  static Future<String> getOrCreateDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_deviceIdKey);
    if (existing != null && existing.isNotEmpty) return existing;
    final id = _generateDeviceId();
    await prefs.setString(_deviceIdKey, id);
    return id;
  }

  static String _generateDeviceId() {
    final now = DateTime.now().millisecondsSinceEpoch.toRadixString(36);
    final rand = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    return (now + rand).padRight(26, '0').substring(0, 26);
  }
}
