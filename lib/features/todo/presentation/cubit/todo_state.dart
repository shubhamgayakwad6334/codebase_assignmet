import 'package:equatable/equatable.dart';

import '../../domain/entity/todo_entity.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodoState {}

class AddTodoLoading extends TodoState {}

class AddTodoSuccess extends TodoState {
  @override
  List<Object?> get props => [];
}

class AddTodoFailed extends TodoState {
  final String error;
  AddTodoFailed({required this.error});
  @override
  List<Object?> get props => [error];
}

class UpdateTodoLoading extends TodoState {}

class UpdateTodoSuccess extends TodoState {
  @override
  List<Object?> get props => [];
}

class UpdateTodoFailed extends TodoState {
  final String error;
  UpdateTodoFailed({required this.error});
  @override
  List<Object?> get props => [error];
}

class DeleteTodoLoading extends TodoState {}

class DeleteTodoSuccess extends TodoState {
  @override
  List<Object?> get props => [];
}

class DeleteTodoFailed extends TodoState {
  final String error;

  DeleteTodoFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

class TodosLoading extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodosSuccess extends TodoState {
  final List<TodoEntity> todos;

  TodosSuccess({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class TodosFailed extends TodoState {
  final String error;

  TodosFailed({required this.error});

  @override
  List<Object?> get props => [error];
}
