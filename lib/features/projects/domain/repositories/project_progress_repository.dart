import 'package:flowtask/features/projects/domain/entities/project_progress_entity.dart';

abstract interface class ProjectProgressRepository {
  Future<ProjectProgressEntity> getProjectProgress({required String projectId});
}
