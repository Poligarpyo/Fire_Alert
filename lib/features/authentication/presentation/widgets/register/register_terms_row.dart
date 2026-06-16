import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../shared/constants/sg_route.dart';
import '../../../../../shared/theme/app_theme.dart';
 

class RegisterTermsRow extends StatelessWidget {
  const RegisterTermsRow({
    super.key,
    required this.acceptedTerms,
    required this.onChanged,
  });

  final bool acceptedTerms;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          scale: context.responsiveValue(small: 0.8, medium: 0.9, large: 1.0),
          child: Checkbox(
            value: acceptedTerms,
            onChanged: (value) => onChanged(value ?? false),
            activeColor: context.primaryColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!acceptedTerms),
            child: RichText(
              text: TextSpan(
                style: context.responsiveBodyText(
                  fontSizeSmall: 9,
                  fontSizeMedium: 10,
                  fontSizeLarge: 12,
                  color: acceptedTerms
                      ? context.textPrimaryColor
                      : context.textTertiaryColor,
                ),
                children: [
                  const TextSpan(text: 'I agree to the '),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () => context.go(
                        SGRoute.termsAndConditions.route,
                        extra: false,
                      ),
                      child: Text(
                        'Terms and Conditions',
                        style: context.responsiveBodyText(
                          fontSizeSmall: 9,
                          fontSizeMedium: 10,
                          fontSizeLarge: 12,
                          color: context.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const TextSpan(text: ' and '),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () => context.go(
                        SGRoute.privacyPolicy.route,
                        extra: false,
                      ),
                      child: Text(
                        'Privacy Policy',
                        style: context.responsiveBodyText(
                          fontSizeSmall: 9,
                          fontSizeMedium: 10,
                          fontSizeLarge: 12,
                          color: context.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}