import 'package:flowtask/features/projects/domain/entities/project_progress_entity.dart';
import 'package:flowtask/features/projects/presentation/providers/project_progress_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final projectProgressProvider = FutureProvider.family
    .autoDispose<ProjectProgressEntity, String>((ref, projectId) {
      final getProjectProgress = ref.watch(getProjectProgressUseCaseProvider);

      return getProjectProgress(projectId: projectId);
    });
