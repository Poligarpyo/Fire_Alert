import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({super.key, required this.message, required this.context});
  final String message;
  final BuildContext context;

  @override
  Widget build(BuildContext ctx) => Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Text(
      message,
      style: context.responsiveBodyText(
        fontSizeSmall: 10,
        fontSizeMedium: 11,
        fontSizeLarge: 12,
        color: context.errorColor,
      ),
    ),
  );
}
