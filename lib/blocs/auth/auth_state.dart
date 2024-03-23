part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? token;
  final String? msg;

  const AuthState({required this.status, this.msg, this.token});

  AuthState copyWith({AuthStatus? status, String? token, String? msg}) =>
      AuthState(
          status: status ?? this.status,
          token: token ?? this.token,
          msg: msg ?? this.msg);

  @override
  List<Object?> get props => [token, status, msg];
}

// final class AuthInitial extends AuthState {
//   const AuthInitial() : super('');
// }

// final class Authenticated extends AuthState {
//   final String token;

//   const Authenticated({required this.token}) : super(token);
// }

// final class UnAuthenticated extends AuthState {
//   const UnAuthenticated() : super('');
// }
