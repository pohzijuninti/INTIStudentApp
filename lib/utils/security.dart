import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Returns a deterministic SHA-256 hash for the provided password.
/// Trims surrounding whitespace so "secret" and " secret " hash identically.
String hashPassword(String password) {
  final normalized = password.trim();
  final digest = sha256.convert(utf8.encode(normalized));
  return digest.toString();
}
