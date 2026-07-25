import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flowtask/app/app.dart';
import 'package:flowtask/firebase_options.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> bootstrap() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      runApp(const ProviderScope(child: FlowTaskApp()));
    },
    (error, stackTrace) {
      debugPrint('Unhandled error: $error');
      debugPrintStack(stackTrace: stackTrace);
    },
  );
}
