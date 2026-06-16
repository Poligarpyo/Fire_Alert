// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ResetPasswordController)
const resetPasswordControllerProvider = ResetPasswordControllerProvider._();

final class ResetPasswordControllerProvider
    extends $NotifierProvider<ResetPasswordController, ResetPasswordUiModel> {
  const ResetPasswordControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetPasswordControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetPasswordControllerHash();

  @$internal
  @override
  ResetPasswordController create() => ResetPasswordController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResetPasswordUiModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResetPasswordUiModel>(value),
    );
  }
}

String _$resetPasswordControllerHash() =>
    r'ea49854ac5f78858ce14f278977313acb13f20be';

abstract class _$ResetPasswordController
    extends $Notifier<ResetPasswordUiModel> {
  ResetPasswordUiModel build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ResetPasswordUiModel, ResetPasswordUiModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ResetPasswordUiModel, ResetPasswordUiModel>,
              ResetPasswordUiModel,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
