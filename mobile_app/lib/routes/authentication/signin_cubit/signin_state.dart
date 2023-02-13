part of 'signin_cubit.dart';

class SigninState extends Equatable {
  const SigninState(
      {this.email = '',
      this.password = '',
      this.errorMessage = '',
      this.status = ActionStatus.initial});

  final String email;
  final String password;
  final String errorMessage;
  final ActionStatus status;

  factory SigninState.initial() {
    return const SigninState(
        email: '',
        password: '',
        errorMessage: '',
        status: ActionStatus.initial);
  }

  SigninState copyWith({
    String? email,
    String? password,
    String? errorMessage,
    ActionStatus? status,
  }) {
    return SigninState(
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [email, password, errorMessage, status];

  @override
  String toString() {
    return 'SigninState{\n'
        '\temail: $email, password: $password, errorMessage: $errorMessage, status: $status}';
  }
}
