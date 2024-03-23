import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/blocs/auth/auth_bloc.dart';
import 'package:task_manager/blocs/filter/filters_bloc.dart';
import 'package:task_manager/blocs/task_view/task_view_bloc.dart';
import 'package:task_manager/services/task_service.dart';
import 'package:task_manager/views/views.dart';
import 'package:task_manager/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FiltersBloc(),
          ),
          BlocProvider(
            create: (context) => TaskViewBloc(
                authService: context.read<AuthBloc>().authService,
                taskService: TaskService()),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'TaskManager',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.exit_to_app_rounded))
            ],
          ),
          body: Column(
            children: [TaskFilters(), TaskListView()],
          ),
          // bottomSheet: TaskActionSheet(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add_rounded),
          ),
        ));
  }
}
