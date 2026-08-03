import 'package:flowtask/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:flowtask/features/tasks/data/datasources/task_remote_data_source_impl.dart';
import 'package:flowtask/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:flowtask/features/tasks/domain/repositories/task_repository.dart';
import 'package:flowtask/features/tasks/domain/usecases/create_task_use_case.dart';
import 'package:flowtask/features/tasks/domain/usecases/delete_task_use_case.dart';
import 'package:flowtask/features/tasks/domain/usecases/get_tasks_use_case.dart';
import 'package:flowtask/features/tasks/domain/usecases/update_task_use_case.dart';
import 'package:flowtask/features/tasks/presentation/states/task_state.dart';
import 'package:flowtask/features/tasks/presentation/task_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Datasource

final taskRemoteDataSourceProvider = Provider<TaskRemoteDataSource>(
  (ref) => TaskRemoteDataSourceImpl(),
);

/// Repository

final taskRepositoryProvider = Provider<TaskRepository>(
  (ref) => TaskRepositoryImpl(ref.read(taskRemoteDataSourceProvider)),
);

/// Use Cases

final getTasksUseCaseProvider = Provider<GetTasksUseCase>(
  (ref) => GetTasksUseCase(ref.read(taskRepositoryProvider)),
);

final createTaskUseCaseProvider = Provider<CreateTaskUseCase>(
  (ref) => CreateTaskUseCase(ref.read(taskRepositoryProvider)),
);

final updateTaskUseCaseProvider = Provider<UpdateTaskUseCase>(
  (ref) => UpdateTaskUseCase(ref.read(taskRepositoryProvider)),
);

final deleteTaskUseCaseProvider = Provider<DeleteTaskUseCase>(
  (ref) => DeleteTaskUseCase(ref.read(taskRepositoryProvider)),
);

/// Controller

final taskControllerProvider = NotifierProvider<TaskController, TaskState>(
  TaskController.new,
);
