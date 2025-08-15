import 'package:codebase_assignment/features/todo/domain/entity/todo_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/theme/app_colors.dart';
import 'create_todo_widget.dart';

class CustomTodoDialog extends StatelessWidget {
  final String title;
  final bool isFromEditTodo;
  final TodoEntity? todo;
  const CustomTodoDialog({super.key, required this.title, required this.isFromEditTodo, this.todo});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 28, color: AppColors.primary, fontWeight: FontWeight.bold),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 400, maxWidth: 500),
        child: CreateTodoWidget(isFromEditTodo: isFromEditTodo, todo: todo),
      ),
    );
  }
}
