import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codebase_assignment/core/services/network_connectivity/network_connectivity.dart';
import 'package:codebase_assignment/core/utils/constants/app_constants.dart';
import 'package:codebase_assignment/core/utils/sharedpref_helper.dart';
import 'package:codebase_assignment/core/widgets/connectivity_banner/cubit/connectivity_cubit.dart';
import 'package:codebase_assignment/features/auth/data/data_source/remote/user_remote_data_source.dart';
import 'package:codebase_assignment/features/auth/data/repository/auth_repository_impl.dart';
import 'package:codebase_assignment/features/auth/domain/usecase/logout_user_usecase.dart';
import 'package:codebase_assignment/features/auth/domain/usecase/register_user_usecase.dart';
import 'package:codebase_assignment/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:codebase_assignment/features/todo/data/data_source/remote/todo_remote_data_source.dart';
import 'package:codebase_assignment/features/todo/data/repository/todo_repository_impl.dart';
import 'package:codebase_assignment/features/todo/domain/repository/todo_repository.dart';
import 'package:codebase_assignment/features/todo/domain/usecase/todo_usecases.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../features/auth/domain/repository/auth_repository.dart';
import '../features/auth/domain/usecase/login_user_usecase.dart';
import '../features/auth/presentation/cubit/local/local_user_cubit.dart';
import '../features/todo/data/data_source/local/todo_local_data_source.dart';
import '../features/todo/data/models/todo_model.dart';
import '../features/todo/presentation/cubit/todo_cubit.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>(AppConstants.todoCollection);
}

final serviceLocator = GetIt.instance;

diSetup() {
  serviceLocator.registerLazySingleton(
    () => PrettyDioLogger(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      logPrint: (log) {
        return debugPrint(log as String);
      },
    ),
  );

  serviceLocator.registerLazySingleton(() => Connectivity());
  serviceLocator.registerSingleton<SharedPrefHelper>(SharedPrefHelper()).init();

  serviceLocator.registerLazySingleton<NetworkConnectivityService>(() => NetworkConnectivityService());

  serviceLocator.registerFactory(
    () => ConnectivityCubit(networkConnectivity: serviceLocator<NetworkConnectivityService>()),
  );

  // Auth factory
  serviceLocator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  serviceLocator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(auth: serviceLocator(), fireStore: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<LoginUserUseCase>(
    () => LoginUserUseCase(repository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<RegisterUserUseCase>(
    () => RegisterUserUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<LogoutUserUseCase>(
    () => LogoutUserUseCase(repository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      logoutUserUseCase: serviceLocator(),
      loginUserUseCase: serviceLocator(),
      registerUserUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<LocalUserCubit>(() => LocalUserCubit());

  // Todos Factory
  serviceLocator.registerLazySingleton<AddTodoUseCase>(() => AddTodoUseCase(repository: serviceLocator()));
  serviceLocator.registerLazySingleton<FetchTodosUseCase>(
    () => FetchTodosUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<UpdateTodoUseCase>(
    () => UpdateTodoUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<DeleteTodoUseCase>(
    () => DeleteTodoUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<DeleteALlTodoUseCase>(
    () => DeleteALlTodoUseCase(repository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSource(firestore: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<TodoLocalDataSource>(() => TodoLocalDataSource(serviceLocator()));

  serviceLocator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
      network: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<Box<TodoModel>>(
    () => Hive.box<TodoModel>(AppConstants.todoCollection),
  );

  serviceLocator.registerLazySingleton<TodoCubit>(
    () => TodoCubit(
      addTodoUseCase: serviceLocator(),
      fetchTodosUseCase: serviceLocator(),
      updateTodoUseCase: serviceLocator(),
      deleteTodoUseCase: serviceLocator(),
      deleteAllTodoUseCase: serviceLocator(),
    ),
  );
}
