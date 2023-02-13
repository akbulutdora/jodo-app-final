import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jodo_app/core/api/local_data_storage.dart';
import 'package:jodo_app/core/api/network_info.dart';
import 'package:jodo_app/core/api/remote_data_source.dart';
import 'package:jodo_app/core/app/bloc_observer.dart';
import 'package:jodo_app/core/app_logging.dart';
import 'package:jodo_app/main.dart';
import 'package:jodo_app/repo/auth_repository.dart';
import 'package:jodo_app/repo/jodo_repository.dart';

Future<void> bootstrap({required RemoteDataSource rds, required LocalDataStorage lds}) async {
  /// [AppBlocObserver] is necessary for logging the bloc events.
  Bloc.observer = AppBlocObserver();

  /// Initialize the repositories.
  final jodoRepository =
      JodoRepository(remoteDataSource: rds, networkInfo: NetworkInfoImpl(), localDataStorage: lds);
  final authRepository =
      AuthRepository(rds: rds, networkInfo: NetworkInfoImpl(), lds: lds);

  /// Run the app.
  /// Running it in a new zone enables us to track the
  /// async operations and  catch errors.
  runZonedGuarded(
    () => runApp(App(
      jodoRepository: jodoRepository,
      authRepository: authRepository,
    )),
    (error, stackTrace) =>
        AppLogging.logger.e(error.toString(), ['', stackTrace]),
  );
}
