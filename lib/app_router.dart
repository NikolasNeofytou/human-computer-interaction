import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/models/app_notification.dart';
import 'core/models/project.dart';
import 'core/models/request.dart';
import 'core/models/task_item.dart';
import 'features/notifications/presentation/notifications_screen.dart';
import 'features/notifications/presentation/notification_detail_screen.dart';
import 'features/inbox/presentation/inbox_screen.dart';
import 'features/profile/presentation/profile_screen.dart';
import 'features/projects/presentation/projects_screen.dart';
import 'features/projects/presentation/project_detail_screen.dart';
import 'features/projects/presentation/task_form_screen.dart';
import 'features/projects/presentation/task_detail_screen.dart';
import 'features/requests/presentation/requests_screen.dart';
import 'features/requests/presentation/request_detail_screen.dart';
import 'features/schedule/presentation/calendar_screen.dart';
import 'features/shell/presentation/app_shell.dart';
import 'features/chat/presentation/chat_screen.dart';

GoRouter createRouter() {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorKey = GlobalKey<NavigatorState>();

  CustomTransitionPage<T> fadeSlide<T>(Widget child) {
    return CustomTransitionPage<T>(
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offsetTween = Tween(begin: const Offset(0.0, 0.02), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeOut));
        final fadeTween =
            Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOut));
        return SlideTransition(
          position: animation.drive(offsetTween),
          child: FadeTransition(
            opacity: animation.drive(fadeTween),
            child: child,
          ),
        );
      },
    );
  }

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/calendar',
    routes: [
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) =>
            AppShell(location: state.uri.toString(), child: child),
        routes: [
          GoRoute(
            path: '/calendar',
            name: 'calendar',
            pageBuilder: (context, state) => fadeSlide(const CalendarScreen()),
          ),
          GoRoute(
            path: '/projects',
            name: 'projects',
            pageBuilder: (context, state) => fadeSlide(const ProjectsScreen()),
            routes: [
              GoRoute(
                path: ':id',
                name: 'project-detail',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  final project = state.extra;
                  return ProjectDetailScreen(
                    projectId: id,
                    project: project is Project ? project : null,
                  );
                },
                routes: [
                  GoRoute(
                    path: 'task/new',
                    name: 'task-new',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return TaskFormScreen(projectId: id);
                    },
                  ),
                  GoRoute(
                    path: 'task/:taskId/edit',
                    name: 'task-edit',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      final task = state.extra;
                      return TaskFormScreen(
                        projectId: id,
                        initialTask: task is TaskItem ? task : null,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'task/:taskId',
                    name: 'task-detail',
                    builder: (context, state) {
                      final id = state.pathParameters['id']!;
                      final task = state.extra;
                      if (task is TaskItem) {
                        return TaskDetailScreen(projectId: id, task: task);
                      }
                      return const Scaffold(
                        body: Center(child: Text('Task not found')),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (context, state) => fadeSlide(const ProfileScreen()),
          ),
          GoRoute(
            path: '/chat',
            name: 'chat',
            builder: (context, state) => const ChatScreen(),
            routes: [
              GoRoute(
                path: ':channelId',
                name: 'chat-thread',
                builder: (context, state) {
                  final channelId = state.pathParameters['channelId']!;
                  final label = state.extra is String ? state.extra as String : 'Chat';
                  return ChatThreadScreen(channelId: channelId, label: label);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/inbox',
            name: 'inbox',
            pageBuilder: (context, state) => fadeSlide(const InboxScreen()),
            routes: [
              GoRoute(
                path: 'request/:id',
                name: 'request-detail',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  final req = state.extra;
                  return RequestDetailScreen(
                    requestId: id,
                    request: req is Request ? req : null,
                  );
                },
              ),
              GoRoute(
                path: 'notification/:id',
                name: 'notification-detail',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  final notif = state.extra;
                  return NotificationDetailScreen(
                    notificationId: id,
                    notification: notif is AppNotification ? notif : null,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
