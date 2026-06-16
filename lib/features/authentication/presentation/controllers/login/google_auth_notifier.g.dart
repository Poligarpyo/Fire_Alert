// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_auth_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GoogleAuthNotifier)
const googleAuthProvider = GoogleAuthNotifierProvider._();

final class GoogleAuthNotifierProvider
    extends $NotifierProvider<GoogleAuthNotifier, GoogleAuthState> {
  const GoogleAuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleAuthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleAuthNotifierHash();

  @$internal
  @override
  GoogleAuthNotifier create() => GoogleAuthNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleAuthState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleAuthState>(value),
    );
  }
}

String _$googleAuthNotifierHash() =>
    r'8517c5cf008091e43be77c760b93805d18b3d2ed';

abstract class _$GoogleAuthNotifier extends $Notifier<GoogleAuthState> {
  GoogleAuthState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<GoogleAuthState, GoogleAuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GoogleAuthState, GoogleAuthState>,
              GoogleAuthState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
