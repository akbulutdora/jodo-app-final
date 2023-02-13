// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthenticatedWrapperRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const AuthenticatedWrapperView(),
      );
    },
    UnauthenticatedWrapperRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const UnauthenticatedWrapperView(),
      );
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    CreateJodoRoute.name: (routeData) {
      final args = routeData.argsAs<CreateJodoRouteArgs>(
          orElse: () => const CreateJodoRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: CreateJodoView(
          key: args.key,
          jodo: args.jodo,
        ),
      );
    },
    TodosListRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const TodosListView(),
      );
    },
    NotesListRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const NotesListView(),
      );
    },
    SigninRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SigninView(),
      );
    },
    SignupRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SignupView(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          AuthenticatedWrapperRoute.name,
          path: '/authenticated-wrapper-view',
          children: [
            RouteConfig(
              HomeRoute.name,
              path: '',
              parent: AuthenticatedWrapperRoute.name,
              children: [
                RouteConfig(
                  TodosListRoute.name,
                  path: '',
                  parent: HomeRoute.name,
                ),
                RouteConfig(
                  NotesListRoute.name,
                  path: 'notes-list-view',
                  parent: HomeRoute.name,
                ),
              ],
            ),
            RouteConfig(
              CreateJodoRoute.name,
              path: 'todos',
              parent: AuthenticatedWrapperRoute.name,
            ),
          ],
        ),
        RouteConfig(
          UnauthenticatedWrapperRoute.name,
          path: '/unauthenticated-wrapper-view',
          children: [
            RouteConfig(
              SigninRoute.name,
              path: '',
              parent: UnauthenticatedWrapperRoute.name,
            ),
            RouteConfig(
              SignupRoute.name,
              path: 'signup-view',
              parent: UnauthenticatedWrapperRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [AuthenticatedWrapperView]
class AuthenticatedWrapperRoute extends PageRouteInfo<void> {
  const AuthenticatedWrapperRoute({List<PageRouteInfo>? children})
      : super(
          AuthenticatedWrapperRoute.name,
          path: '/authenticated-wrapper-view',
          initialChildren: children,
        );

  static const String name = 'AuthenticatedWrapperRoute';
}

/// generated route for
/// [UnauthenticatedWrapperView]
class UnauthenticatedWrapperRoute extends PageRouteInfo<void> {
  const UnauthenticatedWrapperRoute({List<PageRouteInfo>? children})
      : super(
          UnauthenticatedWrapperRoute.name,
          path: '/unauthenticated-wrapper-view',
          initialChildren: children,
        );

  static const String name = 'UnauthenticatedWrapperRoute';
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [CreateJodoView]
class CreateJodoRoute extends PageRouteInfo<CreateJodoRouteArgs> {
  CreateJodoRoute({
    Key? key,
    Jodo? jodo,
  }) : super(
          CreateJodoRoute.name,
          path: 'todos',
          args: CreateJodoRouteArgs(
            key: key,
            jodo: jodo,
          ),
        );

  static const String name = 'CreateJodoRoute';
}

class CreateJodoRouteArgs {
  const CreateJodoRouteArgs({
    this.key,
    this.jodo,
  });

  final Key? key;

  final Jodo? jodo;

  @override
  String toString() {
    return 'CreateJodoRouteArgs{key: $key, jodo: $jodo}';
  }
}

/// generated route for
/// [TodosListView]
class TodosListRoute extends PageRouteInfo<void> {
  const TodosListRoute()
      : super(
          TodosListRoute.name,
          path: '',
        );

  static const String name = 'TodosListRoute';
}

/// generated route for
/// [NotesListView]
class NotesListRoute extends PageRouteInfo<void> {
  const NotesListRoute()
      : super(
          NotesListRoute.name,
          path: 'notes-list-view',
        );

  static const String name = 'NotesListRoute';
}

/// generated route for
/// [SigninView]
class SigninRoute extends PageRouteInfo<void> {
  const SigninRoute()
      : super(
          SigninRoute.name,
          path: '',
        );

  static const String name = 'SigninRoute';
}

/// generated route for
/// [SignupView]
class SignupRoute extends PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: 'signup-view',
        );

  static const String name = 'SignupRoute';
}
