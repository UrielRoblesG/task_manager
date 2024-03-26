part of 'task_crud_bloc.dart';

// Enum con todos los estados que puede tener @TaskCrudBloc
enum TaskCrudStatus {
  initial,
  create,
  view,
  update,
  delete,
  deleted,
  error,
  loading,
  changed
}

// Clase para manejar los estados
class TaskCrudState extends Equatable {
  final TaskCrudStatus status;
  final Task? task;
  final String? msg;

  const TaskCrudState({required this.status, this.task, this.msg});

  // Metodo para generar un nuevo esatado
  TaskCrudState copyWith({TaskCrudStatus? status, Task? task, String? msg}) =>
      TaskCrudState(
          status: status ?? this.status,
          task: task ?? this.task,
          msg: msg ?? this.msg);

  // Ayuda a realizar comparaciones mas a profundidad de las clases
  @override
  List<Object?> get props => [status, task, msg];
}
