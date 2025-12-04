enum NotificationType { overdue, comment, accepted, declined, completed }

class AppNotification {
  const AppNotification({
    required this.id,
    required this.title,
    required this.type,
    required this.createdAt,
  });

  final String id;
  final String title;
  final NotificationType type;
  final DateTime createdAt;
}
