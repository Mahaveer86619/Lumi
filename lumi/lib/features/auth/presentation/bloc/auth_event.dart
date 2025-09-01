part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

//* Email Auth
class SignUpEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  const SignUpEvent({
    required this.fullName,
    required this.email,
    required this.password,
  });
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  const SignInEvent({
    required this.email,
    required this.password,
  });
}

class LogoutEvent extends AuthEvent {}