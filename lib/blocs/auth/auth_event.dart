part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class OnAppStarted extends AuthEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class OnLoggedIn extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class OnLoggedOut extends AuthEvent {
  @override
  List<Object?> get props => [];
}
