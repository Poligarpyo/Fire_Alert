import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../domain/entities/emergency_category.dart';

class EmergencyCategoryUI {
  const EmergencyCategoryUI({
    required this.category,
    required this.color,
    required this.icon,
  });

  final EmergencyCategory category;
  final Color color;
  final IconData icon;

  String get name => category.name;
  List<String> get types => category.types;
}

// Mapping is presentation concern — lives here, not in domain
class EmergencyCategoryUIMapper {
  const EmergencyCategoryUIMapper._();

  static const _meta = {
    'Fire-Related Rescues': (
      color: AppTheme.primaryRed,
      icon: Icons.local_fire_department,
    ),
    'Search and Rescue': (
      color: AppTheme.secondaryOrange,
      icon: Icons.landslide,
    ),
    'Special Technical Rescue Operations': (
      color: AppTheme.infoBlue,
      icon: Icons.engineering,
    ),
    'HAZMAT Specialized Incidents': (
      color: AppTheme.primaryRedDark,
      icon: Icons.warning,
    ),
    'Emergency Medical Services (EMS)': (
      color: AppTheme.successGreen,
      icon: Icons.medical_services,
    ),
  };

  static EmergencyCategoryUI from(EmergencyCategory category) {
    final meta = _meta[category.name];
    return EmergencyCategoryUI(
      category: category,
      color: meta?.color ?? AppTheme.textSecondary,
      icon: meta?.icon ?? Icons.help_outline,
    );
  }
}
