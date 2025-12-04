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

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime _currentMonth;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
    _selectedDate = DateTime.now();
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  void _goToToday() {
    setState(() {
      final now = DateTime.now();
      _currentMonth = DateTime(now.year, now.month);
      _selectedDate = now;
    });
  }

  List<TaskItem> _getTasksForDate(List<TaskItem> tasks, DateTime date) {
    return tasks.where((t) =>
      t.dueDate.year == date.year &&
      t.dueDate.month == date.month &&
      t.dueDate.day == date.day
    ).toList();
  }

  List<TaskItem> _getTasksForMonth(List<TaskItem> tasks) {
    return tasks.where((t) =>
      t.dueDate.year == _currentMonth.year &&
      t.dueDate.month == _currentMonth.month
    ).toList()..sort((a, b) => a.dueDate.compareTo(b.dueDate));
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
        
        // Month navigation
        Row(
          children: [
            IconButton(
              onPressed: _previousMonth,
              icon: const Icon(Icons.chevron_left),
              tooltip: 'Previous month',
            ),
            Expanded(
              child: Center(
                child: Text(
                  DateFormat('MMMM yyyy').format(_currentMonth),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: _nextMonth,
              icon: const Icon(Icons.chevron_right),
              tooltip: 'Next month',
            ),
            const SizedBox(width: AppSpacing.sm),
            FilledButton.tonalIcon(
              onPressed: _goToToday,
              icon: const Icon(Icons.today),
              label: const Text('Today'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        
        // Calendar grid
        asyncTasks.when(
          data: (tasks) {
            return _CalendarGrid(
              currentMonth: _currentMonth,
              selectedDate: _selectedDate,
              tasks: tasks,
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            );
          },
          loading: () => const SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (err, _) => SizedBox(
            height: 300,
            child: AppStateView.error(message: 'Failed to load calendar'),
          ),
        ),
        
        const SizedBox(height: AppSpacing.lg),
        const Divider(),
        const SizedBox(height: AppSpacing.md),
        
        // Selected date tasks
        Expanded(
          child: asyncTasks.when(
            data: (tasks) {
              if (_selectedDate == null) {
                return const AppStateView.empty(
                  message: 'Select a date to view tasks',
                );
              }
              
              final dayTasks = _getTasksForDate(tasks, _selectedDate!);
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tasks for ${DateFormat('EEEE, MMMM d').format(_selectedDate!)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (dayTasks.isEmpty)
                    const Expanded(
                      child: AppStateView.empty(
                        message: 'No tasks on this date',
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.separated(
                        itemCount: dayTasks.length,
                        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                        itemBuilder: (context, index) {
                          final item = dayTasks[index];
                          final color = _statusColor(item.status);
                          return _CalendarItem(
                            title: item.title,
                            color: color,
                            status: item.status,
                            onTap: item.projectId == null
                                ? null
                                : () => context.go(
                                      '/projects/${item.projectId}/task/${item.id}',
                                      extra: item,
                                    ),
                          );
                        },
                      ),
                    ),
                ],
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

// Calendar Grid Widget
class _CalendarGrid extends StatelessWidget {
  const _CalendarGrid({
    required this.currentMonth,
    required this.selectedDate,
    required this.tasks,
    required this.onDateSelected,
  });

  final DateTime currentMonth;
  final DateTime? selectedDate;
  final List<TaskItem> tasks;
  final Function(DateTime) onDateSelected;

  List<DateTime> _getDaysInMonth() {
    final firstDay = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDay = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    
    final days = <DateTime>[];
    
    // Add padding days from previous month
    final weekdayOfFirst = firstDay.weekday % 7; // 0 = Sunday, 1 = Monday, etc.
    for (int i = weekdayOfFirst - 1; i >= 0; i--) {
      days.add(firstDay.subtract(Duration(days: i + 1)));
    }
    
    // Add all days of current month
    for (int day = 1; day <= lastDay.day; day++) {
      days.add(DateTime(currentMonth.year, currentMonth.month, day));
    }
    
    // Add padding days from next month to complete the grid
    final remainingCells = (7 - (days.length % 7)) % 7;
    for (int i = 1; i <= remainingCells; i++) {
      days.add(lastDay.add(Duration(days: i)));
    }
    
    return days;
  }

  int _getTaskCountForDate(DateTime date) {
    return tasks.where((t) =>
      t.dueDate.year == date.year &&
      t.dueDate.month == date.month &&
      t.dueDate.day == date.day
    ).length;
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
           date.month == now.month &&
           date.day == now.day;
  }

  bool _isSelected(DateTime date) {
    if (selectedDate == null) return false;
    return date.year == selectedDate!.year &&
           date.month == selectedDate!.month &&
           date.day == selectedDate!.day;
  }

  bool _isCurrentMonth(DateTime date) {
    return date.month == currentMonth.month && date.year == currentMonth.year;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final days = _getDaysInMonth();
    
    return Column(
      children: [
        // Weekday headers
        Row(
          children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((day) {
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.sm),
        
        // Calendar grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: days.length,
          itemBuilder: (context, index) {
            final date = days[index];
            final isToday = _isToday(date);
            final isSelected = _isSelected(date);
            final isCurrentMonth = _isCurrentMonth(date);
            final taskCount = _getTaskCountForDate(date);
            
            return _CalendarDay(
              date: date,
              isToday: isToday,
              isSelected: isSelected,
              isCurrentMonth: isCurrentMonth,
              taskCount: taskCount,
              onTap: () => onDateSelected(date),
            );
          },
        ),
      ],
    );
  }
}

// Calendar Day Cell Widget
class _CalendarDay extends StatelessWidget {
  const _CalendarDay({
    required this.date,
    required this.isToday,
    required this.isSelected,
    required this.isCurrentMonth,
    required this.taskCount,
    required this.onTap,
  });

  final DateTime date;
  final bool isToday;
  final bool isSelected;
  final bool isCurrentMonth;
  final int taskCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    Color? backgroundColor;
    Color? textColor;
    
    if (isSelected) {
      backgroundColor = colorScheme.primary;
      textColor = colorScheme.onPrimary;
    } else if (isToday) {
      backgroundColor = colorScheme.primaryContainer;
      textColor = colorScheme.onPrimaryContainer;
    }
    
    if (!isCurrentMonth) {
      textColor = colorScheme.onSurfaceVariant.withOpacity(0.4);
    }
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: isToday && !isSelected
              ? Border.all(color: colorScheme.primary, width: 2)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${date.day}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: textColor,
                fontWeight: isToday || isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (taskCount > 0) ...[
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colorScheme.onPrimary.withOpacity(0.3)
                      : colorScheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$taskCount',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isSelected ? colorScheme.onPrimary : colorScheme.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CalendarItem extends StatelessWidget {
  const _CalendarItem({
    required this.title,
    required this.color,
    required this.status,
    this.onTap,
  });

  final String title;
  final Color color;
  final TaskStatus status;
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
            child: Icon(
              status == TaskStatus.done ? Icons.check_circle : Icons.event_available,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    decoration: status == TaskStatus.done
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status.name.toUpperCase(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (onTap != null)
            Icon(Icons.chevron_right, color: AppColors.neutral),
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
