import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/blocs/filter/filters_bloc.dart';
import 'package:task_manager/blocs/task_crud/task_crud_bloc.dart';
import 'package:task_manager/models/models.dart';
import 'package:task_manager/services/services.dart';

part 'task_view_event.dart';
part 'task_view_state.dart';

/**
 * Bloc para manejar la lista de las tareas
 * Recibe como argumentos
 * TaskService
 * AuthService
 * FiltersBloc
 * TaskCrudBloc
 */
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
    // Handlers de los eventos
    on<TaskViewEvent>((event, emit) {});
    on<OnGetAll>(_onGetAll);
    on<OnGetByFilter>(_onGetByFilter);
    on<OnUpdateTaskList>(_onUpdateTaskList);
    on<OnRemoveTaskFromList>(_onRemoveTaskFromList);

    // Stream para escuchar al bloc de filtros y reaccionar
    filtersStream = filtersBloc.stream.listen((filterState) {
      add(OnGetByFilter(filter: filterState));
    });

    // Stream para escuchar al bloc de Crud y reaccionar
    crudStream = crudBloc.stream.listen((crudState) {
      if (crudState.status == TaskCrudStatus.changed) {
        add(OnUpdateTaskList(crudState.task!));
      }
      if (crudState.status == TaskCrudStatus.deleted) {
        add(OnRemoveTaskFromList(crudState.task!));
      }
    });
  }

  /**
   * Handler para obtener todas las tareas del usuario
   */
  FutureOr<void> _onGetAll(OnGetAll event, Emitter<TaskViewState> emit) async {
    // Emite estado de carga
    emit(state.copyWith(status: TaskListStatus.loading));

    final hasToken = await checkToken();

    if (hasToken != null) {
      taskService.token = hasToken;
    }

    // LLama metodo del server
    final tasks = await taskService.getAll();

    if (tasks.isEmpty) {
      emit(state.copyWith(
          status: TaskListStatus.error,
          msg: 'Error al obtener las tareas, intente mas tarde'));
      return;
    }

    // Si la peticion fue exitosa emite estado con las tareas
    emit(state.copyWith(status: TaskListStatus.complete, tasks: tasks));
  }

  FutureOr<String?> checkToken() async {
    if (taskService.token.isEmpty) {
      final token = await authService.hasToken();

      return token!;
    }
    return null;
  }

  /**
   * Handler para mostar las tareas en base a un filtro
   */
  FutureOr<void> _onGetByFilter(
      OnGetByFilter event, Emitter<TaskViewState> emit) {
    // Dependiendo del filtro seleccionado muestra las tareas
    // Indicadas
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

  /**
   * Metodo para obtener una nueva lista con la tarea actualizado
   */
  FutureOr<void> _onUpdateTaskList(
      OnUpdateTaskList event, Emitter<TaskViewState> emit) {
    // Revisar si es una nueva tarea
    final tasks = state.tasks ?? [];
    final exist = tasks.any((e) => e.id == event.task.id);

    // Si la tarea no existe actualmente en la lista la agrega al final
    if (!exist) {
      emit(state.copyWith(
          tasks: [...tasks, event.task], status: TaskListStatus.complete));
    } else {
      // Si la tarea existe actualiza la tarea
      final newList = tasks.map((e) {
        if (e.id == event.task.id) {
          return event.task;
        }
        return e;
      }).toList();

      // Avisa al UI que se redibuje
      emit(state.copyWith(tasks: newList, status: TaskListStatus.complete));
    }
  }

  /**
   * Metodo para quitar una tarea de la lista de tarias
   */
  FutureOr<void> _onRemoveTaskFromList(
      OnRemoveTaskFromList event, Emitter<TaskViewState> emit) {
    emit(state.copyWith(status: TaskListStatus.loading));

    final tempState = state.copyWith();
    // Obtiene una nueva lista sin la tarea eliminada
    tempState.tasks?.removeWhere((e) => e.id == event.task.id);

    // Avisa a la UI que se redibuje
    emit(state.copyWith(
        tasks: tempState.tasks, status: TaskListStatus.complete));
  }

  List<Task> getCompleted(List<Task> items) =>
      List<Task>.from(items.where((e) => e.isCompleted == 1)).toList();
  List<Task> getIncompleted(List<Task> items) =>
      List<Task>.from(items.where((e) => e.isCompleted == 0)).toList();

  /**
   * Cancela la escucha de los blocs
   */
  @override
  Future<void> close() {
    filtersStream?.cancel();
    crudStream?.cancel();
    return super.close();
  }
}
