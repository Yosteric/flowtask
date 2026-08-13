class ProjectProgressEntity {
  const ProjectProgressEntity({
    required this.totalTasks,
    required this.completedTasks,
  });

  final int totalTasks;
  final int completedTasks;

  int get pendingTasks => totalTasks - completedTasks;

  double get progress {
    if (totalTasks == 0) {
      return 0;
    }

    return completedTasks / totalTasks;
  }

  int get percentage => (progress * 100).round();
}
