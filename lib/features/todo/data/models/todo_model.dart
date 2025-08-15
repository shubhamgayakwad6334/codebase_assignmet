import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String createdDate;

  @HiveField(4)
  final int status;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdDate,
    required this.status,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdDate: json['createdDate'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdDate': createdDate,
      'status': status,
    };
  }

  TodoModel copyWith({String? id, String? title, String? description, String? createdDate, int? status}) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdDate: createdDate ?? this.createdDate,
      status: status ?? this.status,
    );
  }
}
