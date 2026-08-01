import 'package:flowtask/features/projects/domain/entities/project_entity.dart';
import 'package:flowtask/shared/widgets/inputs/app_text_field.dart';
import 'package:flutter/material.dart';

class ProjectDialog extends StatefulWidget {
  const ProjectDialog({super.key, this.project, required this.onSave});

  final ProjectEntity? project;

  final Future<void> Function(String name, String description) onSave;

  @override
  State<ProjectDialog> createState() => _ProjectDialogState();
}

class _ProjectDialogState extends State<ProjectDialog> {
  @override
  void initState() {
    super.initState();

    _nameController.text = widget.project?.name ?? '';
    _descriptionController.text = widget.project?.description ?? '';
  }

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await widget.onSave(
      _nameController.text.trim(),
      _descriptionController.text.trim(),
    );

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.project == null ? 'New Project' : 'Edit Project'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              controller: _nameController,
              label: 'Project name',
              hint: 'Enter the project name',
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Project name is required';
                }

                if (value.trim().length < 3) {
                  return 'Minimum 3 characters';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            AppTextField(
              controller: _descriptionController,
              label: 'Description',
              hint: 'Describe your project',
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _save,
          child: Text(widget.project == null ? 'Create' : 'Save'),
        ),
      ],
    );
  }
}
