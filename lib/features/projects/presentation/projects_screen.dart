import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/project.dart';
import '../../../core/models/task_item.dart';
import '../../../core/providers/data_providers.dart';
import '../../../design_system/widgets/animated_card.dart';
import '../../../design_system/widgets/app_pill.dart';
import '../../../design_system/widgets/app_state.dart';
import '../../../design_system/widgets/shimmer_list.dart';
import '../../../theme/tokens.dart';

/// Projects overview with board + roadmap sections.
class ProjectsScreen extends ConsumerStatefulWidget {
  const ProjectsScreen({super.key});

  @override
  ConsumerState<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends ConsumerState<ProjectsScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncProjects = ref.watch(projectsProvider);
    final asyncTasks = ref.watch(calendarTasksProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Semantics(
                header: true,
                child: Text(
                  'Projects overview',
                  style: Theme.of(context).textTheme.headlineLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            IconButton(
              tooltip: 'Add project',
              onPressed: () {},
              icon: const Icon(Icons.add_box_outlined),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _Filters(
          searchCtrl: _searchCtrl,
          onQueryChanged: () => setState(() {}),
        ),
        const SizedBox(height: AppSpacing.md),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StatsRow(asyncProjects: asyncProjects, asyncTasks: asyncTasks),
                const SizedBox(height: AppSpacing.xl),
                _BoardView(
                  searchCtrl: _searchCtrl,
                  onQueryChanged: () => setState(() {}),
                ),
                const SizedBox(height: AppSpacing.xl),
                _RoadmapList(asyncTasks: asyncTasks),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters({required this.searchCtrl, required this.onQueryChanged});

  final TextEditingController searchCtrl;
  final VoidCallback onQueryChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchCtrl,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Filter by keyword or status…',
            ),
            onChanged: (_) => onQueryChanged(),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.filter_alt_outlined),
          label: const Text('Filters'),
        ),
        const SizedBox(width: AppSpacing.sm),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.table_chart_outlined),
          label: const Text('New view'),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.asyncProjects, required this.asyncTasks});

  final AsyncValue<List<Project>> asyncProjects;
  final AsyncValue<List<TaskItem>> asyncTasks;

  @override
  Widget build(BuildContext context) {
    final projectData = asyncProjects.asData?.value ?? const <Project>[];
    final taskData = asyncTasks.asData?.value ?? const <TaskItem>[];
    final onTrack = projectData.where((p) => p.status == ProjectStatus.onTrack).length;
    final dueSoon = projectData.where((p) => p.status == ProjectStatus.dueSoon).length;
    final blocked = projectData.where((p) => p.status == ProjectStatus.blocked).length;
    final upcoming = taskData.length;

    Widget stat(String label, String value, Color color) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppRadii.md),
            border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: AppSpacing.xs),
              Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: color, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      );
    }

    return Row(
      children: [
        stat('Projects', '${projectData.length}', Theme.of(context).colorScheme.primary),
        const SizedBox(width: AppSpacing.md),
        stat('On track', '$onTrack', AppColors.success),
        const SizedBox(width: AppSpacing.md),
        stat('Due soon', '$dueSoon', AppColors.warning),
        const SizedBox(width: AppSpacing.md),
        stat('Blocked', '$blocked', AppColors.error),
        const SizedBox(width: AppSpacing.md),
        stat('Upcoming tasks', '$upcoming', Theme.of(context).colorScheme.tertiary),
      ],
    );
  }
}

class _BoardView extends ConsumerWidget {
  const _BoardView({required this.searchCtrl, required this.onQueryChanged});

  final TextEditingController searchCtrl;
  final VoidCallback onQueryChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProjects = ref.watch(projectsProvider);
    return asyncProjects.when(
      data: (projects) {
        if (projects.isEmpty) {
          return const AppStateView.empty(message: 'No projects yet.');
        }
        final query = searchCtrl.text.trim().toLowerCase();
        final filtered = query.isEmpty
            ? projects
            : projects.where((p) => p.name.toLowerCase().contains(query)).toList();
        final grouped = _groupByStatus(filtered);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: ProjectStatus.values.map((status) {
            final list = grouped[status] ?? [];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: _StatusColumn(
                status: status,
                projects: list,
              ),
            );
          }).toList(),
        );
      },
      loading: () => const AppStateView.loading(shimmer: ShimmerList()),
      error: (err, _) => AppStateView.error(message: 'Failed to load projects: $err'),
    );
  }

  Map<ProjectStatus, List<Project>> _groupByStatus(List<Project> items) {
    final map = <ProjectStatus, List<Project>>{};
    for (final project in items) {
      map.putIfAbsent(project.status, () => []).add(project);
    }
    return map;
  }
}

class _StatusColumn extends StatelessWidget {
  const _StatusColumn({required this.status, required this.projects});

  final ProjectStatus status;
  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(status);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              status == ProjectStatus.blocked
                  ? Icons.block
                  : status == ProjectStatus.dueSoon
                      ? Icons.schedule
                      : Icons.check_circle_outline,
              color: color,
              size: 18,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              _statusLabel(status),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
            ),
            const SizedBox(width: AppSpacing.sm),
            AppPill(label: '${projects.length}', color: color),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final project in projects) ...[
          _ProjectCard(project: project, statusColor: color),
          const SizedBox(height: AppSpacing.sm),
        ],
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Add item'),
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.statusColor,
  });

  final Project project;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      onTap: () => context.go('/projects/${project.id}', extra: project),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.drag_indicator, color: Theme.of(context).colorScheme.outline),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  project.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              AppPill(label: '${project.tasks} tasks', color: statusColor, outlined: false),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
            AppPill(label: _statusLabel(project.status), color: statusColor),
            const AppPill(label: 'Details', color: AppColors.surface, outlined: false),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              IconButton(
                onPressed: () => context.go('/projects/${project.id}'),
                icon: const Icon(Icons.list_alt_outlined),
                tooltip: 'View tasks',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit_outlined),
                tooltip: 'Edit',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Delete',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoadmapList extends StatelessWidget {
  const _RoadmapList({required this.asyncTasks});

  final AsyncValue<List<TaskItem>> asyncTasks;

  @override
  Widget build(BuildContext context) {
    return asyncTasks.when(
      data: (tasks) {
        if (tasks.isEmpty) {
          return const AppStateView.empty(message: 'No tasks on the roadmap.');
        }
        final sorted = [...tasks]..sort((a, b) => a.dueDate.compareTo(b.dueDate));
        final upcoming = sorted.take(8).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Roadmap (next)', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.md),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: upcoming.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, index) {
                final t = upcoming[index];
                final color = _taskStatusColor(t.status);
                final dateLabel = '${t.dueDate.month}/${t.dueDate.day}';
                return AnimatedCard(
                  onTap: () => context.go('/projects/${t.projectId}/task/${t.id}', extra: t),
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
                            Text(
                              t.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              t.projectId ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                            ),
                          ],
                        ),
                      ),
                      AppPill(label: dateLabel, color: color),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
      loading: () => const AppStateView.loading(shimmer: ShimmerList()),
      error: (err, _) => AppStateView.error(message: 'Failed to load roadmap: $err'),
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
