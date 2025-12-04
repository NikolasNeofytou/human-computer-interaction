import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/project.dart';
import '../../../core/models/task_item.dart';
import '../../../core/providers/data_providers.dart';
import '../../../design_system/widgets/app_state.dart';
import '../../../design_system/widgets/shimmer_list.dart';
import '../../../design_system/widgets/animated_card.dart';
import '../../../theme/tokens.dart';

class ProjectDetailScreen extends ConsumerWidget {
  const ProjectDetailScreen({
    super.key,
    required this.projectId,
    this.project,
  });

  final String projectId;
  final Project? project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(projectTasksProvider(projectId));
    final projectsAsync = ref.watch(projectsProvider);
    final resolvedProject =
        project ?? projectsAsync.valueOrNull?.firstWhere((p) => p.id == projectId, orElse: () => const Project(id: '', name: 'Unknown', status: ProjectStatus.onTrack, tasks: 0));

    return Scaffold(
      appBar: AppBar(
        title: Text(resolvedProject?.name ?? 'Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.sm,
              children: [
                _StatusPill(
                  label: _statusLabel(resolvedProject?.status ?? ProjectStatus.onTrack),
                  color: _statusColor(resolvedProject?.status ?? ProjectStatus.onTrack),
                ),
                Text(
                  '${resolvedProject?.tasks ?? '-'} tasks',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: AppColors.neutral),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Semantics(
                  label: 'Create new task',
                  button: true,
                  child: FilledButton.icon(
                    onPressed: () => context.go('/projects/$projectId/task/new'),
                    icon: const Icon(Icons.add),
                    label: const Text('New task'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Semantics(
                  label: 'Invite member',
                  button: true,
                  child: OutlinedButton.icon(
                    onPressed: () => _showInviteDialog(context),
                    icon: const Icon(Icons.qr_code),
                    label: const Text('Invite'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: tasksAsync.when(
                data: (tasks) {
                  if (tasks.isEmpty) {
                    return const AppStateView.empty(
                      message: 'No tasks for this project.',
                    );
                  }
                  return ListView.separated(
                    itemCount: tasks.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return _TaskTile(task: task, projectId: projectId);
                  },
                );
              },
                loading: () => const AppStateView.loading(
                  shimmer: ShimmerList(),
                ),
                error: (err, _) =>
                    AppStateView.error(message: 'Failed to load tasks: $err'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({required this.task, required this.projectId});

  final TaskItem task;
  final String projectId;

  @override
  Widget build(BuildContext context) {
    final color = _taskStatusColor(task.status);
    return AnimatedCard(
      onTap: () => context.go('/projects/$projectId/task/${task.id}', extra: task),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Due: ${task.dueDate.toLocal().toString().split(' ').first}',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: AppColors.neutral),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => context.go('/projects/${task.projectId}/task/${task.id}/edit', extra: task),
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit task',
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});

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

String _statusLabel(ProjectStatus status) {
  switch (status) {
    case ProjectStatus.onTrack:
      return 'On track';
    case ProjectStatus.dueSoon:
      return 'Due soon';
    case ProjectStatus.blocked:
      return 'Blocked';
  }
}

Color _statusColor(ProjectStatus status) {
  switch (status) {
    case ProjectStatus.onTrack:
      return AppColors.success;
    case ProjectStatus.dueSoon:
      return AppColors.warning;
    case ProjectStatus.blocked:
      return AppColors.error;
  }
}

Color _taskStatusColor(TaskStatus status) {
  switch (status) {
    case TaskStatus.pending:
      return AppColors.warning;
    case TaskStatus.done:
      return AppColors.success;
    case TaskStatus.blocked:
      return AppColors.error;
  }
}

Future<void> _showInviteDialog(BuildContext context) async {
  bool copying = false;
  final result = await showDialog<String>(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Invite member'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.qr_code),
                  title: const Text('Invite via QR code'),
                  onTap: copying ? null : () => Navigator.of(ctx).pop('qr'),
                ),
                ListTile(
                  leading: const Icon(Icons.link),
                  title: const Text('Invite via link'),
                  trailing: copying
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : null,
                  onTap: copying
                      ? null
                      : () async {
                          setState(() => copying = true);
                          Navigator.of(ctx).pop('link');
                        },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: copying ? null : () => Navigator.of(ctx).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    },
  );

  if (result == null) return;
  if (!context.mounted) return;

  String message = 'Invite sent';
  if (result == 'link') {
    const link = 'https://example.com/invite/ABC123';
    await Clipboard.setData(const ClipboardData(text: link));
    message = 'Invite link copied';
  } else if (result == 'qr') {
    message = 'QR generated';
  }
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
