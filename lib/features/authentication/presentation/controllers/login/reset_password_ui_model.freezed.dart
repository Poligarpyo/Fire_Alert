// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_ui_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResetPasswordUiModel {

 bool get isLoading; String? get successMessage; String? get errorMessage;
/// Create a copy of ResetPasswordUiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordUiModelCopyWith<ResetPasswordUiModel> get copyWith => _$ResetPasswordUiModelCopyWithImpl<ResetPasswordUiModel>(this as ResetPasswordUiModel, _$identity);

  /// Serializes this ResetPasswordUiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordUiModel&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,successMessage,errorMessage);

@override
String toString() {
  return 'ResetPasswordUiModel(isLoading: $isLoading, successMessage: $successMessage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordUiModelCopyWith<$Res>  {
  factory $ResetPasswordUiModelCopyWith(ResetPasswordUiModel value, $Res Function(ResetPasswordUiModel) _then) = _$ResetPasswordUiModelCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String? successMessage, String? errorMessage
});




}
/// @nodoc
class _$ResetPasswordUiModelCopyWithImpl<$Res>
    implements $ResetPasswordUiModelCopyWith<$Res> {
  _$ResetPasswordUiModelCopyWithImpl(this._self, this._then);

  final ResetPasswordUiModel _self;
  final $Res Function(ResetPasswordUiModel) _then;

/// Create a copy of ResetPasswordUiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? successMessage = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ResetPasswordUiModel].
extension ResetPasswordUiModelPatterns on ResetPasswordUiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResetPasswordUiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResetPasswordUiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResetPasswordUiModel value)  $default,){
final _that = this;
switch (_that) {
case _ResetPasswordUiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResetPasswordUiModel value)?  $default,){
final _that = this;
switch (_that) {
case _ResetPasswordUiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  String? successMessage,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResetPasswordUiModel() when $default != null:
return $default(_that.isLoading,_that.successMessage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  String? successMessage,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ResetPasswordUiModel():
return $default(_that.isLoading,_that.successMessage,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  String? successMessage,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ResetPasswordUiModel() when $default != null:
return $default(_that.isLoading,_that.successMessage,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResetPasswordUiModel implements ResetPasswordUiModel {
  const _ResetPasswordUiModel({this.isLoading = false, this.successMessage, this.errorMessage});
  factory _ResetPasswordUiModel.fromJson(Map<String, dynamic> json) => _$ResetPasswordUiModelFromJson(json);

@override@JsonKey() final  bool isLoading;
@override final  String? successMessage;
@override final  String? errorMessage;

/// Create a copy of ResetPasswordUiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResetPasswordUiModelCopyWith<_ResetPasswordUiModel> get copyWith => __$ResetPasswordUiModelCopyWithImpl<_ResetPasswordUiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResetPasswordUiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResetPasswordUiModel&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,successMessage,errorMessage);

@override
String toString() {
  return 'ResetPasswordUiModel(isLoading: $isLoading, successMessage: $successMessage, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ResetPasswordUiModelCopyWith<$Res> implements $ResetPasswordUiModelCopyWith<$Res> {
  factory _$ResetPasswordUiModelCopyWith(_ResetPasswordUiModel value, $Res Function(_ResetPasswordUiModel) _then) = __$ResetPasswordUiModelCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, String? successMessage, String? errorMessage
});




}
/// @nodoc
class __$ResetPasswordUiModelCopyWithImpl<$Res>
    implements _$ResetPasswordUiModelCopyWith<$Res> {
  __$ResetPasswordUiModelCopyWithImpl(this._self, this._then);

  final _ResetPasswordUiModel _self;
  final $Res Function(_ResetPasswordUiModel) _then;

/// Create a copy of ResetPasswordUiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? successMessage = freezed,Object? errorMessage = freezed,}) {
  return _then(_ResetPasswordUiModel(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
