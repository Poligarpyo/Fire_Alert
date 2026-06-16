import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/additional_details_section.dart';
import '../widgets/capture_photo_section.dart';
import '../widgets/incident_type_section.dart';
import '../widgets/report_header.dart';
import '../widgets/report_incident_listener.dart';
import '../widgets/send_button.dart';
import '../widgets/severity_section.dart';
import '../controllers/report_incident/notifier.dart';
import '../../../../shared/theme/app_theme.dart';
 

class ReportIncidentScreen extends ConsumerWidget {
  const ReportIncidentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(reportIncidentNotifierProvider.notifier);
    return ReportIncidentListener(
      child: Scaffold(
        appBar: const ReportHeader(),
        body: RefreshIndicator(
          onRefresh: () async {
            await notifier.refreshForm();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(
              context.responsiveValue(small: 16, medium: 20, large: 24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IncidentTypeSection(),
                SizedBox(
                  height: context.responsiveValue(
                    small: 16,
                    medium: 20,
                    large: 24,
                  ),
                ),
                // SeveritySection(),
                SizedBox(
                  height: context.responsiveValue(
                    small: 16,
                    medium: 20,
                    large: 24,
                  ),
                ),
                CapturePhotoSection(),
                SizedBox(
                  height: context.responsiveValue(
                    small: 16,
                    medium: 20,
                    large: 24,
                  ),
                ),
                AdditionalDetailsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
