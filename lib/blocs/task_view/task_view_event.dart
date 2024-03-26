part of 'task_view_bloc.dart';

sealed class TaskViewEvent extends Equatable {
  const TaskViewEvent();
}

class OnGetAll extends TaskViewEvent {
  @override
  List<Object?> get props => [];
}

class OnGetByFilter extends TaskViewEvent {
  final int filter;

  const OnGetByFilter({required this.filter});

  @override
  List<Object?> get props => [];
}

class OnUpdateTaskList extends TaskViewEvent {
  final Task task;

  OnUpdateTaskList(this.task);

  @override
  List<Object?> get props => [task];
}

class OnRemoveTaskFromList extends TaskViewEvent {
  final Task task;

  OnRemoveTaskFromList(this.task);

  @override
  List<Object?> get props => [task];
}
