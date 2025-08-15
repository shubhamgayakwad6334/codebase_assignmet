import '../entity/todo_entity.dart';
abstract class TodoRepository {
  Future<void> addTodo(String userId, TodoEntity todo);
  Future<List<TodoEntity>> fetchTodos(String userId);
  Future<void> updateTodo(String userId, TodoEntity todo);
  Future<void> deleteTodo(String userId, String todoId);
  Future<void> deleteAllTodo(String userId);
}
