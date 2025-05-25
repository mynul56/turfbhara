import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/verification_page.dart';
import '../../features/auth/presentation/pages/change_password_page.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/main_navigation_page.dart';
import '../../features/turf/presentation/pages/turf_list_page.dart';
import '../../features/turf/presentation/pages/turf_detail_page.dart';
import '../../features/turf/presentation/pages/nearby_turf_page.dart';
import '../../features/booking/presentation/pages/booking_page.dart';
import '../../features/booking/presentation/pages/booking_confirmation_page.dart';
import '../../features/booking/presentation/pages/booking_history_page.dart';
import '../../features/booking/presentation/pages/booking_detail_page.dart';
import '../../features/payment/presentation/pages/payment_page.dart';
import '../../features/payment/presentation/pages/payment_success_page.dart';
import '../../features/payment/presentation/pages/payment_failed_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/presentation/pages/settings_page.dart';
import '../../features/profile/presentation/pages/notifications_page.dart';
import '../../features/profile/presentation/pages/help_support_page.dart';
import '../../features/profile/presentation/pages/about_page.dart';
import '../../features/profile/presentation/pages/privacy_policy_page.dart';
import '../../features/profile/presentation/pages/terms_conditions_page.dart';
import '../constants/app_constants.dart';

// Route Names
class AppRoutes {
  // Auth Routes
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verification = '/verification';
  static const String changePassword = '/change-password';

  // Main Routes
  static const String home = '/home';
  static const String mainNavigation = '/main';

  // Turf Routes
  static const String turfList = '/turf-list';
  static const String turfDetail = '/turf-detail';
  static const String nearbyTurf = '/nearby-turf';

  // Booking Routes
  static const String booking = '/booking';
  static const String bookingConfirmation = '/booking-confirmation';
  static const String bookingHistory = '/booking-history';
  static const String bookingDetail = '/booking-detail';

  // Payment Routes
  static const String payment = '/payment';
  static const String paymentSuccess = '/payment-success';
  static const String paymentFailed = '/payment-failed';

  // Profile Routes
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String helpSupport = '/help-support';
  static const String about = '/about';
  static const String privacyPolicy = '/privacy-policy';
  static const String termsConditions = '/terms-conditions';
}

// Router Provider
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: AppConstants.isDebugMode,
    routes: [
      // Splash Route
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),

      // Onboarding Route
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),

      // Auth Routes
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.verification,
        name: 'verification',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return VerificationPage(
            email: extra?['email'] ?? '',
            verificationType: extra?['type'] ?? 'email',
          );
        },
      ),
      GoRoute(
        path: AppRoutes.changePassword,
        name: 'changePassword',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return ChangePasswordPage(
            token: extra?['token'] ?? '',
          );
        },
      ),

      // Main Navigation Route
      GoRoute(
        path: AppRoutes.mainNavigation,
        name: 'mainNavigation',
        builder: (context, state) {
          return MainNavigationPage(
            location: state.uri.toString(),
            child: const SizedBox
                .shrink(), // Provide a default child or appropriate widget
          );
        },
        routes: [
          // Home Route
          GoRoute(
            path: 'home',
            name: 'home',
            builder: (context, state) => const HomePage(),
          ),
        ],
      ),

      // Home Route (Standalone)
      GoRoute(
        path: AppRoutes.home,
        name: 'homeStandalone',
        builder: (context, state) => const HomePage(),
      ),

      // Turf Routes
      GoRoute(
        path: AppRoutes.turfList,
        name: 'turfList',
        builder: (context, state) {
          final queryParams = state.uri.queryParameters;
          return TurfListPage(
            category: queryParams['category'],
            location: queryParams['location'],
            searchQuery: queryParams['search'],
          );
        },
      ),
      GoRoute(
        path: '${AppRoutes.turfDetail}/:turfId',
        name: 'turfDetail',
        builder: (context, state) {
          final turfId = state.pathParameters['turfId']!;
          return TurfDetailPage(turfId: turfId);
        },
      ),
      GoRoute(
        path: AppRoutes.nearbyTurf,
        name: 'nearbyTurf',
        builder: (context, state) => const NearbyTurfPage(),
      ),

      // Booking Routes
      GoRoute(
        path: '${AppRoutes.booking}/:turfId',
        name: 'booking',
        builder: (context, state) {
          final turfId = state.pathParameters['turfId']!;
          final extra = state.extra as Map<String, dynamic>?;
          return BookingPage(
            turfId: turfId,
            selectedDate: extra?['selectedDate'],
            selectedSlots: extra?['selectedSlots'],
          );
        },
      ),
      GoRoute(
        path: '${AppRoutes.bookingConfirmation}/:bookingId',
        name: 'bookingConfirmation',
        builder: (context, state) {
          final bookingId = state.pathParameters['bookingId']!;
          return BookingConfirmationPage(bookingId: bookingId);
        },
      ),
      GoRoute(
        path: AppRoutes.bookingHistory,
        name: 'bookingHistory',
        builder: (context, state) => const BookingHistoryPage(),
      ),
      GoRoute(
        path: '${AppRoutes.bookingDetail}/:bookingId',
        name: 'bookingDetail',
        builder: (context, state) {
          final bookingId = state.pathParameters['bookingId']!;
          return BookingDetailPage(bookingId: bookingId);
        },
      ),

      // Payment Routes
      GoRoute(
        path: '${AppRoutes.payment}/:bookingId',
        name: 'payment',
        builder: (context, state) {
          final bookingId = state.pathParameters['bookingId']!;
          final extra = state.extra as Map<String, dynamic>?;
          return PaymentPage(
            bookingId: bookingId,
            amount: extra?['amount'] ?? 0.0,
            paymentMethod: extra?['paymentMethod'],
          );
        },
      ),
      GoRoute(
        path: '${AppRoutes.paymentSuccess}/:transactionId',
        name: 'paymentSuccess',
        builder: (context, state) {
          final transactionId = state.pathParameters['transactionId']!;
          final extra = state.extra as Map<String, dynamic>?;
          return PaymentSuccessPage(
            transactionId: transactionId,
            bookingId: extra?['bookingId'],
            amount: extra?['amount'] ?? 0.0,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.paymentFailed,
        name: 'paymentFailed',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return PaymentFailedPage(
            error: extra?['error'] ?? 'Payment failed',
            bookingId: extra?['bookingId'],
          );
        },
      ),

      // Profile Routes
      GoRoute(
        path: AppRoutes.profile,
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        name: 'editProfile',
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        name: 'notifications',
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: AppRoutes.helpSupport,
        name: 'helpSupport',
        builder: (context, state) => const HelpSupportPage(),
      ),
      GoRoute(
        path: AppRoutes.about,
        name: 'about',
        builder: (context, state) => const AboutPage(),
      ),
      GoRoute(
        path: AppRoutes.privacyPolicy,
        name: 'privacyPolicy',
        builder: (context, state) => const PrivacyPolicyPage(),
      ),
      GoRoute(
        path: AppRoutes.termsConditions,
        name: 'termsConditions',
        builder: (context, state) => const TermsConditionsPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page Not Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Fix: Add the required 'child' parameter to ElevatedButton
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

// Navigation Helper Extensions
extension AppRouterExtension on GoRouter {
  void pushAndClearStack(String location, {Object? extra}) {
    // GoRouter does not have canPop/pop on itself, but context does.
    // This is a custom helper, but GoRouter's context.pop() should be used in widgets.
    // For now, just use pushReplacement for clearing stack.
    pushReplacement(location, extra: extra);
  }
}

// Navigation Helper Methods
class AppNavigation {
  static void goToLogin(BuildContext context) {
    context.go(AppRoutes.login);
  }

  static void goToRegister(BuildContext context) {
    context.go(AppRoutes.register);
  }

  static void goToHome(BuildContext context) {
    context.go(AppRoutes.mainNavigation);
  }

  static void goToTurfDetail(BuildContext context, String turfId) {
    context.push('${AppRoutes.turfDetail}/$turfId');
  }

  static void goToBooking(
    BuildContext context,
    String turfId, {
    DateTime? selectedDate,
    List<String>? selectedSlots,
  }) {
    context.push(
      '${AppRoutes.booking}/$turfId',
      extra: {
        'selectedDate': selectedDate,
        'selectedSlots': selectedSlots,
      },
    );
  }

  static void goToPayment(
    BuildContext context,
    String bookingId, {
    required double amount,
    String? paymentMethod,
  }) {
    context.push(
      '${AppRoutes.payment}/$bookingId',
      extra: {
        'amount': amount,
        'paymentMethod': paymentMethod,
      },
    );
  }

  static void goToPaymentSuccess(
    BuildContext context,
    String transactionId, {
    String? bookingId,
    double? amount,
  }) {
    context.pushReplacement(
      '${AppRoutes.paymentSuccess}/$transactionId',
      extra: {
        'bookingId': bookingId,
        'amount': amount,
      },
    );
  }

  static void goToPaymentFailed(
    BuildContext context, {
    required String error,
    String? bookingId,
  }) {
    context.pushReplacement(
      AppRoutes.paymentFailed,
      extra: {
        'error': error,
        'bookingId': bookingId,
      },
    );
  }

  static void goToVerification(
    BuildContext context, {
    required String email,
    required String type,
  }) {
    context.push(
      AppRoutes.verification,
      extra: {
        'email': email,
        'type': type,
      },
    );
  }

  static void goToChangePassword(BuildContext context, String token) {
    context.push(
      AppRoutes.changePassword,
      extra: {'token': token},
    );
  }

  static void logout(BuildContext context) {
    context.go(AppRoutes.login);
  }

  static void goBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      context.go(AppRoutes.home);
    }
  }
}
