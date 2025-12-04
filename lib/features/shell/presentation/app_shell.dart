import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/tokens.dart';
import '../../../design_system/widgets/app_scaffold.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child, required this.location});

  final Widget child;
  final String location;

  static const _items = <_NavItem>[
    _NavItem(label: 'Chat', icon: Icons.chat_bubble_outline, path: '/chat'),
    _NavItem(label: 'Calendar', icon: Icons.calendar_month_outlined, path: '/calendar'),
    _NavItem(label: 'Projects', icon: Icons.folder_copy_outlined, path: '/projects'),
    _NavItem(label: 'Profile', icon: Icons.person_outline, path: '/profile'),
  ];

  int _locationToIndex(String value) {
    if (value.startsWith('/calendar')) return 1;
    if (value.startsWith('/projects')) return 2;
    if (value.startsWith('/profile')) return 3;
    return 0; // chat default
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _locationToIndex(location);

    return AppScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      tooltip: 'Inbox (requests & notifications)',
                      icon: const Icon(Icons.inbox_outlined),
                      onPressed: () => context.go('/inbox'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (widget, animation) {
                      final slide = Tween<Offset>(
                        begin: const Offset(0, 0.02),
                        end: Offset.zero,
                      ).animate(animation);
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(position: slide, child: widget),
                      );
                    },
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            final target = _items[index];
            if (target.path != location) {
              context.go(target.path);
            }
          },
          destinations: [
            for (final item in _items)
              NavigationDestination(
                icon: Icon(item.icon),
                label: item.label,
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.path,
  });

  final String label;
  final IconData icon;
  final String path;
}
