import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/task_item.dart';
import '../../../theme/tokens.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.task, required this.projectId});

  final TaskItem task;
  final String projectId;

  @override
  Widget build(BuildContext context) {
    final statusLabel = _statusLabel(task.status);
    final statusColor = _statusColor(task.status);
    final dueLabel = task.dueDate.toLocal().toString().split(' ').first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        actions: [
          IconButton(
            tooltip: 'Edit task',
            onPressed: () => context.go('/projects/$projectId/task/${task.id}/edit', extra: task),
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                _StatusChip(label: statusLabel, color: statusColor),
                const SizedBox(width: AppSpacing.md),
                Text(
                  'Due: $dueLabel',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: AppColors.neutral),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Project: $projectId',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: AppColors.neutral),
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

Color _statusColor(TaskStatus status) {
  switch (status) {
    case TaskStatus.pending:
      return AppColors.warning;
    case TaskStatus.done:
      return AppColors.success;
    case TaskStatus.blocked:
      return AppColors.error;
  }
}
