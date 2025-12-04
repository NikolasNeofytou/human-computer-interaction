import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';
import 'core/providers/feedback_providers.dart';
import 'core/providers/deep_link_providers.dart';
import 'core/services/deep_link_service.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: TaskflowApp()));
}

class TaskflowApp extends ConsumerStatefulWidget {
  const TaskflowApp({super.key});

  @override
  ConsumerState<TaskflowApp> createState() => _TaskflowAppState();
}

class _TaskflowAppState extends ConsumerState<TaskflowApp> {
  late final GlobalKey<NavigatorState> _navigatorKey;

  @override
  void initState() {
    super.initState();
    _navigatorKey = GlobalKey<NavigatorState>();

    // Initialize services
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Initialize feedback services
      await ref.read(feedbackServiceProvider).initialize();
      ref.read(feedbackSettingsProvider);

      // Initialize deep link handling
      final deepLinkService = ref.read(deepLinkServiceProvider);

      // Check for initial deep link (app opened via link)
      final initialUri = await deepLinkService.initialize();
      if (initialUri != null) {
        _handleDeepLink(initialUri);
      }

      // Listen for deep links while app is running
      deepLinkService.startListening(_handleDeepLink);
    });
  }

  /// Handle incoming deep link
  void _handleDeepLink(Uri uri) {
    final deepLinkService = ref.read(deepLinkServiceProvider);
    final linkData = deepLinkService.parseDeepLink(uri);

    if (linkData == null) {
      debugPrint('❌ Failed to parse deep link: $uri');
      return;
    }

    debugPrint('✅ Handling deep link: $linkData');

    // Use router to navigate
    final context = _navigatorKey.currentContext;
    if (context == null || !context.mounted) {
      debugPrint('❌ No context available for navigation');
      return;
    }

    // Route based on link type
    switch (linkData.type) {
      case DeepLinkType.invite:
        // Navigate to invite handler screen
        // This screen will validate and process the invite
        Navigator.of(context).pushNamed(
          '/invite/accept',
          arguments: {
            'projectId': linkData.projectId,
            'token': linkData.token,
          },
        );
        break;

      case DeepLinkType.task:
        // Navigate to task detail
        Navigator.of(context).pushNamed(
          '/task/${linkData.taskId}',
        );
        break;

      case DeepLinkType.project:
        // Navigate to project detail
        Navigator.of(context).pushNamed(
          '/projects/${linkData.projectId}',
        );
        break;

      case DeepLinkType.notification:
        // Navigate to notification detail or relevant screen
        Navigator.of(context).pushNamed(
          '/notification/${linkData.notificationId}',
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = createRouter();
    return MaterialApp.router(
      title: 'Taskflow',
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ThemeMode.dark,
      routerConfig: router,
      builder: (context, child) {
        // Store navigator key for deep link navigation
        return Navigator(
          key: _navigatorKey,
          onGenerateRoute: (_) => MaterialPageRoute(
            builder: (_) => child!,
          ),
        );
      },
    );
  }
}
