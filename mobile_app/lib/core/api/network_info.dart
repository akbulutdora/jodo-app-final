import 'dart:io';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// This is a simple implementation of [NetworkInfo] that uses the
/// [InternetAddress.lookup] method to check if the device is connected to the
/// internet.
///
/// It does a second check after a 1.5 second delay to account for flaky
/// connections.
///
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();

  @override
  Future<bool> get isConnected async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      try {
        await Future.delayed(const Duration(milliseconds: 1500));
        final result = await InternetAddress.lookup('example.com');
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        return false;
      }
    }
  }
}
