import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/models/models.dart';
import 'package:task_manager/services/services.dart';

part 'task_crud_event.dart';
part 'task_crud_state.dart';

class TaskCrudBloc extends Bloc<TaskCrudEvent, TaskCrudState> {
  final TaskService taskService;
  final AuthService authService;
  TaskCrudBloc({required this.taskService, required this.authService})
      : super(const TaskCrudState(status: TaskCrudStatus.initial)) {
    on<TaskCrudEvent>((event, emit) {});
    on<OnCreateNewTask>(_onCreateNewTask);
    on<OnViewTask>(_onViewTask);
    on<OnSaveNewTask>(_onSaveNewTask);
    on<OnEditTask>(_onEditTask);
    on<OnDeleteTask>(_onDeleteTask);
    on<OnUpdateTask>(_onUpdateTask);
    on<OnCancelOperation>(_onCancelOperation);
  }

  FutureOr<void> _onCreateNewTask(
      OnCreateNewTask event, Emitter<TaskCrudState> emit) {
    emit(state.copyWith(status: TaskCrudStatus.create));
  }

  FutureOr<void> _onSaveNewTask(
      OnSaveNewTask event, Emitter<TaskCrudState> emit) async {
    emit(state.copyWith(status: TaskCrudStatus.loading));

    await checkToken();

    final resp = await taskService.create(event.task);

    if (resp == null) {
      emit(state.copyWith(
          status: TaskCrudStatus.error,
          msg: 'Error al crear la tarea, intente mas tarde.'));
      return;
    }

    emit(state.copyWith(status: TaskCrudStatus.changed, task: resp));
    Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: TaskCrudStatus.initial));
  }

  FutureOr<void> _onCancelOperation(
      OnCancelOperation event, Emitter<TaskCrudState> emit) {
    emit(state.copyWith(status: TaskCrudStatus.initial));
  }

  FutureOr<bool> checkToken() async {
    if (taskService.token.isEmpty) {
      final token = await authService.hasToken();
      taskService.token = token!;
    }
    return true;
  }

  FutureOr<void> _onViewTask(
      OnViewTask event, Emitter<TaskCrudState> emit) async {
    emit(state.copyWith(status: TaskCrudStatus.loading));
    await checkToken();

    final task = await taskService.getById(event.id);

    if (task == null) {
      emit(state.copyWith(
          status: TaskCrudStatus.error,
          msg: 'No se pudo obtener los datos de la tarea'));
      return;
    }

    emit(state.copyWith(status: TaskCrudStatus.view, task: task));
  }

  FutureOr<void> _onEditTask(
      OnEditTask event, Emitter<TaskCrudState> emit) async {
    emit(state.copyWith(status: TaskCrudStatus.loading));
    await checkToken();
    final task = await taskService.getById(event.id);

    if (task == null) {
      emit(state.copyWith(
          status: TaskCrudStatus.error,
          msg: 'No se pudo obtener los datos de la tarea'));
      return;
    }

    emit(state.copyWith(task: task, status: TaskCrudStatus.update));
  }

  FutureOr<void> _onDeleteTask(
      OnDeleteTask event, Emitter<TaskCrudState> emit) async {
    await checkToken();

    final resp = await taskService.delete(event.task.id!);

    if (!resp) {
      emit(state.copyWith(
          status: TaskCrudStatus.error, msg: 'No se logro eliminar la tarea'));
      return;
    }
    emit(state.copyWith(status: TaskCrudStatus.deleted, task: event.task));
    Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: TaskCrudStatus.initial));
  }

  FutureOr<void> _onUpdateTask(
      OnUpdateTask event, Emitter<TaskCrudState> emit) async {
    await checkToken();

    // final tempTask = state.task?.hasChanged(event.task);

    final resp = await taskService.update(event.task);

    if (!resp) {
      emit(state.copyWith(
          status: TaskCrudStatus.error,
          msg: 'No se pudo obtener los datos de la tarea'));
      return;
    }

    emit(state.copyWith(status: TaskCrudStatus.changed, task: event.task));
    Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: TaskCrudStatus.initial));
  }
}
