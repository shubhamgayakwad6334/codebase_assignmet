import 'package:codebase_assignment/core/di.dart';
import 'package:codebase_assignment/core/routes/route_names.dart';
import 'package:codebase_assignment/core/utils/constants/app_constants.dart';
import 'package:codebase_assignment/core/utils/theme/app_colors.dart';
import 'package:codebase_assignment/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants/app_images.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        logoutUserUseCase: serviceLocator(),
        loginUserUseCase: serviceLocator(),
        registerUserUseCase: serviceLocator(),
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  SizedBox(height: 130),
                  Center(child: Image.asset(AppImages.appLogo, width: 150, height: 150)),
                  SizedBox(height: 100),
                  CustomTextField(
                    prefixIcon: Icon(Icons.email),
                    controller: emailController,
                    hint: AppConstants.email,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppConstants.enterEmail;
                      } else if (!Utils.emailRegex.hasMatch(value)) {
                        return AppConstants.enterValidEmail;
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: passwordController,
                    prefixIcon: Icon(Icons.lock),
                    obscureText: true,
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    hint: AppConstants.password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppConstants.enterPassword;
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 60),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Utils.showSnackBar(context, AppConstants.loginSuccess);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteNames.home,
                          (route) => false,
                          arguments: state.userEntity,
                        );
                      } else if (state is AuthFailure) {
                        Utils.showSnackBar(context, state.message, isError: true);
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        title: AppConstants.login,
                        isLoading: state is AuthLoading ? true : false,
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            context.read<AuthCubit>().loginUser(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                          }
                        },
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.register);
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: AppConstants.dontHaveAccount),
                          TextSpan(
                            text: AppConstants.register,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
