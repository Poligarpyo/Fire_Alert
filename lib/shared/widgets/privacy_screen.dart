// import 'package:flutter/material.dart';
// import '../../../../shared/theme/app_theme.dart';

// class PrivacyScreen extends StatelessWidget {
//   const PrivacyScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Privacy Policy',
//           style: context.responsiveH1(
//             fontSizeSmall: 18,
//             fontSizeMedium: 20,
//             fontSizeLarge: 22,
//           ),
//         ),
//         backgroundColor: context.primaryColor,
//         foregroundColor: context.textWhiteColor,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(
//           context.responsiveValue(small: 16, medium: 20, large: 24),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Fire Alert App - Privacy Policy',
//               style: context
//                   .responsiveH1(
//                     fontSizeSmall: 16,
//                     fontSizeMedium: 18,
//                     fontSizeLarge: 20,
//                   )
//                   .copyWith(color: context.primaryColor),
//             ),
//             SizedBox(
//               height: context.responsiveValue(small: 16, medium: 20, large: 24),
//             ),

//             _buildSection(
//               context,
//               '1. Information We Collect',
//               'We collect the following information to provide emergency alert services:\n\n'
//                   '**Personal Information:**\n'
//                   '- Name and contact details\n'
//                   '- Phone number for SMS alerts\n'
//                   '- Email address (optional)\n\n'
//                   '**Location Information:**\n'
//                   '- Your current location (with your permission)\n'
//                   '- Areas you want to monitor for alerts\n\n'
//                   '**Device Information:**\n'
//                   '- Device type and operating system\n'
//                   '- App version and usage statistics',
//             ),

//             _buildSection(
//               context,
//               '2. How We Use Your Information',
//               'We use your information to:\n'
//                   '- Send emergency fire alerts\n'
//                   '- Provide location-based notifications\n'
//                   '- Improve our services\n'
//                   '- Ensure app functionality\n'
//                   '- Communicate important updates',
//             ),

//             _buildSection(
//               context,
//               '3. Information Sharing',
//               'We do not sell, rent, or trade your personal information. We may share information only:\n'
//                   '- With emergency services when required\n'
//                   '- To comply with legal obligations\n'
//                   '- With service providers who assist in app operations\n'
//                   '- To protect rights, property, or safety',
//             ),

//             _buildSection(
//               context,
//               '4. Data Security',
//               'We implement appropriate security measures to protect your information:\n'
//                   '- Secure data transmission\n'
//                   '- Encrypted storage where applicable\n'
//                   '- Regular security updates\n'
//                   '- Access controls and authentication',
//             ),

//             _buildSection(
//               context,
//               '5. SMS and Notifications',
//               'The app sends SMS messages for emergency alerts. Standard message rates may apply. You can:\n'
//                   '- Opt-in to receive SMS alerts\n'
//                   '- Manage notification preferences\n'
//                   '- Disable alerts at any time',
//             ),

//             _buildSection(
//               context,
//               '6. Location Services',
//               'Location services are used to:\n'
//                   '- Provide relevant local alerts\n'
//                   '- Improve response times\n'
//                   '- Offer location-based features\n\n'
//                   'Location data is only used with your explicit consent and can be disabled in app settings.',
//             ),

//             _buildSection(
//               context,
//               '7. Data Retention',
//               'We retain your information only as long as necessary to:\n'
//                   '- Provide emergency alert services\n'
//                   '- Comply with legal requirements\n'
//                   '- Resolve disputes\n'
//                   '- Enforce our agreements',
//             ),

//             _buildSection(
//               context,
//               '8. Your Rights',
//               'You have the right to:\n'
//                   '- Access your personal information\n'
//                   '- Correct inaccurate data\n'
//                   '- Delete your account and data\n'
//                   '- Opt-out of non-essential communications\n'
//                   '- Control location sharing preferences',
//             ),

//             _buildSection(
//               context,
//               '9. Children\'s Privacy',
//               'Our services are not intended for children under 13. We do not knowingly collect personal information from children under 13.',
//             ),

//             _buildSection(
//               context,
//               '10. Changes to This Policy',
//               'We may update this privacy policy from time to time. We will notify you of any changes by posting the new policy on this page and updating the "Last Updated" date.',
//             ),

//             _buildSection(
//               context,
//               '11. Contact Us',
//               'If you have questions about this Privacy Policy, please contact our privacy team.',
//             ),

//             SizedBox(
//               height: context.responsiveValue(small: 32, medium: 40, large: 48),
//             ),

//             Text(
//               'Last Updated: ${DateTime.now().year}',
//               style: context.responsiveBodyText(
//                 fontSizeSmall: 10,
//                 fontSizeMedium: 11,
//                 fontSizeLarge: 12,
//                 color: context.textTertiaryColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSection(BuildContext context, String title, String content) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: context
//               .responsiveH2(
//                 fontSizeSmall: 14,
//                 fontSizeMedium: 16,
//                 fontSizeLarge: 18,
//               )
//               .copyWith(color: context.textPrimaryColor),
//         ),
//         SizedBox(
//           height: context.responsiveValue(small: 8, medium: 10, large: 12),
//         ),
//         Text(
//           content,
//           style: context.responsiveBodyText(
//             fontSizeSmall: 12,
//             fontSizeMedium: 14,
//             fontSizeLarge: 16,
//             color: context.textSecondaryColor,
//           ),
//         ),
//         SizedBox(
//           height: context.responsiveValue(small: 16, medium: 20, large: 24),
//         ),
//       ],
//     );
//   }
// }
