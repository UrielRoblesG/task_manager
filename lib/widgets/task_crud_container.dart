import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/blocs/task_crud/task_crud_bloc.dart';
import 'package:task_manager/models/models.dart';
import 'package:task_manager/providers/providers.dart';
import 'package:task_manager/ui/app_colors.dart';
import 'package:task_manager/widgets/widgets.dart';

class TaskCrudContainer extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  const TaskCrudContainer(
      {super.key,
      this.borderRadius = const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20))});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCrudBloc, TaskCrudState>(
      builder: (context, state) {
        Widget? child;
        switch (state.status) {
          case TaskCrudStatus.loading:
            child = const SizedBox(
                width: double.infinity,
                height: 100,
                child: Center(child: CircularProgressIndicator()));
            break;
          case TaskCrudStatus.create:
            child = _CreateForm();
            break;
          case TaskCrudStatus.view:
            child = _ViewForm(
              task: state.task!,
            );
            break;
          case TaskCrudStatus.update:
            final provider =
                Provider.of<TaskFormProvider>(context, listen: false);
            provider.task = state.task!.copyWith();
            child = _UpdateForm(
              task: state.task!.copyWith(),
            );
            break;
          default:
        }

        return (state.status != TaskCrudStatus.initial)
            ? Builder(builder: (context) {
                return Container(
                  padding: const EdgeInsets.only(
                      top: 30, left: 20, right: 20, bottom: 20),
                  decoration: BoxDecoration(borderRadius: borderRadius),
                  child: child,
                );
              })
            : const SizedBox();
      },
    );
  }
}

class _ViewForm extends StatelessWidget {
  final Task task;
  const _ViewForm({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        InputField(
          hintText: 'Titulo',
          initialValue: task.title,
          enabled: false,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 200,
              child: Text('Pendiente/Completado'),
            ),
            Switch(
              activeTrackColor: AppColors.strongGreen(),
              onChanged: (val) {},
              value: (task.isCompleted == 1) ? true : false,
            )
          ],
        ),
        InputField(
          hintText: 'Descripción',
          maxLines: null,
          enabled: false,
          initialValue: task.description,
        ),
        SizedBox(
          width: 200,
          child: InputField(
            enabled: false,
            hintText: 'Fecha de vencimiento',
            initialValue: (task.dueDate != null)
                ? "${task.dueDate?.year.toString().padLeft(4, '0')}-${task.dueDate?.month.toString().padLeft(2, '0')}-${task.dueDate?.day.toString().padLeft(2, '0')}"
                : '',
          ),
        ),
        InputField(
          hintText: 'Comentarios',
          enabled: false,
          initialValue: task.comments,
          maxLines: null,
        ),
        InputField(
          enabled: false,
          hintText: 'Tags',
          initialValue: task.tags,
        ),
      ],
    );
  }
}

class _CreateForm extends StatelessWidget {
  final TextEditingController dueDateController = TextEditingController();

  _CreateForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskFormProvider>(context);
    dueDateController.text = provider.task.getFormatedDate()!;
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: provider.formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            InputField(
              hintText: 'Titulo',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo no puede estar vacio';
                }
                return null;
              },
              onChanged: (value) => provider.setTitle = value,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 200,
                  child: Text('Pendiente/Completado'),
                ),
                Switch(
                    activeTrackColor: AppColors.strongGreen(),
                    value: provider.getStatus,
                    onChanged: (value) => provider.setStatus = value)
              ],
            ),
            InputField(
              hintText: 'Descripción',
              maxLines: null,
              onChanged: (value) => provider.setDescription = value,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: InputField(
                    controller: dueDateController,
                    hintText: 'Fecha de vencimiento',
                  ),
                ),
                CustomBtn(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 999999)));

                      if (selectedDate == null) return;
                      provider.setDueDate = selectedDate;
                      dueDateController.text = provider.getFormatedDate ?? '';
                    },
                    child:
                        const Icon(Icons.calendar_month, color: Colors.black)),
              ],
            ),
            InputField(
              hintText: 'Comentarios',
              onChanged: (value) => provider.setComentarios = value,
              maxLines: null,
            ),
            InputField(
              hintText: 'Tags',
              onChanged: (value) => provider.setTags = value,
            ),
          ],
        ));
  }
}

class _UpdateForm extends StatelessWidget {
  final Task task;
  final TextEditingController dueDateController = TextEditingController();

  _UpdateForm({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskFormProvider>(context);
    dueDateController.text = provider.task.getFormatedDate()!;
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: provider.formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            InputField(
              hintText: 'Titulo',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Este campo no puede estar vacio';
                }
                return null;
              },
              initialValue: task.title,
              onChanged: (value) => provider.setTitle = value,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 200,
                  child: Text('Pendiente/Completado'),
                ),
                Switch(
                    activeTrackColor: AppColors.strongGreen(),
                    value: provider.getStatus,
                    onChanged: (value) => provider.setStatus = value)
              ],
            ),
            InputField(
              hintText: 'Descripción',
              maxLines: null,
              initialValue: task.description,
              onChanged: (value) => provider.setDescription = value,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: InputField(
                    controller: dueDateController,
                    hintText: 'Fecha de vencimiento',
                  ),
                ),
                CustomBtn(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 999999)));

                      if (selectedDate == null) return;
                      provider.setDueDate = selectedDate;
                      dueDateController.text = provider.getFormatedDate ?? '';
                    },
                    child:
                        const Icon(Icons.calendar_month, color: Colors.black)),
              ],
            ),
            InputField(
              hintText: 'Comentarios',
              initialValue: task.comments,
              onChanged: (value) => provider.setComentarios = value,
              maxLines: null,
            ),
            InputField(
              hintText: 'Tags',
              initialValue: task.tags,
              onChanged: (value) => provider.setTags = value,
            ),
          ],
        ));
  }
}
