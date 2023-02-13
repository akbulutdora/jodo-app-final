import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jodo_app/core/api/local_data_storage.dart';
import 'package:jodo_app/core/api/remote_data_source.dart';
import 'package:jodo_app/core/app_logging.dart';
import 'package:jodo_app/core/environment.dart';
import 'package:jodo_app/navigation/app_router.dart';
import 'package:jodo_app/repo/auth_repository.dart';
import 'package:jodo_app/repo/jodo_repository.dart';
import 'package:jodo_app/routes/authentication/authentication_bloc/authentication_bloc.dart';

import 'core/app/bootstrap.dart';

Future<void> main() async {
  /// Make sure the widgets are bound.
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize the dotenv.
  try {
    await dotenv.load(fileName: Environment.fileName);
    AppLogging.logger
        .d('Successfully initialized dotenv: ${dotenv.env['INITIALIZED']}');
  } catch (e, st) {
    AppLogging.logger.e('Failed to initialize dotenv', [e, st]);
  }

  /// Get the instances of the remote and local api.
  final rds = RemoteDataSource();
  const storage = FlutterSecureStorage();
  final lds = LocalDataStorage(plugin: storage);

  /// Bootstrap the app.
  bootstrap(rds: rds, lds: lds);
}

class App extends StatelessWidget {
  final _appRouter = AppRouter();
  final JodoRepository jodoRepository;
  final AuthRepository authRepository;

  App({
    super.key,
    required this.jodoRepository,
    required this.authRepository,
  });

  /// This widget is the root of your application.
  /// We use the [MultiRepositoryProvider] to provide the repositories
  /// to the widgets in the tree.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => jodoRepository,
        ),
        RepositoryProvider(
          create: (context) => authRepository,
        ),
      ],
      child: AppView(appRouter: _appRouter),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
    required AppRouter appRouter,
  })  : _appRouter = appRouter,
        super(key: key);

  final AppRouter _appRouter;

  @override
  Widget build(BuildContext context) {
    /// [AuthenticationBloc] is the bloc that handles the authentication
    /// state of the user. It is provided to the [AppView] widget to
    /// determine the initial route of the app based on [AuthenticationState].
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        context.read<AuthRepository>(),
      ),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          debugPrint(state.toString());
          return MaterialApp.router(
            /// A declarative router delegate is used to determine the
            /// initial route.
            routerDelegate: AutoRouterDelegate.declarative(_appRouter,
                routes: (_) => [
                      if (state is AuthenticationAuthenticated)
                        const AuthenticatedWrapperRoute(),
                      if (state is AuthenticationUnauthenticated)
                        const UnauthenticatedWrapperRoute(),
                    ]),
            routeInformationParser: _appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
