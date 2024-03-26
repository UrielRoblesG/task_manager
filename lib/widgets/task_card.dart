import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/blocs/task_crud/task_crud_bloc.dart';
import 'package:task_manager/models/models.dart';
import 'package:task_manager/ui/text_styles.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onTap;

  TaskCard(
      {super.key,
      required this.task,
      this.onTap,
      this.margin = const EdgeInsets.symmetric(vertical: 10),
      this.padding = const EdgeInsets.symmetric(vertical: 4),
      this.borderRadius});
  @override
  Widget build(BuildContext context) {
    final crudBloc = context.read<TaskCrudBloc>();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        decoration: _decoration(
            borderRadius: borderRadius ?? BorderRadius.circular(20)),
        width: double.infinity,
        height: 150,
        child: Stack(
          children: [
            Positioned(
              right: 5,
              top: 2,
              child: GestureDetector(
                  onTapDown: (details) async {
                    final opt = await _showPopupMenu(context, details);

                    if (opt == null) {
                      return;
                    }

                    switch (opt) {
                      case 0:
                        crudBloc.add(OnViewTask(id: task.id!));
                        break;
                      case 1:
                        crudBloc.add(OnEditTask(task.id!));
                        break;
                      case 2:
                        crudBloc.add(OnDeleteTask(task));
                        break;
                      default:
                    }
                  },
                  child: const Icon(Icons.more_vert_rounded)),
            ),
            Column(
              children: [
                _Header(title: task.title ?? ''),
                _Description(
                  description: task.getFormatedDate(),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: _TaskStatus(status: task.isCompleted),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showPopupMenu(BuildContext context, TapDownDetails details) {
    return showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            details.globalPosition.dx,
            details.globalPosition.dy),
        items: const [
          PopupMenuItem(value: 0, child: Text('Ver')),
          PopupMenuItem(value: 1, child: Text('Editar')),
          PopupMenuItem(
              value: 2,
              child: Text('Eliminar', style: TextStyle(color: Colors.red))),
        ],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))));
  }

  BoxDecoration _decoration({BorderRadiusGeometry? borderRadius}) =>
      BoxDecoration(
          borderRadius: borderRadius,
          color: Colors.grey.shade200,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF000000).withOpacity(0.12),
              offset: Offset(0, 0),
              blurRadius: 6,
              spreadRadius: -3,
            )
          ]);
}

class _Description extends StatelessWidget {
  final String? description;
  const _Description({super.key, this.description});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth,
        height: 30,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: (description?.isNotEmpty == true)
            ? Text(
                'Fecha de vencimiento: ${description ?? ''}',
                style: TextStyles.cardDescription(),
              )
            : const SizedBox(),
      ),
    );
  }
}

class _TaskStatus extends StatelessWidget {
  const _TaskStatus({
    super.key,
    required this.status,
  });

  final int? status;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 8, bottom: 2),
        child:
            Text((status == null || status == 0) ? 'Pendiente' : 'Completado'));
  }
}

class _Header extends StatelessWidget {
  final String title;

  const _Header({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        alignment: Alignment.topLeft,
        width: constraints.maxWidth,
        height: 90,
        margin: const EdgeInsets.only(left: 8, top: 8, right: 30),
        child: Text(
          title,
          style: TextStyles.cardTitle(),
        ),
      ),
    );
  }
}
