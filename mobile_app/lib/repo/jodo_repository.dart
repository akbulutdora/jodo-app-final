import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jodo_app/core/api/local_data_storage.dart';
import 'package:jodo_app/core/api/network_info.dart';
import 'package:jodo_app/core/api/remote_data_source.dart';
import 'package:jodo_app/core/app_logging.dart';
import 'package:jodo_app/core/error/failures.dart';
import 'package:jodo_app/models/jodo/jodo.dart';

/// Repository for [Jodo]s.
///
/// This repository is responsible for fetching, deleting and saving [Jodo]s.
class JodoRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataStorage localDataStorage;
  final NetworkInfo networkInfo;

  JodoRepository(
      {required this.localDataStorage, required this.remoteDataSource, required this.networkInfo});

  /// Provides a [Stream] of all todos.
  Stream<List<Jodo>> getJodos() => localDataStorage.getJodos();

  Future<Either<Failure, void>> fetchJodos() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final res = await remoteDataSource.fetchJodos();
        final result = res.map((e) => Jodo.fromJson(e)).toList();

        await localDataStorage.saveJodos(result);

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

  /// Saves a [todo].
  ///
  /// If a [todo] with the same id already exists, it will be replaced.

  Future<Either<Failure, Jodo>> updateJodo(Jodo todo) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final res = await remoteDataSource.updateJodo(todo.toJson());
        final resultJodo = Jodo.fromJson(res!);
        await localDataStorage.saveJodo(resultJodo);
        return Right(resultJodo);
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

  Future<Either<Failure, Jodo>> createJodo(Jodo reqJodo) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final res = await remoteDataSource.createJodo(reqJodo.toJson());
        final resultJodo = Jodo.fromJson(res!);
        await localDataStorage.saveJodo(resultJodo);
        return Right(resultJodo);
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

  /// Deletes the `todo` with the given id.
  ///
  /// If no `todo` with the given id exists, a [JodoNotFoundException] error is
  /// thrown.
  Future<Either<Failure, void>> deleteJodo(int id) async {
    try {
      await remoteDataSource.deleteJodo(id);
      return Right(localDataStorage.deleteJodo(id));
    } on DioError catch (e, st) {
      AppLogging.logger.e(e.message, [e, st]);
      return Left(ServerFailure(response: e.response));
    } catch (e, st) {
      AppLogging.logger.e(e.toString(), [e, st]);
      return Left(OtherFailure(message: e.toString()));
    }
  }

  /// Deletes all completed todos.
  ///
  /// Returns the number of deleted todos.
  Future<int> clearCompleted() async {
    await remoteDataSource.clearCompleted();
    return localDataStorage.clearCompleted();
  }
}
