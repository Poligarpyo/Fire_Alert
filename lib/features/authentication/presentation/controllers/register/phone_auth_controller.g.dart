// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PhoneAuthController)
const phoneAuthControllerProvider = PhoneAuthControllerProvider._();

final class PhoneAuthControllerProvider
    extends $NotifierProvider<PhoneAuthController, PhoneAuthState> {
  const PhoneAuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneAuthControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$phoneAuthControllerHash();

  @$internal
  @override
  PhoneAuthController create() => PhoneAuthController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhoneAuthState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhoneAuthState>(value),
    );
  }
}

String _$phoneAuthControllerHash() =>
    r'df0b2afa8fdc46e3d15af220a9e6552ce0711a60';

abstract class _$PhoneAuthController extends $Notifier<PhoneAuthState> {
  PhoneAuthState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PhoneAuthState, PhoneAuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PhoneAuthState, PhoneAuthState>,
              PhoneAuthState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
