import 'package:flowtask/features/authentication/presentation/providers/auth_controller_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerRefreshListenableProvider = Provider<ValueNotifier<int>>((ref) {
  final notifier = ValueNotifier<int>(0);

  void refresh() {
    Future.microtask(() {
      notifier.value++;
    });
  }

  final subscription = ref.listen(authControllerProvider, (_, _) => refresh());

  ref.onDispose(() {
    subscription.close();
    notifier.dispose();
  });

  return notifier;
});
