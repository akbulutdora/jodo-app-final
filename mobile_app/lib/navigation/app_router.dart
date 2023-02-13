import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:jodo_app/models/jodo/jodo.dart';
import 'package:jodo_app/routes/authenticated_wrapper_view.dart';
import 'package:jodo_app/routes/authentication/signin_view.dart';
import 'package:jodo_app/routes/authentication/signup_view.dart';
import 'package:jodo_app/routes/create_update_jodo/create_jodo_view.dart';
import 'package:jodo_app/routes/home/home_view.dart';
import 'package:jodo_app/routes/jodos_list/notes_list_view.dart';
import 'package:jodo_app/routes/jodos_list/todos_list_view.dart';
import 'package:jodo_app/routes/unauthenticated_wrapper_view.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: AuthenticatedWrapperView, children: [
      AutoRoute(
        page: HomeView,
        initial: true,
        children: [
          AutoRoute(page: TodosListView, initial: true),
          AutoRoute(page: NotesListView),
        ],
      ),
      AutoRoute(
        page: CreateJodoView,
        path: 'todos',
      ),
    ]),
    AutoRoute(
      page: UnauthenticatedWrapperView,
      children: [
        AutoRoute(
          page: SigninView,
          initial: true,
        ),
        AutoRoute(
          page: SignupView,
        ),
      ],
    ),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
