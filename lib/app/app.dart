import 'package:flowtask/core/router/app_router.dart';
import 'package:flutter/material.dart';

class FlowTaskApp extends StatelessWidget {
  const FlowTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FlowTask',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
    );
  }
}
