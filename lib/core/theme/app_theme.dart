import 'package:flowtask/core/theme/dark_theme.dart';
import 'package:flowtask/core/theme/light_theme.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  static ThemeData get light => lightTheme;

  static ThemeData get dark => darkTheme;
}
