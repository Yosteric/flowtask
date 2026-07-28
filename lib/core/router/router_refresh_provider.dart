import 'package:flowtask/core/router/router_refresh_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerRefreshProvider = Provider<RouterRefreshNotifier>(
  RouterRefreshNotifier.new,
);
