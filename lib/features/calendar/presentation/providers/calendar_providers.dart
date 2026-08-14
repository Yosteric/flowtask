import 'package:flowtask/features/tasks/domain/entities/task_entity.dart';
import 'package:flowtask/features/tasks/presentation/providers/task_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarTasksProvider = FutureProvider.autoDispose<List<TaskEntity>>((
  ref,
) {
  return ref.watch(getAllTasksUseCaseProvider).call();
});
