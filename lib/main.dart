import 'package:flutter/material.dart';
import 'package:task_manager/blocs/auth/auth_bloc.dart';
import 'package:task_manager/blocs/filter/filters_bloc.dart';
import 'package:task_manager/blocs/task_crud/task_crud_bloc.dart';
import 'package:task_manager/blocs/task_view/task_view_bloc.dart';
import 'package:task_manager/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/services/services.dart';
import 'package:task_manager/ui/app_colors.dart';
import 'package:task_manager/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  await authService.initialize();
  runApp(BlocProvider(
    create: (context) => AuthBloc(authService: authService),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Revisar si el usuario esta con una sesion activa o inactiva
    context.read<AuthBloc>().add(OnAppStarted());
    return MaterialApp(
      // Definicion de temas para la app
      theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: AppColors.strongGreen())),
      debugShowCheckedModeBanner: false,
      title: 'TaskManager',
      home: BlocConsumer<AuthBloc, AuthState>(
        // Selecciona que pantalla mostrar depandiendo de si el usuario esta
        // con sesion activa o no
        listener: (context, state) {
          if (state.status == AuthStatus.error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.msg ?? '')));
          }
        },
        builder: (context, state) {
          // Sesion activa
          if (state.status == AuthStatus.success) {
            final taskService = TaskService();
            // Declaracion de las clases que manejaran los distintos eventos de la app
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => FiltersBloc(),
                ),
                BlocProvider(
                  create: (context) => TaskCrudBloc(
                      taskService: taskService,
                      authService: context.read<AuthBloc>().authService),
                ),
                BlocProvider(
                  create: (context) => TaskViewBloc(
                      crudBloc: context.read<TaskCrudBloc>(),
                      filtersBloc: context.read<FiltersBloc>(),
                      authService: context.read<AuthBloc>().authService,
                      taskService: taskService),
                ),
              ],
              child: Builder(builder: (context) {
                // Construccion de la pagina principal de la app
                return HomePage();
              }),
            );
          } else if (state.status == AuthStatus.loading) {
            return LoadingIndicator();
          }
          // Sesion inactiva
          return LoginPage();
        },
      ),
    );
  }
}
