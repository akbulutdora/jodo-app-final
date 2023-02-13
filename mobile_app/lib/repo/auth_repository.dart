import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:jodo_app/core/api/local_data_storage.dart';
import 'package:jodo_app/core/api/network_info.dart';
import 'package:jodo_app/core/api/remote_data_source.dart';
import 'package:jodo_app/core/app_logging.dart';
import 'package:jodo_app/core/error/failures.dart';

/// [AuthRepository] is responsible for the user's authentication actions,
/// as well as determining the state of the app.
class AuthRepository {
  AuthRepository({required rds, required lds, required networkInfo})
      : _remoteDataSource = rds,
        _localDataStorage = lds,
        _networkInfo = networkInfo;
  final RemoteDataSource _remoteDataSource;
  final LocalDataStorage _localDataStorage;
  final NetworkInfo _networkInfo;

  Stream<AuthenticationStatus> get authenticationStatus {
    return _remoteDataSource.freshStream.map((status) {
      return status;
    });
  }

  Future<Either<Failure, void>> login(String username, String password) async {
    final isConnected = await _networkInfo.isConnected;
    if (isConnected) {
      try {
        final _ = await _remoteDataSource.login(username, password);

        return const Right(null);
      } on DioError catch (e, st) {
        AppLogging.logger.e(e.message, [e, st]);
        return Left(ServerFailure(response: e.response));
      } catch (e, st) {
        AppLogging.logger.e(e.toString(), [e, st]);
        return Left(OtherFailure(message: e.toString()));
      }
    } else {
      return const Left(ConnectionFailure());
    }
  }

  Future<Either<Failure, void>> register(
      String username, String password) async {
    final isConnected = await _networkInfo.isConnected;
    if (isConnected) {
      try {
        final _ = await _remoteDataSource.register(username, password);
        return const Right(null);
      } on DioError catch (e, st) {
        AppLogging.logger.e(e.message, [e, st]);
        return Left(ServerFailure(response: e.response));
      } catch (e, st) {
        AppLogging.logger.e(e.toString(), [e, st]);
        return Left(OtherFailure(message: e.toString()));
      }
    } else {
      return const Left(ConnectionFailure());
    }
  }

  Future<void> logout() async {
    try {
      await _localDataStorage.deleteAll();
      await _remoteDataSource.logout();
    }  catch (e, st) {
      AppLogging.logger.e(e.toString(), [e, st]);
    }
  }
}
