// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phone_auth_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhoneAuthRequest {

 String get phoneNumber; String? get verificationId; String? get smsCode;
/// Create a copy of PhoneAuthRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneAuthRequestCopyWith<PhoneAuthRequest> get copyWith => _$PhoneAuthRequestCopyWithImpl<PhoneAuthRequest>(this as PhoneAuthRequest, _$identity);

  /// Serializes this PhoneAuthRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneAuthRequest&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.verificationId, verificationId) || other.verificationId == verificationId)&&(identical(other.smsCode, smsCode) || other.smsCode == smsCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,verificationId,smsCode);

@override
String toString() {
  return 'PhoneAuthRequest(phoneNumber: $phoneNumber, verificationId: $verificationId, smsCode: $smsCode)';
}


}

/// @nodoc
abstract mixin class $PhoneAuthRequestCopyWith<$Res>  {
  factory $PhoneAuthRequestCopyWith(PhoneAuthRequest value, $Res Function(PhoneAuthRequest) _then) = _$PhoneAuthRequestCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, String? verificationId, String? smsCode
});




}
/// @nodoc
class _$PhoneAuthRequestCopyWithImpl<$Res>
    implements $PhoneAuthRequestCopyWith<$Res> {
  _$PhoneAuthRequestCopyWithImpl(this._self, this._then);

  final PhoneAuthRequest _self;
  final $Res Function(PhoneAuthRequest) _then;

/// Create a copy of PhoneAuthRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? verificationId = freezed,Object? smsCode = freezed,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,verificationId: freezed == verificationId ? _self.verificationId : verificationId // ignore: cast_nullable_to_non_nullable
as String?,smsCode: freezed == smsCode ? _self.smsCode : smsCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneAuthRequest].
extension PhoneAuthRequestPatterns on PhoneAuthRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneAuthRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneAuthRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneAuthRequest value)  $default,){
final _that = this;
switch (_that) {
case _PhoneAuthRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneAuthRequest value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneAuthRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phoneNumber,  String? verificationId,  String? smsCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneAuthRequest() when $default != null:
return $default(_that.phoneNumber,_that.verificationId,_that.smsCode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phoneNumber,  String? verificationId,  String? smsCode)  $default,) {final _that = this;
switch (_that) {
case _PhoneAuthRequest():
return $default(_that.phoneNumber,_that.verificationId,_that.smsCode);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phoneNumber,  String? verificationId,  String? smsCode)?  $default,) {final _that = this;
switch (_that) {
case _PhoneAuthRequest() when $default != null:
return $default(_that.phoneNumber,_that.verificationId,_that.smsCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneAuthRequest implements PhoneAuthRequest {
  const _PhoneAuthRequest({required this.phoneNumber, this.verificationId, this.smsCode});
  factory _PhoneAuthRequest.fromJson(Map<String, dynamic> json) => _$PhoneAuthRequestFromJson(json);

@override final  String phoneNumber;
@override final  String? verificationId;
@override final  String? smsCode;

/// Create a copy of PhoneAuthRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneAuthRequestCopyWith<_PhoneAuthRequest> get copyWith => __$PhoneAuthRequestCopyWithImpl<_PhoneAuthRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhoneAuthRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneAuthRequest&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.verificationId, verificationId) || other.verificationId == verificationId)&&(identical(other.smsCode, smsCode) || other.smsCode == smsCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,verificationId,smsCode);

@override
String toString() {
  return 'PhoneAuthRequest(phoneNumber: $phoneNumber, verificationId: $verificationId, smsCode: $smsCode)';
}


}

/// @nodoc
abstract mixin class _$PhoneAuthRequestCopyWith<$Res> implements $PhoneAuthRequestCopyWith<$Res> {
  factory _$PhoneAuthRequestCopyWith(_PhoneAuthRequest value, $Res Function(_PhoneAuthRequest) _then) = __$PhoneAuthRequestCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, String? verificationId, String? smsCode
});




}
/// @nodoc
class __$PhoneAuthRequestCopyWithImpl<$Res>
    implements _$PhoneAuthRequestCopyWith<$Res> {
  __$PhoneAuthRequestCopyWithImpl(this._self, this._then);

  final _PhoneAuthRequest _self;
  final $Res Function(_PhoneAuthRequest) _then;

/// Create a copy of PhoneAuthRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? verificationId = freezed,Object? smsCode = freezed,}) {
  return _then(_PhoneAuthRequest(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,verificationId: freezed == verificationId ? _self.verificationId : verificationId // ignore: cast_nullable_to_non_nullable
as String?,smsCode: freezed == smsCode ? _self.smsCode : smsCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
