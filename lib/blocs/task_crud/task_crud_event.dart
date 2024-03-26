part of 'task_crud_bloc.dart';

sealed class TaskCrudEvent extends Equatable {
  const TaskCrudEvent();
}
// Comienza declaracion de los eventos del Bloc

/**
 * Evento para visualizar una tarea.
 * Requiere obligatoriamente el id<int> de la tarea
 * deseada
 */
class OnViewTask extends TaskCrudEvent {
  final int id;

  const OnViewTask({required this.id});
  @override
  List<Object?> get props => [id];
}

/**
 * Evento para mostrar el formulario 
 * de creacion de tarea.
 * No recibe ningun parametro
 */
class OnCreateNewTask extends TaskCrudEvent {
  @override
  List<Object?> get props => [];
}

/**
 * Evento para guardar una tarea.
 * Recibe un task:<Task> 
 * 
 */
class OnSaveNewTask extends TaskCrudEvent {
  final Task task;

  OnSaveNewTask(this.task);
  @override
  List<Object?> get props => [task];
}

/**
 * Evento para cancelar cualquier operacion del bloc
 * No recibe argumentos
 */
class OnCancelOperation extends TaskCrudEvent {
  @override
  List<Object?> get props => [];
}

/**
 * Evento para eliminar una tarea.
 * Recibe como argumento el id:<int> de la tarea
 */
class OnDeleteTask extends TaskCrudEvent {
  final Task task;

  OnDeleteTask(this.task);
  @override
  List<Object?> get props => [task];
}

/**
 * Evento para editar una tarea.
 * Recibe como argumento el id:<int> de la tarea
 * Abre el formuario inicializado con la informacion de la tarea actual
 */
class OnEditTask extends TaskCrudEvent {
  final int id;

  OnEditTask(this.id);
  @override
  List<Object?> get props => [id];
}

/**
 * Evento para actualizar una tarea.
 * Recibe como argumento el task:<Task> de la tarea
 */
class OnUpdateTask extends TaskCrudEvent {
  final Task task;

  const OnUpdateTask(this.task);
  @override
  List<Object?> get props => [task];
}
