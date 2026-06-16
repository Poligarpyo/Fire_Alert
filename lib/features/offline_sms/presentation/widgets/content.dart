import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/auth_local_datasource_provider.dart';
import '../../../../core/value_objects/phone_number.dart';
import '../../../../shared/constants/app_colors.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_text_area_field.dart';
import '../../../../shared/widgets/custom_text_form_field.dart';
import '../../../authentication/presentation/controllers/auth/auth_controller.dart';
import '../controllers/offline_sms/notifier.dart';

class Content extends ConsumerStatefulWidget {
  const Content({super.key});

  @override
  ConsumerState<Content> createState() => _ContentState();
}

class _ContentState extends ConsumerState<Content> {
  final _formKey = GlobalKey<FormState>();
  final _phoneFocusNode = FocusNode();
  final _messageFocusNode = FocusNode();

  String? _phoneError;
  String? _messageError;

  // Whether the logged-in user already has a saved phone number.
  // Resolved once in initState — safe to cache.
  late final bool _showPhoneField;

  @override
  void initState() {
    super.initState();

    final phone = ref.read(authLocalDataSourceProvider).getPhone();
    _showPhoneField = phone == null || phone.isEmpty;

    // Auto-populate notifier with the saved phone so the SMS always has a
    // sender number even when the field is hidden from the UI.
    if (!_showPhoneField && phone != null) {
      // Schedule after the first frame so we're not writing state during build.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ref.read(offlineSmsNotifierProvider.notifier).updatePhone(phone);
        }
      });
    }

    _phoneFocusNode.addListener(_clearPhoneErrorOnFocus);
    _messageFocusNode.addListener(_clearMessageErrorOnFocus);
  }

  @override
  void dispose() {
    _phoneFocusNode.removeListener(_clearPhoneErrorOnFocus);
    _messageFocusNode.removeListener(_clearMessageErrorOnFocus);
    _phoneFocusNode.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  // Clear inline error when the user taps back into the field.
  void _clearPhoneErrorOnFocus() {
    if (_phoneFocusNode.hasFocus && _phoneError != null && mounted) {
      setState(() => _phoneError = null);
    }
  }

  void _clearMessageErrorOnFocus() {
    if (_messageFocusNode.hasFocus && _messageError != null && mounted) {
      setState(() => _messageError = null);
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ref.read(offlineSmsNotifierProvider.notifier).handleEmergency();
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(offlineSmsNotifierProvider.notifier);

    // Watch only the slices we need — avoids full rebuilds.
    ref.watch(authControllerProvider);
    final isLoading = ref.watch(
      offlineSmsNotifierProvider.select((s) => s.isLoading),
    );
    final messageLength = ref.watch(
      offlineSmsNotifierProvider.select((s) => s.message.length),
    );
    final maxCharacters = ref.watch(
      offlineSmsNotifierProvider.select((s) => s.maxCharacters),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Offline mode warning ─────────────────────────────────────────────
        _OfflineBanner(),

        const SizedBox(height: 20),

        // ── Form ─────────────────────────────────────────────────────────────
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_showPhoneField) ...[
                _FieldLabel(label: 'Your phone number', required: true),
                const SizedBox(height: 6),
                _ErrorBorder(
                  hasError: _phoneError != null,
                  child: CustomTextFormField(
                    onChanged: (value) {
                      notifier.updatePhone(value);
                      // Clear error when user starts typing
                      if (_phoneError != null && value.isNotEmpty) {
                        setState(() => _phoneError = null);
                      }
                    },
                    hintText: '912 345 6789',
                    prefixIcon: Icons.phone_outlined,

                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    validator: (value) {
                      final trimmed = value?.trim() ?? '';
                      if (trimmed.isEmpty) {
                        _setError(
                          () => _phoneError = 'Phone number is required',
                        );
                        return 'Phone number is required';
                      }
                      try {
                        PhoneNumber.parse(trimmed);
                        _setError(() => _phoneError = null);
                        return null;
                      } catch (_) {
                        _setError(
                          () => _phoneError = 'Invalid PH mobile number',
                        );
                        return 'Invalid PH mobile number';
                      }
                    },
                  ),
                ),
                _InlineError(message: _phoneError),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),

        const SizedBox(height: 8),

        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Message to BFP',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              TextSpan(
                text: ' *',
                style: context
                    .responsiveH3(
                      fontSizeSmall: 12,
                      fontSizeMedium: 14,
                      fontSizeLarge: 16,
                    )
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _messageError != null ? Colors.red : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomTextAreaField(
            onChanged: (value) {
              notifier.updateMessage(value);
              // Clear error when user starts typing
              if (_messageError != null && value.isNotEmpty) {
                setState(() => _messageError = null);
              }
            },
            maxLines: 5,
            maxLength: maxCharacters,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp('[a-zA-Z0-9\\s\\-#/,\\.\\&]'),
              ),
            ],
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                if (mounted) {
                  setState(() => _messageError = "Message cannot be empty");
                }
                return "Message cannot be empty";
              }
              if (mounted) {
                setState(() => _messageError = null);
              }
              return null;
            },
            hintText: 'FIRE EMERGENCY: Describe the fire situation...',
          ),
        ),
        if (_messageError != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _messageError!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),

        const SizedBox(height: 24),

        // ── Action buttons ───────────────────────────────────────────────────
        Row(
          children: [
            SizedBox(
              width: 90,
              child: OutlinedButton(
                onPressed: notifier.cancel,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.borderColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF90A4AE),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFFB0BEC5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send, size: 16, color: Colors.white),
                          SizedBox(width: 6),
                          Text(
                            'Send SMS Report',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Center(
          child: const Text(
            'SMS reports are processed immediately by BFP emergency system.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
          ),
        ),
      ],
    );
  }

  // Safely calls setState only when mounted — avoids calling during dispose.
  void _setError(VoidCallback fn) {
    if (mounted) setState(fn);
  }
}

// ─── Local sub-widgets ────────────────────────────────────────────────────────

class _OfflineBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFB74D)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Color(0xFFFF8F00), size: 22),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Offline Mode Active',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE65100),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Your report will be sent via SMS to BFP Emergency Hotline.',
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, this.required = false});
  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(fontSize: 15, color: Colors.black),
          ),
          if (required)
            const TextSpan(
              text: ' *',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}

/// Wraps a field in a red border when [hasError] is true.
class _ErrorBorder extends StatelessWidget {
  const _ErrorBorder({required this.hasError, required this.child});
  final bool hasError;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: hasError ? Colors.red : Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

class _InlineError extends StatelessWidget {
  const _InlineError({required this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        message!,
        style: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }
}
