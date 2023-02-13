import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jodo_app/core/error/failures.dart';
import 'package:jodo_app/repo/auth_repository.dart';
import 'package:jodo_app/util/action_status.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit({
    required AuthRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(SigninState.initial());

  final AuthRepository _authenticationRepository;

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  Future<void> submitSignin() async {
    if (state.status == ActionStatus.submitting) {
      return;
    }
    emit(state.copyWith(status: ActionStatus.submitting));

    final result = await _authenticationRepository.login(
      state.email,
      state.password,
    );
    if (result.isLeft()) {
      final err = result.fold((l) => l, (r) => r) as Failure;
      emit(state.copyWith(
        status: ActionStatus.failure,
        errorMessage: err.toString(),
      ));
      emit(state.copyWith(status: ActionStatus.initial, errorMessage: ''));
      return;
    }
    emit(state.copyWith(status: ActionStatus.success));
  }

  Future<void> submitSignup() async {
    if (state.status == ActionStatus.submitting) {
      return;
    }
    emit(state.copyWith(status: ActionStatus.submitting));

    final result = await _authenticationRepository.register(
      state.email,
      state.password,
    );
    if (result.isLeft()) {
      final err = result.fold((l) => l, (r) => r) as Failure;
      emit(state.copyWith(
        status: ActionStatus.failure,
        errorMessage: err.toString(),
      ));
      emit(state.copyWith(status: ActionStatus.initial, errorMessage: ''));
      return;
    }
    emit(state.copyWith(status: ActionStatus.success));
  }

}
