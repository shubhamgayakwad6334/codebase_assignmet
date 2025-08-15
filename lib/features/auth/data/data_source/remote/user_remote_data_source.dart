import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codebase_assignment/core/error/base_error.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/utils/dio_exception_handler.dart';

class UserRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore fireStore;

  UserRemoteDataSource({required this.auth, required this.fireStore});

  Future<Either<BaseError, UserCredential>> registerUser(String email, String password) async {
    try {
      final response = await auth.createUserWithEmailAndPassword(email: email, password: password);
      return Right(response);
    } on FirebaseAuthException catch (e) {
      return DioExceptionHandler.handleFirebaseException(e.code);
    } on DioException catch (dioError) {
      return DioExceptionHandler.handle<UserCredential>(dioError);
    }
  }

  Future<Either<BaseError, UserCredential>> loginUser(String email, String password) async {
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(response);
    } on FirebaseAuthException catch (e) {
      return DioExceptionHandler.handleFirebaseException(e.code);
    } on DioException catch (dioError) {
      return DioExceptionHandler.handle<UserCredential>(dioError);
    }
  }

  Future<Either<BaseError, void>> logoutUser() async {
    try {
      await Future.delayed(Duration(seconds: 3));
      await FirebaseAuth.instance.signOut();
      return Right(null);
    } on FirebaseAuthException catch (e) {
      return DioExceptionHandler.handleFirebaseException(e.code);
    } on DioException catch (dioError) {
      return DioExceptionHandler.handle<void>(dioError);
    }
  }
}
