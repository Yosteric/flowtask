import 'package:flowtask/features/dashboard/data/repositories/dashboard_statistics_repository_impl.dart';
import 'package:flowtask/features/dashboard/domain/entities/dashboard_statistics_entity.dart';
import 'package:flowtask/features/dashboard/domain/repositories/dashboard_statistics_repository.dart';
import 'package:flowtask/features/dashboard/domain/usecases/get_dashboard_statistics_use_case.dart';
import 'package:flowtask/features/projects/presentation/providers/project_providers.dart';
import 'package:flowtask/features/tasks/presentation/providers/task_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardStatisticsRepositoryProvider =
    Provider<DashboardStatisticsRepository>(
      (ref) => DashboardStatisticsRepositoryImpl(
        projectRepository: ref.watch(projectRepositoryProvider),
        taskRepository: ref.watch(taskRepositoryProvider),
      ),
    );

final getDashboardStatisticsUseCaseProvider =
    Provider<GetDashboardStatisticsUseCase>(
      (ref) => GetDashboardStatisticsUseCase(
        ref.watch(dashboardStatisticsRepositoryProvider),
      ),
    );

final dashboardStatisticsProvider =
    FutureProvider.autoDispose<DashboardStatisticsEntity>((ref) {
      return ref.watch(getDashboardStatisticsUseCaseProvider).call();
    });
