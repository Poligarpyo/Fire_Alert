// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HistoryReportModel {

 String get id; String get type; String get severity; String get location; String get date; String get status; String get additionalInfo; String? get imageUrl; String? get rescuer;
/// Create a copy of HistoryReportModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryReportModelCopyWith<HistoryReportModel> get copyWith => _$HistoryReportModelCopyWithImpl<HistoryReportModel>(this as HistoryReportModel, _$identity);

  /// Serializes this HistoryReportModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryReportModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.location, location) || other.location == location)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.additionalInfo, additionalInfo) || other.additionalInfo == additionalInfo)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.rescuer, rescuer) || other.rescuer == rescuer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,severity,location,date,status,additionalInfo,imageUrl,rescuer);

@override
String toString() {
  return 'HistoryReportModel(id: $id, type: $type, severity: $severity, location: $location, date: $date, status: $status, additionalInfo: $additionalInfo, imageUrl: $imageUrl, rescuer: $rescuer)';
}


}

/// @nodoc
abstract mixin class $HistoryReportModelCopyWith<$Res>  {
  factory $HistoryReportModelCopyWith(HistoryReportModel value, $Res Function(HistoryReportModel) _then) = _$HistoryReportModelCopyWithImpl;
@useResult
$Res call({
 String id, String type, String severity, String location, String date, String status, String additionalInfo, String? imageUrl, String? rescuer
});




}
/// @nodoc
class _$HistoryReportModelCopyWithImpl<$Res>
    implements $HistoryReportModelCopyWith<$Res> {
  _$HistoryReportModelCopyWithImpl(this._self, this._then);

  final HistoryReportModel _self;
  final $Res Function(HistoryReportModel) _then;

/// Create a copy of HistoryReportModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? severity = null,Object? location = null,Object? date = null,Object? status = null,Object? additionalInfo = null,Object? imageUrl = freezed,Object? rescuer = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,additionalInfo: null == additionalInfo ? _self.additionalInfo : additionalInfo // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,rescuer: freezed == rescuer ? _self.rescuer : rescuer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryReportModel].
extension HistoryReportModelPatterns on HistoryReportModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryReportModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryReportModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryReportModel value)  $default,){
final _that = this;
switch (_that) {
case _HistoryReportModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryReportModel value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryReportModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String severity,  String location,  String date,  String status,  String additionalInfo,  String? imageUrl,  String? rescuer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryReportModel() when $default != null:
return $default(_that.id,_that.type,_that.severity,_that.location,_that.date,_that.status,_that.additionalInfo,_that.imageUrl,_that.rescuer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String severity,  String location,  String date,  String status,  String additionalInfo,  String? imageUrl,  String? rescuer)  $default,) {final _that = this;
switch (_that) {
case _HistoryReportModel():
return $default(_that.id,_that.type,_that.severity,_that.location,_that.date,_that.status,_that.additionalInfo,_that.imageUrl,_that.rescuer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String severity,  String location,  String date,  String status,  String additionalInfo,  String? imageUrl,  String? rescuer)?  $default,) {final _that = this;
switch (_that) {
case _HistoryReportModel() when $default != null:
return $default(_that.id,_that.type,_that.severity,_that.location,_that.date,_that.status,_that.additionalInfo,_that.imageUrl,_that.rescuer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoryReportModel implements HistoryReportModel {
  const _HistoryReportModel({required this.id, required this.type, required this.severity, required this.location, required this.date, required this.status, this.additionalInfo = '', this.imageUrl, this.rescuer});
  factory _HistoryReportModel.fromJson(Map<String, dynamic> json) => _$HistoryReportModelFromJson(json);

@override final  String id;
@override final  String type;
@override final  String severity;
@override final  String location;
@override final  String date;
@override final  String status;
@override@JsonKey() final  String additionalInfo;
@override final  String? imageUrl;
@override final  String? rescuer;

/// Create a copy of HistoryReportModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryReportModelCopyWith<_HistoryReportModel> get copyWith => __$HistoryReportModelCopyWithImpl<_HistoryReportModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryReportModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryReportModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.location, location) || other.location == location)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.additionalInfo, additionalInfo) || other.additionalInfo == additionalInfo)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.rescuer, rescuer) || other.rescuer == rescuer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,severity,location,date,status,additionalInfo,imageUrl,rescuer);

@override
String toString() {
  return 'HistoryReportModel(id: $id, type: $type, severity: $severity, location: $location, date: $date, status: $status, additionalInfo: $additionalInfo, imageUrl: $imageUrl, rescuer: $rescuer)';
}


}

/// @nodoc
abstract mixin class _$HistoryReportModelCopyWith<$Res> implements $HistoryReportModelCopyWith<$Res> {
  factory _$HistoryReportModelCopyWith(_HistoryReportModel value, $Res Function(_HistoryReportModel) _then) = __$HistoryReportModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String severity, String location, String date, String status, String additionalInfo, String? imageUrl, String? rescuer
});




}
/// @nodoc
class __$HistoryReportModelCopyWithImpl<$Res>
    implements _$HistoryReportModelCopyWith<$Res> {
  __$HistoryReportModelCopyWithImpl(this._self, this._then);

  final _HistoryReportModel _self;
  final $Res Function(_HistoryReportModel) _then;

/// Create a copy of HistoryReportModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? severity = null,Object? location = null,Object? date = null,Object? status = null,Object? additionalInfo = null,Object? imageUrl = freezed,Object? rescuer = freezed,}) {
  return _then(_HistoryReportModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,additionalInfo: null == additionalInfo ? _self.additionalInfo : additionalInfo // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,rescuer: freezed == rescuer ? _self.rescuer : rescuer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$HistoryReportListResponse {

 List<HistoryReportModel> get data; int get currentPage; int get totalPages; int get totalCount;
/// Create a copy of HistoryReportListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryReportListResponseCopyWith<HistoryReportListResponse> get copyWith => _$HistoryReportListResponseCopyWithImpl<HistoryReportListResponse>(this as HistoryReportListResponse, _$identity);

  /// Serializes this HistoryReportListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryReportListResponse&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data),currentPage,totalPages,totalCount);

@override
String toString() {
  return 'HistoryReportListResponse(data: $data, currentPage: $currentPage, totalPages: $totalPages, totalCount: $totalCount)';
}


}

/// @nodoc
abstract mixin class $HistoryReportListResponseCopyWith<$Res>  {
  factory $HistoryReportListResponseCopyWith(HistoryReportListResponse value, $Res Function(HistoryReportListResponse) _then) = _$HistoryReportListResponseCopyWithImpl;
@useResult
$Res call({
 List<HistoryReportModel> data, int currentPage, int totalPages, int totalCount
});




}
/// @nodoc
class _$HistoryReportListResponseCopyWithImpl<$Res>
    implements $HistoryReportListResponseCopyWith<$Res> {
  _$HistoryReportListResponseCopyWithImpl(this._self, this._then);

  final HistoryReportListResponse _self;
  final $Res Function(HistoryReportListResponse) _then;

/// Create a copy of HistoryReportListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,Object? currentPage = null,Object? totalPages = null,Object? totalCount = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<HistoryReportModel>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryReportListResponse].
extension HistoryReportListResponsePatterns on HistoryReportListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryReportListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryReportListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryReportListResponse value)  $default,){
final _that = this;
switch (_that) {
case _HistoryReportListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryReportListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryReportListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HistoryReportModel> data,  int currentPage,  int totalPages,  int totalCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryReportListResponse() when $default != null:
return $default(_that.data,_that.currentPage,_that.totalPages,_that.totalCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HistoryReportModel> data,  int currentPage,  int totalPages,  int totalCount)  $default,) {final _that = this;
switch (_that) {
case _HistoryReportListResponse():
return $default(_that.data,_that.currentPage,_that.totalPages,_that.totalCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HistoryReportModel> data,  int currentPage,  int totalPages,  int totalCount)?  $default,) {final _that = this;
switch (_that) {
case _HistoryReportListResponse() when $default != null:
return $default(_that.data,_that.currentPage,_that.totalPages,_that.totalCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoryReportListResponse implements HistoryReportListResponse {
  const _HistoryReportListResponse({required final  List<HistoryReportModel> data, this.currentPage = 1, this.totalPages = 1, this.totalCount = 0}): _data = data;
  factory _HistoryReportListResponse.fromJson(Map<String, dynamic> json) => _$HistoryReportListResponseFromJson(json);

 final  List<HistoryReportModel> _data;
@override List<HistoryReportModel> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int totalPages;
@override@JsonKey() final  int totalCount;

/// Create a copy of HistoryReportListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryReportListResponseCopyWith<_HistoryReportListResponse> get copyWith => __$HistoryReportListResponseCopyWithImpl<_HistoryReportListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryReportListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryReportListResponse&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data),currentPage,totalPages,totalCount);

@override
String toString() {
  return 'HistoryReportListResponse(data: $data, currentPage: $currentPage, totalPages: $totalPages, totalCount: $totalCount)';
}


}

/// @nodoc
abstract mixin class _$HistoryReportListResponseCopyWith<$Res> implements $HistoryReportListResponseCopyWith<$Res> {
  factory _$HistoryReportListResponseCopyWith(_HistoryReportListResponse value, $Res Function(_HistoryReportListResponse) _then) = __$HistoryReportListResponseCopyWithImpl;
@override @useResult
$Res call({
 List<HistoryReportModel> data, int currentPage, int totalPages, int totalCount
});




}
/// @nodoc
class __$HistoryReportListResponseCopyWithImpl<$Res>
    implements _$HistoryReportListResponseCopyWith<$Res> {
  __$HistoryReportListResponseCopyWithImpl(this._self, this._then);

  final _HistoryReportListResponse _self;
  final $Res Function(_HistoryReportListResponse) _then;

/// Create a copy of HistoryReportListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,Object? currentPage = null,Object? totalPages = null,Object? totalCount = null,}) {
  return _then(_HistoryReportListResponse(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<HistoryReportModel>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
