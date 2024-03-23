import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/models/models.dart';
import 'package:task_manager/services/services.dart';

part 'task_view_event.dart';
part 'task_view_state.dart';

class TaskViewBloc extends Bloc<TaskViewEvent, TaskViewState> {
  final TaskService taskService;
  final AuthService authService;

  TaskViewBloc({required this.authService, required this.taskService})
      : super(TaskViewState(status: TaskListStatus.initial)) {
    on<TaskViewEvent>((event, emit) {});
    on<OnGetAll>(_onGetAll);
  }

  FutureOr<void> _onGetAll(OnGetAll event, Emitter<TaskViewState> emit) async {
    emit(state.copyWith(status: TaskListStatus.loading));

    final hasToken = await checkToken();

    if (hasToken != null) {
      taskService.token = hasToken;
    }

    final tasks = await taskService.getAll();

    if (tasks.isEmpty) {
      emit(state.copyWith(
          status: TaskListStatus.error,
          msg: 'Error al obtener las tareas, intente mas tarde'));
      return;
    }

    emit(state.copyWith(status: TaskListStatus.complete, tasks: tasks));
  }

  FutureOr<String?> checkToken() async {
    if (taskService.token.isEmpty) {
      final token = await authService.hasToken();

      return token!;
    }
    return null;
  }
}
