part of 'jodos_list_bloc.dart';

abstract class JodosOverviewEvent extends Equatable {
  const JodosOverviewEvent();

  @override
  List<Object> get props => [];
}

/// Subscribes to the jodos repository and emits the state with the
/// updated jodos.
///
/// Called whenever the [TodosListView] or [NotesListView] is opened.
/// Handles its own disposal.
class JodosOverviewSubscriptionRequested extends JodosOverviewEvent {
  const JodosOverviewSubscriptionRequested();
}

/// Toggles the completion status of a jodo.
class JodosOverviewJodoCompletionToggled extends JodosOverviewEvent {
  const JodosOverviewJodoCompletionToggled({
    required this.jodo,
    required this.isCompleted,
  });

  final Jodo jodo;
  final bool isCompleted;

  @override
  List<Object> get props => [jodo, isCompleted];
}

/// Deletes a jodo.
class JodosOverviewJodoDeleted extends JodosOverviewEvent {
  const JodosOverviewJodoDeleted(this.jodo);

  final Jodo jodo;

  @override
  List<Object> get props => [jodo];
}

/// Deletes all completed jodos.
class JodosOverviewClearCompletedRequested extends JodosOverviewEvent {
  const JodosOverviewClearCompletedRequested();
}

/// Fetches the jodos of the user
class JodosOverviewJodosFetched extends JodosOverviewEvent {
  const JodosOverviewJodosFetched();
}
