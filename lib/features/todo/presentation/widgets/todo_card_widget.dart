import 'package:codebase_assignment/core/utils/constants/app_constants.dart';
import 'package:codebase_assignment/core/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/extentions.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../domain/entity/todo_entity.dart';
import '../cubit/todo_cubit.dart';
import 'custom_todo_dialog.dart';

class TodoCardWidget extends StatelessWidget {
  const TodoCardWidget({super.key, required this.todo});
  final TodoEntity todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 204, 218, 236),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                   todo.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomTodoDialog(
                        title: AppConstants.updateTodo,
                        isFromEditTodo: true,
                        todo: todo,
                      );
                    },
                  );
                },
                icon: Icon(Icons.edit,color: AppColors.primary, size: 18,),
              ),
              SizedBox(width: 0),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomAlertDialog(
                        title: AppConstants.alert,
                        titleColor: AppColors.red,
                        content: AppConstants.deleteTodoConfirmation,
                        onConfirm: () {
                          context.read<TodoCubit>().deleteTodo(todo.id);
                        },
                      );
                    },
                  );
                },
                icon: Icon(Icons.delete, color: Colors.red,size: 18,),
              ),
            ],
          ),
          Text(
            todo.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                "${AppConstants.status}: ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                TodoStatusExtension.fromInt(todo.status).toUpperCase(),
                style: TextStyle(
                  color: TodoStatusExtension.getColor(todo.status),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
