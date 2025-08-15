import 'package:codebase_assignment/features/todo/data/data_source/data.mappers.dart';
import 'package:codebase_assignment/features/todo/domain/repository/todo_repository.dart';

import '../../../../core/services/network_connectivity/network_connectivity.dart';
import '../../domain/entity/todo_entity.dart';
import '../data_source/local/todo_local_data_source.dart';
import '../data_source/remote/todo_remote_data_source.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;
  final TodoLocalDataSource localDataSource;
  final NetworkConnectivityService network;
  TodoRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.network});

  @override
  Future<void> addTodo(String userId, TodoEntity todo) async {
    final tempModel = TodoModel(
      id: '', // Will be generated in data source
      title: todo.title,
      description: todo.description,
      createdDate: DateTime.now().toIso8601String(), // Temporary, replaced inside data source
      status: todo.status,
    );

    await remoteDataSource.createTodo(userId, tempModel);
    localDataSource.saveTodoLocally(tempModel);
  }

  @override
  Future<void> updateTodo(String userId, TodoEntity todo) async {
    await remoteDataSource.updateTodo(userId, todo.toDto());
  }

  @override
  Future<void> deleteTodo(String userId, String todoId) async {
    await localDataSource.deleteTodoFromHive(todoId);
    return await remoteDataSource.deleteTodo(userId, todoId);
  }

  @override
  Future<void> deleteAllTodo(String userId) async {
    await localDataSource.clearAllTodos();
    return await remoteDataSource.deleteAllTodo(userId);
  }

  @override
  Future<List<TodoEntity>> fetchTodos(String userId) async {
    final connected = await network.isConnected;
    if (!connected) {
      final localTodos = await localDataSource.getAllTodosFromHive();
      return localTodos.map((e) => e.toEntity()).toList();
    } else {
      final remoteTodos = await remoteDataSource.getTodos(userId);
      await localDataSource.clearAllTodos();
      await Future.wait(remoteTodos.map((todo) => localDataSource.saveTodoLocally(todo)));
      return remoteTodos.map((e) => e.toEntity()).toList();
    }
  }
}
