import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider/speed_test_provider.dart';
import '../../../../data/enums/connection_quality.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../utils/context_extensions.dart';
import '../controllers/report_incident/notifier.dart';

class SendButton extends ConsumerWidget {
  const SendButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reportIncidentNotifierProvider);
    final notifier = ref.read(reportIncidentNotifierProvider.notifier);
    final isLoading = state.isLoading;
    final canSend = ref.watch(canSendReportProvider);
    final canSubmit = ref.watch(canSubmitReportProvider);
    final quality = ref.watch(connectionQualityProvider);
    final pingAsync = ref.watch(speedTestProvider);

    final isDisabled = isLoading || !canSend || !canSubmit;

    return SizedBox(
      width: double.infinity,
      height: context.responsiveValue(small: 45, medium: 50, large: 56),
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1.0,
        child: ElevatedButton(
          onPressed: isDisabled
              ? null
              : () async {
                  final options = [
                    'Ambulance / Medical Response Team',
                    'Fire Rescue Team',
                    'Police Assistance',
                    'Search and Rescue (SAR)',
                    'Disaster Response Team',
                    'Other Emergency Services',
                  ];

                  String? selected = await showDialog<String?>(
                    context: context,
                    builder: (context) {
                      String? tempSelection;
                      bool isSending = false;
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            insetPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 24,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.8,
                                maxWidth:
                                    MediaQuery.of(context).size.width > 600
                                    ? 500
                                    : MediaQuery.of(context).size.width,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFEF5350),
                                          Color(0xFFE53935),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.emergency,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        const SizedBox(width: 12),
                                        const Expanded(
                                          child: Text(
                                            'Select Rescuer',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(null),
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Scrollable content
                                  Expanded(
                                    child: SingleChildScrollView(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: options
                                            .map(
                                              (o) => Container(
                                                margin: const EdgeInsets.only(
                                                  bottom: 12,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: tempSelection == o
                                                      ? const Color(0xFFFFEBEE)
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: tempSelection == o
                                                        ? const Color(
                                                            0xFFEF5350,
                                                          )
                                                        : const Color(
                                                            0xFFE0E0E0,
                                                          ),
                                                    width: tempSelection == o
                                                        ? 2
                                                        : 1,
                                                  ),
                                                ),
                                                child: RadioListTile<String>(
                                                  title: Text(
                                                    o,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: tempSelection == o
                                                          ? const Color(
                                                              0xFFE53935,
                                                            )
                                                          : const Color(
                                                              0xFF424242,
                                                            ),
                                                    ),
                                                  ),
                                                  value: o,
                                                  groupValue: tempSelection,
                                                  onChanged: (v) {
                                                    setState(
                                                      () => tempSelection = v,
                                                    );
                                                  },
                                                  activeColor: const Color(
                                                    0xFFE53935,
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 8,
                                                      ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 50,
                                            child: OutlinedButton(
                                              onPressed: () => Navigator.of(
                                                context,
                                              ).pop(null),
                                              style: OutlinedButton.styleFrom(
                                                side: const BorderSide(
                                                  color: Color(0xFFE0E0E0),
                                                  width: 1,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF757575),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: SizedBox(
                                            height: 50,
                                            child: ElevatedButton(
                                              onPressed:
                                                  tempSelection != null &&
                                                      !isSending
                                                  ? () async {
                                                      setState(
                                                        () => isSending = true,
                                                      );
                                                      Navigator.of(
                                                        context,
                                                      ).pop(tempSelection);
                                                    }
                                                  : null,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(
                                                  0xFFE53935,
                                                ),
                                                foregroundColor: Colors.white,
                                                elevation: 0,
                                                disabledBackgroundColor:
                                                    const Color(0xFFE0E0E0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              child: isSending
                                                  ? const SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child: CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                              Color
                                                            >(Colors.white),
                                                      ),
                                                    )
                                                  : const Text(
                                                      'Confirm',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );

                  if (selected != null) {
                    notifier.setRescuerSelection(selected);
                    await notifier.sendReport();
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: context.primaryColor,
            foregroundColor: context.textWhiteColor,
            disabledBackgroundColor: context.primaryColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                context.responsiveValue(small: 8, medium: 10, large: 12),
              ),
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isLoading
                ? SizedBox(
                    key: const ValueKey('loading'),
                    height: context.responsiveIconSize(
                      small: 16,
                      medium: 18,
                      large: 20,
                    ),
                    width: context.responsiveIconSize(
                      small: 16,
                      medium: 18,
                      large: 20,
                    ),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        context.textWhiteColor,
                      ),
                    ),
                  )
                : _buildButtonContent(
                    context,
                    canSend,
                    canSubmit,
                    quality,
                    pingAsync,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonContent(
    BuildContext context,
    bool canSend,
    bool canSubmit,
    ConnectionQuality quality,
    AsyncValue<double> pingAsync,
  ) {
    final pingLabel = pingAsync.maybeWhen(
      data: (ms) => ms >= 9999 ? 'No Signal' : '${ms}ms',
      orElse: () => '...',
    );

    return Row(
      key: ValueKey(quality),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Ping dot — green / yellow / red
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _pingColor(quality),
          ),
        ),
        SizedBox(
          width: context.responsiveValue(small: 6, medium: 8, large: 10),
        ),
        Text(
          !canSubmit
              ? 'Fill Required Fields'
              : (canSend ? 'Send Report' : 'Poor Connection  $pingLabel'),
          style: context.responsiveButtonText(
            fontSizeSmall: 12,
            fontSizeMedium: 14,
            fontSizeLarge: 16,
            color: context.textWhiteColor,
          ),
        ),
      ],
    );
  }

  Color _pingColor(ConnectionQuality quality) {
    return switch (quality) {
      ConnectionQuality.excellent => AppTheme.successGreen,
      ConnectionQuality.good => AppTheme.warningYellow,
      ConnectionQuality.poor => AppTheme.secondaryOrange,
      ConnectionQuality.offline => AppTheme.errorRed,
      _ => AppTheme.errorRed,
    };
  }
}
