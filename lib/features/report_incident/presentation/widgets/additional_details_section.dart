import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/report_incident/notifier.dart';
import 'shimmer/shimmer_loading_widget.dart';
import '../../../../shared/theme/app_theme.dart';

class AdditionalDetailsSection extends ConsumerStatefulWidget {
  const AdditionalDetailsSection({super.key});

  @override
  ConsumerState<AdditionalDetailsSection> createState() =>
      _AdditionalDetailsSectionState();
}

class _AdditionalDetailsSectionState
    extends ConsumerState<AdditionalDetailsSection> {
  final TextEditingController _additionalDetailsController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    // Sync controller when state resets
    _additionalDetailsController.addListener(() {
      // no-op, just keeping controller alive
    });
  }

  @override
  void dispose() {
    _additionalDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reportState = ref.watch(reportIncidentNotifierProvider);
    // 👇 Sync controller when state's details is cleared externally
    ref.listen(reportIncidentNotifierProvider.select((s) => s.details), (
      previous,
      next,
    ) {
      if (next.isEmpty && _additionalDetailsController.text.isNotEmpty) {
        _additionalDetailsController.clear();
      }
    });

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
        child: reportState.isLoading
            ? _buildShimmerLoading(context)
            : _buildContent(context),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerTextWidget(
          width: context.responsiveValue(small: 140, medium: 160, large: 200),
          height: context.responsiveValue(small: 14, medium: 16, large: 18),
        ),
        SizedBox(
          height: context.responsiveValue(small: 12, medium: 16, large: 20),
        ),
        ShimmerLoadingWidget(
          width: double.infinity,
          height: context.responsiveValue(small: 72, medium: 88, large: 100),
          borderRadius: BorderRadius.all(
            Radius.circular(
              context.responsiveValue(small: 6, medium: 8, large: 10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Additional Details',
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
        TextField(
          controller: _additionalDetailsController,
          maxLines: context
              .responsiveValue(small: 3, medium: 4, large: 5)
              .toInt(),
          style: context.responsiveBodyText(
            fontSizeSmall: 12,
            fontSizeMedium: 14,
            fontSizeLarge: 16,
            color: context.textPrimaryColor,
          ),
          onChanged: (value) {
            ref.read(reportIncidentNotifierProvider.notifier).setDetails(value);
            // Clear error when user starts typing
            final state = ref.read(reportIncidentNotifierProvider);
            if (state.errorMessage != null && value.isNotEmpty) {
              ref.read(reportIncidentNotifierProvider.notifier).clearError();
            }
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp('[a-zA-Z0-9\\s\\-#/,\\.\\&]'),
            ),
            LengthLimitingTextInputFormatter(500),
          ],
          decoration: InputDecoration(
            hintText:
                'Describe the situation, number of people affected, accessibility issues...',
            hintStyle: context.responsiveBodyText(
              fontSizeSmall: 11,
              fontSizeMedium: 12,
              fontSizeLarge: 13,
              color: context.textTertiaryColor,
            ),
            contentPadding: EdgeInsets.all(
              context.responsiveValue(small: 12, medium: 16, large: 20),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                context.responsiveValue(small: 6, medium: 8, large: 10),
              ),
              borderSide: BorderSide(color: AppTheme.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                context.responsiveValue(small: 6, medium: 8, large: 10),
              ),
              borderSide: BorderSide(color: AppTheme.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                context.responsiveValue(small: 6, medium: 8, large: 10),
              ),
              borderSide: BorderSide(color: AppTheme.primaryRed),
            ),
          ),
        ),
      ],
    );
  }
}
