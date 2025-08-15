import 'package:codebase_assignment/core/routes/route_names.dart';
import 'package:codebase_assignment/core/utils/theme/app_colors.dart';
import 'package:codebase_assignment/features/auth/presentation/screens/splash_screen.dart';
import 'package:codebase_assignment/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di.dart';
import 'core/routes/app_routes.dart';
import 'core/services/network_connectivity/network_connectivity.dart';
import 'core/widgets/connectivity_banner/connectivity_banner.dart';
import 'core/widgets/connectivity_banner/cubit/connectivity_cubit.dart';
import 'features/auth/presentation/cubit/local/local_user_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initHive();
  diSetup();
  final networkConnectivityService = serviceLocator.get<NetworkConnectivityService>();
  networkConnectivityService.initialize();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ConnectivityCubit(networkConnectivity: serviceLocator())),
        BlocProvider(create: (context) => LocalUserCubit()),
        BlocProvider(
          create: (context) => TodoCubit(
            addTodoUseCase: serviceLocator(),
            fetchTodosUseCase: serviceLocator(),
            updateTodoUseCase: serviceLocator(),
            deleteTodoUseCase: serviceLocator(),
            deleteAllTodoUseCase: serviceLocator(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Stack(
          children: [
            child ?? const SizedBox(),
            const Positioned(bottom: 0, left: 0, right: 0, child: ConnectivityBanner()),
          ],
        );
      },
      title: 'CodeBase',
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: RouteNames.splash,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary)),
      home: SplashScreen(),
    );
  }
}
