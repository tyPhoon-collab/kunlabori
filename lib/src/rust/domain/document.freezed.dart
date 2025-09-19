// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SimpleDelta {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimpleDelta);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SimpleDelta()';
}


}

/// @nodoc
class $SimpleDeltaCopyWith<$Res>  {
$SimpleDeltaCopyWith(SimpleDelta _, $Res Function(SimpleDelta) __);
}


/// Adds pattern-matching-related methods to [SimpleDelta].
extension SimpleDeltaPatterns on SimpleDelta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SimpleDelta_Insert value)?  insert,TResult Function( SimpleDelta_Delete value)?  delete,TResult Function( SimpleDelta_Retain value)?  retain,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SimpleDelta_Insert() when insert != null:
return insert(_that);case SimpleDelta_Delete() when delete != null:
return delete(_that);case SimpleDelta_Retain() when retain != null:
return retain(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SimpleDelta_Insert value)  insert,required TResult Function( SimpleDelta_Delete value)  delete,required TResult Function( SimpleDelta_Retain value)  retain,}){
final _that = this;
switch (_that) {
case SimpleDelta_Insert():
return insert(_that);case SimpleDelta_Delete():
return delete(_that);case SimpleDelta_Retain():
return retain(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SimpleDelta_Insert value)?  insert,TResult? Function( SimpleDelta_Delete value)?  delete,TResult? Function( SimpleDelta_Retain value)?  retain,}){
final _that = this;
switch (_that) {
case SimpleDelta_Insert() when insert != null:
return insert(_that);case SimpleDelta_Delete() when delete != null:
return delete(_that);case SimpleDelta_Retain() when retain != null:
return retain(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String text)?  insert,TResult Function( int deleteCount)?  delete,TResult Function( int retainCount)?  retain,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SimpleDelta_Insert() when insert != null:
return insert(_that.text);case SimpleDelta_Delete() when delete != null:
return delete(_that.deleteCount);case SimpleDelta_Retain() when retain != null:
return retain(_that.retainCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String text)  insert,required TResult Function( int deleteCount)  delete,required TResult Function( int retainCount)  retain,}) {final _that = this;
switch (_that) {
case SimpleDelta_Insert():
return insert(_that.text);case SimpleDelta_Delete():
return delete(_that.deleteCount);case SimpleDelta_Retain():
return retain(_that.retainCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String text)?  insert,TResult? Function( int deleteCount)?  delete,TResult? Function( int retainCount)?  retain,}) {final _that = this;
switch (_that) {
case SimpleDelta_Insert() when insert != null:
return insert(_that.text);case SimpleDelta_Delete() when delete != null:
return delete(_that.deleteCount);case SimpleDelta_Retain() when retain != null:
return retain(_that.retainCount);case _:
  return null;

}
}

}

/// @nodoc


class SimpleDelta_Insert extends SimpleDelta {
  const SimpleDelta_Insert({required this.text}): super._();
  

 final  String text;

/// Create a copy of SimpleDelta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimpleDelta_InsertCopyWith<SimpleDelta_Insert> get copyWith => _$SimpleDelta_InsertCopyWithImpl<SimpleDelta_Insert>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimpleDelta_Insert&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'SimpleDelta.insert(text: $text)';
}


}

/// @nodoc
abstract mixin class $SimpleDelta_InsertCopyWith<$Res> implements $SimpleDeltaCopyWith<$Res> {
  factory $SimpleDelta_InsertCopyWith(SimpleDelta_Insert value, $Res Function(SimpleDelta_Insert) _then) = _$SimpleDelta_InsertCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$SimpleDelta_InsertCopyWithImpl<$Res>
    implements $SimpleDelta_InsertCopyWith<$Res> {
  _$SimpleDelta_InsertCopyWithImpl(this._self, this._then);

  final SimpleDelta_Insert _self;
  final $Res Function(SimpleDelta_Insert) _then;

/// Create a copy of SimpleDelta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(SimpleDelta_Insert(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SimpleDelta_Delete extends SimpleDelta {
  const SimpleDelta_Delete({required this.deleteCount}): super._();
  

 final  int deleteCount;

/// Create a copy of SimpleDelta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimpleDelta_DeleteCopyWith<SimpleDelta_Delete> get copyWith => _$SimpleDelta_DeleteCopyWithImpl<SimpleDelta_Delete>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimpleDelta_Delete&&(identical(other.deleteCount, deleteCount) || other.deleteCount == deleteCount));
}


@override
int get hashCode => Object.hash(runtimeType,deleteCount);

@override
String toString() {
  return 'SimpleDelta.delete(deleteCount: $deleteCount)';
}


}

/// @nodoc
abstract mixin class $SimpleDelta_DeleteCopyWith<$Res> implements $SimpleDeltaCopyWith<$Res> {
  factory $SimpleDelta_DeleteCopyWith(SimpleDelta_Delete value, $Res Function(SimpleDelta_Delete) _then) = _$SimpleDelta_DeleteCopyWithImpl;
@useResult
$Res call({
 int deleteCount
});




}
/// @nodoc
class _$SimpleDelta_DeleteCopyWithImpl<$Res>
    implements $SimpleDelta_DeleteCopyWith<$Res> {
  _$SimpleDelta_DeleteCopyWithImpl(this._self, this._then);

  final SimpleDelta_Delete _self;
  final $Res Function(SimpleDelta_Delete) _then;

/// Create a copy of SimpleDelta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? deleteCount = null,}) {
  return _then(SimpleDelta_Delete(
deleteCount: null == deleteCount ? _self.deleteCount : deleteCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class SimpleDelta_Retain extends SimpleDelta {
  const SimpleDelta_Retain({required this.retainCount}): super._();
  

 final  int retainCount;

/// Create a copy of SimpleDelta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimpleDelta_RetainCopyWith<SimpleDelta_Retain> get copyWith => _$SimpleDelta_RetainCopyWithImpl<SimpleDelta_Retain>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimpleDelta_Retain&&(identical(other.retainCount, retainCount) || other.retainCount == retainCount));
}


@override
int get hashCode => Object.hash(runtimeType,retainCount);

@override
String toString() {
  return 'SimpleDelta.retain(retainCount: $retainCount)';
}


}

/// @nodoc
abstract mixin class $SimpleDelta_RetainCopyWith<$Res> implements $SimpleDeltaCopyWith<$Res> {
  factory $SimpleDelta_RetainCopyWith(SimpleDelta_Retain value, $Res Function(SimpleDelta_Retain) _then) = _$SimpleDelta_RetainCopyWithImpl;
@useResult
$Res call({
 int retainCount
});




}
/// @nodoc
class _$SimpleDelta_RetainCopyWithImpl<$Res>
    implements $SimpleDelta_RetainCopyWith<$Res> {
  _$SimpleDelta_RetainCopyWithImpl(this._self, this._then);

  final SimpleDelta_Retain _self;
  final $Res Function(SimpleDelta_Retain) _then;

/// Create a copy of SimpleDelta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? retainCount = null,}) {
  return _then(SimpleDelta_Retain(
retainCount: null == retainCount ? _self.retainCount : retainCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
