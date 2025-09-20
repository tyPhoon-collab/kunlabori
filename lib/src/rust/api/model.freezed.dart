// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Partial {

 Object get field0;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Partial&&const DeepCollectionEquality().equals(other.field0, field0));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(field0));

@override
String toString() {
  return 'Partial(field0: $field0)';
}


}

/// @nodoc
class $PartialCopyWith<$Res>  {
$PartialCopyWith(Partial _, $Res Function(Partial) __);
}


/// Adds pattern-matching-related methods to [Partial].
extension PartialPatterns on Partial {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Partial_Delta value)?  delta,TResult Function( Partial_Update value)?  update,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Partial_Delta() when delta != null:
return delta(_that);case Partial_Update() when update != null:
return update(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Partial_Delta value)  delta,required TResult Function( Partial_Update value)  update,}){
final _that = this;
switch (_that) {
case Partial_Delta():
return delta(_that);case Partial_Update():
return update(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Partial_Delta value)?  delta,TResult? Function( Partial_Update value)?  update,}){
final _that = this;
switch (_that) {
case Partial_Delta() when delta != null:
return delta(_that);case Partial_Update() when update != null:
return update(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SimpleDelta field0)?  delta,TResult Function( Uint8List field0)?  update,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Partial_Delta() when delta != null:
return delta(_that.field0);case Partial_Update() when update != null:
return update(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SimpleDelta field0)  delta,required TResult Function( Uint8List field0)  update,}) {final _that = this;
switch (_that) {
case Partial_Delta():
return delta(_that.field0);case Partial_Update():
return update(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SimpleDelta field0)?  delta,TResult? Function( Uint8List field0)?  update,}) {final _that = this;
switch (_that) {
case Partial_Delta() when delta != null:
return delta(_that.field0);case Partial_Update() when update != null:
return update(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class Partial_Delta extends Partial {
  const Partial_Delta(this.field0): super._();
  

@override final  SimpleDelta field0;

/// Create a copy of Partial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Partial_DeltaCopyWith<Partial_Delta> get copyWith => _$Partial_DeltaCopyWithImpl<Partial_Delta>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Partial_Delta&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'Partial.delta(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Partial_DeltaCopyWith<$Res> implements $PartialCopyWith<$Res> {
  factory $Partial_DeltaCopyWith(Partial_Delta value, $Res Function(Partial_Delta) _then) = _$Partial_DeltaCopyWithImpl;
@useResult
$Res call({
 SimpleDelta field0
});


$SimpleDeltaCopyWith<$Res> get field0;

}
/// @nodoc
class _$Partial_DeltaCopyWithImpl<$Res>
    implements $Partial_DeltaCopyWith<$Res> {
  _$Partial_DeltaCopyWithImpl(this._self, this._then);

  final Partial_Delta _self;
  final $Res Function(Partial_Delta) _then;

/// Create a copy of Partial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Partial_Delta(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as SimpleDelta,
  ));
}

/// Create a copy of Partial
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SimpleDeltaCopyWith<$Res> get field0 {
  
  return $SimpleDeltaCopyWith<$Res>(_self.field0, (value) {
    return _then(_self.copyWith(field0: value));
  });
}
}

/// @nodoc


class Partial_Update extends Partial {
  const Partial_Update(this.field0): super._();
  

@override final  Uint8List field0;

/// Create a copy of Partial
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$Partial_UpdateCopyWith<Partial_Update> get copyWith => _$Partial_UpdateCopyWithImpl<Partial_Update>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Partial_Update&&const DeepCollectionEquality().equals(other.field0, field0));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(field0));

@override
String toString() {
  return 'Partial.update(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $Partial_UpdateCopyWith<$Res> implements $PartialCopyWith<$Res> {
  factory $Partial_UpdateCopyWith(Partial_Update value, $Res Function(Partial_Update) _then) = _$Partial_UpdateCopyWithImpl;
@useResult
$Res call({
 Uint8List field0
});




}
/// @nodoc
class _$Partial_UpdateCopyWithImpl<$Res>
    implements $Partial_UpdateCopyWith<$Res> {
  _$Partial_UpdateCopyWithImpl(this._self, this._then);

  final Partial_Update _self;
  final $Res Function(Partial_Update) _then;

/// Create a copy of Partial
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(Partial_Update(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

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
