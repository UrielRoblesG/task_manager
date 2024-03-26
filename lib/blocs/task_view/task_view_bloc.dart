import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/blocs/filter/filters_bloc.dart';
import 'package:task_manager/blocs/task_crud/task_crud_bloc.dart';
import 'package:task_manager/models/models.dart';
import 'package:task_manager/services/services.dart';

part 'task_view_event.dart';
part 'task_view_state.dart';

class TaskViewBloc extends Bloc<TaskViewEvent, TaskViewState> {
  final TaskService taskService;
  final AuthService authService;
  final FiltersBloc filtersBloc;
  final TaskCrudBloc crudBloc;

  StreamSubscription? filtersStream;
  StreamSubscription? crudStream;

  TaskViewBloc(
      {required this.filtersBloc,
      required this.crudBloc,
      required this.authService,
      required this.taskService})
      : super(TaskViewState(status: TaskListStatus.initial)) {
    on<TaskViewEvent>((event, emit) {});
    on<OnGetAll>(_onGetAll);
    on<OnGetByFilter>(_onGetByFilter);
    on<OnUpdateTaskList>(_onUpdateTaskList);
    on<OnRemoveTaskFromList>(_onRemoveTaskFromList);
    filtersStream = filtersBloc.stream.listen((filterState) {
      add(OnGetByFilter(filter: filterState));
    });

    crudStream = crudBloc.stream.listen((crudState) {
      if (crudState.status == TaskCrudStatus.changed) {
        add(OnUpdateTaskList(crudState.task!));
      }
      if (crudState.status == TaskCrudStatus.deleted) {
        add(OnRemoveTaskFromList(crudState.task!));
      }
    });
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

  FutureOr<void> _onGetByFilter(
      OnGetByFilter event, Emitter<TaskViewState> emit) {
    switch (event.filter) {
      case 0:
        emit(state.copyWith(status: TaskListStatus.complete));
        break;
      case 1:
        final tasks = getCompleted(state.tasks!);
        emit(state.copyWith(
            filteredTasks: tasks, status: TaskListStatus.changed));
      case 2:
        final tasks = getIncompleted(state.tasks!);
        emit(state.copyWith(
            filteredTasks: tasks, status: TaskListStatus.changed));
      default:
        break;
    }
  }

  FutureOr<void> _onUpdateTaskList(
      OnUpdateTaskList event, Emitter<TaskViewState> emit) {
    // Revisar si es una nueva tarea
    final tasks = state.tasks ?? [];
    final exist = tasks.any((e) => e.id == event.task.id);

    if (!exist) {
      emit(state.copyWith(
          tasks: [...tasks, event.task], status: TaskListStatus.complete));
    } else {
      final newList = tasks.map((e) {
        if (e.id == event.task.id) {
          return event.task;
        }
        return e;
      }).toList();

      emit(state.copyWith(tasks: newList, status: TaskListStatus.complete));
    }
  }

  FutureOr<void> _onRemoveTaskFromList(
      OnRemoveTaskFromList event, Emitter<TaskViewState> emit) {
    emit(state.copyWith(status: TaskListStatus.loading));
    final tempState = state.copyWith();

    tempState.tasks?.removeWhere((e) => e.id == event.task.id);

    emit(state.copyWith(
        tasks: tempState.tasks, status: TaskListStatus.complete));
  }

  List<Task> getCompleted(List<Task> items) =>
      List<Task>.from(items.where((e) => e.isCompleted == 1)).toList();
  List<Task> getIncompleted(List<Task> items) =>
      List<Task>.from(items.where((e) => e.isCompleted == 0)).toList();

  @override
  Future<void> close() {
    filtersStream?.cancel();
    crudStream?.cancel();
    return super.close();
  }
}
