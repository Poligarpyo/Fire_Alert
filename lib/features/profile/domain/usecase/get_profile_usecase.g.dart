// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getProfileUsecase)
const getProfileUsecaseProvider = GetProfileUsecaseProvider._();

final class GetProfileUsecaseProvider
    extends
        $FunctionalProvider<
          GetProfileUsecase,
          GetProfileUsecase,
          GetProfileUsecase
        >
    with $Provider<GetProfileUsecase> {
  const GetProfileUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getProfileUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getProfileUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetProfileUsecase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetProfileUsecase create(Ref ref) {
    return getProfileUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetProfileUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetProfileUsecase>(value),
    );
  }
}

String _$getProfileUsecaseHash() => r'd4170a5e0026acc7e21f4a473d8be893a11fa8ca';
