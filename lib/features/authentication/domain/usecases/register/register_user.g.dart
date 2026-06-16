// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(registerUserUseCase)
const registerUserUseCaseProvider = RegisterUserUseCaseProvider._();

final class RegisterUserUseCaseProvider
    extends
        $FunctionalProvider<
          RegisterUserUseCase,
          RegisterUserUseCase,
          RegisterUserUseCase
        >
    with $Provider<RegisterUserUseCase> {
  const RegisterUserUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerUserUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerUserUseCaseHash();

  @$internal
  @override
  $ProviderElement<RegisterUserUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RegisterUserUseCase create(Ref ref) {
    return registerUserUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegisterUserUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegisterUserUseCase>(value),
    );
  }
}

String _$registerUserUseCaseHash() =>
    r'f41bfdd6421c1d65d4a1ea30177a27f97cadacc5';
