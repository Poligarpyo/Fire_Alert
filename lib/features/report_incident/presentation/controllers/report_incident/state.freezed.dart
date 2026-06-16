// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportIncidentState {

 bool get isLoading; String get incidentType; String get details; File? get selectedImage; double? get latitude; double? get longitude; String? get errorMessage; String? get selectedCategory; String? get rescuerSelection; bool get isSubmitted; Uint8List? get compressedImageBytes; bool get limitReached;
/// Create a copy of ReportIncidentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportIncidentStateCopyWith<ReportIncidentState> get copyWith => _$ReportIncidentStateCopyWithImpl<ReportIncidentState>(this as ReportIncidentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportIncidentState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.incidentType, incidentType) || other.incidentType == incidentType)&&(identical(other.details, details) || other.details == details)&&(identical(other.selectedImage, selectedImage) || other.selectedImage == selectedImage)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.rescuerSelection, rescuerSelection) || other.rescuerSelection == rescuerSelection)&&(identical(other.isSubmitted, isSubmitted) || other.isSubmitted == isSubmitted)&&const DeepCollectionEquality().equals(other.compressedImageBytes, compressedImageBytes)&&(identical(other.limitReached, limitReached) || other.limitReached == limitReached));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,incidentType,details,selectedImage,latitude,longitude,errorMessage,selectedCategory,rescuerSelection,isSubmitted,const DeepCollectionEquality().hash(compressedImageBytes),limitReached);

@override
String toString() {
  return 'ReportIncidentState(isLoading: $isLoading, incidentType: $incidentType, details: $details, selectedImage: $selectedImage, latitude: $latitude, longitude: $longitude, errorMessage: $errorMessage, selectedCategory: $selectedCategory, rescuerSelection: $rescuerSelection, isSubmitted: $isSubmitted, compressedImageBytes: $compressedImageBytes, limitReached: $limitReached)';
}


}

/// @nodoc
abstract mixin class $ReportIncidentStateCopyWith<$Res>  {
  factory $ReportIncidentStateCopyWith(ReportIncidentState value, $Res Function(ReportIncidentState) _then) = _$ReportIncidentStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String incidentType, String details, File? selectedImage, double? latitude, double? longitude, String? errorMessage, String? selectedCategory, String? rescuerSelection, bool isSubmitted, Uint8List? compressedImageBytes, bool limitReached
});




}
/// @nodoc
class _$ReportIncidentStateCopyWithImpl<$Res>
    implements $ReportIncidentStateCopyWith<$Res> {
  _$ReportIncidentStateCopyWithImpl(this._self, this._then);

  final ReportIncidentState _self;
  final $Res Function(ReportIncidentState) _then;

/// Create a copy of ReportIncidentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? incidentType = null,Object? details = null,Object? selectedImage = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? errorMessage = freezed,Object? selectedCategory = freezed,Object? rescuerSelection = freezed,Object? isSubmitted = null,Object? compressedImageBytes = freezed,Object? limitReached = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,incidentType: null == incidentType ? _self.incidentType : incidentType // ignore: cast_nullable_to_non_nullable
as String,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,selectedImage: freezed == selectedImage ? _self.selectedImage : selectedImage // ignore: cast_nullable_to_non_nullable
as File?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String?,rescuerSelection: freezed == rescuerSelection ? _self.rescuerSelection : rescuerSelection // ignore: cast_nullable_to_non_nullable
as String?,isSubmitted: null == isSubmitted ? _self.isSubmitted : isSubmitted // ignore: cast_nullable_to_non_nullable
as bool,compressedImageBytes: freezed == compressedImageBytes ? _self.compressedImageBytes : compressedImageBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,limitReached: null == limitReached ? _self.limitReached : limitReached // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportIncidentState].
extension ReportIncidentStatePatterns on ReportIncidentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportIncidentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportIncidentState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportIncidentState value)  $default,){
final _that = this;
switch (_that) {
case _ReportIncidentState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportIncidentState value)?  $default,){
final _that = this;
switch (_that) {
case _ReportIncidentState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  String incidentType,  String details,  File? selectedImage,  double? latitude,  double? longitude,  String? errorMessage,  String? selectedCategory,  String? rescuerSelection,  bool isSubmitted,  Uint8List? compressedImageBytes,  bool limitReached)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportIncidentState() when $default != null:
return $default(_that.isLoading,_that.incidentType,_that.details,_that.selectedImage,_that.latitude,_that.longitude,_that.errorMessage,_that.selectedCategory,_that.rescuerSelection,_that.isSubmitted,_that.compressedImageBytes,_that.limitReached);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  String incidentType,  String details,  File? selectedImage,  double? latitude,  double? longitude,  String? errorMessage,  String? selectedCategory,  String? rescuerSelection,  bool isSubmitted,  Uint8List? compressedImageBytes,  bool limitReached)  $default,) {final _that = this;
switch (_that) {
case _ReportIncidentState():
return $default(_that.isLoading,_that.incidentType,_that.details,_that.selectedImage,_that.latitude,_that.longitude,_that.errorMessage,_that.selectedCategory,_that.rescuerSelection,_that.isSubmitted,_that.compressedImageBytes,_that.limitReached);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  String incidentType,  String details,  File? selectedImage,  double? latitude,  double? longitude,  String? errorMessage,  String? selectedCategory,  String? rescuerSelection,  bool isSubmitted,  Uint8List? compressedImageBytes,  bool limitReached)?  $default,) {final _that = this;
switch (_that) {
case _ReportIncidentState() when $default != null:
return $default(_that.isLoading,_that.incidentType,_that.details,_that.selectedImage,_that.latitude,_that.longitude,_that.errorMessage,_that.selectedCategory,_that.rescuerSelection,_that.isSubmitted,_that.compressedImageBytes,_that.limitReached);case _:
  return null;

}
}

}

/// @nodoc


class _ReportIncidentState implements ReportIncidentState {
  const _ReportIncidentState({this.isLoading = false, this.incidentType = '', this.details = '', this.selectedImage, this.latitude, this.longitude, this.errorMessage, this.selectedCategory, this.rescuerSelection, this.isSubmitted = false, this.compressedImageBytes, this.limitReached = false});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  String incidentType;
@override@JsonKey() final  String details;
@override final  File? selectedImage;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? errorMessage;
@override final  String? selectedCategory;
@override final  String? rescuerSelection;
@override@JsonKey() final  bool isSubmitted;
@override final  Uint8List? compressedImageBytes;
@override@JsonKey() final  bool limitReached;

/// Create a copy of ReportIncidentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportIncidentStateCopyWith<_ReportIncidentState> get copyWith => __$ReportIncidentStateCopyWithImpl<_ReportIncidentState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportIncidentState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.incidentType, incidentType) || other.incidentType == incidentType)&&(identical(other.details, details) || other.details == details)&&(identical(other.selectedImage, selectedImage) || other.selectedImage == selectedImage)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.rescuerSelection, rescuerSelection) || other.rescuerSelection == rescuerSelection)&&(identical(other.isSubmitted, isSubmitted) || other.isSubmitted == isSubmitted)&&const DeepCollectionEquality().equals(other.compressedImageBytes, compressedImageBytes)&&(identical(other.limitReached, limitReached) || other.limitReached == limitReached));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,incidentType,details,selectedImage,latitude,longitude,errorMessage,selectedCategory,rescuerSelection,isSubmitted,const DeepCollectionEquality().hash(compressedImageBytes),limitReached);

@override
String toString() {
  return 'ReportIncidentState(isLoading: $isLoading, incidentType: $incidentType, details: $details, selectedImage: $selectedImage, latitude: $latitude, longitude: $longitude, errorMessage: $errorMessage, selectedCategory: $selectedCategory, rescuerSelection: $rescuerSelection, isSubmitted: $isSubmitted, compressedImageBytes: $compressedImageBytes, limitReached: $limitReached)';
}


}

/// @nodoc
abstract mixin class _$ReportIncidentStateCopyWith<$Res> implements $ReportIncidentStateCopyWith<$Res> {
  factory _$ReportIncidentStateCopyWith(_ReportIncidentState value, $Res Function(_ReportIncidentState) _then) = __$ReportIncidentStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, String incidentType, String details, File? selectedImage, double? latitude, double? longitude, String? errorMessage, String? selectedCategory, String? rescuerSelection, bool isSubmitted, Uint8List? compressedImageBytes, bool limitReached
});




}
/// @nodoc
class __$ReportIncidentStateCopyWithImpl<$Res>
    implements _$ReportIncidentStateCopyWith<$Res> {
  __$ReportIncidentStateCopyWithImpl(this._self, this._then);

  final _ReportIncidentState _self;
  final $Res Function(_ReportIncidentState) _then;

/// Create a copy of ReportIncidentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? incidentType = null,Object? details = null,Object? selectedImage = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? errorMessage = freezed,Object? selectedCategory = freezed,Object? rescuerSelection = freezed,Object? isSubmitted = null,Object? compressedImageBytes = freezed,Object? limitReached = null,}) {
  return _then(_ReportIncidentState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,incidentType: null == incidentType ? _self.incidentType : incidentType // ignore: cast_nullable_to_non_nullable
as String,details: null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String,selectedImage: freezed == selectedImage ? _self.selectedImage : selectedImage // ignore: cast_nullable_to_non_nullable
as File?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String?,rescuerSelection: freezed == rescuerSelection ? _self.rescuerSelection : rescuerSelection // ignore: cast_nullable_to_non_nullable
as String?,isSubmitted: null == isSubmitted ? _self.isSubmitted : isSubmitted // ignore: cast_nullable_to_non_nullable
as bool,compressedImageBytes: freezed == compressedImageBytes ? _self.compressedImageBytes : compressedImageBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,limitReached: null == limitReached ? _self.limitReached : limitReached // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
