import 'package:flowtask/features/tasks/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    required super.id,
    required super.projectId,
    required super.title,
    required super.description,
    required super.isCompleted,
    required super.createdAt,
    super.dueDate,
  });

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      projectId: entity.projectId,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
      createdAt: entity.createdAt,
      dueDate: entity.dueDate,
    );
  }

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      projectId: projectId,
      title: title,
      description: description,
      isCompleted: isCompleted,
      createdAt: createdAt,
      dueDate: dueDate,
    );
  }
}
