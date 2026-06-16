// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisterFormState {

 String get name; String get phone; String get address; String get password; String get confirmPassword; String? get nameError; String? get phoneError; String? get addressError; String? get passwordError; String? get confirmPasswordError; bool get obscurePassword; bool get obscureConfirmPassword; bool get acceptedTerms; bool get isSubmitting;
/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterFormStateCopyWith<RegisterFormState> get copyWith => _$RegisterFormStateCopyWithImpl<RegisterFormState>(this as RegisterFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterFormState&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.nameError, nameError) || other.nameError == nameError)&&(identical(other.phoneError, phoneError) || other.phoneError == phoneError)&&(identical(other.addressError, addressError) || other.addressError == addressError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.confirmPasswordError, confirmPasswordError) || other.confirmPasswordError == confirmPasswordError)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword)&&(identical(other.obscureConfirmPassword, obscureConfirmPassword) || other.obscureConfirmPassword == obscureConfirmPassword)&&(identical(other.acceptedTerms, acceptedTerms) || other.acceptedTerms == acceptedTerms)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,name,phone,address,password,confirmPassword,nameError,phoneError,addressError,passwordError,confirmPasswordError,obscurePassword,obscureConfirmPassword,acceptedTerms,isSubmitting);

@override
String toString() {
  return 'RegisterFormState(name: $name, phone: $phone, address: $address, password: $password, confirmPassword: $confirmPassword, nameError: $nameError, phoneError: $phoneError, addressError: $addressError, passwordError: $passwordError, confirmPasswordError: $confirmPasswordError, obscurePassword: $obscurePassword, obscureConfirmPassword: $obscureConfirmPassword, acceptedTerms: $acceptedTerms, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class $RegisterFormStateCopyWith<$Res>  {
  factory $RegisterFormStateCopyWith(RegisterFormState value, $Res Function(RegisterFormState) _then) = _$RegisterFormStateCopyWithImpl;
@useResult
$Res call({
 String name, String phone, String address, String password, String confirmPassword, String? nameError, String? phoneError, String? addressError, String? passwordError, String? confirmPasswordError, bool obscurePassword, bool obscureConfirmPassword, bool acceptedTerms, bool isSubmitting
});




}
/// @nodoc
class _$RegisterFormStateCopyWithImpl<$Res>
    implements $RegisterFormStateCopyWith<$Res> {
  _$RegisterFormStateCopyWithImpl(this._self, this._then);

  final RegisterFormState _self;
  final $Res Function(RegisterFormState) _then;

/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? phone = null,Object? address = null,Object? password = null,Object? confirmPassword = null,Object? nameError = freezed,Object? phoneError = freezed,Object? addressError = freezed,Object? passwordError = freezed,Object? confirmPasswordError = freezed,Object? obscurePassword = null,Object? obscureConfirmPassword = null,Object? acceptedTerms = null,Object? isSubmitting = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,nameError: freezed == nameError ? _self.nameError : nameError // ignore: cast_nullable_to_non_nullable
as String?,phoneError: freezed == phoneError ? _self.phoneError : phoneError // ignore: cast_nullable_to_non_nullable
as String?,addressError: freezed == addressError ? _self.addressError : addressError // ignore: cast_nullable_to_non_nullable
as String?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,confirmPasswordError: freezed == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as String?,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,obscureConfirmPassword: null == obscureConfirmPassword ? _self.obscureConfirmPassword : obscureConfirmPassword // ignore: cast_nullable_to_non_nullable
as bool,acceptedTerms: null == acceptedTerms ? _self.acceptedTerms : acceptedTerms // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterFormState].
extension RegisterFormStatePatterns on RegisterFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterFormState value)  $default,){
final _that = this;
switch (_that) {
case _RegisterFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterFormState value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String phone,  String address,  String password,  String confirmPassword,  String? nameError,  String? phoneError,  String? addressError,  String? passwordError,  String? confirmPasswordError,  bool obscurePassword,  bool obscureConfirmPassword,  bool acceptedTerms,  bool isSubmitting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterFormState() when $default != null:
return $default(_that.name,_that.phone,_that.address,_that.password,_that.confirmPassword,_that.nameError,_that.phoneError,_that.addressError,_that.passwordError,_that.confirmPasswordError,_that.obscurePassword,_that.obscureConfirmPassword,_that.acceptedTerms,_that.isSubmitting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String phone,  String address,  String password,  String confirmPassword,  String? nameError,  String? phoneError,  String? addressError,  String? passwordError,  String? confirmPasswordError,  bool obscurePassword,  bool obscureConfirmPassword,  bool acceptedTerms,  bool isSubmitting)  $default,) {final _that = this;
switch (_that) {
case _RegisterFormState():
return $default(_that.name,_that.phone,_that.address,_that.password,_that.confirmPassword,_that.nameError,_that.phoneError,_that.addressError,_that.passwordError,_that.confirmPasswordError,_that.obscurePassword,_that.obscureConfirmPassword,_that.acceptedTerms,_that.isSubmitting);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String phone,  String address,  String password,  String confirmPassword,  String? nameError,  String? phoneError,  String? addressError,  String? passwordError,  String? confirmPasswordError,  bool obscurePassword,  bool obscureConfirmPassword,  bool acceptedTerms,  bool isSubmitting)?  $default,) {final _that = this;
switch (_that) {
case _RegisterFormState() when $default != null:
return $default(_that.name,_that.phone,_that.address,_that.password,_that.confirmPassword,_that.nameError,_that.phoneError,_that.addressError,_that.passwordError,_that.confirmPasswordError,_that.obscurePassword,_that.obscureConfirmPassword,_that.acceptedTerms,_that.isSubmitting);case _:
  return null;

}
}

}

/// @nodoc


class _RegisterFormState implements RegisterFormState {
  const _RegisterFormState({this.name = '', this.phone = '', this.address = '', this.password = '', this.confirmPassword = '', this.nameError, this.phoneError, this.addressError, this.passwordError, this.confirmPasswordError, this.obscurePassword = true, this.obscureConfirmPassword = true, this.acceptedTerms = false, this.isSubmitting = false});
  

@override@JsonKey() final  String name;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String address;
@override@JsonKey() final  String password;
@override@JsonKey() final  String confirmPassword;
@override final  String? nameError;
@override final  String? phoneError;
@override final  String? addressError;
@override final  String? passwordError;
@override final  String? confirmPasswordError;
@override@JsonKey() final  bool obscurePassword;
@override@JsonKey() final  bool obscureConfirmPassword;
@override@JsonKey() final  bool acceptedTerms;
@override@JsonKey() final  bool isSubmitting;

/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterFormStateCopyWith<_RegisterFormState> get copyWith => __$RegisterFormStateCopyWithImpl<_RegisterFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterFormState&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.nameError, nameError) || other.nameError == nameError)&&(identical(other.phoneError, phoneError) || other.phoneError == phoneError)&&(identical(other.addressError, addressError) || other.addressError == addressError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.confirmPasswordError, confirmPasswordError) || other.confirmPasswordError == confirmPasswordError)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword)&&(identical(other.obscureConfirmPassword, obscureConfirmPassword) || other.obscureConfirmPassword == obscureConfirmPassword)&&(identical(other.acceptedTerms, acceptedTerms) || other.acceptedTerms == acceptedTerms)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,name,phone,address,password,confirmPassword,nameError,phoneError,addressError,passwordError,confirmPasswordError,obscurePassword,obscureConfirmPassword,acceptedTerms,isSubmitting);

@override
String toString() {
  return 'RegisterFormState(name: $name, phone: $phone, address: $address, password: $password, confirmPassword: $confirmPassword, nameError: $nameError, phoneError: $phoneError, addressError: $addressError, passwordError: $passwordError, confirmPasswordError: $confirmPasswordError, obscurePassword: $obscurePassword, obscureConfirmPassword: $obscureConfirmPassword, acceptedTerms: $acceptedTerms, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class _$RegisterFormStateCopyWith<$Res> implements $RegisterFormStateCopyWith<$Res> {
  factory _$RegisterFormStateCopyWith(_RegisterFormState value, $Res Function(_RegisterFormState) _then) = __$RegisterFormStateCopyWithImpl;
@override @useResult
$Res call({
 String name, String phone, String address, String password, String confirmPassword, String? nameError, String? phoneError, String? addressError, String? passwordError, String? confirmPasswordError, bool obscurePassword, bool obscureConfirmPassword, bool acceptedTerms, bool isSubmitting
});




}
/// @nodoc
class __$RegisterFormStateCopyWithImpl<$Res>
    implements _$RegisterFormStateCopyWith<$Res> {
  __$RegisterFormStateCopyWithImpl(this._self, this._then);

  final _RegisterFormState _self;
  final $Res Function(_RegisterFormState) _then;

/// Create a copy of RegisterFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? phone = null,Object? address = null,Object? password = null,Object? confirmPassword = null,Object? nameError = freezed,Object? phoneError = freezed,Object? addressError = freezed,Object? passwordError = freezed,Object? confirmPasswordError = freezed,Object? obscurePassword = null,Object? obscureConfirmPassword = null,Object? acceptedTerms = null,Object? isSubmitting = null,}) {
  return _then(_RegisterFormState(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,nameError: freezed == nameError ? _self.nameError : nameError // ignore: cast_nullable_to_non_nullable
as String?,phoneError: freezed == phoneError ? _self.phoneError : phoneError // ignore: cast_nullable_to_non_nullable
as String?,addressError: freezed == addressError ? _self.addressError : addressError // ignore: cast_nullable_to_non_nullable
as String?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,confirmPasswordError: freezed == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as String?,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,obscureConfirmPassword: null == obscureConfirmPassword ? _self.obscureConfirmPassword : obscureConfirmPassword // ignore: cast_nullable_to_non_nullable
as bool,acceptedTerms: null == acceptedTerms ? _self.acceptedTerms : acceptedTerms // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
