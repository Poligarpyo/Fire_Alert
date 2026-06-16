import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../data/constants/emergency_categories_data.dart';
import '../controllers/report_incident/notifier.dart';
import '../controllers/report_incident/state.dart';
import 'emergency_category_ui.dart';
import 'severity_section.dart';
import 'shimmer/shimmer_loading_widget.dart';

class IncidentTypeSection extends ConsumerStatefulWidget {
  const IncidentTypeSection({super.key});

  @override
  ConsumerState<IncidentTypeSection> createState() =>
      _IncidentTypeSectionState();
}

class _IncidentTypeSectionState extends ConsumerState<IncidentTypeSection> {
  late final List<EmergencyCategoryUI> _categories = EmergencyCategoriesData.all
      .map(EmergencyCategoryUIMapper.from)
      .toList();

  void _onCategorySelected(String category) {
    ref.read(reportIncidentNotifierProvider.notifier).selectCategory(category);
  }

  void _setIncidentType(String type) {
    ref.read(reportIncidentNotifierProvider.notifier).setIncidentType(type);
    // Auto-set recommended severity based on incident type
    // final recommendedSeverity =
    //     SeverityMapper.getRecommendedSeverityForIncident(type);
    // ref
    //     .read(reportIncidentNotifierProvider.notifier)
    //     .setSeverity(recommendedSeverity);
  }

  @override
  Widget build(BuildContext context) {
    final ReportIncidentState reportState = ref.watch(
      reportIncidentNotifierProvider,
    );
    final selectedType = reportState.incidentType;
    final isLoading = reportState.isLoading;
    final selectedCategory = reportState.selectedCategory;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(small: 8, medium: 12, large: 16),
        ),
        boxShadow: <BoxShadow>[
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: 'Emergency Type',
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

            Text(
              'Select by category:',
              style: context
                  .responsiveBodyText(
                    fontSizeSmall: 10,
                    fontSizeMedium: 12,
                    fontSizeLarge: 14,
                    color: context.textSecondaryColor,
                  )
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: context.responsiveValue(small: 8, medium: 12, large: 16),
            ),

            isLoading
                ? _buildShimmerLoading()
                : _buildCategoryGrid(selectedType, ref, selectedCategory),

            if (selectedCategory != null && !isLoading) ...[
              SizedBox(
                height: context.responsiveValue(
                  small: 12,
                  medium: 16,
                  large: 20,
                ),
              ),
              _buildSpecificTypes(selectedType, ref, selectedCategory),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: context.responsiveValue(small: 6, medium: 8, large: 10),
      mainAxisSpacing: context.responsiveValue(small: 6, medium: 8, large: 10),
      childAspectRatio: context.responsiveValue(
        small: 2.2,
        medium: 1.8,
        large: 1.6,
      ),
      children: List.generate(
        4,
        (index) => const ShimmerLoadingWidget(
          width: double.infinity,
          height: double.infinity,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildCategoryGrid(
    String selectedType,
    WidgetRef ref,
    String? selectedCategory,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: context.responsiveValue(
            small: 8,
            medium: 10,
            large: 12,
          ),
          mainAxisSpacing: context.responsiveValue(
            small: 8,
            medium: 10,
            large: 12,
          ),
          childAspectRatio: context.responsiveValue(
            small: 2.0,
            medium: 1.8,
            large: 1.6,
          ),
          children: _categories.map((category) {
            final isSelected = selectedCategory == category.name;

            return GestureDetector(
              onTap: () => _onCategorySelected(category.name),
              child: Container(
                padding: EdgeInsets.all(
                  context.responsiveValue(small: 6, medium: 8, large: 10),
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? category.color.withOpacity(0.1)
                      : AppTheme.backgroundGrey,
                  borderRadius: BorderRadius.circular(
                    context.responsiveValue(small: 6, medium: 8, large: 10),
                  ),
                  border: Border.all(
                    color: isSelected ? category.color : AppTheme.borderMedium,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      category.icon,
                      size: context.responsiveIconSize(
                        small: 16,
                        medium: 18,
                        large: 20,
                      ),
                      color: isSelected
                          ? category.color
                          : context.textSecondaryColor,
                    ),
                    SizedBox(height: 2),
                    Text(
                      category.name,
                      style: context
                          .responsiveBodyText(
                            fontSizeSmall: 7,
                            fontSizeMedium: 8,
                            fontSizeLarge: 10,
                            color: isSelected
                                ? category.color
                                : context.textPrimaryColor,
                          )
                          .copyWith(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${category.types.length} types',
                      style: context.responsiveBodyText(
                        fontSizeSmall: 7,
                        fontSizeMedium: 8,
                        fontSizeLarge: 9,
                        color: context.textTertiaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildSpecificTypes(
    String selectedType,
    WidgetRef ref,
    String? selectedCategory,
  ) {
    if (selectedCategory == null) return const SizedBox.shrink();

    final category = _categories.firstWhere((c) => c.name == selectedCategory);
    final types = category.types;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              category.icon,
              size: context.responsiveIconSize(
                small: 14,
                medium: 16,
                large: 18,
              ),
              color: category.color,
            ),
            SizedBox(
              width: context.responsiveValue(small: 3, medium: 4, large: 5),
            ),
            Text(
              '$selectedCategory Types:',
              style: context
                  .responsiveBodyText(
                    fontSizeSmall: 10,
                    fontSizeMedium: 12,
                    fontSizeLarge: 14,
                    color: category.color,
                  )
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(
          height: context.responsiveValue(small: 4, medium: 6, large: 8),
        ),
        Wrap(
          spacing: context.responsiveValue(small: 6, medium: 8, large: 10),
          runSpacing: context.responsiveValue(small: 6, medium: 8, large: 10),
          children: types.map((type) {
            final isSelected = selectedType == type;

            return GestureDetector(
              onTap: () => _setIncidentType(type),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveValue(
                    small: 10,
                    medium: 12,
                    large: 14,
                  ),
                  vertical: context.responsiveValue(
                    small: 6,
                    medium: 8,
                    large: 10,
                  ),
                ),
                decoration: BoxDecoration(
                  color: isSelected ? category.color : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    context.responsiveValue(small: 16, medium: 18, large: 20),
                  ),
                  border: Border.all(
                    color: isSelected ? category.color : AppTheme.borderMedium,
                    width: 1,
                  ),
                ),
                child: Text(
                  type,
                  style: context
                      .responsiveBodyText(
                        fontSizeSmall: 9,
                        fontSizeMedium: 10,
                        fontSizeLarge: 11,
                        color: isSelected
                            ? AppTheme.textWhite
                            : context.textPrimaryColor,
                      )
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
