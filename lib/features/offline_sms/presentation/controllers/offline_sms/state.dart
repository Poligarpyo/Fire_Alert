import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
abstract class OfflineSmsState with _$OfflineSmsState {
  const factory OfflineSmsState({
    @Default(false) bool isLoading,
    @Default(false) bool success,
    @Default('') String message,
    @Default('') String phone,
    @Default(160) int maxCharacters,
    String? error,
    @Default(false) bool shouldCloseDialog,
    @Default(false) bool hasPendingSync,
    @Default(0) int syncedCount, // ← DAGDAG — ilan ang na-sync
  }) = _OfflineSmsState;

  factory OfflineSmsState.initial() => const OfflineSmsState();
}
