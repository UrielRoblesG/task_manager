import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager/models/models.dart';
import 'package:task_manager/services/services.dart';

part 'task_crud_event.dart';
part 'task_crud_state.dart';

/**
 * Bloc para gestionar las operaciones de las tarea
 * C = Create
 * R = Read
 * U = Update
 * D = Delete
 * -----------------------------------
 * Recibe como argumentos obligatorios 
 * @TaskService
 * @AuthService
 */
class TaskCrudBloc extends Bloc<TaskCrudEvent, TaskCrudState> {
  final TaskService taskService;
  final AuthService authService;
  TaskCrudBloc({required this.taskService, required this.authService})
      : super(const TaskCrudState(status: TaskCrudStatus.initial)) {
    on<TaskCrudEvent>((event, emit) {});
    // Declaracion de handlers de los eventos
    on<OnCreateNewTask>(_onCreateNewTask);
    on<OnViewTask>(_onViewTask);
    on<OnSaveNewTask>(_onSaveNewTask);
    on<OnEditTask>(_onEditTask);
    on<OnDeleteTask>(_onDeleteTask);
    on<OnUpdateTask>(_onUpdateTask);
    on<OnCancelOperation>(_onCancelOperation);
  }

  // Emite evento que abre el formulario de creacion de tareas
  FutureOr<void> _onCreateNewTask(
      OnCreateNewTask event, Emitter<TaskCrudState> emit) {
    emit(state.copyWith(status: TaskCrudStatus.create));
  }

  /**
   * Handler que realiza la peticon de CREATE al server
   */
  FutureOr<void> _onSaveNewTask(
      OnSaveNewTask event, Emitter<TaskCrudState> emit) async {
    emit(state.copyWith(status: TaskCrudStatus.loading));

    await checkToken();

    final resp = await taskService.create(event.task);

    // Si la peticion arroja un error
    // muestra un mensaje
    if (resp == null) {
      emit(state.copyWith(
          status: TaskCrudStatus.error,
          msg: 'Error al crear la tarea, intente mas tarde.'));
      return;
    }

    // Si la peticion es correcta
    // emite un nuevo estado con la
    // tarea hacia la lista de tareas
    emit(state.copyWith(status: TaskCrudStatus.changed, task: resp));
    Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: TaskCrudStatus.initial));
  }

  /**
   * Handler para cancelar cualquier operacion del CRUD
   */
  FutureOr<void> _onCancelOperation(
      OnCancelOperation event, Emitter<TaskCrudState> emit) {
    emit(state.copyWith(status: TaskCrudStatus.initial));
  }

  // Verifica si existe una sesion activa y obtiene el token del
  // Usuario de la memoria del dispositivo
  FutureOr<bool> checkToken() async {
    if (taskService.token.isEmpty) {
      final token = await authService.hasToken();
      taskService.token = token!;
    }
    return true;
  }

  /**
   * Handler para abrir el contenedor de vista de una tarea
   */
  FutureOr<void> _onViewTask(
      OnViewTask event, Emitter<TaskCrudState> emit) async {
    // Emite un estado para mostrar un componente de loading
    emit(state.copyWith(status: TaskCrudStatus.loading));
    await checkToken();

    // Realiza peticion al server para obtener toda
    // la data de una tarea
    final task = await taskService.getById(event.id);

    // Si no se encuentra la tarea, muestra un mensaje
    if (task == null) {
      emit(state.copyWith(
          status: TaskCrudStatus.error,
          msg: 'No se pudo obtener los datos de la tarea'));
      return;
    }
    // Si la encuentra emite el estado correspondiente, y muestra la tarea.
    emit(state.copyWith(status: TaskCrudStatus.view, task: task));
  }

  FutureOr<void> _onEditTask(
      OnEditTask event, Emitter<TaskCrudState> emit) async {
    emit(state.copyWith(status: TaskCrudStatus.loading));
    await checkToken();

    // Realiza peticion al server para obtener toda
    // la data de una tarea
    final task = await taskService.getById(event.id);

    if (task == null) {
      emit(state.copyWith(
          status: TaskCrudStatus.error,
          msg: 'No se pudo obtener los datos de la tarea'));
      return;
    }

    emit(state.copyWith(task: task, status: TaskCrudStatus.update));
  }

  /**
   * Handler para eliminar una tarea
   */
  FutureOr<void> _onDeleteTask(
      OnDeleteTask event, Emitter<TaskCrudState> emit) async {
    await checkToken();
    /**
     * Realiza peticion al server para eliminar
     * una tarea
     */
    final resp = await taskService.delete(event.task.id!);

    // Verifica si la eliminacion de la tarea fue correcta.
    if (!resp) {
      emit(state.copyWith(
          status: TaskCrudStatus.error, msg: 'No se logro eliminar la tarea'));
      return;
    }

    /**
     * Si la eliminacion fue correcta emite un nuevo estado para actualizar la 
     * lista de las tareas
     */
    emit(state.copyWith(status: TaskCrudStatus.deleted, task: event.task));
    Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: TaskCrudStatus.initial));
  }

  /**
   * Handler para manejar la actualizacion de una tarea
   */
  FutureOr<void> _onUpdateTask(
      OnUpdateTask event, Emitter<TaskCrudState> emit) async {
    await checkToken();

    /**
     * Realiza peticion al server para actualizar una tarea
     */
    final resp = await taskService.update(event.task);

    // Verifica la respuesta del servidor
    if (!resp) {
      emit(state.copyWith(
          status: TaskCrudStatus.error,
          msg: 'No se pudo obtener los datos de la tarea'));
      return;
    }

    // Si la respuesta fue correcta actualiza la tarea en la lista
    emit(state.copyWith(status: TaskCrudStatus.changed, task: event.task));
    Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(status: TaskCrudStatus.initial));
  }
}
