import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/blocs/auth/auth_bloc.dart';
import 'package:task_manager/providers/providers.dart';
import 'package:task_manager/views/views.dart';
import 'package:task_manager/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ChangeNotifierProvider(
          create: (context) => TaskFormProvider(),
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  'TaskManager',
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        final bloc =
                            context.read<AuthBloc>().add(OnLoggedOut());
                      },
                      icon: const Icon(Icons.exit_to_app_rounded))
                ],
              ),
              body: Column(
                children: [TaskFilters(), TaskListView()],
              ),
              bottomSheet: Builder(builder: (context) {
                return TaskCrudContainer();
              }),
              floatingActionButton: HomeFab()),
        ));
  }
}
