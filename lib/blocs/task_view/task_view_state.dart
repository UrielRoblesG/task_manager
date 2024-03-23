part of 'task_view_bloc.dart';

enum TaskListStatus { initial, loading, complete, error }

class TaskViewState extends Equatable {
  final TaskListStatus status;
  final List<Task>? tasks;
  final String? msg;
  const TaskViewState({required this.status, this.tasks, this.msg});

  TaskViewState copyWith(
          {TaskListStatus? status, List<Task>? tasks, String? msg}) =>
      TaskViewState(status: status ?? this.status, tasks: tasks, msg: msg);

  @override
  List<Object?> get props => [status, tasks, msg];
}
