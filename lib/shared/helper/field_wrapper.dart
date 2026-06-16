import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FieldWrapper extends StatelessWidget {
  const FieldWrapper({super.key, required this.hasError, required this.child});
  final bool hasError;
  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      border: Border.all(
        color: hasError ? context.errorColor : Colors.transparent,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: child,
  );
}
