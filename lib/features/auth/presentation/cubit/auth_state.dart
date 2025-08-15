import 'package:codebase_assignment/features/auth/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState {
  final UserEntity userEntity;
  AuthSuccess({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class LogoutSuccess extends AuthState {
  LogoutSuccess();

  @override
  List<Object?> get props => [];
}

// class Authenticated extends AuthState {}
//
// class Unauthenticated extends AuthState {}
