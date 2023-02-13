import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:jodo_app/core/api/token_storage.dart';
import 'package:jodo_app/core/app_logging.dart';
import 'package:jodo_app/core/environment.dart';
import 'package:jodo_app/core/error/exception.dart';

class RemoteDataSource {
  /// The first interceptor is responsible for logging the requests and responses.
  ///
  /// The second dio interceptor is responsible for refreshing the token.
  RemoteDataSource({Dio? dioClient})
      : _dioClient = dioClient ?? Dio()
          ..interceptors.add(
            InterceptorsWrapper(
              onRequest: (RequestOptions options,
                  RequestInterceptorHandler handler) async {
                AppLogging.logger.v(options.uri);
                AppLogging.logger.d(options.headers);

                if (options.method == 'POST' || options.method == 'PATCH') {
                  dynamic data = options.data;
                  if (data is Map) {
                    AppLogging.logger.d(data);
                  } else if (data is FormData) {
                    final map = <String, dynamic>{};
                    for (final file in data.files) {
                      map[file.key] =
                          '${file.value.filename} ${file.value.contentType}';
                    }
                    for (final field in data.fields) {
                      map[field.key] = field.value;
                    }
                    AppLogging.logger.d(map);
                  }
                }

                return handler.next(options);
              },
              onResponse: (Response<dynamic> response,
                  ResponseInterceptorHandler handler) {
                AppLogging.logger.v(
                    '(${response.statusCode}, ${response.statusMessage}) - ${response.requestOptions.uri}');
                if (AppLogging.showResponseData) {
                  AppLogging.logger.i(response.data);
                }
                return handler.next(response);
              },
              onError: (DioError error, ErrorInterceptorHandler handler) {
                AppLogging.logger.v(
                    '(${error.response?.statusCode}) - ${error.requestOptions.uri}');
                AppLogging.logger.wtf(error.response?.toString());

                return handler.next(error);
              },
            ),
          )
          ..interceptors.add(_fresh);

  final Dio _dioClient;

  // Read the baseURL from the environment variables.
  // If the environment variable is not set, use the localhost.
  static final baseURL = Environment.baseUrl;

  /* AUTHENTICATION */

  static final _fresh = Fresh<String>(
    refreshToken: (token, httpClient) async {
      return '';
    },
    tokenStorage: MyTokenStorage(),
    tokenHeader: (token) {
      return {
        'Authorization': 'Bearer $token',
      };
    },
    shouldRefresh: (response) {
      return false;
    },
  );

  /// The getter for the fresh stream
  Stream<AuthenticationStatus> get freshStream => _fresh.authenticationStatus;

  Future<void> login(String username, String password) async {
    final resp = await _dioClient.post<Map<String, dynamic>>(
      '$baseURL/sessions',
      data: {
        'user': {'email': username, 'password': password}
      },
    );
    if (resp.statusCode == 200) {
      /// The token is stored in the token storage.
      /// Fresh will take care of the authorization headers once the token is set.
      _fresh.setToken(resp.data!['data']['token']);
      return;
    } else {
      throw ServerException(response: resp);
    }
  }

  /// Upon logout, the token is cleared from the token storage.
  logout() {
    _fresh.clearToken();
    return;
  }

  Future<void> register(String username, String password) async {
    final resp = await _dioClient
        .post<Map<String, dynamic>>('$baseURL/registrations', data: {
      'user': {'email': username, 'password': password},
    });
    if (resp.statusCode == 201) {
      login(username, password);
      return;
    } else {
      throw ServerException(response: resp);
    }
  }

  /* JODOS */

  Future<Map<String, dynamic>?> updateJodo(
      Map<String, dynamic> jodoJson) async {
    try {
      final response = await _dioClient.patch<Map<String, dynamic>>(
          '$baseURL/blocks/${jodoJson['id']}',
          data: {'block': jodoJson});

      if (response.statusCode == 200) {
        if (response.data != null) {
          return response.data!['data'];
        }
      } else {
        throw ServerException(response: response);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  /// The create request for jodos
  Future<Map<String, dynamic>?> createJodo(
      Map<String, dynamic> jodoJson) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
        '$baseURL/blocks',
        data: {'block': jodoJson});

    if (response.statusCode == 201) {
      if (response.data != null) {
        return response.data!['data'];
      }
    } else {
      throw ServerException(response: response);
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> fetchJodos() async {
    try {
      final response = await _dioClient.get(
        '$baseURL/blocks',
      );
      if (response.statusCode == 200) {
        if (response.data != null) {
          return List<Map<String, dynamic>>.from(response.data!['data']);
        }
      } else {
        throw ServerException(response: response);
      }
    } catch (e) {
      rethrow;
    }
    throw Exception('Unknown exception');
  }

  /// Delete jodo
  Future<void> deleteJodo(int id) async {
    final response = await _dioClient.delete(
      '$baseURL/blocks/$id',
    );
    if (response.statusCode == 204) {
      return;
    } else {
      throw ServerException(response: response);
    }
  }

  /// Delete todos that are completed
  Future<void> clearCompleted() async {
    final response = await _dioClient.delete(
      '$baseURL/blocks/completed',
    );
    if (response.statusCode == 204) {
      return;
    } else {
      throw ServerException(response: response);
    }
  }
}
