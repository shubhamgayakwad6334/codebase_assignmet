import 'package:codebase_assignment/features/auth/data/data_source/mappers/user_data_mapper.dart';
import 'package:codebase_assignment/features/auth/domain/entity/user_entity.dart';
import 'package:codebase_assignment/features/auth/domain/usecase/login_user_usecase.dart';
import 'package:codebase_assignment/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/sharedpref_helper.dart';
import '../../domain/usecase/logout_user_usecase.dart';
import '../../domain/usecase/register_user_usecase.dart';

class AuthCubit extends Cubit<AuthState> {
  LoginUserUseCase loginUserUseCase;
  RegisterUserUseCase registerUserUseCase;
  LogoutUserUseCase logoutUserUseCase;

  AuthCubit({
    required this.loginUserUseCase,
    required this.registerUserUseCase,
    required this.logoutUserUseCase,
  }) : super(AuthInitial());

  Future<void> loginUser({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await loginUserUseCase.call(email, password);
    result.fold((e) => emit(AuthFailure(e.message)), (UserEntity result) {
      SharedPrefHelper.setUserDetails(user: result.toDto());
      emit(AuthSuccess(userEntity: result));
    });
  }

  Future<void> registerUser({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await registerUserUseCase.call(email, password);
    result.fold((e) => emit(AuthFailure(e.message)), (result) {
      SharedPrefHelper.setUserDetails(user: result.toDto());
      emit(AuthSuccess(userEntity: result));
    });
  }

  Future<void> logoutUser() async {
    emit(AuthLoading());
    await logoutUserUseCase.call();
    await SharedPrefHelper.deleteAll();
    emit(LogoutSuccess());
  }
}
