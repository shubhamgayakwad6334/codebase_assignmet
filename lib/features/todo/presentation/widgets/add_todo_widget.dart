import 'package:flutter/material.dart';

import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/theme/app_colors.dart';
import 'custom_todo_dialog.dart';

class AddTodoWidget extends StatelessWidget {
  const AddTodoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return CustomTodoDialog(title: AppConstants.createTodo, isFromEditTodo: false);
          },
        );
      },
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}
