import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:jodo_app/repo/auth_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(AuthenticationUnknown()) {
    _subscription = _authRepository.authenticationStatus.listen((status) {
      add(AuthenticationStatusChanged(status));
    });

    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<LoggedOut>(_onLoggedOut);
  }

  late StreamSubscription<AuthenticationStatus> _subscription;
  final AuthRepository _authRepository;

  void _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    switch (event.authenticationStatus) {
      case AuthenticationStatus.authenticated:
        return emit(AuthenticationAuthenticated());
      case AuthenticationStatus.unauthenticated:
        return emit(AuthenticationUnauthenticated());
      case AuthenticationStatus.initial:
        return emit(AuthenticationUnknown());
    }
  }

  void _onLoggedOut(
    LoggedOut event,
    Emitter<AuthenticationState> emit,
  ) {
    _authRepository.logout().ignore();
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
