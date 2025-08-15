import 'package:codebase_assignment/core/di.dart';
import 'package:codebase_assignment/core/routes/route_names.dart';
import 'package:codebase_assignment/core/utils/theme/app_colors.dart';
import 'package:codebase_assignment/features/auth/domain/entity/user_entity.dart';
import 'package:codebase_assignment/features/auth/presentation/cubit/auth_state.dart';
import 'package:codebase_assignment/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:codebase_assignment/features/todo/presentation/widgets/add_todo_widget.dart';
import 'package:codebase_assignment/features/todo/presentation/widgets/todo_board_screen.dart';
import 'package:codebase_assignment/features/todo/presentation/widgets/user_heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/custom_dialog.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/local/local_user_cubit.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.user});

  final UserEntity user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LocalUserCubit>().fetchUserDataFromLocal();
    context.read<TodoCubit>().fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(
        logoutUserUseCase: serviceLocator(),
        registerUserUseCase: serviceLocator(),
        loginUserUseCase: serviceLocator(),
      ),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            return CustomLoading.showLoader(context);
          }
          if (state is LogoutSuccess) {
            CustomLoading.hideLoader(context);
            Utils.showSnackBar(context, AppConstants.logOutSuccess);
            Navigator.pushNamedAndRemoveUntil(context, RouteNames.login, (route) => false);
          }
        },
        builder: (builderContext, state) {
          return Scaffold(
            floatingActionButton: AddTodoWidget(),
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              actions: [
                IconButton(
                  icon: Icon(Icons.logout, color: Colors.white),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => CustomAlertDialog(
                        title: AppConstants.logOut,
                        titleColor: AppColors.red,
                        content: AppConstants.logoutConfirmation,
                        onConfirm: () {
                          builderContext.read<AuthCubit>().logoutUser();
                        },
                      ),
                    );
                  },
                ),
              ],
              title: Center(
                child: Text(
                  AppConstants.kanbanBoard,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [UserHeadingWidget(), SizedBox(height: 26), TodoBoardScreen()],
              ),
            ),
          );
        },
      ),
    );
  }
}
