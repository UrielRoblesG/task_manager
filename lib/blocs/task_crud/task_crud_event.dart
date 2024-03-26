part of 'task_crud_bloc.dart';

sealed class TaskCrudEvent extends Equatable {
  const TaskCrudEvent();
}

class OnViewTask extends TaskCrudEvent {
  final int id;

  const OnViewTask({required this.id});
  @override
  List<Object?> get props => [id];
}

class OnCreateNewTask extends TaskCrudEvent {
  @override
  List<Object?> get props => [];
}

class OnSaveNewTask extends TaskCrudEvent {
  final Task task;

  OnSaveNewTask(this.task);
  @override
  List<Object?> get props => [task];
}

class OnCancelOperation extends TaskCrudEvent {
  @override
  List<Object?> get props => [];
}

class OnDeleteTask extends TaskCrudEvent {
  final Task task;

  OnDeleteTask(this.task);
  @override
  List<Object?> get props => [task];
}

class OnEditTask extends TaskCrudEvent {
  final int id;

  OnEditTask(this.id);
  @override
  List<Object?> get props => [id];
}

class OnUpdateTask extends TaskCrudEvent {
  final Task task;

  const OnUpdateTask(this.task);
  @override
  List<Object?> get props => [task];
}
