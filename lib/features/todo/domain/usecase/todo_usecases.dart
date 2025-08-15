import 'package:equatable/equatable.dart';
import '../entity/todo_entity.dart';
import '../repository/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository repository;

  AddTodoUseCase({required this.repository});

  Future<void> call(String userId, TodoEntity todo) {
    return repository.addTodo(userId, todo);
  }
}

class TodoRequestParams extends Equatable {
  final String title;
  final String description;
  final int status;

  const TodoRequestParams({required this.title, required this.description, required this.status});

  @override
  List<Object?> get props => [title, description, status];

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "status": status,
  };
}

class FetchTodosUseCase {
  final TodoRepository repository;

  FetchTodosUseCase({required this.repository});

  Future<List<TodoEntity>> call(String userId) {
    return repository.fetchTodos(userId);
  }
}

class UpdateTodoUseCase {
  final TodoRepository repository;

  UpdateTodoUseCase({required this.repository});

  Future<void> call(String userId, TodoEntity todo) {
    return repository.updateTodo(userId, todo);
  }
}

class DeleteTodoUseCase {
  final TodoRepository repository;

  DeleteTodoUseCase({required this.repository});

  Future<void> call(String userId, String todoId) {
    return repository.deleteTodo(userId, todoId);
  }
}

class DeleteALlTodoUseCase {
  final TodoRepository repository;

  DeleteALlTodoUseCase({required this.repository});

  Future<void> call(String userId) {
    return repository.deleteAllTodo(userId);
  }
}
