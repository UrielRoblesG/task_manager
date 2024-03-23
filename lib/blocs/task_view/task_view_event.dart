part of 'task_view_bloc.dart';

sealed class TaskViewEvent extends Equatable {
  const TaskViewEvent();
}

class OnGetAll extends TaskViewEvent {
  @override
  List<Object?> get props => [];
}
