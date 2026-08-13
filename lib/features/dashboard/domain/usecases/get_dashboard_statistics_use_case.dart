import 'package:flowtask/features/dashboard/domain/entities/dashboard_statistics_entity.dart';
import 'package:flowtask/features/dashboard/domain/repositories/dashboard_statistics_repository.dart';

class GetDashboardStatisticsUseCase {
  const GetDashboardStatisticsUseCase(this._repository);

  final DashboardStatisticsRepository _repository;

  Future<DashboardStatisticsEntity> call() {
    return _repository.getStatistics();
  }
}
