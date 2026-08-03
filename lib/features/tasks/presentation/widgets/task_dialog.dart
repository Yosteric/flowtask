import 'package:flowtask/features/tasks/domain/entities/task_entity.dart';
import 'package:flowtask/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TaskDialog extends StatefulWidget {
  const TaskDialog({super.key, this.task, required this.onSave});

  final TaskEntity? task;

  final Future<void> Function(String title, String description) onSave;

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  final _formKey = GlobalKey<FormState>();

  bool _isSaving = false;

  bool get _isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.task?.title ?? '');

    _descriptionController = TextEditingController(
      text: widget.task?.description ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    await widget.onSave(
      _titleController.text.trim(),
      _descriptionController.text.trim(),
    );

    if (!mounted) return;

    Navigator.of(context).pop();

    setState(() {
      _isSaving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Edit Task' : 'Create Task'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(controller: _titleController, label: 'Title'),
            const SizedBox(height: 16),
            AppTextField(
              controller: _descriptionController,
              label: 'Description',
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        SecondaryButton(
          text: 'Cancel',
          onPressed: () => Navigator.pop(context),
        ),
        PrimaryButton(
          text: _isEditing ? 'Update' : 'Create',
          isLoading: _isSaving,
          onPressed: _save,
        ),
      ],
    );
  }
}
