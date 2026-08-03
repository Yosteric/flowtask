class TaskEntity {
  const TaskEntity({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
  });

  final String id;
  final String projectId;

  final String title;
  final String description;

  final bool isCompleted;

  final DateTime createdAt;

  TaskEntity copyWith({
    String? id,
    String? projectId,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
