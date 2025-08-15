import 'package:dartz/dartz.dart';

import '../../../../core/error/base_error.dart';
import '../entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<BaseError, UserEntity>> registerUser(String email, String password);
  Future<Either<BaseError, UserEntity>> loginUser(String email, String password);
  Future<void> logoutUser();
}
