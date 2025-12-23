import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:math';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

// Generate random salt
String generateSalt([int length = 16]) {
  final rand = Random.secure();
  final codeUnits = List.generate(length, (index) {
    return rand.nextInt(256);
  });
  return base64
      .encode(codeUnits)
      .substring(0, length); // Simple hex-like or base64
  // Original used hex.
}

// Mimic original hex salt
String generateHexSalt([int length = 16]) {
  final rand = Random.secure();
  final codeUnits = List.generate(length, (index) {
    return rand.nextInt(256);
  });
  return codeUnits.map((e) => e.toRadixString(16).padLeft(2, '0')).join();
}

String hashPassword(String password) {
  final salt = generateHexSalt(16);
  final bytes = utf8.encode(password + salt);
  final hash = sha256.convert(bytes).toString();
  return '$salt:$hash';
}

bool verifyPassword(String password, String hashedPassword) {
  final parts = hashedPassword.split(':');
  if (parts.length != 2) return false;
  final salt = parts[0];
  final hash = parts[1];

  final bytes = utf8.encode(password + salt);
  final computedHash = sha256.convert(bytes).toString();
  return computedHash == hash;
}
