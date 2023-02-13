import 'package:dio/dio.dart';

/// We implement our own [Exception] class to be able to
/// convert it to a [Failure] when needed.
///
/// We use the [Failure] class (instead of throwing [Exception]s directly)
/// to keep the data layer separated from the presentation layer.
///
class ServerException implements Exception {
  Response response;

  ServerException({required this.response});

  Response getResponse() {
    return response;
  }
}

class CacheException implements Exception {
  Response response;

  CacheException({required this.response});

  Response getResponse() {
    return response;
  }
}

/// Error thrown when a [Todo] with a given id is not found.
class JodoNotFoundException implements Exception {}
