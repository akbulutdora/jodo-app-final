part of 'create_jodo_cubit.dart';

class CreateJodoState extends Equatable {
  const CreateJodoState({
    this.jodo = const Jodo(title: '', text: '', completedAt: null, id: -1, type: JodoType.note),
    this.jodoStatus = ActionStatus.initial,
    this.errorMessage = '',
  });

  final Jodo jodo;
  final ActionStatus jodoStatus;
  final String errorMessage;

  factory CreateJodoState.initial() {
    return const CreateJodoState(
      jodo: Jodo(title: '', text: '', completedAt: null, id: -1, type: JodoType.note),
      jodoStatus: ActionStatus.initial,
      errorMessage: '',
    );
  }

  // The copyWith method is used to create a new instance of the state with the
  // same properties as the current state, but with the specified properties
  // overridden.
  CreateJodoState copyWith({
    Jodo? jodo,
    ActionStatus? jodoStatus,
    String? errorMessage,
  }) {
    return CreateJodoState(
      jodo: jodo ?? this.jodo,
      jodoStatus: jodoStatus ?? this.jodoStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [jodo, jodoStatus, errorMessage];

  @override
  String toString() {
    return 'CreateJodoState{\n'
        '\tjodo title: ${jodo.title}, jodo text: ${jodo.text}, jodo done: ${jodo.completedAt},\n'
        'jodoStatus: $jodoStatus, errorMessage: $errorMessage}';
  }
}
