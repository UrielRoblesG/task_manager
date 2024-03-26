import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/services/services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// Clase para gestionar el estado de inicio de sesion
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  AuthBloc({required this.authService})
      : super(const AuthState(status: AuthStatus.initial)) {
    // Handlers para los eventos
    on<AuthEvent>((event, emit) {});
    on<OnAppStarted>(_onAppStarted);
    on<OnLoggedIn>(_onLoggedIn);
    on<OnLoggedOut>(_onLoggedOut);
  }

  // Verifica si existe una sesion activa o no
  FutureOr<void> _onAppStarted(
      OnAppStarted event, Emitter<AuthState> emit) async {
    final token = await authService.hasToken();

    if (token != null) {
      // Envia al usuario al home
      emit(state.copyWith(token: token, status: AuthStatus.success));
    } else {
      // Envia al usuario al login
      emit(state.copyWith(status: AuthStatus.initial));
    }
  }

  // Simula una peticion exitosa de login a una apid
  FutureOr<void> _onLoggedIn(OnLoggedIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    await Future.delayed(const Duration(milliseconds: 1500));
    final token = await authService.loggin();

    if (token == null) {
      emit(state.copyWith(
          status: AuthStatus.error, msg: 'Error al tratar de iniciar sesión'));
      return;
    }
    emit(state.copyWith(status: AuthStatus.success, token: token));
  }

  // Evento que elimina el token guardado en la memoria del dispositivo
  // y cierra sesion
  FutureOr<void> _onLoggedOut(
      OnLoggedOut event, Emitter<AuthState> emit) async {
    await authService.logout();

    emit(state.copyWith(status: AuthStatus.initial));
  }
}
