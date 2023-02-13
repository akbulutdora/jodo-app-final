import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_dio/fresh_dio.dart';

/// Custom token storage implementation for [FreshDio].
/// Implements read, write and delete operations.
class MyTokenStorage implements TokenStorage<String> {
  final storage = const FlutterSecureStorage();

  @override
  Future<void> delete() async {
    await storage.deleteAll();
  }

  @override
  Future<String?> read() async {
    final token = await storage.read(key: 'token');

    if (token?.isNotEmpty ?? false) {
      return token;
    }
    return null;
  }

  @override
  Future<void> write(String token) async {
    await storage.write(
      key: 'token',
      value: token,
    );
  }
}
