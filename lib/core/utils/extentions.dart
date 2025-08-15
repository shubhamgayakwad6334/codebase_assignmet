import 'package:flutter/material.dart';

enum TodoStatus { inProgress, todo, done }

extension TodoStatusExtension on TodoStatus {
  String get label {
    switch (this) {
      case TodoStatus.inProgress:
        return "In Progress";
      case TodoStatus.todo:
        return "Todo";
      case TodoStatus.done:
        return "Done";
    }
  }

  int get apiValue {
    switch (this) {
      case TodoStatus.todo:
        return 0;
      case TodoStatus.inProgress:
        return 1;
      case TodoStatus.done:
        return 2;
    }
  }

  static Color getColor(int value) {
    switch (value) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.blue[900] ?? Colors.blue;
      case 2:
        return Colors.green;
    }
    return Colors.red;
  }

  static String fromInt(int value) {
    switch (value) {
      case 0:
        return TodoStatus.todo.label;
      case 1:
        return TodoStatus.inProgress.label;
      case 2:
        return TodoStatus.done.label;
      default:
        return TodoStatus.todo.label; // fallback for invalid values
    }
  }

  static TodoStatus toEnum(int value) {
    switch (value) {
      case 0:
        return TodoStatus.todo;
      case 1:
        return TodoStatus.inProgress;
      case 2:
        return TodoStatus.done;
      default:
        return TodoStatus.todo; // fallback for invalid values
    }
  }
}
