import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/geolocator/get_current_location.dart';
import '../../../../../core/provider/speed_test_provider.dart';
import '../../../domain/entities/report_incident.dart';
import '../../../domain/usecases/send_report_incident_usecase.dart';
import '../../providers/report_incident_providers.dart';
import 'state.dart';

final reportIncidentNotifierProvider =
    StateNotifierProvider<ReportIncidentNotifier, ReportIncidentState>((ref) {
      return ReportIncidentNotifier(
        ref,
        ref.read(sendReportIncidentUseCaseProvider),
      );
    });

final canSubmitReportProvider = Provider<bool>((ref) {
  final state = ref.watch(reportIncidentNotifierProvider);
  final hasIncidentType = state.incidentType.trim().isNotEmpty;
  final hasDetails = state.details.trim().isNotEmpty;
  final hasImage = state.selectedImage != null;
  return hasIncidentType && hasDetails && hasImage;
});

class ReportIncidentNotifier extends StateNotifier<ReportIncidentState> {
  ReportIncidentNotifier(this.ref, this.sendReportIncidentUseCase)
    : super(const ReportIncidentState());
  final Ref ref;
  final SendReportIncidentUseCase sendReportIncidentUseCase;

  // notifier.dart
  void selectCategory(String category) => state = state.copyWith(
    selectedCategory: category.isEmpty ? null : category,
  );

  // ─── Send report ───────────────────────────────────────────────────────────

  Future<void> sendReport() async {
    final currentState = state;

    // ── Validation ────────────────────────────────────────────────────────────
    if (currentState.incidentType.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please select an incident type.');
      return;
    }

    if (currentState.details.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please provide incident details.');
      return;
    }
    // ✅ Add this
    if (currentState.selectedImage == null) {
      state = state.copyWith(
        errorMessage: 'Please capture a photo of the incident.',
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final position = await getCurrentLocation();

      final report = ReportIncident(
        incidentType: currentState.incidentType,
        details: currentState.details,
        latitude: position.latitude,
        longitude: position.longitude,
        image: currentState.selectedImage,
        compressedImageBytes:
            currentState.compressedImageBytes, // add this to entity
        rescuerSelection: currentState.rescuerSelection,
      );

      final result = await sendReportIncidentUseCase(report);

      result.when(
        success: (_) {
          resetSubmission();
          state = state.copyWith(
            isLoading: false,
            isSubmitted: true,
            errorMessage: null,
          );
        },
        failure: (error) {
          if (error.message.contains('same coordinates')) {
            state = state.copyWith(
              isLoading: false,
              limitReached: true,
              errorMessage: null,
            );
            return;
          }

          state = state.copyWith(
            isLoading: false,
            errorMessage: _mapError(error.message),
          );
        },
      );
    } on SocketException {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No internet connection. Please check your network.',
      );
    } on HandshakeException {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Secure connection failed. Please try again.',
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _mapError(error.toString()),
      );
    }
  }

  // ─── Error mapper ──────────────────────────────────────────────────────────

  String _mapError(String raw) {
    if (raw.contains('SocketException') || raw.contains('Failed host lookup')) {
      return 'No internet connection. Please check your network.';
    }
    if (raw.contains('TimeoutException')) {
      return 'Request timed out. Please try again.';
    }
    if (raw.contains('403') || raw.contains('401')) {
      return 'Session expired. Please log in again.';
    }
    if (raw.contains('500')) {
      return 'Server error. Please try again later.';
    }
    if (raw.contains('permission-denied') ||
        raw.contains('Permission denied')) {
      return 'Could not save the report. Check Firebase security rules for '
          'Firestore and Storage.';
    }
    return 'Something went wrong. Please try again.';
  }

  // ─── Image ────────────────────────────────────────────────────────────────

  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxWidth: 1280,
        maxHeight: 1280,
      );
      if (pickedFile == null) return;

      final file = File(pickedFile.path);

      // Validate file size (max 10MB for incident photos)
      final fileSize = await file.length();
      if (fileSize > 10 * 1024 * 1024) {
        state = state.copyWith(
          errorMessage: 'Image file too large. Maximum size is 10MB.',
        );
        return;
      }

      state = state.copyWith(selectedImage: file); // show preview immediately

      // compress in background while user fills out the form
      final bytes = await FlutterImageCompress.compressWithList(
        await file.readAsBytes(),
        quality: 40,
        minWidth: 800,
        minHeight: 800,
      );
      state = state.copyWith(compressedImageBytes: Uint8List.fromList(bytes));
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Failed to capture photo. Please try again.',
      );
    }
  }

  void removeImage() => state = state.copyWith(selectedImage: null);

  void setRescuerSelection(String? rescuer) =>
      state = state.copyWith(rescuerSelection: rescuer);

  // ─── Field setters ────────────────────────────────────────────────────────

  void setIncidentType(String type) =>
      state = state.copyWith(incidentType: type);

  void setDetails(String details) => state = state.copyWith(details: details);

  void clearError() => state = state.copyWith(errorMessage: null);

  // ─── Reset ────────────────────────────────────────────────────────────────

  Future<void> refreshForm() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    await Future<void>.delayed(const Duration(seconds: 2));
    _clearForm();
  }

  void resetSubmission() => _clearForm();

  void _clearForm() {
    state = state.copyWith(
      isLoading: false,
      isSubmitted: false,
      limitReached: false, // ✅ reset
      incidentType: '',
      details: '',
      selectedImage: null,
      rescuerSelection: null,
      errorMessage: null,
    );
  }
}
