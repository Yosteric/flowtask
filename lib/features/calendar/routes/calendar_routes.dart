import 'package:flowtask/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:go_router/go_router.dart';

final calendarRoutes = <GoRoute>[
  GoRoute(
    path: '/calendar',
    builder: (context, state) => const CalendarScreen(),
  ),
];
