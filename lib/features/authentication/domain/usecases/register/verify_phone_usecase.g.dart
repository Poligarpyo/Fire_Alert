// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_phone_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(verifyPhoneUsecase)
const verifyPhoneUsecaseProvider = VerifyPhoneUsecaseProvider._();

final class VerifyPhoneUsecaseProvider
    extends
        $FunctionalProvider<
          VerifyPhoneUsecase,
          VerifyPhoneUsecase,
          VerifyPhoneUsecase
        >
    with $Provider<VerifyPhoneUsecase> {
  const VerifyPhoneUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyPhoneUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyPhoneUsecaseHash();

  @$internal
  @override
  $ProviderElement<VerifyPhoneUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  VerifyPhoneUsecase create(Ref ref) {
    return verifyPhoneUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VerifyPhoneUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VerifyPhoneUsecase>(value),
    );
  }
}

String _$verifyPhoneUsecaseHash() =>
    r'795a1c596046cd56fe68f8b98ead22bc8814c6c0';
