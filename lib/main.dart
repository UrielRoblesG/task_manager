import 'package:flutter/material.dart';
import 'package:task_manager/blocs/auth/auth_bloc.dart';
import 'package:task_manager/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/services/services.dart';
import 'package:task_manager/ui/app_colors.dart';

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
    context.read<AuthBloc>().add(OnAppStarted());
    return MaterialApp(
      theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: AppColors.strongGreen())),
      debugShowCheckedModeBanner: false,
      title: 'TaskManager',
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.msg ?? '')));
          }
        },
        builder: (context, state) {
          if (state.status == AuthStatus.success) {
            return HomePage();
          }

          return LoginPage();
        },
      ),
    );
  }
}
