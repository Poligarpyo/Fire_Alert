// lib/features/authentication/presentation/screens/register_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/constants/sg_route.dart';
import '../../../../shared/theme/app_theme.dart';
import '../controllers/register/phone_auth_controller.dart';
import '../controllers/register/register_controller.dart';
import '../controllers/register/register_form_notifier.dart';
import '../controllers/register/register_state.dart';
import '../widgets/register/register_dialogs.dart';
import '../widgets/register/register_form_card.dart';
import '../widgets/register/register_header.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Controllers still needed for text input but owned here
    // We use a single listen block per provider

    ref
      ..listen(phoneAuthControllerProvider, (previous, next) {
        if (previous == next) return;
        // final notifier = ref.read(registerFormProvider.notifier);
        final notifier = ref.read(registerFormProvider.notifier);
        next.whenOrNull(
          otpSent: (verificationId) {
            notifier.setSubmitting(false);
            showOtpDialog(
              context: context,
              ref: ref,
              verificationId: verificationId,
              phoneNumber: ref.read(registerFormProvider).phone,
              onResend: () => _handleCreateAccount(ref),
              onCancel: () => notifier.setSubmitting(false),
            );
          },
          success: () => _submitRegistration(context, ref),
          error: (msg) {
            notifier.setSubmitting(false);
            showRegisterErrorDialog(
              context: context,
              message: msg,
              onRetry: () => _handleCreateAccount(ref),
            );
          },
        );
      })
      ..listen(registerControllerProvider, (previous, next) {
        if (previous == next) return;
        next.when(
          initial: () {},
          loading: () {},
          success: (message) {
            // ✅ Show the message before navigating
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: AppTheme.successGreen,
                duration: const Duration(seconds: 2),
              ),
            );
            context.go(SGRoute.reportIncident.route);
          },
          error: (message) {
            ref.read(registerFormProvider.notifier).setSubmitting(false);
            showRegisterErrorDialog(
              context: context,
              message: message,
              onRetry: () => _submitRegistration(context, ref),
            );
          },
        );
      });

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: context.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 12.0 : (isLargeScreen ? 24.0 : 14.0),
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                RegisterHeader(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                ),
                SizedBox(height: screenHeight * 0.04),
                RegisterFormCard(screenHeight: screenHeight),
                SizedBox(height: screenHeight * 0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleCreateAccount(WidgetRef ref) {
    final notifier = ref.read(registerFormProvider.notifier);
    if (!notifier.validate()) return;

    final state = ref.read(registerFormProvider);
    notifier.setSubmitting(true);
    ref
        .read(phoneAuthControllerProvider.notifier)
        .sendOtp('+63${state.phone.trim()}');
  }

  Future<void> _submitRegistration(BuildContext context, WidgetRef ref) async {
    if (context.mounted && Navigator.canPop(context)) Navigator.pop(context);
    final state = ref.read(registerFormProvider);
    await ref
        .read(registerControllerProvider.notifier)
        .register(
          name: state.name.trim(),
          phone: '+63${state.phone.trim()}',
          address: state.address.trim(),
          password: state.password,
        );
  }
}

// ── Private form card widget ─────────────────────────────────────────────────
