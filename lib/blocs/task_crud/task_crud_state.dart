part of 'task_crud_bloc.dart';

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

class TaskCrudState extends Equatable {
  final TaskCrudStatus status;
  final Task? task;
  final String? msg;

  const TaskCrudState({required this.status, this.task, this.msg});

  TaskCrudState copyWith({TaskCrudStatus? status, Task? task, String? msg}) =>
      TaskCrudState(
          status: status ?? this.status,
          task: task ?? this.task,
          msg: msg ?? this.msg);

  @override
  List<Object?> get props => [status, task, msg];
}
