part of 'jodos_list_bloc.dart';

class JodosOverviewState extends Equatable {
  const JodosOverviewState({
    this.status = ActionStatus.initial,
    this.todos = const [],
    this.notes = const [],
  });

  final ActionStatus status;
  final List<Jodo> todos;
  final List<Jodo> notes;


  JodosOverviewState copyWith({
    ActionStatus Function()? status,
    List<Jodo> Function()? todos,
    List<Jodo> Function()? notes,
  }) {
    return JodosOverviewState(
      status: status != null ? status() : this.status,
      todos: todos != null ? todos() : this.todos,
      notes: notes != null ? notes() : this.notes,
    );
  }

  @override
  List<Object?> get props => [
    status,
    todos,
    notes,
  ];
}
