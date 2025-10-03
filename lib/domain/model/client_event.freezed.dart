// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClientEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClientEvent()';
}


}

/// @nodoc
class $ClientEventCopyWith<$Res>  {
$ClientEventCopyWith(ClientEvent _, $Res Function(ClientEvent) __);
}


/// Adds pattern-matching-related methods to [ClientEvent].
extension ClientEventPatterns on ClientEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ClientEventInit value)?  init,TResult Function( ClientEventConnected value)?  connected,TResult Function( ClientEventDisconnected value)?  disconnected,TResult Function( ClientEventSelected value)?  selected,TResult Function( ClientEventUnselected value)?  unselected,TResult Function( ClientEventText value)?  text,TResult Function( ClientEventDelta value)?  delta,TResult Function( ClientEventMoved value)?  moved,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ClientEventInit() when init != null:
return init(_that);case ClientEventConnected() when connected != null:
return connected(_that);case ClientEventDisconnected() when disconnected != null:
return disconnected(_that);case ClientEventSelected() when selected != null:
return selected(_that);case ClientEventUnselected() when unselected != null:
return unselected(_that);case ClientEventText() when text != null:
return text(_that);case ClientEventDelta() when delta != null:
return delta(_that);case ClientEventMoved() when moved != null:
return moved(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ClientEventInit value)  init,required TResult Function( ClientEventConnected value)  connected,required TResult Function( ClientEventDisconnected value)  disconnected,required TResult Function( ClientEventSelected value)  selected,required TResult Function( ClientEventUnselected value)  unselected,required TResult Function( ClientEventText value)  text,required TResult Function( ClientEventDelta value)  delta,required TResult Function( ClientEventMoved value)  moved,}){
final _that = this;
switch (_that) {
case ClientEventInit():
return init(_that);case ClientEventConnected():
return connected(_that);case ClientEventDisconnected():
return disconnected(_that);case ClientEventSelected():
return selected(_that);case ClientEventUnselected():
return unselected(_that);case ClientEventText():
return text(_that);case ClientEventDelta():
return delta(_that);case ClientEventMoved():
return moved(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ClientEventInit value)?  init,TResult? Function( ClientEventConnected value)?  connected,TResult? Function( ClientEventDisconnected value)?  disconnected,TResult? Function( ClientEventSelected value)?  selected,TResult? Function( ClientEventUnselected value)?  unselected,TResult? Function( ClientEventText value)?  text,TResult? Function( ClientEventDelta value)?  delta,TResult? Function( ClientEventMoved value)?  moved,}){
final _that = this;
switch (_that) {
case ClientEventInit() when init != null:
return init(_that);case ClientEventConnected() when connected != null:
return connected(_that);case ClientEventDisconnected() when disconnected != null:
return disconnected(_that);case ClientEventSelected() when selected != null:
return selected(_that);case ClientEventUnselected() when unselected != null:
return unselected(_that);case ClientEventText() when text != null:
return text(_that);case ClientEventDelta() when delta != null:
return delta(_that);case ClientEventMoved() when moved != null:
return moved(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  init,TResult Function( String addr)?  connected,TResult Function( String addr)?  disconnected,TResult Function( Selection selection,  String addr)?  selected,TResult Function( String addr)?  unselected,TResult Function( String text)?  text,TResult Function( SimpleDelta delta)?  delta,TResult Function( Selection? selection)?  moved,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ClientEventInit() when init != null:
return init();case ClientEventConnected() when connected != null:
return connected(_that.addr);case ClientEventDisconnected() when disconnected != null:
return disconnected(_that.addr);case ClientEventSelected() when selected != null:
return selected(_that.selection,_that.addr);case ClientEventUnselected() when unselected != null:
return unselected(_that.addr);case ClientEventText() when text != null:
return text(_that.text);case ClientEventDelta() when delta != null:
return delta(_that.delta);case ClientEventMoved() when moved != null:
return moved(_that.selection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  init,required TResult Function( String addr)  connected,required TResult Function( String addr)  disconnected,required TResult Function( Selection selection,  String addr)  selected,required TResult Function( String addr)  unselected,required TResult Function( String text)  text,required TResult Function( SimpleDelta delta)  delta,required TResult Function( Selection? selection)  moved,}) {final _that = this;
switch (_that) {
case ClientEventInit():
return init();case ClientEventConnected():
return connected(_that.addr);case ClientEventDisconnected():
return disconnected(_that.addr);case ClientEventSelected():
return selected(_that.selection,_that.addr);case ClientEventUnselected():
return unselected(_that.addr);case ClientEventText():
return text(_that.text);case ClientEventDelta():
return delta(_that.delta);case ClientEventMoved():
return moved(_that.selection);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  init,TResult? Function( String addr)?  connected,TResult? Function( String addr)?  disconnected,TResult? Function( Selection selection,  String addr)?  selected,TResult? Function( String addr)?  unselected,TResult? Function( String text)?  text,TResult? Function( SimpleDelta delta)?  delta,TResult? Function( Selection? selection)?  moved,}) {final _that = this;
switch (_that) {
case ClientEventInit() when init != null:
return init();case ClientEventConnected() when connected != null:
return connected(_that.addr);case ClientEventDisconnected() when disconnected != null:
return disconnected(_that.addr);case ClientEventSelected() when selected != null:
return selected(_that.selection,_that.addr);case ClientEventUnselected() when unselected != null:
return unselected(_that.addr);case ClientEventText() when text != null:
return text(_that.text);case ClientEventDelta() when delta != null:
return delta(_that.delta);case ClientEventMoved() when moved != null:
return moved(_that.selection);case _:
  return null;

}
}

}

/// @nodoc


class ClientEventInit implements ClientEvent {
  const ClientEventInit();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientEventInit);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClientEvent.init()';
}


}




/// @nodoc


class ClientEventConnected implements ClientEvent {
  const ClientEventConnected({required this.addr});
  

 final  String addr;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientEventConnectedCopyWith<ClientEventConnected> get copyWith => _$ClientEventConnectedCopyWithImpl<ClientEventConnected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientEventConnected&&(identical(other.addr, addr) || other.addr == addr));
}


@override
int get hashCode => Object.hash(runtimeType,addr);

@override
String toString() {
  return 'ClientEvent.connected(addr: $addr)';
}


}

/// @nodoc
abstract mixin class $ClientEventConnectedCopyWith<$Res> implements $ClientEventCopyWith<$Res> {
  factory $ClientEventConnectedCopyWith(ClientEventConnected value, $Res Function(ClientEventConnected) _then) = _$ClientEventConnectedCopyWithImpl;
@useResult
$Res call({
 String addr
});




}
/// @nodoc
class _$ClientEventConnectedCopyWithImpl<$Res>
    implements $ClientEventConnectedCopyWith<$Res> {
  _$ClientEventConnectedCopyWithImpl(this._self, this._then);

  final ClientEventConnected _self;
  final $Res Function(ClientEventConnected) _then;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? addr = null,}) {
  return _then(ClientEventConnected(
addr: null == addr ? _self.addr : addr // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ClientEventDisconnected implements ClientEvent {
  const ClientEventDisconnected({required this.addr});
  

 final  String addr;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientEventDisconnectedCopyWith<ClientEventDisconnected> get copyWith => _$ClientEventDisconnectedCopyWithImpl<ClientEventDisconnected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientEventDisconnected&&(identical(other.addr, addr) || other.addr == addr));
}


@override
int get hashCode => Object.hash(runtimeType,addr);

@override
String toString() {
  return 'ClientEvent.disconnected(addr: $addr)';
}


}

/// @nodoc
abstract mixin class $ClientEventDisconnectedCopyWith<$Res> implements $ClientEventCopyWith<$Res> {
  factory $ClientEventDisconnectedCopyWith(ClientEventDisconnected value, $Res Function(ClientEventDisconnected) _then) = _$ClientEventDisconnectedCopyWithImpl;
@useResult
$Res call({
 String addr
});




}
/// @nodoc
class _$ClientEventDisconnectedCopyWithImpl<$Res>
    implements $ClientEventDisconnectedCopyWith<$Res> {
  _$ClientEventDisconnectedCopyWithImpl(this._self, this._then);

  final ClientEventDisconnected _self;
  final $Res Function(ClientEventDisconnected) _then;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? addr = null,}) {
  return _then(ClientEventDisconnected(
addr: null == addr ? _self.addr : addr // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ClientEventSelected implements ClientEvent {
  const ClientEventSelected({required this.selection, required this.addr});
  

 final  Selection selection;
 final  String addr;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientEventSelectedCopyWith<ClientEventSelected> get copyWith => _$ClientEventSelectedCopyWithImpl<ClientEventSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientEventSelected&&(identical(other.selection, selection) || other.selection == selection)&&(identical(other.addr, addr) || other.addr == addr));
}


@override
int get hashCode => Object.hash(runtimeType,selection,addr);

@override
String toString() {
  return 'ClientEvent.selected(selection: $selection, addr: $addr)';
}


}

/// @nodoc
abstract mixin class $ClientEventSelectedCopyWith<$Res> implements $ClientEventCopyWith<$Res> {
  factory $ClientEventSelectedCopyWith(ClientEventSelected value, $Res Function(ClientEventSelected) _then) = _$ClientEventSelectedCopyWithImpl;
@useResult
$Res call({
 Selection selection, String addr
});




}
/// @nodoc
class _$ClientEventSelectedCopyWithImpl<$Res>
    implements $ClientEventSelectedCopyWith<$Res> {
  _$ClientEventSelectedCopyWithImpl(this._self, this._then);

  final ClientEventSelected _self;
  final $Res Function(ClientEventSelected) _then;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selection = null,Object? addr = null,}) {
  return _then(ClientEventSelected(
selection: null == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as Selection,addr: null == addr ? _self.addr : addr // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ClientEventUnselected implements ClientEvent {
  const ClientEventUnselected({required this.addr});
  

 final  String addr;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientEventUnselectedCopyWith<ClientEventUnselected> get copyWith => _$ClientEventUnselectedCopyWithImpl<ClientEventUnselected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientEventUnselected&&(identical(other.addr, addr) || other.addr == addr));
}


@override
int get hashCode => Object.hash(runtimeType,addr);

@override
String toString() {
  return 'ClientEvent.unselected(addr: $addr)';
}


}

/// @nodoc
abstract mixin class $ClientEventUnselectedCopyWith<$Res> implements $ClientEventCopyWith<$Res> {
  factory $ClientEventUnselectedCopyWith(ClientEventUnselected value, $Res Function(ClientEventUnselected) _then) = _$ClientEventUnselectedCopyWithImpl;
@useResult
$Res call({
 String addr
});




}
/// @nodoc
class _$ClientEventUnselectedCopyWithImpl<$Res>
    implements $ClientEventUnselectedCopyWith<$Res> {
  _$ClientEventUnselectedCopyWithImpl(this._self, this._then);

  final ClientEventUnselected _self;
  final $Res Function(ClientEventUnselected) _then;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? addr = null,}) {
  return _then(ClientEventUnselected(
addr: null == addr ? _self.addr : addr // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ClientEventText implements ClientEvent {
  const ClientEventText({required this.text});
  

 final  String text;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientEventTextCopyWith<ClientEventText> get copyWith => _$ClientEventTextCopyWithImpl<ClientEventText>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientEventText&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'ClientEvent.text(text: $text)';
}


}

/// @nodoc
abstract mixin class $ClientEventTextCopyWith<$Res> implements $ClientEventCopyWith<$Res> {
  factory $ClientEventTextCopyWith(ClientEventText value, $Res Function(ClientEventText) _then) = _$ClientEventTextCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$ClientEventTextCopyWithImpl<$Res>
    implements $ClientEventTextCopyWith<$Res> {
  _$ClientEventTextCopyWithImpl(this._self, this._then);

  final ClientEventText _self;
  final $Res Function(ClientEventText) _then;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(ClientEventText(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ClientEventDelta implements ClientEvent {
  const ClientEventDelta({required this.delta});
  

 final  SimpleDelta delta;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientEventDeltaCopyWith<ClientEventDelta> get copyWith => _$ClientEventDeltaCopyWithImpl<ClientEventDelta>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientEventDelta&&(identical(other.delta, delta) || other.delta == delta));
}


@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'ClientEvent.delta(delta: $delta)';
}


}

/// @nodoc
abstract mixin class $ClientEventDeltaCopyWith<$Res> implements $ClientEventCopyWith<$Res> {
  factory $ClientEventDeltaCopyWith(ClientEventDelta value, $Res Function(ClientEventDelta) _then) = _$ClientEventDeltaCopyWithImpl;
@useResult
$Res call({
 SimpleDelta delta
});


$SimpleDeltaCopyWith<$Res> get delta;

}
/// @nodoc
class _$ClientEventDeltaCopyWithImpl<$Res>
    implements $ClientEventDeltaCopyWith<$Res> {
  _$ClientEventDeltaCopyWithImpl(this._self, this._then);

  final ClientEventDelta _self;
  final $Res Function(ClientEventDelta) _then;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? delta = null,}) {
  return _then(ClientEventDelta(
delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as SimpleDelta,
  ));
}

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SimpleDeltaCopyWith<$Res> get delta {
  
  return $SimpleDeltaCopyWith<$Res>(_self.delta, (value) {
    return _then(_self.copyWith(delta: value));
  });
}
}

/// @nodoc


class ClientEventMoved implements ClientEvent {
  const ClientEventMoved({required this.selection});
  

 final  Selection? selection;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientEventMovedCopyWith<ClientEventMoved> get copyWith => _$ClientEventMovedCopyWithImpl<ClientEventMoved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientEventMoved&&(identical(other.selection, selection) || other.selection == selection));
}


@override
int get hashCode => Object.hash(runtimeType,selection);

@override
String toString() {
  return 'ClientEvent.moved(selection: $selection)';
}


}

/// @nodoc
abstract mixin class $ClientEventMovedCopyWith<$Res> implements $ClientEventCopyWith<$Res> {
  factory $ClientEventMovedCopyWith(ClientEventMoved value, $Res Function(ClientEventMoved) _then) = _$ClientEventMovedCopyWithImpl;
@useResult
$Res call({
 Selection? selection
});




}
/// @nodoc
class _$ClientEventMovedCopyWithImpl<$Res>
    implements $ClientEventMovedCopyWith<$Res> {
  _$ClientEventMovedCopyWithImpl(this._self, this._then);

  final ClientEventMoved _self;
  final $Res Function(ClientEventMoved) _then;

/// Create a copy of ClientEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selection = freezed,}) {
  return _then(ClientEventMoved(
selection: freezed == selection ? _self.selection : selection // ignore: cast_nullable_to_non_nullable
as Selection?,
  ));
}


}

// dart format on
