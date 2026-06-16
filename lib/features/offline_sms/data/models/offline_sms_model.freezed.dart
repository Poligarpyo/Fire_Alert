// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offline_sms_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OfflineSmsModel {

 String get id; String get message;@JsonKey(name: 'phone_number') String get phoneNumber; double get latitude; double get longitude; bool get sentViaSms; int get syncStatus;@_TimestampConverter() DateTime? get createdAt;// ← fixes Timestamp crash
 String? get localIpAddress; String? get deviceId;
/// Create a copy of OfflineSmsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfflineSmsModelCopyWith<OfflineSmsModel> get copyWith => _$OfflineSmsModelCopyWithImpl<OfflineSmsModel>(this as OfflineSmsModel, _$identity);

  /// Serializes this OfflineSmsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfflineSmsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.message, message) || other.message == message)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.sentViaSms, sentViaSms) || other.sentViaSms == sentViaSms)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.localIpAddress, localIpAddress) || other.localIpAddress == localIpAddress)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,message,phoneNumber,latitude,longitude,sentViaSms,syncStatus,createdAt,localIpAddress,deviceId);

@override
String toString() {
  return 'OfflineSmsModel(id: $id, message: $message, phoneNumber: $phoneNumber, latitude: $latitude, longitude: $longitude, sentViaSms: $sentViaSms, syncStatus: $syncStatus, createdAt: $createdAt, localIpAddress: $localIpAddress, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class $OfflineSmsModelCopyWith<$Res>  {
  factory $OfflineSmsModelCopyWith(OfflineSmsModel value, $Res Function(OfflineSmsModel) _then) = _$OfflineSmsModelCopyWithImpl;
@useResult
$Res call({
 String id, String message,@JsonKey(name: 'phone_number') String phoneNumber, double latitude, double longitude, bool sentViaSms, int syncStatus,@_TimestampConverter() DateTime? createdAt, String? localIpAddress, String? deviceId
});




}
/// @nodoc
class _$OfflineSmsModelCopyWithImpl<$Res>
    implements $OfflineSmsModelCopyWith<$Res> {
  _$OfflineSmsModelCopyWithImpl(this._self, this._then);

  final OfflineSmsModel _self;
  final $Res Function(OfflineSmsModel) _then;

/// Create a copy of OfflineSmsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? message = null,Object? phoneNumber = null,Object? latitude = null,Object? longitude = null,Object? sentViaSms = null,Object? syncStatus = null,Object? createdAt = freezed,Object? localIpAddress = freezed,Object? deviceId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,sentViaSms: null == sentViaSms ? _self.sentViaSms : sentViaSms // ignore: cast_nullable_to_non_nullable
as bool,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,localIpAddress: freezed == localIpAddress ? _self.localIpAddress : localIpAddress // ignore: cast_nullable_to_non_nullable
as String?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OfflineSmsModel].
extension OfflineSmsModelPatterns on OfflineSmsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OfflineSmsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OfflineSmsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OfflineSmsModel value)  $default,){
final _that = this;
switch (_that) {
case _OfflineSmsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OfflineSmsModel value)?  $default,){
final _that = this;
switch (_that) {
case _OfflineSmsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String message, @JsonKey(name: 'phone_number')  String phoneNumber,  double latitude,  double longitude,  bool sentViaSms,  int syncStatus, @_TimestampConverter()  DateTime? createdAt,  String? localIpAddress,  String? deviceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OfflineSmsModel() when $default != null:
return $default(_that.id,_that.message,_that.phoneNumber,_that.latitude,_that.longitude,_that.sentViaSms,_that.syncStatus,_that.createdAt,_that.localIpAddress,_that.deviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String message, @JsonKey(name: 'phone_number')  String phoneNumber,  double latitude,  double longitude,  bool sentViaSms,  int syncStatus, @_TimestampConverter()  DateTime? createdAt,  String? localIpAddress,  String? deviceId)  $default,) {final _that = this;
switch (_that) {
case _OfflineSmsModel():
return $default(_that.id,_that.message,_that.phoneNumber,_that.latitude,_that.longitude,_that.sentViaSms,_that.syncStatus,_that.createdAt,_that.localIpAddress,_that.deviceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String message, @JsonKey(name: 'phone_number')  String phoneNumber,  double latitude,  double longitude,  bool sentViaSms,  int syncStatus, @_TimestampConverter()  DateTime? createdAt,  String? localIpAddress,  String? deviceId)?  $default,) {final _that = this;
switch (_that) {
case _OfflineSmsModel() when $default != null:
return $default(_that.id,_that.message,_that.phoneNumber,_that.latitude,_that.longitude,_that.sentViaSms,_that.syncStatus,_that.createdAt,_that.localIpAddress,_that.deviceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OfflineSmsModel extends OfflineSmsModel {
  const _OfflineSmsModel({required this.id, required this.message, @JsonKey(name: 'phone_number') required this.phoneNumber, required this.latitude, required this.longitude, this.sentViaSms = false, this.syncStatus = 0, @_TimestampConverter() this.createdAt, this.localIpAddress, this.deviceId}): super._();
  factory _OfflineSmsModel.fromJson(Map<String, dynamic> json) => _$OfflineSmsModelFromJson(json);

@override final  String id;
@override final  String message;
@override@JsonKey(name: 'phone_number') final  String phoneNumber;
@override final  double latitude;
@override final  double longitude;
@override@JsonKey() final  bool sentViaSms;
@override@JsonKey() final  int syncStatus;
@override@_TimestampConverter() final  DateTime? createdAt;
// ← fixes Timestamp crash
@override final  String? localIpAddress;
@override final  String? deviceId;

/// Create a copy of OfflineSmsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfflineSmsModelCopyWith<_OfflineSmsModel> get copyWith => __$OfflineSmsModelCopyWithImpl<_OfflineSmsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfflineSmsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OfflineSmsModel&&(identical(other.id, id) || other.id == id)&&(identical(other.message, message) || other.message == message)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.sentViaSms, sentViaSms) || other.sentViaSms == sentViaSms)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.localIpAddress, localIpAddress) || other.localIpAddress == localIpAddress)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,message,phoneNumber,latitude,longitude,sentViaSms,syncStatus,createdAt,localIpAddress,deviceId);

@override
String toString() {
  return 'OfflineSmsModel(id: $id, message: $message, phoneNumber: $phoneNumber, latitude: $latitude, longitude: $longitude, sentViaSms: $sentViaSms, syncStatus: $syncStatus, createdAt: $createdAt, localIpAddress: $localIpAddress, deviceId: $deviceId)';
}


}

/// @nodoc
abstract mixin class _$OfflineSmsModelCopyWith<$Res> implements $OfflineSmsModelCopyWith<$Res> {
  factory _$OfflineSmsModelCopyWith(_OfflineSmsModel value, $Res Function(_OfflineSmsModel) _then) = __$OfflineSmsModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String message,@JsonKey(name: 'phone_number') String phoneNumber, double latitude, double longitude, bool sentViaSms, int syncStatus,@_TimestampConverter() DateTime? createdAt, String? localIpAddress, String? deviceId
});




}
/// @nodoc
class __$OfflineSmsModelCopyWithImpl<$Res>
    implements _$OfflineSmsModelCopyWith<$Res> {
  __$OfflineSmsModelCopyWithImpl(this._self, this._then);

  final _OfflineSmsModel _self;
  final $Res Function(_OfflineSmsModel) _then;

/// Create a copy of OfflineSmsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? message = null,Object? phoneNumber = null,Object? latitude = null,Object? longitude = null,Object? sentViaSms = null,Object? syncStatus = null,Object? createdAt = freezed,Object? localIpAddress = freezed,Object? deviceId = freezed,}) {
  return _then(_OfflineSmsModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,sentViaSms: null == sentViaSms ? _self.sentViaSms : sentViaSms // ignore: cast_nullable_to_non_nullable
as bool,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,localIpAddress: freezed == localIpAddress ? _self.localIpAddress : localIpAddress // ignore: cast_nullable_to_non_nullable
as String?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
