import 'package:dartz/dartz.dart';

import '../../../../core/error/base_error.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUserUseCase {
  final AuthRepository repository;

  RegisterUserUseCase({required this.repository});

  Future<Either<BaseError, UserEntity>> call(String email, String password) async {
    return await repository.registerUser(email, password);
  }
}
