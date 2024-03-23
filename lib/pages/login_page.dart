import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/blocs/auth/auth_bloc.dart';
import 'package:task_manager/pages/pages.dart';
import 'package:task_manager/providers/providers.dart';
import 'package:task_manager/ui/app_colors.dart';
import 'package:task_manager/ui/text_styles.dart';
import 'package:task_manager/utils/route_navigate.dart';
import 'package:task_manager/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.success) {
            Navigator.pushReplacement(
                context, RouteNavigate.createRoute(HomePage()));
          }
        },
        child: Scaffold(
            body: AuthBackground(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.3),
                const _LoginHeader(),
                FormContainer(
                    height: size.height * .4,
                    width: size.width,
                    child: ChangeNotifierProvider(
                      create: (context) => LoginFormProvider(),
                      child: const _LoginForm(),
                    )),
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30),
      width: double.infinity,
      child: const Text(
        'Bienvenido',
        style: TextStyle(color: Colors.black, fontSize: 35),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginFormProvider>(context);
    final authBloc = context.read<AuthBloc>();
    return Container(
      child: Form(
          key: loginProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              InputField(
                icon: Icons.person,
                obscureText: false,
                isPasswordField: false,
                hintText: 'Username',
                validator: (value) {
                  if (value != null && value.isNotEmpty) return null;
                  return 'Este campo no puede estar vacio';
                },
              ),
              InputField(
                icon: Icons.lock_rounded,
                obscureText: loginProvider.passwordVisibility,
                isPasswordField: true,
                hintText: 'Contraseña',
                onChangeVisibility: () {
                  loginProvider.onChangeVisibility();
                },
                validator: (value) {
                  if (value != null && value.isNotEmpty) return null;

                  return 'Este campo no puede estar vacio';
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return _LoginButton(
                        isLoading:
                            (state.status == AuthStatus.loading) ? true : false,
                        onPressed: () {
                          if (!loginProvider.isValid()) return;

                          authBloc.add(OnLoggedIn());
                        },
                      );
                    },
                  )
                ],
              )
            ],
          )),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onPressed;
  final bool isLoading;
  _LoginButton(
      {super.key, this.borderRadius, this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final br = borderRadius ?? BorderRadius.circular(20);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: br,
          gradient: LinearGradient(
              colors: [AppColors.strongGreen(), AppColors.lightGreen()])),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: br)),
          onPressed: onPressed,
          child: (!isLoading)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Login', style: TextStyles.buttonStyle(fontSize: 25)),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.black,
                      size: 25,
                    )
                  ],
                )
              : const CircularProgressIndicator(
                  color: Colors.black,
                )),
    );
  }
}
