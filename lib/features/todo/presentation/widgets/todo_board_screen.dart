import 'package:codebase_assignment/features/todo/presentation/widgets/todo_colum_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/app_constants.dart';
import '../../domain/entity/todo_entity.dart';
import '../cubit/todo_cubit.dart';
import '../cubit/todo_state.dart';

class TodoBoardScreen extends StatelessWidget {
  const TodoBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      buildWhen: (previous, current) {
        return current is! UpdateTodoLoading;
      },
      builder: (context, state) {
        if (state is TodosLoading || state is DeleteTodoLoading) {
          return Expanded(child: const Center(child: CircularProgressIndicator()));
        } else if (state is TodosSuccess) {
          final todos = state.todos;
          if (todos.isEmpty) {
            return Expanded(
              child: Center(child: Text(AppConstants.createATodo, style: TextStyle(fontSize: 18))),
            );
          }

          final todoList = getTodosByStatus(todos, 0);
          final inProgressList = getTodosByStatus(todos, 1);
          final doneList = getTodosByStatus(todos, 2);

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TodoColumnWidget(title: AppConstants.todoTitle, status: 0, todos: todoList),
                TodoColumnWidget(title: AppConstants.todoInProgress, status: 1, todos: inProgressList),
                TodoColumnWidget(title: AppConstants.todoDone, status: 2, todos: doneList),
              ],
            ),
          );
        } else if (state is TodosFailed) {
          return Center(child: Text(AppConstants.failedToFetchTodos, style: TextStyle(fontSize: 18)));
        }
        return Center(child: Text(AppConstants.somethingWentWrong, style: TextStyle(fontSize: 18)));
      },
    );
  }

  List<TodoEntity> getTodosByStatus(List<TodoEntity> todos, int status) {
    return todos.where((todo) => todo.status == status).toList();
  }
}
