// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeItemModel {

 int get id; String get email;@JsonKey(name: 'first_name') String get firstName;@JsonKey(name: 'last_name') String get lastName; String get avatar;
/// Create a copy of HomeItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeItemModelCopyWith<HomeItemModel> get copyWith => _$HomeItemModelCopyWithImpl<HomeItemModel>(this as HomeItemModel, _$identity);

  /// Serializes this HomeItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,avatar);

@override
String toString() {
  return 'HomeItemModel(id: $id, email: $email, firstName: $firstName, lastName: $lastName, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class $HomeItemModelCopyWith<$Res>  {
  factory $HomeItemModelCopyWith(HomeItemModel value, $Res Function(HomeItemModel) _then) = _$HomeItemModelCopyWithImpl;
@useResult
$Res call({
 int id, String email,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName, String avatar
});




}
/// @nodoc
class _$HomeItemModelCopyWithImpl<$Res>
    implements $HomeItemModelCopyWith<$Res> {
  _$HomeItemModelCopyWithImpl(this._self, this._then);

  final HomeItemModel _self;
  final $Res Function(HomeItemModel) _then;

/// Create a copy of HomeItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? avatar = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeItemModel].
extension HomeItemModelPatterns on HomeItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeItemModel value)  $default,){
final _that = this;
switch (_that) {
case _HomeItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _HomeItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String email, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName,  String avatar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeItemModel() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.avatar);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String email, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName,  String avatar)  $default,) {final _that = this;
switch (_that) {
case _HomeItemModel():
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.avatar);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String email, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String lastName,  String avatar)?  $default,) {final _that = this;
switch (_that) {
case _HomeItemModel() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.avatar);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeItemModel extends HomeItemModel {
  const _HomeItemModel({required this.id, required this.email, @JsonKey(name: 'first_name') required this.firstName, @JsonKey(name: 'last_name') required this.lastName, required this.avatar}): super._();
  factory _HomeItemModel.fromJson(Map<String, dynamic> json) => _$HomeItemModelFromJson(json);

@override final  int id;
@override final  String email;
@override@JsonKey(name: 'first_name') final  String firstName;
@override@JsonKey(name: 'last_name') final  String lastName;
@override final  String avatar;

/// Create a copy of HomeItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeItemModelCopyWith<_HomeItemModel> get copyWith => __$HomeItemModelCopyWithImpl<_HomeItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,avatar);

@override
String toString() {
  return 'HomeItemModel(id: $id, email: $email, firstName: $firstName, lastName: $lastName, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class _$HomeItemModelCopyWith<$Res> implements $HomeItemModelCopyWith<$Res> {
  factory _$HomeItemModelCopyWith(_HomeItemModel value, $Res Function(_HomeItemModel) _then) = __$HomeItemModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String email,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String lastName, String avatar
});




}
/// @nodoc
class __$HomeItemModelCopyWithImpl<$Res>
    implements _$HomeItemModelCopyWith<$Res> {
  __$HomeItemModelCopyWithImpl(this._self, this._then);

  final _HomeItemModel _self;
  final $Res Function(_HomeItemModel) _then;

/// Create a copy of HomeItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? avatar = null,}) {
  return _then(_HomeItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$HomeUsersResponseModel {

 List<HomeItemModel> get data;
/// Create a copy of HomeUsersResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeUsersResponseModelCopyWith<HomeUsersResponseModel> get copyWith => _$HomeUsersResponseModelCopyWithImpl<HomeUsersResponseModel>(this as HomeUsersResponseModel, _$identity);

  /// Serializes this HomeUsersResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeUsersResponseModel&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'HomeUsersResponseModel(data: $data)';
}


}

/// @nodoc
abstract mixin class $HomeUsersResponseModelCopyWith<$Res>  {
  factory $HomeUsersResponseModelCopyWith(HomeUsersResponseModel value, $Res Function(HomeUsersResponseModel) _then) = _$HomeUsersResponseModelCopyWithImpl;
@useResult
$Res call({
 List<HomeItemModel> data
});




}
/// @nodoc
class _$HomeUsersResponseModelCopyWithImpl<$Res>
    implements $HomeUsersResponseModelCopyWith<$Res> {
  _$HomeUsersResponseModelCopyWithImpl(this._self, this._then);

  final HomeUsersResponseModel _self;
  final $Res Function(HomeUsersResponseModel) _then;

/// Create a copy of HomeUsersResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<HomeItemModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeUsersResponseModel].
extension HomeUsersResponseModelPatterns on HomeUsersResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeUsersResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeUsersResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeUsersResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _HomeUsersResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeUsersResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _HomeUsersResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HomeItemModel> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeUsersResponseModel() when $default != null:
return $default(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HomeItemModel> data)  $default,) {final _that = this;
switch (_that) {
case _HomeUsersResponseModel():
return $default(_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HomeItemModel> data)?  $default,) {final _that = this;
switch (_that) {
case _HomeUsersResponseModel() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HomeUsersResponseModel implements HomeUsersResponseModel {
  const _HomeUsersResponseModel({required final  List<HomeItemModel> data}): _data = data;
  factory _HomeUsersResponseModel.fromJson(Map<String, dynamic> json) => _$HomeUsersResponseModelFromJson(json);

 final  List<HomeItemModel> _data;
@override List<HomeItemModel> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of HomeUsersResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeUsersResponseModelCopyWith<_HomeUsersResponseModel> get copyWith => __$HomeUsersResponseModelCopyWithImpl<_HomeUsersResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HomeUsersResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeUsersResponseModel&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'HomeUsersResponseModel(data: $data)';
}


}

/// @nodoc
abstract mixin class _$HomeUsersResponseModelCopyWith<$Res> implements $HomeUsersResponseModelCopyWith<$Res> {
  factory _$HomeUsersResponseModelCopyWith(_HomeUsersResponseModel value, $Res Function(_HomeUsersResponseModel) _then) = __$HomeUsersResponseModelCopyWithImpl;
@override @useResult
$Res call({
 List<HomeItemModel> data
});




}
/// @nodoc
class __$HomeUsersResponseModelCopyWithImpl<$Res>
    implements _$HomeUsersResponseModelCopyWith<$Res> {
  __$HomeUsersResponseModelCopyWithImpl(this._self, this._then);

  final _HomeUsersResponseModel _self;
  final $Res Function(_HomeUsersResponseModel) _then;

/// Create a copy of HomeUsersResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_HomeUsersResponseModel(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<HomeItemModel>,
  ));
}


}

// dart format on
