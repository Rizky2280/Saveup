import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../features/activity/presentation/activity_screen.dart';
import '../../features/goals/presentation/goals_list_screen.dart';
import '../../features/home/presentation/home_dashboard_screen.dart';
import '../../features/profile/presentation/profile_settings_screen.dart';
import '../widgets/widgets.dart';

class MainTabShell extends StatefulWidget {
  const MainTabShell({this.initialItem = SaveUpNavItem.home, super.key});

  final SaveUpNavItem initialItem;

  static bool selectTab(BuildContext context, SaveUpNavItem item) {
    final state = context
        .dependOnInheritedWidgetOfExactType<_MainTabShellScope>()
        ?.state;
    if (state == null) {
      return false;
    }
    state._selectTab(item);
    return true;
  }

  @override
  State<MainTabShell> createState() => _MainTabShellState();
}

class _MainTabShellState extends State<MainTabShell> {
  late final PageController _pageController;
  late SaveUpNavItem _currentItem;
  DateTime? _lastBackPressedAt;

  static const _items = [
    SaveUpNavItem.home,
    SaveUpNavItem.goals,
    SaveUpNavItem.activity,
    SaveUpNavItem.profile,
  ];

  @override
  void initState() {
    super.initState();
    _currentItem = widget.initialItem;
    _pageController = PageController(initialPage: _indexOf(widget.initialItem));
  }

  @override
  void didUpdateWidget(covariant MainTabShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialItem != oldWidget.initialItem &&
        widget.initialItem != _currentItem) {
      _selectTab(widget.initialItem, jump: true);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, _) => _handleBackPressed(context),
      child: _MainTabShellScope(
        state: this,
        child: SaveUpScaffold(
          applySafeArea: false,
          bottomNavigationBar: SaveUpBottomNavBar(
            currentItem: _currentItem,
            onChanged: _selectTab,
          ),
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentItem = _items[index]);
            },
            children: const [
              HomeDashboardScreen(showBottomNavigation: false),
              GoalsListScreen(showBottomNavigation: false),
              ActivityScreen(showBottomNavigation: false),
              ProfileSettingsScreen(showBottomNavigation: false),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleBackPressed(BuildContext context) async {
    if (_currentItem != SaveUpNavItem.home) {
      _selectTab(SaveUpNavItem.home);
      return;
    }

    final now = DateTime.now();
    final shouldExit =
        _lastBackPressedAt != null &&
        now.difference(_lastBackPressedAt!) < const Duration(seconds: 2);

    if (shouldExit) {
      SystemNavigator.pop();
      return;
    }

    _lastBackPressedAt = now;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Press back again to exit')));
  }

  void _selectTab(SaveUpNavItem item, {bool jump = false}) {
    final index = _indexOf(item);
    setState(() => _currentItem = item);
    if (jump) {
      _pageController.jumpToPage(index);
    } else {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
      );
    }
  }

  static int _indexOf(SaveUpNavItem item) => _items.indexOf(item);
}

class _MainTabShellScope extends InheritedWidget {
  const _MainTabShellScope({required this.state, required super.child});

  final _MainTabShellState state;

  @override
  bool updateShouldNotify(_MainTabShellScope oldWidget) {
    return state != oldWidget.state;
  }
}
