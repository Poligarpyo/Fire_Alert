// ── Private helpers ────────────────────────────────────────────────────────── 
import 'package:flutter/material.dart'; 
import '../theme/app_theme.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel({super.key, required this.label, required this.context});
  final String label;
  final BuildContext context;

  @override
  Widget build(BuildContext context) => Text(
    label,
    style: context.responsiveBodyText(
      fontSizeSmall: 10,
      fontSizeMedium: 12,
      fontSizeLarge: 14,
      color: context.textSecondaryColor,
    ),
  );
}
