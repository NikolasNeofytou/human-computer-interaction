enum TaskStatus { pending, done, blocked }

class TaskItem {
  const TaskItem({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.status,
    this.projectId,
  });

  final String id;
  final String title;
  final DateTime dueDate;
  final TaskStatus status;
  final String? projectId;
}
