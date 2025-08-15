import 'package:codebase_assignment/core/widgets/custom_loading.dart';
import 'package:codebase_assignment/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../../../../core/utils/extentions.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../domain/entity/todo_entity.dart';
import '../cubit/todo_cubit.dart';
import '../cubit/todo_state.dart';

class CreateTodoWidget extends StatefulWidget {
  final bool isFromEditTodo;
  final TodoEntity? todo;
  const CreateTodoWidget({super.key, required this.isFromEditTodo, this.todo});

  @override
  State<CreateTodoWidget> createState() => _CreateTodoWidgetState();
}

class _CreateTodoWidgetState extends State<CreateTodoWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ValueNotifier<TodoStatus?> selectedStatusNotifier = ValueNotifier<TodoStatus?>(TodoStatus.todo);
  TodoEntity? currentTodo;

  @override
  void initState() {
    super.initState();
    if (widget.isFromEditTodo) {
      _initUpdateTodo();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    selectedStatusNotifier.dispose();
    super.dispose();
  }

  _initUpdateTodo() {
    if (widget.todo != null) {
      currentTodo = widget.todo;
      titleController.text = widget.todo!.title;
      descriptionController.text = widget.todo!.description;
      selectedStatusNotifier = ValueNotifier<TodoStatus?>(TodoStatusExtension.toEnum(widget.todo!.status));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoCubit, TodoState>(
      listener: (context, state) {
        if (state is AddTodoLoading || state is UpdateTodoLoading) {
          return CustomLoading.showLoader(context);
        } else if (state is AddTodoSuccess) {
          CustomLoading.hideLoader(context);
          Utils.showSnackBar(context, AppConstants.todoAddedSuccessfully);
          Navigator.pop(context);
        } else if (state is UpdateTodoSuccess) {
          CustomLoading.hideLoader(context);
          Utils.showSnackBar(context, AppConstants.todoUpdatedSuccessfully);
          Navigator.pop(context);
        } else if (state is AddTodoFailed) {
          CustomLoading.hideLoader(context);
          Utils.showSnackBar(context, AppConstants.somethingWentWrong, isError: true);
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: titleController,
                  label: AppConstants.title,
                  hint: AppConstants.title,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.titleRequired;
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: descriptionController,
                  label: AppConstants.description,
                  hint: AppConstants.description,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppConstants.descriptionRequired;
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                Visibility(
                  visible: widget.isFromEditTodo,
                  child: ValueListenableBuilder<TodoStatus?>(
                    valueListenable: selectedStatusNotifier,
                    builder: (context, value, child) {
                      return DropdownButtonFormField<TodoStatus>(
                        decoration: const InputDecoration(
                          labelText: AppConstants.status,
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        value: value,
                        items: TodoStatus.values.map((status) {
                          return DropdownMenuItem(value: status, child: Text(status.label));
                        }).toList(),
                        onChanged: (status) {
                          selectedStatusNotifier.value = status;
                          currentTodo = currentTodo?.copyWith(status: status?.apiValue ?? 0);
                        },
                        validator: (value) {
                          if (value == null) {
                            return AppConstants.statusRequired;
                          }
                          return null;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomButton(
                    title: widget.isFromEditTodo ? AppConstants.update : AppConstants.create,
                    onPressed: () {
                      if (widget.isFromEditTodo && currentTodo != null) {
                        _updateTodo();
                      } else {
                        _submitTodo();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitTodo() {
    if (_formKey.currentState?.validate() == true) {
      final todo = TodoEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: titleController.text.trim(),
        status: 0,
        description: descriptionController.text.trim(),
        createdDate: DateTime.now().millisecondsSinceEpoch.toString(),
      );
      context.read<TodoCubit>().addTodo(todo);
    }
  }

  void _updateTodo() {
    currentTodo = currentTodo?.copyWith(title: titleController.text, description: descriptionController.text);
    context.read<TodoCubit>().updateTodo(currentTodo!);
  }
}
