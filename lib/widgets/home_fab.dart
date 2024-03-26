import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/blocs/task_crud/task_crud_bloc.dart';
import 'package:task_manager/providers/providers.dart';

/**
 * Componente que muestra un FloatingActionButton
 * customizado.
 * Tambien genera varios FloatingActionButton dependiendo
 * de lo que el estado necesite 
 */
class HomeFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCrudBloc, TaskCrudState>(
      builder: (context, state) {
        /**
         * Dependiendo del estado muestro los botones necesarios
         */
        switch (state.status) {
          case TaskCrudStatus.initial:
            return const _InitialFab();
          case TaskCrudStatus.create:
            return const _CreateFab();
          case TaskCrudStatus.view:
            return _CloseFab();
          case TaskCrudStatus.update:
            return _UpdateFab();
          default:
            return const SizedBox();
        }
      },
    );
  }
}

class _UpdateFab extends StatelessWidget {
  const _UpdateFab({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskCrudBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
            onPressed: () {
              bloc.add(OnCancelOperation());
            },
            child: const Icon(Icons.cancel_rounded, size: 30)),
        const SizedBox(width: 40),
        FloatingActionButton(
            onPressed: () {
              final formProvider =
                  Provider.of<TaskFormProvider>(context, listen: false);

              if (!formProvider.isValidForm()) return;

              bloc.add(OnUpdateTask(formProvider.task));
            },
            child: const Icon(Icons.save_rounded, size: 30)),
      ],
    );
  }
}

class _CloseFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskCrudBloc>();

    return FloatingActionButton(
        onPressed: () {
          bloc.add(OnCancelOperation());
        },
        child: const Icon(Icons.cancel_rounded, size: 30));
  }
}

class _CreateFab extends StatelessWidget {
  const _CreateFab({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskCrudBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
            onPressed: () {
              bloc.add(OnCancelOperation());
            },
            child: const Icon(Icons.cancel_rounded, size: 30)),
        const SizedBox(width: 40),
        FloatingActionButton(
            onPressed: () {
              final formProvider =
                  Provider.of<TaskFormProvider>(context, listen: false);

              if (!formProvider.isValidForm()) return;

              bloc.add(OnSaveNewTask(formProvider.task));
            },
            child: const Icon(Icons.save_rounded, size: 30)),
      ],
    );
  }
}

class _InitialFab extends StatelessWidget {
  const _InitialFab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskCrudBloc>();
    return FloatingActionButton(
      onPressed: () {
        bloc.add(OnCreateNewTask());
      },
      child: const Icon(
        Icons.add_rounded,
        size: 30,
      ),
    );
  }
}
