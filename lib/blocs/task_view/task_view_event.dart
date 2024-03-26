part of 'task_view_bloc.dart';

sealed class TaskViewEvent extends Equatable {
  const TaskViewEvent();
}

/**
 * Eventos del bloc
 */

/**
 * Evento para obtener todas las tareas 
 * por el usuario.
 * No recibe ningun parametro
 */
class OnGetAll extends TaskViewEvent {
  @override
  List<Object?> get props => [];
}

/**
 * Evento para mostrar las tareas dependiendo
 * de filtro indicado.
 * Recibe un entero dependiendo del filto.
 * Todoas las tareas : 0,
 * Completas : 1,
 * Pendientes : 2
 */
class OnGetByFilter extends TaskViewEvent {
  final int filter;

  const OnGetByFilter({required this.filter});

  @override
  List<Object?> get props => [filter];
}

/**
 * Evento para actualizar la lista de las tareas
 * Recibe una tarea como parametro
 */
class OnUpdateTaskList extends TaskViewEvent {
  final Task task;

  OnUpdateTaskList(this.task);

  @override
  List<Object?> get props => [task];
}

/**
 * Evento para quitar una tarea de la lista de las tareas
 * Recibe una tarea como parametro
 */
class OnRemoveTaskFromList extends TaskViewEvent {
  final Task task;

  OnRemoveTaskFromList(this.task);

  @override
  List<Object?> get props => [task];
}
