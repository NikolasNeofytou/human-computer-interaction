import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/models/task_item.dart';
import '../../../core/providers/data_providers.dart';
import '../../../design_system/widgets/app_state.dart';
import '../../../design_system/widgets/shimmer_list.dart';
import '../../../design_system/widgets/animated_card.dart';
import '../../../theme/tokens.dart';

enum CalendarView { day, week, month }

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  CalendarView _view = CalendarView.week;
  late DateTime _anchorDate;

  @override
  void initState() {
    super.initState();
    _anchorDate = DateTime.now();
  }

  List<TaskItem> _filtered(List<TaskItem> items) {
    final now = _anchorDate;
    switch (_view) {
      case CalendarView.day:
        return items
            .where((t) =>
                t.dueDate.year == now.year &&
                t.dueDate.month == now.month &&
                t.dueDate.day == now.day)
            .toList();
      case CalendarView.week:
        return items
            .where((t) => t.dueDate.difference(now).inDays >= -1 && // include yesterday buffer
                t.dueDate.difference(now).inDays <= 6)
            .toList()
          ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
      case CalendarView.month:
        return items
            .where((t) =>
                t.dueDate.year == now.year && t.dueDate.month == now.month)
            .toList()
          ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncTasks = ref.watch(calendarTasksProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text('Calendar', style: Theme.of(context).textTheme.headlineLarge),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.sm,
          children: [
            SegmentedButton<CalendarView>(
              segments: const [
                ButtonSegment(value: CalendarView.day, icon: Icon(Icons.today), label: Text('Day')),
                ButtonSegment(value: CalendarView.week, icon: Icon(Icons.view_week), label: Text('Week')),
                ButtonSegment(value: CalendarView.month, icon: Icon(Icons.calendar_view_month), label: Text('Month')),
              ],
              selected: {_view},
              onSelectionChanged: (s) => setState(() => _view = s.first),
            ),
            FilledButton.tonalIcon(
              onPressed: () {},
              icon: const Icon(Icons.event_available),
              label: Text('Today • ${DateFormat('EEE, MMM d').format(_anchorDate)}'),
            ),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('New task for this view'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Expanded(
          child: asyncTasks.when(
            data: (tasks) {
              final filtered = _filtered(tasks);
              if (filtered.isEmpty) {
                return AppStateView.empty(
                  message: _view == CalendarView.day
                      ? 'No tasks today.'
                      : _view == CalendarView.week
                          ? 'No tasks this week.'
                          : 'No tasks this month.',
                );
              }
              return ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final item = filtered[index];
                  final color = _statusColor(item.status);
                  final dateLabel = DateFormat('EEE, MMM d').format(item.dueDate);
                  return _CalendarItem(
                    title: item.title,
                    dateLabel: dateLabel,
                    color: color,
                    onTap: item.projectId == null
                        ? null
                        : () => context.go(
                              '/projects/${item.projectId}/task/${item.id}',
                              extra: item,
                            ),
                  );
                },
              );
            },
            loading: () => const AppStateView.loading(
              shimmer: ShimmerList(),
            ),
            error: (err, _) => AppStateView.error(message: 'Failed to load tasks: $err'),
          ),
        ),
      ],
    );
  }
}

class _CalendarItem extends StatelessWidget {
  const _CalendarItem({
    required this.title,
    required this.dateLabel,
    required this.color,
    this.onTap,
  });

  final String title;
  final String dateLabel;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color.withOpacity(0.18),
        colorScheme.surfaceContainerHighest.withOpacity(0.9),
      ],
    );

    return AnimatedCard(
      backgroundGradient: gradient,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.75),
                  color.withOpacity(0.5),
                ],
              ),
            ),
            child: const Icon(Icons.event_available, color: Colors.white),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 14, color: AppColors.neutral.withOpacity(0.8)),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      dateLabel,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: AppColors.neutral),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.more_vert),
            tooltip: 'Task actions',
          ),
        ],
      ),
    );
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
