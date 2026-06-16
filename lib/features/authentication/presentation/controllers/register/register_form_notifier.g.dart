// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_form_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RegisterFormNotifier)
const registerFormProvider = RegisterFormNotifierProvider._();

final class RegisterFormNotifierProvider
    extends $NotifierProvider<RegisterFormNotifier, RegisterFormState> {
  const RegisterFormNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerFormNotifierHash();

  @$internal
  @override
  RegisterFormNotifier create() => RegisterFormNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegisterFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegisterFormState>(value),
    );
  }
}

String _$registerFormNotifierHash() =>
    r'7cb60118fd70de561e81e3282b9869913136b679';

abstract class _$RegisterFormNotifier extends $Notifier<RegisterFormState> {
  RegisterFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<RegisterFormState, RegisterFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RegisterFormState, RegisterFormState>,
              RegisterFormState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
