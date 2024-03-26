import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/blocs/filter/filters_bloc.dart';
import 'package:task_manager/models/models.dart';
import 'package:task_manager/ui/app_colors.dart';
import 'package:task_manager/ui/text_styles.dart';

/**
 * Componente chip para los botones de los filtros
 */
class TaskFilters extends StatelessWidget {
  const TaskFilters({super.key});
  @override
  Widget build(BuildContext context) {
    final filtersBloc = context.read<FiltersBloc>();
    final filters = filtersBloc.filters;
    return Container(
        height: 60,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: BlocBuilder<FiltersBloc, int>(
          builder: (context, state) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: filters
                  .map((f) => _Filter(
                        filter: f,
                        selected: (state == f.id) ? true : false,
                        onPressed: () {
                          filtersBloc.add(OnSelectionChanged(choice: f.id));
                        },
                      ))
                  .toList(),
            );
          },
        ));
  }
}

class _Filter extends StatelessWidget {
  final Filter filter;
  final bool selected;
  final VoidCallback? onPressed;
  final BorderRadiusGeometry? borderRadius;

  _Filter(
      {super.key,
      required this.filter,
      required this.selected,
      this.borderRadius,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    final br = borderRadius ?? BorderRadius.circular(20);

    return AnimatedContainer(
        decoration: BoxDecoration(
          color: _getBackgroundColor(selected),
          borderRadius: br,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: br),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent),
            onPressed: onPressed,
            child: Text(
              filter.name,
              style: TextStyles.buttonStyle(),
            )));
  }

  Color _getBackgroundColor(bool selected) =>
      (selected) ? AppColors.strongGreen() : AppColors.lightGreen();
}
