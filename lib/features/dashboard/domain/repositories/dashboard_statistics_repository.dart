import 'package:flowtask/features/dashboard/domain/entities/dashboard_statistics_entity.dart';

abstract interface class DashboardStatisticsRepository {
  Future<DashboardStatisticsEntity> getStatistics();
}
