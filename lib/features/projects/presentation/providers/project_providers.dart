import 'package:flowtask/features/projects/data/datasources/project_remote_data_source.dart';
import 'package:flowtask/features/projects/data/datasources/project_remote_data_source_impl.dart';
import 'package:flowtask/features/projects/data/repositories/project_repository_impl.dart';
import 'package:flowtask/features/projects/domain/repositories/project_repository.dart';
import 'package:flowtask/features/projects/domain/usecases/create_project_use_case.dart';
import 'package:flowtask/features/projects/domain/usecases/delete_project_use_case.dart';
import 'package:flowtask/features/projects/domain/usecases/get_projects_use_case.dart';
import 'package:flowtask/features/projects/domain/usecases/update_project_use_case.dart';
import 'package:flowtask/features/projects/presentation/project_controller.dart';
import 'package:flowtask/features/projects/presentation/states/project_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final projectRemoteDataSourceProvider = Provider<ProjectRemoteDataSource>(
  (ref) => ProjectRemoteDataSourceImpl(),
);

final projectRepositoryProvider = Provider<ProjectRepository>(
  (ref) => ProjectRepositoryImpl(ref.read(projectRemoteDataSourceProvider)),
);

final getProjectsUseCaseProvider = Provider<GetProjectsUseCase>(
  (ref) => GetProjectsUseCase(ref.read(projectRepositoryProvider)),
);

final createProjectUseCaseProvider = Provider<CreateProjectUseCase>(
  (ref) => CreateProjectUseCase(ref.read(projectRepositoryProvider)),
);

final projectControllerProvider =
    NotifierProvider<ProjectController, ProjectState>(ProjectController.new);

final updateProjectUseCaseProvider = Provider<UpdateProjectUseCase>(
  (ref) => UpdateProjectUseCase(ref.read(projectRepositoryProvider)),
);

final deleteProjectUseCaseProvider = Provider<DeleteProjectUseCase>(
  (ref) => DeleteProjectUseCase(ref.read(projectRepositoryProvider)),
);
