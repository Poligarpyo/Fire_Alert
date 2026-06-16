import 'dart:io';
import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
abstract class ReportIncidentState with _$ReportIncidentState {
  const factory ReportIncidentState({
    @Default(false) bool isLoading,
    @Default('') String incidentType,
    @Default('') String details,
    File? selectedImage,
    double? latitude,
    double? longitude,
    String? errorMessage,
    String? selectedCategory,
    String? rescuerSelection,
    @Default(false) bool isSubmitted,
    Uint8List? compressedImageBytes,
    @Default(false) bool limitReached, // ✅ add this
  }) = _ReportIncidentState;
}