import 'package:codebase_assignment/features/todo/presentation/widgets/todo_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/theme/app_colors.dart';
import '../../domain/entity/todo_entity.dart';
import '../cubit/todo_cubit.dart';

class TodoColumnWidget extends StatelessWidget {
  final String title;
  final List<TodoEntity> todos;
  final int status;

  const TodoColumnWidget({
    super.key,
    required this.title,
    required this.todos,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withAlpha(100)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column title
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Drag Target
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.68,
            child: DragTarget<TodoEntity>(
              onWillAccept: (todo) => todo != null && todo.status != status,
              onAccept: (todo) {
                final updatedTodo = todo.copyWith(status: status);
                context.read<TodoCubit>().updateTodo(updatedTodo);
              },
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                  itemCount: todos.length,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return LongPressDraggable<TodoEntity>(
                      data: todo,
                      feedback: Material(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6,
                          ),
                          child: TodoCardWidget(todo: todo),
                        ),
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.5,
                        child: TodoCardWidget(todo: todo),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TodoCardWidget(todo: todo),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
