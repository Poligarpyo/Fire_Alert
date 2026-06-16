import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../shared/constants/sg_route.dart';
import '../../../../../shared/theme/app_theme.dart';
import '../../../../../utils/context_extensions.dart';
import '../../controllers/register/phone_auth_controller.dart';
import '../../controllers/register/register_form_notifier.dart';
import '../custom_button.dart';
import 'register_form_fields.dart';
import 'register_terms_row.dart';

class RegisterFormCard extends HookConsumerWidget {
  const RegisterFormCard({super.key, required this.screenHeight});
  final double screenHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(registerFormProvider);
    final notifier = ref.read(registerFormProvider.notifier);

    // Text controllers — kept local, synced via onChanged
    final nameController = useTextEditingController(text: formState.name);
    final phoneController = useTextEditingController(text: formState.phone);
    final addressController = useTextEditingController(text: formState.address);
    final passwordController = useTextEditingController(
      text: formState.password,
    );
    final confirmPasswordController = useTextEditingController(
      text: formState.confirmPassword,
    );
    // 👇 Sync controller text → notifier on every change
    useEffect(() {
      nameController.addListener(() => notifier.setName(nameController.text));
      phoneController.addListener(
        () => notifier.setPhone(phoneController.text),
      );
      addressController.addListener(
        () => notifier.setAddress(addressController.text),
      );
      passwordController.addListener(
        () => notifier.setPassword(passwordController.text),
      );
      confirmPasswordController.addListener(
        () => notifier.setConfirmPassword(confirmPasswordController.text),
      );
      return null;
    }, []);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(small: 16, medium: 20, large: 24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(
          context.responsiveValue(small: 16, medium: 20, large: 24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header row ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Create Account',
                    style: context
                        .responsiveH3(
                          fontSizeSmall: 18,
                          fontSizeMedium: 20,
                          fontSizeLarge: 22,
                        )
                        .copyWith(color: context.textPrimaryColor),
                  ),
                ),
                if (context.isSmallScreen)
                  IconButton(
                    onPressed: () => context.go(SGRoute.login.route),
                    icon: Icon(
                      Icons.arrow_back,
                      size: context.responsiveIconSize(
                        small: 16,
                        medium: 18,
                        large: 20,
                      ),
                      color: context.errorColor,
                    ),
                    tooltip: 'Back to Login',
                  )
                else
                  TextButton.icon(
                    onPressed: () => context.go(SGRoute.login.route),
                    icon: Icon(
                      Icons.arrow_back,
                      size: context.responsiveIconSize(
                        small: 14,
                        medium: 16,
                        large: 18,
                      ),
                      color: context.errorColor,
                    ),
                    label: Text(
                      'Back to Login',
                      style: context.responsiveButtonText(
                        fontSizeSmall: 10,
                        fontSizeMedium: 12,
                        fontSizeLarge: 14,
                        color: context.errorColor,
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: screenHeight * 0.025),

            RegisterFormFields(
              screenHeight: screenHeight,
              nameController: nameController,
              phoneController: phoneController,
              addressController: addressController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              nameError: formState.nameError,
              phoneError: formState.phoneError,
              addressError: formState.addressError,
              passwordError: formState.passwordError,
              confirmPasswordError: formState.confirmPasswordError,
              obscurePassword: formState.obscurePassword,
              obscureConfirmPassword: formState.obscureConfirmPassword,
              onTogglePassword: notifier.toggleObscurePassword,
              onToggleConfirmPassword: notifier.toggleObscureConfirmPassword,
              onNameChanged: notifier.setName,
              onPhoneChanged: notifier.setPhone,
              onAddressChanged: notifier.setAddress,
              onPasswordChanged: notifier.setPassword,
              onConfirmPasswordChanged: notifier.setConfirmPassword,
            ),

            SizedBox(height: screenHeight * 0.03),

            RegisterTermsRow(
              acceptedTerms: formState.acceptedTerms,
              onChanged: notifier.setAcceptedTerms,
            ),

            SizedBox(height: screenHeight * 0.03),

            CustomButton(
              text: 'Create Account',
              onPressed: formState.acceptedTerms
                  ? () => _handleCreateAccount(ref)
                  : null,
              icon: Icons.person_add,
              isLoading: formState.isSubmitting,
            ),

            SizedBox(height: screenHeight * 0.02),

            Center(
              child: Text(
                'By creating an account, you agree to receive emergency alerts via SMS',
                style: context.responsiveBodyText(
                  fontSizeSmall: 9,
                  fontSizeMedium: 10,
                  fontSizeLarge: 12,
                  color: context.textTertiaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
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
}
