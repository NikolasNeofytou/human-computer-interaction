import 'dart:async';

import '../models/app_notification.dart';
import '../models/project.dart';
import '../models/request.dart';
import '../models/task_item.dart';

class MockDataSource {
  static final Map<String, List<TaskItem>> _projectTasks = {
    'proj-1': [
      TaskItem(
        id: 'task-a',
        title: 'Design handoff',
        dueDate: DateTime(2025, 8, 18),
        status: TaskStatus.pending,
        projectId: 'proj-1',
      ),
      TaskItem(
        id: 'task-b',
        title: 'Implement calendar',
        dueDate: DateTime(2025, 8, 20),
        status: TaskStatus.blocked,
        projectId: 'proj-1',
      ),
    ],
    'proj-2': [
      TaskItem(
        id: 'task-c',
        title: 'QA round',
        dueDate: DateTime(2025, 8, 22),
        status: TaskStatus.pending,
        projectId: 'proj-2',
      ),
    ],
    'proj-3': [
      TaskItem(
        id: 'task-d',
        title: 'Dependency fix',
        dueDate: DateTime(2025, 8, 19),
        status: TaskStatus.blocked,
        projectId: 'proj-3',
      ),
    ],
  };

  static Future<List<Request>> fetchRequests() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      Request(
        id: 'req-1',
        title: 'Member X asked you to take task Y',
        status: RequestStatus.pending,
        createdAt: DateTime(2025, 8, 15),
      ),
      Request(
        id: 'req-2',
        title: 'You want to take task X from member Y',
        status: RequestStatus.pending,
        createdAt: DateTime(2025, 8, 16),
      ),
      Request(
        id: 'req-3',
        title: 'Member Z accepted your request',
        status: RequestStatus.accepted,
        createdAt: DateTime(2025, 8, 17),
      ),
    ];
  }

  static Future<List<AppNotification>> fetchNotifications() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      AppNotification(
        id: 'not-1',
        title: 'Project X is overdue.',
        type: NotificationType.overdue,
        createdAt: DateTime(2025, 8, 12),
      ),
      AppNotification(
        id: 'not-2',
        title: 'Member Z commented on Project Y.',
        type: NotificationType.comment,
        createdAt: DateTime(2025, 8, 13),
      ),
      AppNotification(
        id: 'not-3',
        title: 'Member X accepted your request.',
        type: NotificationType.accepted,
        createdAt: DateTime(2025, 8, 14),
      ),
      AppNotification(
        id: 'not-4',
        title: 'Member Y declined your request.',
        type: NotificationType.declined,
        createdAt: DateTime(2025, 8, 15),
      ),
    ];
  }

  static Future<List<Project>> fetchProjects() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return const [
      Project(
        id: 'proj-1',
        name: 'Project A',
        status: ProjectStatus.dueSoon,
        tasks: 5,
      ),
      Project(
        id: 'proj-2',
        name: 'Project B',
        status: ProjectStatus.onTrack,
        tasks: 8,
      ),
      Project(
        id: 'proj-3',
        name: 'Project C',
        status: ProjectStatus.blocked,
        tasks: 3,
      ),
    ];
  }

  static Future<List<TaskItem>> fetchCalendarTasks() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      TaskItem(
        id: 'task-1',
        title: 'Project X due tomorrow',
        dueDate: DateTime(2025, 8, 17),
        status: TaskStatus.pending,
        projectId: 'proj-1',
      ),
      TaskItem(
        id: 'task-2',
        title: 'Project Z kickoff',
        dueDate: DateTime(2025, 8, 19),
        status: TaskStatus.pending,
        projectId: 'proj-2',
      ),
      TaskItem(
        id: 'task-3',
        title: 'Task review with Member Y',
        dueDate: DateTime(2025, 8, 21),
        status: TaskStatus.done,
        projectId: 'proj-1',
      ),
    ];
  }

  static Future<List<TaskItem>> fetchProjectTasks(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _projectTasks[projectId] ?? [];
  }
}
