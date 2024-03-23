import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/blocs/task_view/task_view_bloc.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/widgets/task_card.dart';
import 'package:task_manager/widgets/widgets.dart';

class TaskListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<TaskViewBloc>().add(OnGetAll());
    return BlocListener<TaskViewBloc, TaskViewState>(
      listener: (context, state) {
        if (state.status == TaskListStatus.error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${state.msg}')));
        }
      },
      child: BlocBuilder<TaskViewBloc, TaskViewState>(
        builder: (context, state) {
          if (state.status == TaskListStatus.loading) {
            return LoadingIndicator();
          } else if (state.status == TaskListStatus.error) {
            return _CenterMsg(msg: state.msg!);
          } else if (state.status == TaskListStatus.initial) {
            return const _CenterMsg(msg: '');
          } else {
            return _TaskListBody(tasks: state.tasks!);
          }
        },
      ),
    );
  }
}

class _TaskListBody extends StatelessWidget {
  final List<Task> tasks;
  final EdgeInsetsGeometry padding;
  const _TaskListBody(
      {super.key,
      this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: padding,
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: tasks.length,
          itemBuilder: (context, i) => TaskCard(task: tasks[i]),
        ),
      ),
    );
  }
}

class _CenterMsg extends StatelessWidget {
  final String msg;
  const _CenterMsg({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Center(child: Text(msg)));
  }
}
