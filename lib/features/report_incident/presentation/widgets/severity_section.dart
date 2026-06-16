import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/report_incident/notifier.dart';
import 'shimmer/shimmer_loading_widget.dart';
import '../../../../shared/theme/app_theme.dart';

class SeverityMapper {
  static List<String> getSeverityLevelsForIncident(String incidentType) {
    switch (incidentType) {
      // Fire-Related Rescues
      case 'Structure Fires':
        return [
          'Minor (Small room fire, controllable)',
          'Moderate (Multiple rooms, spreading)',
          'Major (Building involved, evacuation needed)',
          'Critical (Multi-story building, life threatening)',
        ];
      case 'Vehicle Fires':
        return [
          'Minor (Small vehicle, controllable)',
          'Moderate (Large vehicle, spreading)',
          'Major (Multiple vehicles, explosion risk)',
          'Critical (Hazardous materials, life threatening)',
        ];
      case 'Forest/Grass Fires':
        return [
          'Minor (Small area, controllable)',
          'Moderate (Spreading, multiple acres)',
          'Major (Large area, homes threatened)',
          'Critical (Rapid spread, communities at risk)',
        ];
      case 'Industrial/LPG Fires':
        return [
          'Minor (Small equipment, controllable)',
          'Moderate (Industrial area, spreading)',
          'Major (Large facility, evacuation needed)',
          'Critical (Explosion risk, life threatening)',
        ];

      // Natural Disaster Response
      case 'Earthquake Rescue':
        return [
          'Minor (Minor damage, few trapped)',
          'Moderate (Building collapse, multiple trapped)',
          'Major (Widespread damage, many trapped)',
          'Critical (Mass casualties, infrastructure collapse)',
        ];
      case 'Flood/Water Rescue':
        return [
          'Minor (Street flooding, no immediate danger)',
          'Moderate (Homes flooded, rescues needed)',
          'Major (Widespread flooding, many trapped)',
          'Critical (Flash flood, life threatening)',
        ];
      case 'Landslide/Structural Collapse':
        return [
          'Minor (Minor damage, no injuries)',
          'Moderate (Partial collapse, few trapped)',
          'Major (Major collapse, multiple trapped)',
          'Critical (Complete collapse, many casualties)',
        ];
      case 'Volcanic Eruption Evacuation':
        return [
          'Minor (Ash fall, advisory)',
          'Moderate (Lava flow, evacuation ordered)',
          'Major (Pyroclastic flow, immediate danger)',
          'Critical (Major eruption, life threatening)',
        ];

      // Special Technical Rescue
      case 'Vehicular Accident':
        return [
          'Minor (Minor collision, no injuries)',
          'Moderate (Major collision, injuries)',
          'Major (Multi-vehicle, serious injuries)',
          'Critical (Fatalities, hazardous materials)',
        ];
      case 'High-Angle/Rope Rescue':
        return [
          'Minor (Low height, simple extraction)',
          'Moderate (Medium height, complex extraction)',
          'Major (Great height, technical rescue)',
          'Critical (Extreme height, life threatening)',
        ];
      case 'Confined Space Rescue':
        return [
          'Minor (Simple space, easy access)',
          'Moderate (Complex space, limited access)',
          'Major (Difficult extraction, injuries)',
          'Critical (Toxic environment, life threatening)',
        ];
      case 'Elevator Rescue':
        return [
          'Minor (Minor malfunction, no injuries)',
          'Moderate (Major malfunction, people trapped)',
          'Major (Multiple elevators, medical issues)',
          'Critical (Fire in shaft, life threatening)',
        ];
      case 'Impalement/Machinery Accident':
        return [
          'Minor (Minor injury, simple extraction)',
          'Moderate (Serious injury, complex extraction)',
          'Major (Severe injury, specialized equipment)',
          'Critical (Fatal injury, life threatening)',
        ];

      // HAZMAT & Specialized Incidents
      case 'Chemical Spill/HAZMAT':
        return [
          'Minor (Small spill, contained)',
          'Moderate (Medium spill, evacuation)',
          'Major (Large spill, specialized response)',
          'Critical (Toxic release, life threatening)',
        ];
      case 'Electrical Accident/Live Wire':
        return [
          'Minor (Minor shock, no injuries)',
          'Moderate (Serious shock, injuries)',
          'Major (Multiple casualties, power outage)',
          'Critical (High voltage, life threatening)',
        ];
      case 'Aviation Accident':
        return [
          'Minor (Minor incident, no injuries)',
          'Moderate (Minor crash, few injuries)',
          'Major (Major crash, multiple injuries)',
          'Critical (Major crash, mass casualties)',
        ];
      case 'Water Safety/Drowning Rescue':
        return [
          'Minor (Near drowning, conscious)',
          'Moderate (Drowning, unconscious)',
          'Major (Multiple victims, difficult rescue)',
          'Critical (Mass drowning, life threatening)',
        ];

      // Emergency Medical Services
      case 'Mass Casualty Incident (MCI)':
        return [
          'Minor (Few casualties, manageable)',
          'Moderate (Multiple casualties, overwhelmed)',
          'Major (Many casualties, disaster response)',
          'Critical (Mass casualties, life threatening)',
        ];
      case 'Medical Emergency (Cardiac Arrest, Trauma)':
        return [
          'Minor (Minor injury, stable)',
          'Moderate (Serious injury, needs transport)',
          'Major (Critical injury, life threatening)',
          'Critical (Cardiac arrest, immediate death risk)',
        ];

      default:
        return [
          'Minor (Low priority)',
          'Moderate (Medium priority)',
          'Major (High priority)',
          'Critical (Life threatening)',
        ];
    }
  }

  static String getDefaultSeverityForIncident(String incidentType) {
    final severityLevels = getSeverityLevelsForIncident(incidentType);
    return severityLevels
        .first; // Return the first (lowest) severity as default
  }

  static String getRecommendedSeverityForIncident(String incidentType) {
    // For high-risk incidents, recommend higher severity
    final criticalIncidents = [
      'Mass Casualty Incident (MCI)',
      'Chemical Spill/HAZMAT',
      'Aviation Accident',
      'Industrial/LPG Fires',
      'Volcanic Eruption Evacuation',
    ];

    if (criticalIncidents.contains(incidentType)) {
      final levels = getSeverityLevelsForIncident(incidentType);
      return levels[levels.length - 2]; // Second highest severity
    }

    return getDefaultSeverityForIncident(incidentType);
  }
}

class SeveritySection extends ConsumerWidget {
  const SeveritySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportState = ref.watch(reportIncidentNotifierProvider);
 
    final selectedIncidentType = reportState.incidentType;

    // Get dynamic severity levels based on incident type
    final List<String> _severityLevels = selectedIncidentType.isNotEmpty
        ? SeverityMapper.getSeverityLevelsForIncident(selectedIncidentType)
        : [
            'Minor (Small fire, controllable)',
            'Moderate (Medium fire, spreading)',
            'Major (Large fire, uncontrollable)',
            'Critical (Life threatening)',
          ];

    // Ensure selected severity is valid for current severity levels
    // String validSelectedSeverity = selectedSeverity;
    // if (!_severityLevels.contains(selectedSeverity)) {
    //   validSelectedSeverity = _severityLevels.first;
    //   // Auto-update the severity in the state if it's invalid
    //   // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   //   ref
    //   //       .read(reportIncidentNotifierProvider.notifier)
    //   //       .setSeverity(validSelectedSeverity);
    //   // });
    // }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Severity Level',
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
            // if (reportState.isLoading)
            //   _buildShimmerLoading(context)
            // else
            //   _buildContent(
            //     context,
            //     validSelectedSeverity,
            //     _severityLevels,
            //     ref,
            //   ),
          ],
        ),
      ),
    );
  }
}

Widget _buildShimmerLoading(BuildContext context) {
  return Container(
    width: double.infinity,
    height: context.responsiveValue(small: 36, medium: 44, large: 52),
    padding: EdgeInsets.symmetric(
      horizontal: context.responsiveValue(small: 10, medium: 12, large: 16),
      vertical: context.responsiveValue(small: 5, medium: 6, large: 8),
    ),
    decoration: BoxDecoration(
      border: Border.all(color: AppTheme.borderLight),
      borderRadius: BorderRadius.circular(
        context.responsiveValue(small: 6, medium: 8, large: 10),
      ),
    ),
    child: ShimmerTextWidget(
      width: double.infinity,
      height: context.responsiveValue(small: 14, medium: 16, large: 18),
    ),
  );
}

Widget _buildContent(
  BuildContext context,
  String selectedSeverity,
  List<String> severityLevels,
  WidgetRef ref,
) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: context.responsiveValue(small: 10, medium: 12, large: 16),
      vertical: context.responsiveValue(small: 5, medium: 6, large: 8),
    ),
    decoration: BoxDecoration(
      border: Border.all(color: AppTheme.borderLight),
      borderRadius: BorderRadius.circular(
        context.responsiveValue(small: 6, medium: 8, large: 10),
      ),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedSeverity,
        hint: Text(
          'Select Severity',
          style: context.responsiveBodyText(
            fontSizeSmall: 10,
            fontSizeMedium: 12,
            fontSizeLarge: 14,
            color: context.textTertiaryColor,
          ),
        ),
        isExpanded: true,
        items: severityLevels.map((String severity) {
          return DropdownMenuItem<String>(
            value: severity,
            child: Text(
              severity,
              style: context.responsiveBodyText(
                fontSizeSmall: 10,
                fontSizeMedium: 12,
                fontSizeLarge: 14,
                color: context.textPrimaryColor,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          // if (newValue != null) {
          //   ref
          //       .read(reportIncidentNotifierProvider.notifier)
          //       .setSeverity(newValue);
          // }
        },
      ),
    ),
  );
}
