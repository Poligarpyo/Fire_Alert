import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../domain/usecase/get_profile_usecase.dart';
import 'profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  final GetProfileUsecase _usecase;

  ProfileNotifier(this._usecase) : super(const ProfileState.initial());

  Future<void> fetchProfile() async {
    state = const ProfileState.loading();

    final result = await _usecase();
    result.when(
      success: (profile) => state = ProfileState.loaded(profile: profile),
      failure: (error) {
        String errorMessage = _mapError(error.message);
        state = ProfileState.error(message: errorMessage);
      },
    );
  }

  String _mapError(String rawError) {
    if (rawError.contains('network') || rawError.contains('SocketException')) {
      return 'Network error. Please check your internet connection.';
    }
    if (rawError.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    if (rawError.contains('unauthorized') || rawError.contains('401')) {
      return 'Session expired. Please login again.';
    }
    if (rawError.contains('not-found') || rawError.contains('404')) {
      return 'Profile not found. Please contact support.';
    }
    if (rawError.contains('permission-denied') || rawError.contains('403')) {
      return 'Permission denied. Please contact support.';
    }
    // Return original error if no specific mapping found
    if (rawError.startsWith('Exception: ')) {
      return rawError.substring(11);
    }
    return rawError;
  }
}
