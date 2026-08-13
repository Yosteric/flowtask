import 'package:flowtask/features/projects/data/repositories/project_progress_repository_impl.dart';
import 'package:flowtask/features/projects/domain/repositories/project_progress_repository.dart';
import 'package:flowtask/features/projects/domain/usecases/get_project_progress_usecase.dart';
import 'package:flowtask/features/tasks/presentation/providers/task_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final projectProgressRepositoryProvider = Provider<ProjectProgressRepository>((
  ref,
) {
  final taskRepository = ref.watch(taskRepositoryProvider);

  return ProjectProgressRepositoryImpl(taskRepository);
});

final getProjectProgressUseCaseProvider = Provider<GetProjectProgressUseCase>((
  ref,
) {
  final repository = ref.watch(projectProgressRepositoryProvider);

  return GetProjectProgressUseCase(repository);
});
