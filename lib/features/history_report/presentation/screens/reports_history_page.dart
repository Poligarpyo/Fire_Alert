import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/app_theme.dart';
import '../providers/history_report_providers.dart';
import '../widgets/filter_section.dart';
import '../widgets/reports_list.dart';

class ReportsHistoryPage extends ConsumerStatefulWidget {
  const ReportsHistoryPage({super.key});

  @override
  ConsumerState<ReportsHistoryPage> createState() => _ReportsHistoryPageState();
}

class _ReportsHistoryPageState extends ConsumerState<ReportsHistoryPage> {
  String _selectedType = 'All';
  String _selectedSeverity = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(historyReportNotifierProvider.notifier).watchReports();
    });
  }

  void _watchReports() {
    ref.read(historyReportNotifierProvider.notifier).watchReports();
  }

  Future<void> _refreshReports() async {
    _watchReports();
    // ref
    //     .read(historyReportNotifierProvider.notifier)
    //     .watchReports(type: _selectedType, severity: _selectedSeverity);
  }

  void _onTypeChanged(String value) {
    print("values $value");
    setState(() => _selectedType = value);
    ref.read(historyReportNotifierProvider.notifier).watchReports();
  }

  void _onSeverityChanged(String value) {
    setState(() => _selectedSeverity = value);
    ref.read(historyReportNotifierProvider.notifier).watchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.responsiveValue(
          small: 70,
          medium: 80,
          large: 90,
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveValue(
              small: 12,
              medium: 16,
              large: 20,
            ),
            vertical: context.responsiveValue(small: 8, medium: 12, large: 16),
          ),
          child: Text(
            'Reports History',
            style: context.responsiveBodyText(
              fontSizeSmall: 18,
              fontSizeMedium: 20,
              fontSizeLarge: 22,
              color: context.textWhiteColor,
            ),
          ),
        ),
        backgroundColor: context.primaryColor,
        foregroundColor: context.textWhiteColor,
        elevation: 0,
      ),
      body: ColoredBox(
        color: context.backgroundColor,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: context.surfaceColor,
              child: FilterSection(
                selectedType: _selectedType,
                selectedSeverity: _selectedSeverity,
                onTypeChanged: _onTypeChanged,
                onSeverityChanged: _onSeverityChanged,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshReports,
                color: context.primaryColor,
                child: ReportsList(
                  selectedType: _selectedType,
                  selectedSeverity: _selectedSeverity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
