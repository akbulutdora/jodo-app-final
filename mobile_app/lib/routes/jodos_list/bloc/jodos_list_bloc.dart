import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jodo_app/models/jodo/jodo.dart';
import 'package:jodo_app/repo/jodo_repository.dart';
import 'package:jodo_app/util/action_status.dart';

part 'jodos_list_event.dart';

part 'jodos_list_state.dart';

class JodosOverviewBloc extends Bloc<JodosOverviewEvent, JodosOverviewState> {
  JodosOverviewBloc({
    required JodoRepository jodoRepository,
  })  : _jodosRepository = jodoRepository,
        super(const JodosOverviewState()) {
    on<JodosOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<JodosOverviewJodoCompletionToggled>(_onJodoCompletionToggled);
    on<JodosOverviewJodoDeleted>(_onJodoDeleted);
    on<JodosOverviewClearCompletedRequested>(_onClearCompletedRequested);
    on<JodosOverviewJodosFetched>(_fetchJodos);
  }

  final JodoRepository _jodosRepository;

  Future<void> _onSubscriptionRequested(
    JodosOverviewSubscriptionRequested event,
    Emitter<JodosOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => ActionStatus.submitting));

    await _jodosRepository.fetchJodos();

    await emit.forEach<List<Jodo>>(
      _jodosRepository.getJodos(),
      onData: (jodos) => state.copyWith(
        status: () => ActionStatus.success,
        todos: () => jodos.where((e) => e.type == JodoType.todo).toList(),
        notes: () => jodos.where((e) => e.type == JodoType.note).toList(),
      ),
      onError: (_, __) => state.copyWith(
        status: () => ActionStatus.failure,
      ),
    );
  }

  Future<void> _onJodoCompletionToggled(
    JodosOverviewJodoCompletionToggled event,
    Emitter<JodosOverviewState> emit,
  ) async {
    final newJodo = event.jodo
        .copyWith(completedAt: event.isCompleted ? DateTime.now() : null);
    await _jodosRepository.updateJodo(newJodo);
  }

  Future<void> _onJodoDeleted(
    JodosOverviewJodoDeleted event,
    Emitter<JodosOverviewState> emit,
  ) async {
    await _jodosRepository.deleteJodo(event.jodo.id!);
  }

  Future<void> _onClearCompletedRequested(
    JodosOverviewClearCompletedRequested event,
    Emitter<JodosOverviewState> emit,
  ) async {
    await _jodosRepository.clearCompleted();
  }

  Future<void> _fetchJodos(
    JodosOverviewJodosFetched event,
    Emitter<JodosOverviewState> emit,
  ) async {
    await _jodosRepository.fetchJodos();
  }
}
