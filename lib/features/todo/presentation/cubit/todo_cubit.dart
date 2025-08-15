import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../domain/entity/todo_entity.dart';
import '../../domain/usecase/todo_usecases.dart';
import 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final AddTodoUseCase addTodoUseCase;
  final FetchTodosUseCase fetchTodosUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final DeleteALlTodoUseCase deleteAllTodoUseCase;

  TodoCubit({
    required this.addTodoUseCase,
    required this.fetchTodosUseCase,
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
    required this.deleteAllTodoUseCase,
  }) : super(TodoInitial()) {
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    emit(TodosLoading());
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        emit(TodosFailed(error: AppConstants.userNotLoggedIn));
      }
      final todos = await fetchTodosUseCase(userId ?? "");
      emit(TodosSuccess(todos: todos));
    } catch (e) {
      emit(TodosFailed(error: AppConstants.failedToFetchTodos));
    }
  }

  Future<void> addTodo(TodoEntity todo) async {
    try {
      emit(AddTodoLoading());
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        emit(AddTodoFailed(error: AppConstants.userNotLoggedIn));
        return;
      }

      await addTodoUseCase(userId, todo);
      emit(AddTodoSuccess());
      fetchTodos();
    } catch (e) {
      emit(AddTodoFailed(error: AppConstants.failedToCreateTodo));
    }
  }

  Future<void> updateTodo(TodoEntity todo) async {
    try {
      emit(UpdateTodoLoading());
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        emit(UpdateTodoFailed(error: AppConstants.userNotLoggedIn));
        return;
      }
      await updateTodoUseCase(userId, todo);
      emit(UpdateTodoSuccess());
      fetchTodos();
    } catch (e) {
      emit(UpdateTodoFailed(error: AppConstants.failedToUpdateTodo));
    }
  }

  Future<void> deleteTodo(String todoId) async {
    try {
      emit(DeleteTodoLoading());
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        emit(DeleteTodoFailed(error: AppConstants.userNotLoggedIn));
        return;
      }

      await deleteTodoUseCase(userId, todoId);
      fetchTodos();
    } catch (e) {
      emit(DeleteTodoFailed(error: AppConstants.failedToDeleteTodo));
    }
  }
}
