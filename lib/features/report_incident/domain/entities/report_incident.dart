import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class ReportIncident {
  const ReportIncident({
    required this.incidentType,
    required this.details,
    required this.latitude,
    required this.longitude,
    this.image,
    this.compressedImageBytes,
    this.rescuerSelection,
  });

  final String incidentType;
  final String details;
  final double latitude;
  final double longitude;
  final File? image;
  final Uint8List? compressedImageBytes;
  final String? rescuerSelection;

  // ✅ Serialization concern scoped to entity — no model needed
  Future<FormData> toFormData(String phone) async {
    final Map<String, dynamic> data = {
      'phone': phone,
      'incident_type': incidentType,
      'details': details,
      'latitude': latitude,
      'longitude': longitude,
    };

    if (rescuerSelection != null && rescuerSelection!.isNotEmpty) {
      data['rescuer_selection'] = rescuerSelection;
    }

    // ✅ Prefer compressed bytes, fall back to raw file
    if (compressedImageBytes != null) {
      data['photo'] = MultipartFile.fromBytes(
        compressedImageBytes!,
        filename: 'photo.jpg',
        contentType: DioMediaType('image', 'jpeg'),
      );
    } else if (image != null) {
      if (!await image!.exists()) {
        throw Exception(
          'Image file no longer exists. Please retake the photo.',
        );
      }
      data['photo'] = await MultipartFile.fromFile(
        image!.path,
        filename: basename(image!.path),
      );
    }

    return FormData.fromMap(data);
  }
}
