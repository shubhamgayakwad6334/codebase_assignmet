import 'package:codebase_assignment/features/todo/data/models/todo_model.dart';

import '../../domain/entity/todo_entity.dart';

extension TodoEntityDataMapper on TodoEntity {
  TodoModel toDto() {
    return TodoModel(
      id: id,
      title: title,
      description: description,
      createdDate: createdDate,
      status: status,
    );
  }
}

extension TodoModelDataMapper on TodoModel {
  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      title: title,
      description: description,
      createdDate: createdDate,
      status: status,
    );
  }
}
