import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/models.dart';
import 'package:task_manager/providers/filters_provider.dart';

class TaskFilters extends StatelessWidget {
  const TaskFilters({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FiltersProvider>(context);
    final filters = provider.filters;
    final choice = provider.selected;
    return Container(
        height: 60,
        width: double.infinity,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: filters
              .map((f) => _Filter(
                    filter: f,
                    selected: (choice == f.id) ? true : false,
                    onPressed: () {
                      provider.selected = f.id;
                    },
                  ))
              .toList(),
        ));
  }
}

class _Filter extends StatelessWidget {
  final Filter filter;
  final bool selected;
  final VoidCallback? onPressed;
  _Filter(
      {super.key,
      required this.filter,
      required this.selected,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: (selected) ? Colors.red : Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(onPressed: onPressed, child: Text(filter.name)));
  }
}
