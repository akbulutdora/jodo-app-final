import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jodo_app/core/error/failures.dart';
import 'package:jodo_app/models/jodo/jodo.dart';
import 'package:jodo_app/repo/jodo_repository.dart';
import 'package:jodo_app/util/action_status.dart';

part 'create_jodo_state.dart';

class CreateJodoCubit extends Cubit<CreateJodoState> {
  CreateJodoCubit({required jodoRepository})
      : _jodoRepository = jodoRepository,
        super(CreateJodoState.initial());
  final JodoRepository _jodoRepository;

  /// Initialize the cubit with a jodo.
  void initialize(Jodo? jodo) {
    if (jodo == null) {
      emit(state.copyWith(jodo: Jodo.empty()));
      return;
    }
    if (jodo.type == JodoType.todo) {
      emit(state.copyWith(
        jodo: jodo,
      ));
      return;
    }
    emit(state.copyWith(jodo: jodo));
  }

  void updateTitle(String title) {
    emit(state.copyWith(jodo: state.jodo.copyWith(title: title)));
  }

  void updateDescription(String description) {
    emit(state.copyWith(jodo: state.jodo.copyWith(text: description)));
  }

  void createJodo() async {
    if (state.jodoStatus == ActionStatus.submitting) {
      return;
    }
    emit(state.copyWith(jodoStatus: ActionStatus.submitting));
    final Jodo reqJodo = state.jodo.copyWith(
      completedAt:
          state.jodo.type == JodoType.note ? null : state.jodo.completedAt,
    );

    /// If the id is null, we are creating a new jodo.
    if (reqJodo.id == null) {
      debugPrint('calling create');
      final result = await _jodoRepository.createJodo(reqJodo);
      if (result.isLeft()) {
        final err = result.fold((l) => l, (r) => r) as Failure;
        emit(state.copyWith(
            jodoStatus: ActionStatus.failure, errorMessage: err.toString()));
        emit(state.copyWith(
            jodoStatus: ActionStatus.initial, errorMessage: ''));
        return;
      }
      final jodo = result.getOrElse(() => Jodo.empty());
      emit(state.copyWith(jodoStatus: ActionStatus.success, jodo: jodo));
      return;
    }

    final result = await _jodoRepository.updateJodo(reqJodo);
    if (result.isLeft()) {
      final err = result.fold((l) => l, (r) => r) as Failure;
      emit(state.copyWith(
          jodoStatus: ActionStatus.failure, errorMessage: err.toString()));
      emit(state.copyWith(
          jodoStatus: ActionStatus.initial, errorMessage: ''));
      return;
    }
    final jodo = result.getOrElse(() => Jodo.empty());
    emit(state.copyWith(jodoStatus: ActionStatus.success, jodo: jodo));
  }

  void updateCompleted(bool? value) {
    emit(state.copyWith(
        jodo:
            state.jodo.copyWith(completedAt: value! ? DateTime.now() : null)));
  }

  void deleteJodo() {
    if (state.jodoStatus == ActionStatus.submitting) {
      return;
    }
    emit(state.copyWith(jodoStatus: ActionStatus.submitting));
    _jodoRepository.deleteJodo(state.jodo.id!);
    emit(state.copyWith(jodoStatus: ActionStatus.success));
  }

  void updateType(bool value) {
    if (!value) {
      emit(state.copyWith(jodo: state.jodo.copyWith(type: JodoType.todo)));
      return;
    }
    emit(state.copyWith(jodo: state.jodo.copyWith(type: JodoType.note)));
  }
}
