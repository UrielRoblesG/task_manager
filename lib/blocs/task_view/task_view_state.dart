part of 'task_view_bloc.dart';

enum TaskListStatus { initial, loading, complete, changed, error }

class TaskViewState extends Equatable {
  final TaskListStatus status;
  final List<Task>? tasks;
  final List<Task>? filteredTasks;
  final String? msg;
  const TaskViewState(
      {required this.status, this.tasks, this.filteredTasks, this.msg});

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

  @override
  List<Object?> get props => [status, tasks, msg, filteredTasks];
}
