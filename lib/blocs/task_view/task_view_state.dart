part of 'task_view_bloc.dart';

// Enum para manejar los estados del  @TaskViewBloc
enum TaskListStatus { initial, loading, complete, changed, error }

/**
 * Clase para gestionar los estados del bloc
 * TaskListStatus status;
 * List<Task>? tasks
 * List<Task>? filteredTasks
 * String? msg
 */
class TaskViewState extends Equatable {
  final TaskListStatus status;
  final List<Task>? tasks;
  final List<Task>? filteredTasks;
  final String? msg;
  const TaskViewState(
      {required this.status, this.tasks, this.filteredTasks, this.msg});

  /**
   * Metodo para generar un nuevo estado 
   */
  TaskViewState copyWith(
          {TaskListStatus? status,
          List<Task>? tasks,
          String? msg,
          List<Task>? filteredTasks}) =>
      TaskViewState(
          status: status ?? this.status,
          tasks: tasks ?? this.tasks,
          msg: msg ?? this.msg,
          filteredTasks: filteredTasks ?? this.filteredTasks);

  // Ayuda a realizar comparaciones a profundidad en objetos
  @override
  List<Object?> get props => [status, tasks, msg, filteredTasks];
}
