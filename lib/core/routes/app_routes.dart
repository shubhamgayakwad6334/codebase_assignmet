import 'package:codebase_assignment/core/routes/route_names.dart';
import 'package:codebase_assignment/features/auth/domain/entity/user_entity.dart';
import 'package:codebase_assignment/features/auth/presentation/screens/login_screen.dart';
import 'package:codebase_assignment/features/todo/presentation/screens/home_screen.dart';
import 'package:codebase_assignment/features/auth/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/register_screen.dart';


class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case RouteNames.home:
        final user = settings.arguments as UserEntity;
        return MaterialPageRoute(builder: (_) => HomeScreen(user: user));

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('No route defined'))),
        );
    }
  }
}
