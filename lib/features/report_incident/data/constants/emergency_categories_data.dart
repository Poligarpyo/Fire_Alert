import '../../domain/entities/emergency_category.dart';

class EmergencyCategoriesData {
  const EmergencyCategoriesData._();

  static const List<EmergencyCategory> all = [
    EmergencyCategory(
      name: 'Fire-Related Rescues',
      types: [
        'Structure Fires',
        'Vehicle Fires',
        'Forest/Grass Fires',
        'Industrial/LPG Fires',
      ],
    ),
    EmergencyCategory(
      name: 'Search and Rescue',
      types: [
        'Earthquakes',
        'Floods',
        'Landslides/Collapse',
        'Volcanic Eruptions',
      ],
    ),
    EmergencyCategory(
      name: 'Special Technical Rescue Operations',
      types: [
        'Vehicular Accidents',
        'High-Angle/Rope Rescue',
        'Confined Space Rescue',
        'Elevator Rescue',
        'Impaling/Accident Rescue',
      ],
    ),
    EmergencyCategory(
      name: 'HAZMAT Specialized Incidents',
      types: [
        'Chemical Spillages',
        'Electric Shock/Danger',
        'Aviation Accidents',
        'Water Safety',
      ],
    ),
    EmergencyCategory(
      name: 'Emergency Medical Services (EMS)',
      types: ['Mass Casualty Incidents (MCI)', 'Medical Emergencies'],
    ),
  ];
}
