import 'package:codebase_assignment/core/error/base_error.dart';

import 'package:dartz/dartz.dart';

import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class LoginUserUseCase {
  final AuthRepository repository;

  LoginUserUseCase({required this.repository});

  Future<Either<BaseError, UserEntity>> call(String email, String password) {
    return repository.loginUser(email, password);
  }
}
