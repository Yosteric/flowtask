import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract final class AppNavigator {
  static void go(BuildContext context, String location) {
    context.go(location);
  }

  static void push(BuildContext context, String location) {
    context.push(location);
  }

  static void pop(BuildContext context) {
    context.pop();
  }
}
