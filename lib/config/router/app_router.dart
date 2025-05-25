import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

/// Provider that holds the app's router configuration
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // Splash screen
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      // Main app shell
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithBottomNav(
            child: child,
          );
        },
        routes: [
          // Home
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          // Bookings
          GoRoute(
            path: '/bookings',
            name: 'bookings',
            builder: (context, state) => const BookingsScreen(),
          ),
          // Profile
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      // Auth routes
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      // Turf details
      GoRoute(
        path: '/turf/:id',
        name: 'turf_details',
        builder: (context, state) => TurfDetailsScreen(
          turfId: state.pathParameters['id']!,
        ),
      ),
      // Booking flow
      GoRoute(
        path: '/book/:turfId',
        name: 'book_turf',
        builder: (context, state) => BookTurfScreen(
          turfId: state.pathParameters['turfId']!,
        ),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});

/// Scaffold with bottom navigation bar
class ScaffoldWithBottomNav extends StatelessWidget {
  final Widget child;

  const ScaffoldWithBottomNav({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.goNamed('home');
              break;
            case 1:
              context.goNamed('bookings');
              break;
            case 2:
              context.goNamed('profile');
              break;
          }
        },
        selectedIndex: _calculateSelectedIndex(context),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    final String location = state.uri.path;
    if (location.startsWith('/bookings')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }
}

// TODO: Import and implement these screens
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class TurfDetailsScreen extends StatelessWidget {
  final String turfId;
  const TurfDetailsScreen({super.key, required this.turfId});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class BookTurfScreen extends StatelessWidget {
  final String turfId;
  const BookTurfScreen({super.key, required this.turfId});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}