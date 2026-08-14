import 'package:flowtask/features/tasks/domain/entities/task_entity.dart';
import 'package:flowtask/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TaskDialog extends StatefulWidget {
  const TaskDialog({super.key, this.task, required this.onSave});

  final TaskEntity? task;

  final Future<void> Function(
    String title,
    String description,
    DateTime? dueDate,
  )
  onSave;

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  final _formKey = GlobalKey<FormState>();

  DateTime? _dueDate;
  bool _isSaving = false;

  bool get _isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.task?.title ?? '');

    _descriptionController = TextEditingController(
      text: widget.task?.description ?? '',
    );

    _dueDate = widget.task?.dueDate;
  }

  Future<void> _selectDueDate() async {
    final now = DateTime.now();

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 10),
    );

    if (selectedDate == null) {
      return;
    }

    setState(() {
      _dueDate = selectedDate;
    });
  }

  void _clearDueDate() {
    setState(() {
      _dueDate = null;
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      await widget.onSave(
        _titleController.text.trim(),
        _descriptionController.text.trim(),
        _dueDate,
      );

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop();
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _selectDueDate,
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      _dueDate == null
                          ? 'Set due date'
                          : _formatDate(_dueDate!),
                    ),
                  ),
                ),
                if (_dueDate != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _clearDueDate,
                    tooltip: 'Remove due date',
                    icon: const Icon(Icons.clear),
                  ),
                ],
              ],
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

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}
