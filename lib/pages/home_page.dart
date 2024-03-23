import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/providers/filters_provider.dart';
import 'package:task_manager/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => FiltersProvider(),
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'TaskManager',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.exit_to_app_rounded))
              ],
            ),
            body: Column(
              children: [TaskFilters()],
            )));
  }
}
