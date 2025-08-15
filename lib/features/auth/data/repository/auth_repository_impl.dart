import 'package:codebase_assignment/core/error/base_error.dart';
import 'package:codebase_assignment/features/auth/data/data_source/mappers/user_data_mapper.dart';
import 'package:codebase_assignment/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entity/user_entity.dart';
import '../data_source/remote/user_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final UserRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<BaseError, UserEntity>> registerUser(String email, String password) async {
    final Either<BaseError, UserCredential> userCredentials;
    userCredentials = await remoteDataSource.registerUser(email, password);
    return userCredentials.fold((error) => Left(error), (result) => Right(result.toEntity()));
  }

  @override
  Future<Either<BaseError, UserEntity>> loginUser(String email, String password) async {
    final Either<BaseError, UserCredential> userCredentials;
    userCredentials = await remoteDataSource.loginUser(email, password);
    return userCredentials.fold((error) => Left(error), (result) => Right(result.toEntity()));
  }

  @override
  Future<void> logoutUser() async {
    await remoteDataSource.logoutUser();
  }
}
