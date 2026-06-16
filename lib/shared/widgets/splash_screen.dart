import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/storage/auth_local_datasource_provider.dart';
import '../../data/enums/auth_status.dart';
import '../../features/authentication/presentation/controllers/auth/auth_controller.dart';
import '../constants/sg_route.dart';
import '../theme/app_theme.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _textFadeAnimation;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    print('SplashScreen: initState called');

    // Mark splash as shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authLocalDataSourceProvider).setSplashShown();
      print('SplashScreen: Splash shown flag set');
    });

    _initializeAnimations();
    _animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed && !_hasNavigated) {
        print(
          'SplashScreen: Animation completed, waiting 3 seconds before redirect',
        );
        _navigateAfterDelay();
      }
    });

    Future.delayed(const Duration(seconds: 7), () {
      if (!_hasNavigated) {
        print('SplashScreen: Backup timer triggered - navigating to home');
        _navigateToHome();
      }
    });
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.50)).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.5, 1, curve: Curves.easeOut),
          ),
        );

    _textFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.83, 1, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
  }

  void _navigateAfterDelay() {
    if (_hasNavigated) {
      print('SplashScreen: Already navigated, skipping');
      return;
    }

    print('SplashScreen: Starting 3-second delay after animation');
    Future.delayed(const Duration(seconds: 3), () {
      if (!_hasNavigated) {
        _navigateToHome();
      }
    });
  }

  void _navigateToHome() {
    if (_hasNavigated) {
      print('SplashScreen: Already navigated, skipping');
      return;
    }

    _hasNavigated = true;

    final authStatus = ref.read(authControllerProvider);
    print('SplashScreen: Auth status is $authStatus');

    if (authStatus == AuthStatus.authenticated) {
      print('SplashScreen: Navigating to home route');
      GoRouter.of(context).go(SGRoute.home.route);
    } else {
      print('SplashScreen: Navigating to login route');
      GoRouter.of(context).go(SGRoute.login.route);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('SplashScreen: build method called');
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Image.asset(
                        'assets/img/BFP_LOGO.png',
                        width: 200,
                        height: 200,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.local_fire_department,
                            size: 200,
                            color: AppTheme.primaryRed,
                          );
                        },
                      ),
                    ),
                  ),
                ),

                FadeTransition(
                  opacity: _textFadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 160),
                      Text(
                        'FireAlert',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryRed,
                          letterSpacing: 2,
                        ),
                      ),

                      SizedBox(height: 12),

                      Text(
                        'Emergency Reporting System',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.textSecondary,
                          letterSpacing: 1,
                        ),
                      ),

                      SizedBox(height: 60),

                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.primaryRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
