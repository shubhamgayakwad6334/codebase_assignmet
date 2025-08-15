class TodoEntity {
  final String id;
  final String title;
  final String description;
  final String createdDate;
  final int status;

  TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdDate,
    required this.status,
  });

  TodoEntity copyWith({String? id, String? title, String? description, String? createdDate, int? status}) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdDate: createdDate ?? this.createdDate,
      status: status ?? this.status,
    );
  }
}


