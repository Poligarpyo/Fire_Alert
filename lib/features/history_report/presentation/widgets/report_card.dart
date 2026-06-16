import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../domain/entities/history_report.dart';
import '../../../report_incident/data/constants/emergency_categories_data.dart';

class ReportCard extends ConsumerWidget {
  final HistoryReport report;

  const ReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.only(
          top: context.responsiveValue(small: 4, medium: 6, large: 8),
          bottom: context.responsiveValue(small: 4, medium: 6, large: 8),
        ),
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius12),
        ),
        color: AppTheme.backgroundWhite,
        child: Padding(
          padding: EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (report.imageUrl != null) {
                    _showImageViewer(context, report.imageUrl!);
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                  child: Container(
                    width: double.infinity,
                    height: context.responsiveValue(
                      small: 120,
                      medium: 150,
                      large: 180,
                    ),
                    color: AppTheme.surfaceGrey,
                    child: report.imageUrl != null
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                report.imageUrl!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (_, __, ___) =>
                                    _buildImagePlaceholder(context),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.1),
                                      ],
                                    ),
                                  ),
                                  child: const Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.fullscreen,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : _buildImagePlaceholder(context),
                  ),
                ),
              ),
              SizedBox(height: AppTheme.spacing12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.responsiveValue(
                            small: 6,
                            medium: 8,
                            large: 10,
                          ),
                          vertical: context.responsiveValue(
                            small: 2,
                            medium: 3,
                            large: 4,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: _getTypeColor(report.type),
                          borderRadius: BorderRadius.circular(
                            context.responsiveValue(
                              small: 4,
                              medium: 6,
                              large: 8,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _getCategoryName(report.type),
                              style: context
                                  .responsiveBodyText(
                                    fontSizeSmall: 6,
                                    fontSizeMedium: 8,
                                    fontSizeLarge: 10,
                                    color: Colors.white70,
                                  )
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              report.type,
                              style: context
                                  .responsiveBodyText(
                                    fontSizeSmall: 8,
                                    fontSizeMedium: 10,
                                    fontSizeLarge: 12,
                                    color: Colors.white,
                                  )
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      if (report.rescuer != null && report.rescuer!.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.responsiveValue(
                              small: 6,
                              medium: 8,
                              large: 10,
                            ),
                            vertical: context.responsiveValue(
                              small: 2,
                              medium: 3,
                              large: 4,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: _getRescuerTypeColor(
                              _getRescuerType(report.rescuer!),
                            ),
                            borderRadius: BorderRadius.circular(
                              context.responsiveValue(
                                small: 4,
                                medium: 6,
                                large: 8,
                              ),
                            ),
                          ),
                          child: Text(
                            _getRescuerType(report.rescuer!),
                            style: context
                                .responsiveBodyText(
                                  fontSizeSmall: 8,
                                  fontSizeMedium: 10,
                                  fontSizeLarge: 12,
                                  color: Colors.white,
                                )
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: AppTheme.spacing4),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveValue(
                        small: 6,
                        medium: 8,
                        large: 10,
                      ),
                      vertical: context.responsiveValue(
                        small: 2,
                        medium: 3,
                        large: 4,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(report.status),
                      borderRadius: BorderRadius.circular(
                        context.responsiveValue(small: 4, medium: 6, large: 8),
                      ),
                    ),
                    child: Text(
                      report.status,
                      style: context
                          .responsiveBodyText(
                            fontSizeSmall: 8,
                            fontSizeMedium: 10,
                            fontSizeLarge: 12,
                            color: Colors.white,
                          )
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppTheme.spacing8),
              Text(
                report.additionalInfo.isNotEmpty
                    ? report.additionalInfo
                    : 'No description available',
                style: context.responsiveBodyText(
                  fontSizeSmall: 10,
                  fontSizeMedium: 12,
                  fontSizeLarge: 14,
                  color: AppTheme.textSecondary,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppTheme.spacing8),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: context.responsiveIconSize(
                      small: 14,
                      medium: 16,
                      large: 18,
                    ),
                    color: AppTheme.textTertiary,
                  ),
                  SizedBox(width: AppTheme.spacing4),
                  Expanded(
                    child: Text(
                      report.location,
                      style: context
                          .responsiveBodyText(
                            fontSizeSmall: 10,
                            fontSizeMedium: 12,
                            fontSizeLarge: 14,
                            color: AppTheme.textPrimary,
                          )
                          .copyWith(fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppTheme.spacing8),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: context.responsiveIconSize(
                      small: 14,
                      medium: 16,
                      large: 18,
                    ),
                    color: AppTheme.textTertiary,
                  ),
                  SizedBox(width: AppTheme.spacing4),
                  Text(
                    report.date,
                    style: context.responsiveBodyText(
                      fontSizeSmall: 10,
                      fontSizeMedium: 12,
                      fontSizeLarge: 14,
                      color: AppTheme.textTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(BuildContext context) {
    return Icon(
      Icons.image,
      size: context.responsiveIconSize(small: 32, medium: 40, large: 48),
      color: AppTheme.textTertiary,
    );
  }

  void _showImageViewer(BuildContext context, String imageUrl) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              InteractiveViewer(
                panEnabled: true,
                boundaryMargin: const EdgeInsets.all(20),
                minScale: 0.5,
                maxScale: 4.0,
                child: Center(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.broken_image,
                              size: 64,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Failed to load image',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getCategoryName(String type) {
    for (final category in EmergencyCategoriesData.all) {
      if (category.types.contains(type)) {
        return category.name;
      }
    }
    return 'Other';
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Structure Fires':
      case 'Vehicle Fires':
      case 'Forest/Grass Fires':
      case 'Industrial/LPG Fires':
        return AppTheme.primaryRed;
      case 'Mass Casualty Incident (MCI)':
      case 'Medical Emergency (Cardiac Arrest, Trauma)':
        return AppTheme.successGreen;
      case 'Earthquake Rescue':
      case 'Flood/Water Rescue':
      case 'Landslide/Structural Collapse':
      case 'Volcanic Eruption Evacuation':
        return AppTheme.secondaryOrange;
      case 'Vehicular Accident':
      case 'High-Angle/Rope Rescue':
      case 'Confined Space Rescue':
      case 'Elevator Rescue':
      case 'Impalement/Machinery Accident':
        return AppTheme.warningYellow;
      case 'Chemical Spill/HAZMAT':
      case 'Electrical Accident/Live Wire':
      case 'Aviation Accident':
      case 'Water Safety/Drowning Rescue':
        return AppTheme.primaryRedDark;

      default:
        return AppTheme.primaryRed;
    }
  }

  Color _getStatusColor(String status) {
    final String normalized = status
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[_-]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
    if (normalized == 'resolved' ||
        normalized.contains('resolved') ||
        normalized.contains('closed') ||
        normalized.contains('complete')) {
      return AppTheme.successGreen;
    }
    if (normalized == 'reported') {
      return AppTheme.errorRed;
    }
    if (normalized == 'in progress') {
      return AppTheme.warningYellow;
    }
    if (normalized.contains('dispatch') ||
        normalized.contains('assigned') ||
        normalized.contains('en route')) {
      return AppTheme.primaryRed;
    }
    return AppTheme.textSecondary;
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'Critical':
        return AppTheme.errorRed;
      case 'Major':
      case 'High':
        return AppTheme.primaryRed;
      case 'Moderate':
      case 'Medium':
        return AppTheme.secondaryOrange;
      case 'Minor':
      case 'Low':
        return AppTheme.successGreen;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getRescuerType(String rescuer) {
    final normalized = rescuer.trim().toLowerCase();

    if (normalized.contains('ambulance') || normalized.contains('medical')) {
      return 'Medical/Ambulance';
    } else if (normalized.contains('fire')) {
      return 'Fire Rescue';
    } else if (normalized.contains('police')) {
      return 'Police';
    } else if (normalized.contains('search and rescue') ||
        normalized.contains('sar')) {
      return 'Search & Rescue';
    } else if (normalized.contains('disaster')) {
      return 'Disaster Response';
    } else if (normalized.contains('emergency')) {
      return 'Emergency Services';
    } else {
      return 'Other';
    }
  }

  Color _getRescuerTypeColor(String rescuerType) {
    switch (rescuerType) {
      case 'Medical/Ambulance':
        return AppTheme.successGreen;
      case 'Fire Rescue':
        return AppTheme.primaryRed;
      case 'Police':
        return AppTheme.infoBlue;
      case 'Search & Rescue':
        return AppTheme.warningYellow;
      case 'Disaster Response':
        return AppTheme.primaryRed;
      case 'Emergency Services':
        return AppTheme.primaryRed;
      default:
        return AppTheme.textSecondary;
    }
  }
}
