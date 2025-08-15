import 'package:codebase_assignment/core/error/network_error.dart';
import 'package:codebase_assignment/core/utils/constants/app_constants.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class DioExceptionHandler {
  static Either<NetworkError, T> handle<T>(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.badResponse:
        return Left(
          NetworkError(
            message: dioError.response?.data is Map && dioError.response?.data["message"] != null
                ? dioError.response?.data["message"]
                : "Something went wrong",
            httpError: dioError.response?.statusCode ?? 400,
          ),
        );

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Left(NetworkError(message: "Connection timeout with API server", httpError: 408));

      case DioExceptionType.cancel:
        return Left(NetworkError(message: "Request to API server was cancelled", httpError: 499));

      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return Left(NetworkError(message: "Something went wrong", httpError: 500));

      case DioExceptionType.connectionError:
        return Left(NetworkError(message: "Please check internet connection.", httpError: 503));
    }
  }

  static Either<NetworkError, T> handleFirebaseException<T>(String error) {
    switch (error) {
      case 'email-already-in-use':
        return Left(NetworkError(message: AppConstants.emailIsAlreadyInUse, httpError: 400));
      case 'invalid-credential':
        return Left(NetworkError(message: AppConstants.invalidCredentials, httpError: 401));
      case 'weak-password':
        return Left(NetworkError(message: AppConstants.passwordIsTooWeak, httpError: 402));
      case 'network-request-failed':
        return Left(NetworkError(message: AppConstants.connectionTimeout, httpError: 503));
      default:
        return Left(NetworkError(message: AppConstants.somethingWentWrong, httpError: 500));
    }
  }
}
