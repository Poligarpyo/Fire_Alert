import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/sg_route.dart';
import '../theme/app_theme.dart';
 

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Redirect to the new TermsAndConditionsPage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go(SGRoute.offlineSMS.route);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
          style: context.responsiveH1(
            fontSizeSmall: 18,
            fontSizeMedium: 20,
            fontSizeLarge: 22,
          ),
        ),
        backgroundColor: context.primaryColor,
        foregroundColor: context.textWhiteColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          context.responsiveValue(small: 16, medium: 20, large: 24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Fire Alert App - Terms and Conditions',
              style: context
                  .responsiveH1(
                    fontSizeSmall: 16,
                    fontSizeMedium: 18,
                    fontSizeLarge: 20,
                  )
                  .copyWith(color: context.primaryColor),
            ),
            SizedBox(
              height: context.responsiveValue(small: 16, medium: 20, large: 24),
            ),

            _buildSection(
              context,
              '1. Acceptance of Terms',
              'By downloading, installing, or using the Fire Alert App, you agree to be bound by these Terms and Conditions. If you do not agree to these terms, please do not use the app.',
            ),

            _buildSection(
              context,
              '2. Emergency Alert Services',
              'The Fire Alert App provides emergency fire alerts and notifications. These services are provided "as is" and we make no guarantees about the timeliness or accuracy of alerts. Always follow official emergency procedures.',
            ),

            _buildSection(
              context,
              '3. User Responsibilities',
              'You are responsible for:\n'
                  '- Providing accurate contact information\n'
                  '- Keeping your app updated\n'
                  '- Ensuring your device can receive notifications\n'
                  '- Following official emergency protocols',
            ),

            _buildSection(
              context,
              '4. Privacy and Data',
              'Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your information. By using this app, you consent to our data practices as described in the Privacy Policy.',
            ),

            _buildSection(
              context,
              '5. SMS Notifications',
              'The app may send SMS messages for emergency alerts. Standard message rates may apply. You are responsible for any charges associated with receiving these messages.',
            ),

            _buildSection(
              context,
              '6. Limitation of Liability',
              'The Fire Alert App and its providers shall not be liable for any damages arising from the use or inability to use this service, including but not limited to direct, indirect, incidental, or consequential damages.',
            ),

            _buildSection(
              context,
              '7. Service Availability',
              'We strive to maintain high availability but cannot guarantee uninterrupted service. Emergency alert services may be affected by technical issues, network outages, or other factors beyond our control.',
            ),

            _buildSection(
              context,
              '8. Modifications',
              'We reserve the right to modify these terms at any time. Continued use of the app after changes constitutes acceptance of the modified terms.',
            ),

            _buildSection(
              context,
              '9. Contact Information',
              'For questions about these Terms and Conditions, please contact our support team.',
            ),

            SizedBox(
              height: context.responsiveValue(small: 32, medium: 40, large: 48),
            ),

            Text(
              'Last Updated: ${DateTime.now().year}',
              style: context.responsiveBodyText(
                fontSizeSmall: 10,
                fontSizeMedium: 11,
                fontSizeLarge: 12,
                color: context.textTertiaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: context
              .responsiveH2(
                fontSizeSmall: 14,
                fontSizeMedium: 16,
                fontSizeLarge: 18,
              )
              .copyWith(color: context.textPrimaryColor),
        ),
        SizedBox(
          height: context.responsiveValue(small: 8, medium: 10, large: 12),
        ),
        Text(
          content,
          style: context.responsiveBodyText(
            fontSizeSmall: 12,
            fontSizeMedium: 14,
            fontSizeLarge: 16,
            color: context.textSecondaryColor,
          ),
        ),
        SizedBox(
          height: context.responsiveValue(small: 16, medium: 20, large: 24),
        ),
      ],
    );
  }
}
