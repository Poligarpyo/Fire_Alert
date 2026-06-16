import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../features/home/presentation/providers/select_provider.dart';
import '../constants/sg_route.dart';
import '../theme/app_theme.dart';

class TermsAndConditionsPage extends ConsumerWidget {
  const TermsAndConditionsPage({
    super.key,
    this.navigateToProfileOnBack = true,
  });
  final bool navigateToProfileOnBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void goBackToProfile() {
      ref.read(selectedTabProvider.notifier).state = 2;
      context.go(SGRoute.home.route);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        backgroundColor: AppTheme.primaryRed,
        foregroundColor: AppTheme.textWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (navigateToProfileOnBack) {
              print(" Navigating to profile page...");
              goBackToProfile();
            } else {
              print(" Navigating to register page...");
              GoRouter.of(context).go(SGRoute.register.route);
            }
          },
        ),
      ),
      backgroundColor: AppTheme.backgroundWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header
            Text(
              'Terms and Conditions',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppTheme.primaryRed,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              'Last updated: ${DateTime.now().year}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary),
            ),

            const SizedBox(height: AppTheme.spacing24),

            // Introduction
            _buildSection(
              title: 'Acceptance of Terms',
              content:
                  'By downloading, installing, or using the Fire Alert App, you agree to be bound by these Terms and Conditions. If you do not agree to these terms, please do not use the app.',
              context: context,
            ),

            const SizedBox(height: AppTheme.spacing24),

            // Services
            _buildSection(
              title: 'Emergency Alert Services',
              content: '',
              context: context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildSubsection(
                    title: 'Service Description',
                    content:
                        'The Fire Alert App provides emergency fire alerts and notifications to help users stay informed about potential fire hazards in their area.',
                  ),
                  _buildSubsection(
                    title: 'Service Availability',
                    content:
                        'We strive to maintain high availability but cannot guarantee uninterrupted service. Emergency alert services may be affected by technical issues, network outages, or other factors beyond our control.',
                  ),
                  _buildSubsection(
                    title: 'Service Limitations',
                    content:
                        'These services are provided "as is" and we make no guarantees about the timeliness or accuracy of alerts. Always follow official emergency procedures.',
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppTheme.spacing24),

            // User Responsibilities
            _buildSection(
              title: 'User Responsibilities',
              content: '',
              context: context,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildResponsibilityItem(
                    'Accurate Information',
                    'Provide accurate and up-to-date contact information',
                  ),
                  _buildResponsibilityItem(
                    'App Updates',
                    'Keep the application updated to ensure optimal performance',
                  ),
                  _buildResponsibilityItem(
                    'Device Compatibility',
                    'Ensure your device can receive notifications and alerts',
                  ),
                  _buildResponsibilityItem(
                    'Emergency Protocols',
                    'Always follow official emergency response procedures',
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppTheme.spacing24),

            // SMS Notifications
            _buildSection(
              title: 'SMS Notifications',
              content:
                  'The app may send SMS messages for emergency alerts. Standard message rates may apply. You are responsible for any charges associated with receiving these messages. You can opt-out of SMS alerts at any time through the app settings.',
              context: context,
            ),

            const SizedBox(height: AppTheme.spacing24),

            // Privacy and Data
            _buildSection(
              title: 'Privacy and Data',
              content:
                  'Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your information. By using this app, you consent to our data practices as described in the Privacy Policy.',
              context: context,
            ),

            const SizedBox(height: AppTheme.spacing24),

            // Limitation of Liability
            _buildSection(
              title: 'Limitation of Liability',
              content:
                  'The Fire Alert App and its providers shall not be liable for any damages arising from the use or inability to use this service, including but not limited to direct, indirect, incidental, or consequential damages.',
              context: context,
            ),

            const SizedBox(height: AppTheme.spacing24),

            // Indemnification
            _buildSection(
              title: 'Indemnification',
              content:
                  'You agree to indemnify and hold harmless Fire Alert and its providers from any claims, damages, or expenses arising from your use of the service or violation of these terms.',
              context: context,
            ),

            const SizedBox(height: AppTheme.spacing24),

            // Termination
            _buildSection(
              title: 'Termination',
              content:
                  'We reserve the right to terminate or suspend access to our service immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.',
              context: context,
            ),

            const SizedBox(height: AppTheme.spacing24),

            // Modifications
            _buildSection(
              title: 'Modifications to Terms',
              content:
                  'We reserve the right to modify these terms at any time. Continued use of the app after changes constitutes acceptance of the modified terms. We will notify users of any significant changes through appropriate channels.',
              context: context,
            ),

            const SizedBox(height: AppTheme.spacing24),

            // Contact Information
            _buildSection(
              title: 'Contact Information',
              content:
                  'For questions about these Terms and Conditions, please contact us:\n\n'
                  'Email: support@firealert.com\n'
                  'Phone: +1-800-FIRE-HELP\n'
                  'Website: www.firealert.com',
              context: context,
            ),

            const SizedBox(height: AppTheme.spacing32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required BuildContext context,
    Widget? child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppTheme.spacing12),
        if (content.isNotEmpty)
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),
        if (child != null) child,
      ],
    );
  }

  Widget _buildSubsection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryRed,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          Padding(
            padding: const EdgeInsets.only(left: AppTheme.spacing20),
            child: Text(
              content,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponsibilityItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: AppTheme.primaryRed.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radius6),
            ),
            child: const Icon(
              Ionicons.shield_checkmark_outline,
              color: AppTheme.primaryRed,
              size: 16,
            ),
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing2),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
