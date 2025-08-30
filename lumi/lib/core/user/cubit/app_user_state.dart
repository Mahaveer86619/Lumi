part of 'app_user_cubit.dart';

/// Base class for all app user states
abstract class AppUserState extends Equatable {
  const AppUserState();

  @override
  List<Object?> get props => [];
}

/// Initial state when no user is authenticated
class AppUserInitial extends AppUserState {
  const AppUserInitial();
}

/// Loading state during authentication operations
class AppUserLoading extends AppUserState {
  const AppUserLoading();
}

/// State when user is successfully authenticated
class AppUserAuthenticated extends AppUserState {
  final AppUser user;

  const AppUserAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// Error state when authentication operations fail
class AppUserError extends AppUserState {
  final String message;

  const AppUserError(this.message);

  @override
  List<Object?> get props => [message];
}