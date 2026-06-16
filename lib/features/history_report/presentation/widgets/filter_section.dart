import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/app_theme.dart';

class FilterSection extends ConsumerWidget {
  final String selectedType;
  final String selectedSeverity;
  final void Function(String) onTypeChanged;
  final void Function(String) onSeverityChanged;

  const FilterSection({
    super.key,
    required this.selectedType,
    required this.selectedSeverity,
    required this.onTypeChanged,
    required this.onSeverityChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveValue(small: 8, medium: 12, large: 16),
        vertical: context.responsiveValue(small: 6, medium: 8, large: 10),
      ),
      decoration: BoxDecoration(
        color: context.primaryColor,
        border: Border(
          bottom: BorderSide(
            color: context.textTertiaryColor.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filters',
            style: context
                .responsiveBodyText(
                  fontSizeSmall: 12,
                  fontSizeMedium: 14,
                  fontSizeLarge: 16,
                  color: context.textWhiteColor,
                )
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: context.responsiveValue(small: 4, medium: 6, large: 8),
          ),
          Row(
            children: [
              Expanded(
                child: _buildFilterDropdown(context, 'Emergency Type', selectedType, [
                  'All',
                  'Fire-Related Rescues',
                  'Natural Disasters',
                  'Special Technical',
                  'Hazmat& Special Incidents',
                  'Emergency Medical Services',
                ], (value) => onTypeChanged(value!)),
              ),
              SizedBox(
                width: context.responsiveValue(small: 8, medium: 12, large: 16),
              ),
              // Expanded(
              //   child: _buildFilterDropdown(
              //     context,
              //     'Severity Level',
              //     selectedSeverity,
              //     ['All', 'Minor', 'Moderate', 'Major', 'Critical'],
              //     (value) => onSeverityChanged(value!),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(
    BuildContext context,
    String label,
    String value,
    List<String> items,
    void Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.responsiveBodyText(
            fontSizeSmall: 10,
            fontSizeMedium: 12,
            fontSizeLarge: 14,
            color: context.textWhiteColor,
          ),
        ),
        SizedBox(
          height: context.responsiveValue(small: 4, medium: 6, large: 8),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveValue(
              small: 8,
              medium: 12,
              large: 16,
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.textTertiaryColor.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(
              context.responsiveValue(small: 6, medium: 8, large: 10),
            ),
            color: context.backgroundColor,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              style: context.responsiveBodyText(
                fontSizeSmall: 12,
                fontSizeMedium: 14,
                fontSizeLarge: 16,
                color: context.textPrimaryColor,
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: context.responsiveBodyText(
                      fontSizeSmall: 12,
                      fontSizeMedium: 14,
                      fontSizeLarge: 16,
                      color: context.textPrimaryColor,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
