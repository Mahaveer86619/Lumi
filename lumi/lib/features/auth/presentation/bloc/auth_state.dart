part of 'auth_bloc.dart';

enum AuthStatus { unauthenticated, authenticated }

sealed class AuthState extends Equatable {
  final AuthStatus status;

  const AuthState(this.status);

  @override
  List<Object> get props => [status];
}

final class AuthInitial extends AuthState {
  const AuthInitial() : super(AuthStatus.unauthenticated);
}

final class AuthLoading extends AuthState {
  const AuthLoading() : super(AuthStatus.unauthenticated);
}

final class AuthError extends AuthState {
  final String error;

  const AuthError(
    this.error
  ) : super(AuthStatus.unauthenticated);
}

// Auth Success
final class Authenticated extends AuthState {
  const Authenticated() : super(AuthStatus.authenticated);
}
