import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Screens
import '../screens/splash/splash_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/record/record_screen.dart';
import '../screens/record/result_screen.dart';
import '../screens/calendar/calendar_screen.dart';
import '../screens/trends/trends_screen.dart';
import '../screens/insights/insights_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/settings/privacy_settings_screen.dart';
import '../screens/wellness/wellness_history_screen.dart';

// Navigation shell
import 'main_shell.dart';

/// App router configuration using go_router
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Splash screen
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    // Onboarding
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    // Auth routes
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),

    // Main app routes with shell
    ShellRoute(
      builder: (context, state, child) => MainShell(child: child),
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) {
            final action = state.uri.queryParameters['action'];
            return CustomTransitionPage(
              key: const ValueKey('home'),
              child: HomeScreen(initialAction: action),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
        ),
        GoRoute(
          path: '/calendar',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: const ValueKey('calendar'),
            child: const CalendarScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/trends',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: const ValueKey('trends'),
            child: const TrendsScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/insights',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: const ValueKey('insights'),
            child: const InsightsScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: const ValueKey('profile'),
            child: const ProfileScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
      ],
    ),

    // Recording flow (outside shell)
    GoRoute(
      path: '/record',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: const ValueKey('record'),
        child: const RecordScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/result',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: const ValueKey('result'),
        child: const ResultScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: child,
            ),
          );
        },
      ),
    ),

    // Settings routes
    GoRoute(
      path: '/privacy-settings',
      builder: (context, state) => const PrivacySettingsScreen(),
    ),

    // Wellness history route
    GoRoute(
      path: '/wellness-history',
      builder: (context, state) => const WellnessHistoryScreen(),
    ),

    // Entry detail route
    GoRoute(
      path: '/entry/:id',
      builder: (context, state) {
        // final id = state.pathParameters['id']!;
        // For now, just go back to home - can implement detail screen later
        return const HomeScreen();
      },
    ),
  ],

  // Error handler
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '404',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text('Page not found: ${state.uri}'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/home'),
            child: const Text('Go Home'),
          ),
        ],
      ),
    ),
  ),
);
