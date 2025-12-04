import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/tokens.dart';
import '../../../design_system/widgets/app_scaffold.dart';
import '../../../design_system/widgets/expandable_fab.dart';
import '../../../theme/gradients.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child, required this.location});

  final Widget child;
  final String location;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {

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

  void _navigateToIndex(int index) {
    if (index >= 0 && index < _items.length) {
      final target = _items[index];
      if (target.path != widget.location) {
        context.go(target.path);
      }
    }
  }

  void _onHorizontalSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    
    // Require minimum swipe velocity
    if (velocity.abs() < 500) return;

    final currentIndex = _locationToIndex(widget.location);
    
    if (velocity < 0) {
      // Swipe left - go to next page
      _navigateToIndex(currentIndex + 1);
    } else {
      // Swipe right - go to previous page
      _navigateToIndex(currentIndex - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _locationToIndex(widget.location);
    final isProjectsScreen = widget.location.startsWith('/projects') && !widget.location.contains('/projects/');

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
                child: GestureDetector(
                  onHorizontalDragEnd: _onHorizontalSwipe,
                  behavior: HitTestBehavior.translucent,
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
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: _navigateToIndex,
          destinations: [
            for (final item in _items)
              NavigationDestination(
                icon: Icon(item.icon),
                label: item.label,
              ),
          ],
        ),
        floatingActionButton: isProjectsScreen
            ? ExpandableFab(
                mainIcon: Icons.add,
                actions: [
                  FabAction(
                    icon: Icons.folder_outlined,
                    label: 'New Project',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('New project creation coming soon')),
                    ),
                  ),
                  FabAction(
                    icon: Icons.task_alt,
                    label: 'Quick Task',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Quick task creation coming soon')),
                    ),
                  ),
                  FabAction(
                    icon: Icons.qr_code_scanner,
                    label: 'Scan QR',
                    onTap: () => context.push('/qr-scanner'),
                    color: AppColors.accent,
                  ),
                ],
              )
            : null,
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
