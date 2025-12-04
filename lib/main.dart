import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';
import 'core/providers/feedback_providers.dart';
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
  @override
  void initState() {
    super.initState();
    // Initialize feedback services
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feedbackServiceProvider).initialize();
      // Watch settings
      ref.read(feedbackSettingsProvider);
    });
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
    );
  }
}
