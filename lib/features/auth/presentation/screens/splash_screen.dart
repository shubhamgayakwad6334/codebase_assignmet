import 'dart:async';

import 'package:codebase_assignment/core/utils/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/route_names.dart';
import '../cubit/local/local_user_cubit.dart';
import '../cubit/local/local_user_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalUserCubit>(
      create: (context) => LocalUserCubit()..fetchUserDataFromLocal(),
      child: Scaffold(
        body: BlocListener<LocalUserCubit, LocalUserState>(
          listener: (BuildContext context, state) {
            if (state is LocalUserSuccessState) {
              _timer = Timer(
                const Duration(seconds: 2),
                () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.home,
                  (route) => false,
                  arguments: state.userDetails,
                ),
              );
            } else if (state is LocalUserErrorState) {
              _timer = Timer(
                const Duration(seconds: 2),
                () => Navigator.pushNamedAndRemoveUntil(context, RouteNames.login, (route) => false),
              );
            }
          },
          child: Center(child: SizedBox(height: 150, width: 150, child: Image.asset(AppImages.appLogo))),
        ),
      ),
    );
  }
}
