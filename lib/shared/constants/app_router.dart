// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/storage/auth_local_datasource.dart';
import '../../core/storage/auth_local_datasource_provider.dart';
import '../../data/enums/auth_status.dart';
import '../../features/authentication/presentation/controllers/auth/auth_controller.dart';

import '../../features/authentication/presentation/screens/forgot_password_screen.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/register_screen.dart';
import '../../features/history_report/presentation/screens/reports_history_page.dart';
import '../../features/home/presentation/screen/home_screen.dart';
import '../../features/offline_sms/presentation/screens/offline_sms_screen.dart';
import '../../features/profile/presentation/widgets/edit_profile_page.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/report_incident/presentation/screens/report_incident_screen.dart';
import '../../shared/widgets/splash_screen.dart';
import '../common/navigation_keys.dart';
import '../widgets/about_page.dart';
import '../widgets/privacy_policy_page.dart';
import '../widgets/terms_and_conditions_page.dart';
import 'fade_extension.dart';
import 'sg_route.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true) // 👈 THIS is what you're missing
GoRouter goRouter(Ref ref) {
  final AuthStatus authStatus = ref.watch(authControllerProvider);
  final AuthLocalDataSource authLocalDataSource = ref.read(
    authLocalDataSourceProvider,
  );

  print('GoRouter: Initializing with auth status: $authStatus');
  final ValueNotifier<AuthStatus> notifier = ValueNotifier<AuthStatus>(
    ref.read(authControllerProvider),
  );

  ref.listen(authControllerProvider, (_, AuthStatus next) {
    notifier.value = next;
  });

  ref.onDispose(() => notifier.dispose());

  final List<String> publicRoutes = [
    SGRoute.login.route,

    SGRoute.register.route,

    SGRoute.forgotPassword.route,

    SGRoute.offlineSMS.route,
  ];
  // Always accessible regardless of auth state
  final List<String> openRoutes = [
    SGRoute.privacyPolicy.route,
    SGRoute.termsAndConditions.route,
  ];
  // Check if splash has been shown before
  final splashShown = authLocalDataSource.isSplashShown();
  final initialLocation = () {
    if (!splashShown) {
      // First time app launch - show splash screen
      return SGRoute.splash.route;
    } else if (authStatus == AuthStatus.authenticated) {
      // User is authenticated - go to home
      return SGRoute.home.route;
    } else {
      // User not authenticated - go to login
      return SGRoute.login.route;
    }
  }();

  // print(
  //   'GoRouter: Splash shown: $splashShown, Initial location: $initialLocation',
  // );

  return GoRouter(
    initialLocation: initialLocation,

    navigatorKey: rootNavigatorKey,

    refreshListenable: notifier,

    redirect: (BuildContext context, GoRouterState state) {
      final bool isAuthenticated = notifier.value == AuthStatus.authenticated;
      final bool isPublicRoute = publicRoutes.contains(state.matchedLocation);
      final bool isSplashRoute = state.matchedLocation == SGRoute.splash.route;
      final bool isOpenRoute = openRoutes.contains(
        state.matchedLocation,
      ); // 👈 add this

      // Don't redirect from splash screen - let it handle its own navigation
      if (isSplashRoute) return null;
      if (isOpenRoute) return null; // 👈 add this — always allow through

      if (!isAuthenticated && !isPublicRoute) return SGRoute.login.route;
      if (isAuthenticated && isPublicRoute) return SGRoute.home.route;
      print(
        'GoRouter redirect: isAuthenticated=$isAuthenticated, isPublicRoute=$isPublicRoute, current=${state.matchedLocation}',
      );
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: SGRoute.splash.route,

        builder: (_, __) => const SplashScreen(),
      ),

      GoRoute(
        path: SGRoute.login.route,

        builder: (_, __) => const LoginScreen(),
      ).fade(),

      GoRoute(
        path: SGRoute.forgotPassword.route,

        builder: (_, __) => const ForgotPasswordScreen(),
      ).fade(),

      GoRoute(
        path: SGRoute.register.route,

        builder: (_, __) => const RegisterScreen(),
      ).fade(),

      GoRoute(
        path: SGRoute.home.route,

        builder: (_, __) => const HomeScreen(),
      ).fade(),

      GoRoute(
        path: SGRoute.accountInfo.route,

        builder: (_, __) => const ProfilePage(),
      ).fade(),

      GoRoute(
        path: SGRoute.editProfile.route,

        builder: (_, __) => const EditProfilePage(),
      ).fade(),

      GoRoute(
        path: SGRoute.about.route,
        builder: (_, __) => const AboutPage(),
      ).fade(),

      GoRoute(
        path: SGRoute.reportIncident.route,

        builder: (_, __) => const ReportIncidentScreen(),
      ).fade(),

      GoRoute(
        path: SGRoute.reportsHistory.route,
        builder: (_, __) => const ReportsHistoryPage(),
      ).fade(),

      GoRoute(
        path: SGRoute.termsAndConditions.route,
        builder: (context, state) {
          final navigateToProfileOnBack = state.extra as bool? ?? true;
          return TermsAndConditionsPage(
            navigateToProfileOnBack: navigateToProfileOnBack,
          );
        },
      ).fade(),

      GoRoute(
        path: SGRoute.privacyPolicy.route,
        builder: (context, state) {
          final navigateToProfileOnBack = state.extra as bool? ?? true;
          return PrivacyPolicyPage(
            navigateToProfileOnBack: navigateToProfileOnBack,
          );
        },
        // builder: (_, __) => const PrivacyPolicyPage(),
      ).fade(),

      GoRoute(
        path: SGRoute.offlineSMS.route,
        builder: (_, __) => const OfflineSmsScreen(),
      ).fade(),
    ],
  );
}
