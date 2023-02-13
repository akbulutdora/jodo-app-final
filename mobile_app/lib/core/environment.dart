import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io' show Platform;

class Environment {
  static String get fileName => 'env/.env.development';

  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'localhost';

  static String get kJodosCollectionKey =>
      dotenv.env['JODOS_LIST'] ?? 'fallback';
  static String get kSessionKey => dotenv.env['SESSION'] ?? 'fallback';
}
