import 'package:codebase_assignment/core/di.dart';
import 'package:codebase_assignment/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:codebase_assignment/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/route_names.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/constants/app_images.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(
        registerUserUseCase: serviceLocator(),
        loginUserUseCase: serviceLocator(),
        logoutUserUseCase: serviceLocator(),
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
                  SizedBox(height: 100),
                  Center(child: Image.asset(AppImages.appLogo, width: 150, height: 150)),
                  SizedBox(height: 60),
                  CustomTextField(
                    controller: nameController,
                    prefixIcon: Icon(Icons.lock),
                    textInputAction: TextInputAction.next,
                    hint: AppConstants.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppConstants.enterPassword;
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    prefixIcon: Icon(Icons.email),
                    controller: emailController,
                    obscureText: true,
                    maxLines: 1,
                    hint: AppConstants.email,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppConstants.enterEmail;
                      } else if (value.length < 6) {
                        return AppConstants.enterValidPassword;
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
                    textInputAction: TextInputAction.next,
                    hint: AppConstants.password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppConstants.enterPassword;
                      } else if (value.length < 6) {
                        return AppConstants.enterValidPassword;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: confirmPasswordController,
                    prefixIcon: Icon(Icons.lock),
                    textInputAction: TextInputAction.done,
                    hint: AppConstants.confirmPassword,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppConstants.enterConfirmPassword;
                      } else if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
                        return AppConstants.passwordDoesNotMatch;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 60),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (BuildContext context, AuthState state) {
                      if (state is AuthSuccess) {
                        Utils.showSnackBar(context, AppConstants.registerSuccess);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouteNames.home,
                          (routes) => false,
                          arguments: state.userEntity,
                        );
                      } else if (state is AuthFailure) {
                        Utils.showSnackBar(context, state.message, isError: true);
                      }
                    },
                    builder: (BuildContext context, AuthState state) {
                      return CustomButton(
                        isLoading: state is AuthLoading,
                        title: AppConstants.register,
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            context.read<AuthCubit>().registerUser(
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
                      Navigator.pushNamedAndRemoveUntil(context, RouteNames.login, (route) => false);
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: AppConstants.alreadyHaveAccount),
                          TextSpan(
                            text: AppConstants.login,
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
