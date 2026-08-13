class DashboardStatisticsEntity {
  const DashboardStatisticsEntity({
    required this.totalProjects,
    required this.totalTasks,
    required this.completedTasks,
    required this.pendingTasks,
  });

  final int totalProjects;
  final int totalTasks;
  final int completedTasks;
  final int pendingTasks;
}
