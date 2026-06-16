import 'dart:io';
import 'dart:typed_data'; // ← add this
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/report_incident.dart';

part 'report_incident_model.freezed.dart';
part 'report_incident_model.g.dart';

@freezed
abstract class ReportIncidentModel with _$ReportIncidentModel {
  const factory ReportIncidentModel({
    required double latitude,
    required double longitude,
    required String incidentType,
    required String additionalDetails,
    @JsonKey(name: 'rescuer_selection') String? rescuerSelection,
    @JsonKey(includeFromJson: false, includeToJson: false) File? image,
    @JsonKey(includeFromJson: false, includeToJson: false)
    Uint8List? compressedImageBytes, // ← add
  }) = _ReportIncidentModel;
  const ReportIncidentModel._();

  factory ReportIncidentModel.fromJson(Map<String, dynamic> json) =>
      _$ReportIncidentModelFromJson(json);

  // ✅ Add this — entity → model conversion lives in data layer
  factory ReportIncidentModel.fromEntity(ReportIncident entity) =>
      ReportIncidentModel(
        latitude: entity.latitude,
        longitude: entity.longitude,
        incidentType: entity.incidentType,
        additionalDetails: entity.details,
        rescuerSelection: entity.rescuerSelection,
        image: entity.image,
        compressedImageBytes: entity.compressedImageBytes,
      );
}

extension ReportIncidentModelX on ReportIncidentModel {
  ReportIncident toEntity() => ReportIncident(
    latitude: latitude,
    longitude: longitude,
    incidentType: incidentType,
    details: additionalDetails,
    image: image,
    compressedImageBytes: compressedImageBytes,
    rescuerSelection: rescuerSelection,

  );
}
