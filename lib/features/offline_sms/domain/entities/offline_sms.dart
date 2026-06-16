import 'dart:io';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';

class OfflineSms {
  final String
  id; // Unique identifier, can be generated using UUID or timestamp-based ID
  final String message; // Add this field
  final String phoneNumber; // Add this field
  final double latitude;
  final double longitude;
  final bool sentViaSms;
  final int syncStatus; // optional if you want to track sync in entity
  final DateTime createdAt; // Timestamp for when the report was created
  final String? localIpAddress;
  final String? deviceId;

  OfflineSms({
    required this.id,
    required this.message,
    required this.phoneNumber, // Add this field
    required this.latitude,
    required this.longitude,
    this.sentViaSms = false,
    this.syncStatus = 0,
    DateTime? createdAt,
    required this.localIpAddress,
    required this.deviceId,
  }) : createdAt = createdAt ?? DateTime.now();

  EmergencyReportsCompanion toCompanion({required bool sent}) {
    return EmergencyReportsCompanion(
      id: Value(id),
      message: Value(message),
      phoneNumber: Value(phoneNumber), // Add this line
      latitude: Value(latitude),
      longitude: Value(longitude),
      sentViaSms: Value(sentViaSms ? 1 : 0),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      localIpAddress: Value(localIpAddress),
      deviceId: Value(deviceId),
    );
  }
}
