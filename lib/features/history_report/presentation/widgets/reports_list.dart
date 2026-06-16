import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../../report_incident/data/constants/emergency_categories_data.dart';
import '../../domain/entities/history_report.dart';
 
import '../controllers/history_report_state.dart';
import '../providers/history_report_providers.dart';
import 'report_card.dart';
import 'report_shimmer.dart';

class ReportsList extends ConsumerWidget {
  final String selectedType;
  final String selectedSeverity;

  const ReportsList({
    super.key,
    required this.selectedType,
    required this.selectedSeverity,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportState = ref.watch(historyReportNotifierProvider);

    return reportState.when(
      initial: () => const SizedBox.shrink(),
      loading: () => const ReportsListShimmer(),
      error: (message) => _buildError(context, ref, message),
      loaded: (reports) {
        final filtered = _applyFilters(reports);

        if (filtered.isEmpty) {
          return _buildEmpty(context);
        }

        return ListView.builder(
          padding: EdgeInsets.all(
            context.responsiveValue(small: 12, medium: 16, large: 20),
          ),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            return ReportCard(report: filtered[index]);
          },
        );
      },
    );
  }

  String _categoryFilterLabelToDataName(String filter) {
    switch (filter) {
      case 'Natural Disasters':
        return 'Natural Disaster Response';
      case 'Special Technical':
        return 'Special Technical Rescue';
      case 'Hazmat& Special Incidents':
        return 'HAZMAT & Specialized Incidents';
      default:
        return filter;
    }
  }

  bool _incidentMatchesCategoryFilter(String incidentType, String filter) {
    if (filter == 'All') return true;
    final String name = _categoryFilterLabelToDataName(filter);
    for (final cat in EmergencyCategoriesData.all) {
      if (cat.name == name && cat.types.contains(incidentType)) return true;
    }
    return incidentType == filter;
  }

  List<HistoryReport> _applyFilters(List<HistoryReport> reports) {
    return reports.where((HistoryReport report) {
      if (!_incidentMatchesCategoryFilter(report.type, selectedType)) {
        return false;
      }
      if (selectedSeverity != 'All' &&
          !report.severity.startsWith(selectedSeverity)) {
        return false;
      }
      return true;
    }).toList();
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.filter_list,
            size: context.responsiveIconSize(small: 48, medium: 64, large: 80),
            color: context.textSecondaryColor,
          ),
          SizedBox(
            height: context.responsiveValue(small: 16, medium: 20, large: 24),
          ),
          Text(
            'No reports found',
            style: context.responsiveBodyText(
              fontSizeSmall: 14,
              fontSizeMedium: 16,
              fontSizeLarge: 18,
              color: context.textSecondaryColor,
            ),
          ),
          SizedBox(
            height: context.responsiveValue(small: 8, medium: 12, large: 16),
          ),
          Text(
            'Try adjusting your filters',
            style: context.responsiveBodyText(
              fontSizeSmall: 12,
              fontSizeMedium: 14,
              fontSizeLarge: 16,
              color: context.textTertiaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildError(
    BuildContext context,
    WidgetRef ref,
    String message,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: context.responsiveIconSize(small: 48, medium: 64, large: 80),
            color: Colors.red,
          ),
          SizedBox(
            height: context.responsiveValue(small: 16, medium: 20, large: 24),
          ),
          Text(
            message,
            style: context.responsiveBodyText(
              fontSizeSmall: 14,
              fontSizeMedium: 16,
              fontSizeLarge: 18,
              color: context.textSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: context.responsiveValue(small: 12, medium: 16, large: 20),
          ),
          ElevatedButton.icon(
            onPressed: () => ref
                .read(historyReportNotifierProvider.notifier)
                .watchReports(),
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}