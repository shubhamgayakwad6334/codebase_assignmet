import 'package:equatable/equatable.dart';

import '../../../../auth/domain/entity/user_entity.dart';

abstract class LocalUserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocalUserInitial extends LocalUserState {
  @override
  List<Object> get props => [];
}

class LocalUserLoading extends LocalUserState {}

class LocalUserSuccessState extends LocalUserState {
  final UserEntity userDetails;

  LocalUserSuccessState({required this.userDetails});

  @override
  List<Object> get props => [userDetails];
}

class LocalUserErrorState extends LocalUserState {
  final String error;

  LocalUserErrorState(this.error);

  @override
  List<Object> get props => [error];
}
