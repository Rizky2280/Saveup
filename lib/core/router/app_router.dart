import 'package:go_router/go_router.dart';

import '../../features/goals/presentation/create_goal_screen.dart';
import '../../features/goals/presentation/goal_detail_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/setup/presentation/setup_screen.dart';
import '../../features/simulation/presentation/savings_simulation_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../widgets/saveup_bottom_nav_bar.dart';
import 'main_tab_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/onboarding/simulate',
      builder: (context, state) =>
          const OnboardingScreen(step: OnboardingStep.simulate),
    ),
    GoRoute(
      path: '/onboarding/track',
      builder: (context, state) =>
          const OnboardingScreen(step: OnboardingStep.track),
    ),
    GoRoute(
      path: '/onboarding/motivation',
      builder: (context, state) =>
          const OnboardingScreen(step: OnboardingStep.motivation),
    ),
    GoRoute(path: '/setup', builder: (context, state) => const SetupScreen()),
    GoRoute(path: '/home', builder: (context, state) => const MainTabShell()),
    GoRoute(
      path: '/goals',
      builder: (context, state) =>
          const MainTabShell(initialItem: SaveUpNavItem.goals),
    ),
    GoRoute(
      path: '/goals/create',
      builder: (context, state) => const CreateGoalScreen(),
    ),
    GoRoute(
      path: '/goals/simulation',
      builder: (context, state) => SavingsSimulationScreen(draft: state.extra),
    ),
    GoRoute(
      path: '/goals/:goalId',
      builder: (context, state) =>
          GoalDetailScreen(goalId: state.pathParameters['goalId'] ?? ''),
    ),
    GoRoute(
      path: '/activity',
      builder: (context, state) =>
          const MainTabShell(initialItem: SaveUpNavItem.activity),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) =>
          const MainTabShell(initialItem: SaveUpNavItem.profile),
    ),
  ],
);
