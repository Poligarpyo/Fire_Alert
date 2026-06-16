import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/report_incident/notifier.dart';
import 'shimmer/shimmer_loading_widget.dart';
import '../../../../shared/theme/app_theme.dart';

class CapturePhotoSection extends ConsumerStatefulWidget {
  const CapturePhotoSection({super.key});

  @override
  ConsumerState<CapturePhotoSection> createState() =>
      _CapturePhotoSectionState();
}

class _CapturePhotoSectionState extends ConsumerState<CapturePhotoSection> {
  String? _capturedImagePath;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reportIncidentNotifierProvider);
    final notifier = ref.read(reportIncidentNotifierProvider.notifier);

    _capturedImagePath = state.selectedImage?.path;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(small: 8, medium: 12, large: 16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(
          context.responsiveValue(small: 12, medium: 16, large: 20),
        ),
        child: state.isLoading
            ? _buildShimmerLoading(context)
            : _buildContent(context, state, notifier),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerTextWidget(
          width: context.responsiveValue(small: 130, medium: 150, large: 180),
          height: context.responsiveValue(small: 14, medium: 16, large: 18),
        ),
        SizedBox(
          height: context.responsiveValue(small: 12, medium: 16, large: 20),
        ),
        ShimmerLoadingWidget(
          width: double.infinity,
          height: context.responsiveValue(small: 130, medium: 170, large: 200),
          borderRadius: BorderRadius.all(
            Radius.circular(
              context.responsiveValue(small: 6, medium: 8, large: 10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, state, notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Capture Photo Evidence',
                style: context
                    .responsiveH3(
                      fontSizeSmall: 12,
                      fontSizeMedium: 14,
                      fontSizeLarge: 16,
                    )
                    .copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.textPrimaryColor,
                    ),
              ),
              TextSpan(
                text: ' *',
                style: context
                    .responsiveH3(
                      fontSizeSmall: 12,
                      fontSizeMedium: 14,
                      fontSizeLarge: 16,
                    )
                    .copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.errorRed,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: context.responsiveValue(small: 12, medium: 16, large: 20),
        ),

        GestureDetector(
          onTap: () {
            notifier.pickImage();
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: context.responsiveValue(
                small: 10,
                medium: 12,
                large: 16,
              ),
            ),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(
                context.responsiveValue(small: 6, medium: 8, large: 10),
              ),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: _capturedImagePath != null
                ? Column(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            _showImageViewer(context, _capturedImagePath!),
                        child: Container(
                          height: context.responsiveValue(
                            small: 100,
                            medium: 130,
                            large: 150,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: context.responsiveValue(
                              small: 8,
                              medium: 12,
                              large: 16,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              context.responsiveValue(
                                small: 6,
                                medium: 8,
                                large: 10,
                              ),
                            ),
                            image: DecorationImage(
                              image: FileImage(File(_capturedImagePath!)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.responsiveValue(
                          small: 8,
                          medium: 12,
                          large: 16,
                        ),
                      ),
                      Text(
                        'Photo captured - Tap image to view',
                        style: context
                            .responsiveBodyText(
                              fontSizeSmall: 10,
                              fontSizeMedium: 12,
                              fontSizeLarge: 14,
                            )
                            .copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppTheme.successGreen,
                            ),
                      ),
                      SizedBox(
                        height: context.responsiveValue(
                          small: 8,
                          medium: 12,
                          large: 16,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => notifier.pickImage(),
                        icon: Icon(
                          Icons.refresh,
                          color: AppTheme.textWhite,
                          size: context.responsiveIconSize(
                            small: 14,
                            medium: 16,
                            large: 18,
                          ),
                        ),
                        label: Text(
                          'Retake Photo',
                          style: context.responsiveBodyText(
                            fontSizeSmall: 10,
                            fontSizeMedium: 12,
                            fontSizeLarge: 14,
                            color: AppTheme.textWhite,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryRed,
                          foregroundColor: AppTheme.textWhite,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: context.responsiveValue(
                              small: 12,
                              medium: 16,
                              large: 20,
                            ),
                            vertical: context.responsiveValue(
                              small: 8,
                              medium: 10,
                              large: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(
                          context.responsiveValue(
                            small: 10,
                            medium: 12,
                            large: 16,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: context.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: AppTheme.textWhite,
                          size: context.responsiveIconSize(
                            small: 20,
                            medium: 24,
                            large: 28,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: context.responsiveValue(
                          small: 12,
                          medium: 16,
                          large: 20,
                        ),
                      ),
                      Text(
                        'Tap to Open Camera',
                        style: context
                            .responsiveBodyText(
                              fontSizeSmall: 12,
                              fontSizeMedium: 14,
                              fontSizeLarge: 16,
                              color: context.textPrimaryColor,
                            )
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: context.responsiveValue(
                          small: 6,
                          medium: 8,
                          large: 10,
                        ),
                      ),
                      Text(
                        'Take a picture of the fire incident',
                        style: context.responsiveBodyText(
                          fontSizeSmall: 9,
                          fontSizeMedium: 10,
                          fontSizeLarge: 12,
                          color: context.textSecondaryColor,
                        ),
                      ),
                      SizedBox(
                        height: context.responsiveValue(
                          small: 6,
                          medium: 8,
                          large: 10,
                        ),
                      ),
                      Text(
                        '* Camera access required. Photo will include location metadata',
                        style: context.responsiveBodyText(
                          fontSizeSmall: 7,
                          fontSizeMedium: 8,
                          fontSizeLarge: 9,
                          color: context.textTertiaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  void _showImageViewer(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(
          context.responsiveValue(small: 16, medium: 24, large: 32),
        ),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(color: Colors.black.withOpacity(0.9)),
            ),
            Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Container(
                  margin: EdgeInsets.all(
                    context.responsiveValue(small: 20, medium: 30, large: 40),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      context.responsiveValue(small: 8, medium: 12, large: 16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      context.responsiveValue(small: 8, medium: 12, large: 16),
                    ),
                    child: Image.file(File(imagePath), fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
            Positioned(
              top: context.responsiveValue(small: 40, medium: 50, large: 60),
              right: context.responsiveValue(small: 20, medium: 30, large: 40),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(
                    context.responsiveValue(small: 8, medium: 10, large: 12),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: context.responsiveIconSize(
                      small: 20,
                      medium: 24,
                      large: 28,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
