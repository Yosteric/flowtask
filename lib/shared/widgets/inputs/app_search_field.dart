import 'package:flowtask/shared/widgets/inputs/app_text_field.dart';
import 'package:flutter/material.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    required this.controller,
    this.onChanged,
    this.hint = 'Search...',
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      hint: hint,
      onChanged: onChanged,
      prefixIcon: const Icon(Icons.search_rounded),
      textInputAction: TextInputAction.search,
    );
  }
}
