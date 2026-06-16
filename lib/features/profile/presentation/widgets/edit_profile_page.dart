import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/constants/sg_route.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../authentication/presentation/widgets/custom_button.dart';

import '../../../home/presentation/providers/select_provider.dart';
import '../providers/profile_providers.dart';
import 'edit_profile_avatar.dart';
import 'edit_profile_form_field.dart';
import 'edit_profile_form_validator.dart';
import 'edit_profile_header.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _addressFocus = FocusNode();

  String? _nameError;
  String? _phoneError;
  String? _addressError;
  bool _isSubmitting = false;

  late final String _initialName;
  late final String _initialPhone;
  late final String _initialAddress;

  @override
  void initState() {
    super.initState();

    _nameFocus.addListener(_validateName);
    _phoneFocus.addListener(_validatePhone);
    _addressFocus.addListener(_validateAddress);

    // Add listeners for real-time error clearing
    _nameController.addListener(() {
      if (_nameError != null && _nameController.text.isNotEmpty) {
        setState(() => _nameError = null);
      }
    });
    _phoneController.addListener(() {
      if (_phoneError != null && _phoneController.text.isNotEmpty) {
        setState(() => _phoneError = null);
      }
    });
    _addressController.addListener(() {
      if (_addressError != null && _addressController.text.isNotEmpty) {
        setState(() => _addressError = null);
      }
    });

    _loadCurrentProfile();
  }

  Future<void> _loadCurrentProfile() async {
    final result = await ref.read(getProfileUsecaseProvider)();
    if (!mounted) return;

    result.when(
      success: (profile) {
        _nameController.text = profile.name;
        _phoneController.text = profile.phone.replaceFirst('+63', '');
        _addressController.text = profile.address;
      },
      failure: (_) {},
    );

    _initialName = _nameController.text;
    _initialPhone = _phoneController.text;
    _initialAddress = _addressController.text;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _nameFocus
      ..removeListener(_validateName)
      ..dispose();
    _phoneFocus
      ..removeListener(_validatePhone)
      ..dispose();
    _addressFocus
      ..removeListener(_validateAddress)
      ..dispose();
    super.dispose();
  }

  // ─── Validation ────────────────────────────────────────────────────────────

  void _validateName() {
    if (!_nameFocus.hasFocus && mounted) {
      setState(() => _nameError = null);
    }
  }

  void _validatePhone() {
    if (!_phoneFocus.hasFocus && mounted) {
      setState(() => _phoneError = null);
    }
  }

  void _validateAddress() {
    if (!_addressFocus.hasFocus && mounted) {
      setState(() => _addressError = null);
    }
  }

  // ─── Navigation ────────────────────────────────────────────────────────────

  /// Go back to HomeScreen at the Profile tab (index 2).
  void _goBackToProfile() {
    ref.read(selectedTabProvider.notifier).state = 2;
    context.go(SGRoute.home.route);
  }

  bool _hasChanges() =>
      _nameController.text.trim() != _initialName ||
      _phoneController.text.trim() != _initialPhone ||
      _addressController.text.trim() != _initialAddress;

  void _handleBackNavigation() {
    if (_hasChanges()) {
      _showUnsavedChangesDialog();
    } else {
      _goBackToProfile();
    }
  }

  // ─── Dialogs ───────────────────────────────────────────────────────────────

  void _showUnsavedChangesDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Unsaved Changes',
          style: context.responsiveBodyText(
            fontSizeSmall: 16,
            fontSizeMedium: 18,
            fontSizeLarge: 20,
            color: context.textPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'You have unsaved changes. What would you like to do?',
          style: context.responsiveBodyText(
            fontSizeSmall: 14,
            fontSizeMedium: 15,
            fontSizeLarge: 16,
            color: context.textSecondaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _handleSaveProfile();
            },
            child: Text(
              'Save',
              style: context.responsiveBodyText(
                fontSizeSmall: 14,
                fontSizeMedium: 15,
                fontSizeLarge: 16,
                color: context.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _resetChanges();
            },
            child: Text(
              "Don't Save",
              style: context.responsiveBodyText(
                fontSizeSmall: 14,
                fontSizeMedium: 15,
                fontSizeLarge: 16,
                color: context.errorColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancel',
              style: context.responsiveBodyText(
                fontSizeSmall: 14,
                fontSizeMedium: 15,
                fontSizeLarge: 16,
                color: context.textSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetChanges() {
    setState(() {
      _nameController.text = _initialName;
      _phoneController.text = _initialPhone;
      _addressController.text = _initialAddress;
      _nameError = null;
      _phoneError = null;
      _addressError = null;
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _goBackToProfile();
    });
  }

  void _handleSaveProfile() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: AppTheme.successGreen,
        ),
      );
      _goBackToProfile();
    });
  }

  // ─── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: EditProfileHeader(
        title: 'Edit Profile',
        onBackPressed: _handleBackNavigation,
      ),
      backgroundColor: context.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              context.responsiveValue(small: 16, medium: 20, large: 24),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),

                  Center(
                    child: EditProfileAvatar(
                      icon: Icons.person,
                      onImageSelected: (imagePath) =>
                          debugPrint('Selected image: $imagePath'),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  EditProfileFormField(
                    controller: _nameController,
                    focusNode: _nameFocus,
                    label: 'Full Name',
                    hintText: 'Enter your full name',
                    prefixIcon: Icons.person_outline,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                    ],
                    validator: (value) {
                      final error = EditProfileFormValidator.validateName(
                        value,
                      );
                      if (mounted) setState(() => _nameError = error);
                      return null;
                    },
                    errorText: _nameError,
                  ),

                  SizedBox(height: screenHeight * 0.025),

                  EditProfileFormField(
                    controller: _phoneController,
                    focusNode: _phoneFocus,
                    label: 'Mobile Number',
                    hintText: '912 345 6789',
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    validator: (value) {
                      final error = EditProfileFormValidator.validatePhone(
                        value,
                      );
                      if (mounted) setState(() => _phoneError = error);
                      return null;
                    },
                    errorText: _phoneError,
                    subtitle: 'For SMS alerts and verification',
                  ),

                  SizedBox(height: screenHeight * 0.025),

                  EditProfileFormField(
                    controller: _addressController,
                    focusNode: _addressFocus,
                    label: 'Address',
                    hintText: 'Complete home address',
                    prefixIcon: Icons.location_on_outlined,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                        RegExp(r'[\u{1F600}-\u{1FAFF}]', unicode: true),
                      ),
                    ],
                    validator: (value) {
                      final error = EditProfileFormValidator.validateAddress(
                        value,
                      );
                      if (mounted) setState(() => _addressError = error);
                      return null;
                    },
                    errorText: _addressError,
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  CustomButton(
                    text: 'Save Changes',
                    onPressed: _handleSaveProfile,
                    icon: Icons.save,
                    isLoading: _isSubmitting,
                  ),

                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
