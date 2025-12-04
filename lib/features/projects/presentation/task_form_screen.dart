import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/task_item.dart';
import '../../../theme/tokens.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({
    super.key,
    required this.projectId,
    this.initialTask,
  });

  final String projectId;
  final TaskItem? initialTask;

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  late final TextEditingController _titleController;
  DateTime? _dueDate;
  TaskStatus _status = TaskStatus.pending;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTask?.title ?? '');
    _dueDate = widget.initialTask?.dueDate;
    _status = widget.initialTask?.status ?? TaskStatus.pending;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = _dueDate ?? now;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 2)),
    );
    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  Future<void> _save() async {
    if (_titleController.text.isEmpty || _dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and due date are required')),
      );
      return;
    }
    if (_saving) return;
    setState(() => _saving = true);
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.initialTask == null ? 'Task created' : 'Task updated'),
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initialTask != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Task' : 'New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Semantics(
              label: 'Task title',
              textField: true,
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Task title'),
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _dueDate == null
                        ? 'No date selected'
                        : 'Due: ${_dueDate!.toLocal().toString().split(' ').first}',
                  ),
                ),
                Semantics(
                  label: 'Pick due date',
                  button: true,
                  child: OutlinedButton.icon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.event),
                    label: const Text('Pick date'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Semantics(
              label: 'Task status',
              child: DropdownButtonFormField<TaskStatus>(
                value: _status,
                items: TaskStatus.values
                    .map(
                      (s) => DropdownMenuItem(
                        value: s,
                        child: Text(_statusLabel(s)),
                      ),
                    )
                    .toList(),
                onChanged: (s) {
                  if (s != null) setState(() => _status = s);
                },
                decoration: const InputDecoration(labelText: 'Status'),
              ),
            ),
            const Spacer(),
            Semantics(
              button: true,
              label: isEdit ? 'Update Task' : 'Create Task',
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(isEdit ? 'Update Task' : 'Create Task'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _statusLabel(TaskStatus status) {
  switch (status) {
    case TaskStatus.pending:
      return 'Pending';
    case TaskStatus.done:
      return 'Done';
    case TaskStatus.blocked:
      return 'Blocked';
  }
}
