// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
SendMessage _$SendMessageFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'update':
          return SendMessageUpdate.fromJson(
            json
          );
                case 'selection':
          return SendMessageSelection.fromJson(
            json
          );
                case 'unselect':
          return SendMessageUnselect.fromJson(
            json
          );
                case 'init':
          return SendMessageInit.fromJson(
            json
          );
                case 'join':
          return SendMessageJoin.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'SendMessage',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$SendMessage {



  /// Serializes this SendMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendMessage);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SendMessage()';
}


}

/// @nodoc
class $SendMessageCopyWith<$Res>  {
$SendMessageCopyWith(SendMessage _, $Res Function(SendMessage) __);
}


/// Adds pattern-matching-related methods to [SendMessage].
extension SendMessagePatterns on SendMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SendMessageUpdate value)?  update,TResult Function( SendMessageSelection value)?  selection,TResult Function( SendMessageUnselect value)?  unselect,TResult Function( SendMessageInit value)?  init,TResult Function( SendMessageJoin value)?  join,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SendMessageUpdate() when update != null:
return update(_that);case SendMessageSelection() when selection != null:
return selection(_that);case SendMessageUnselect() when unselect != null:
return unselect(_that);case SendMessageInit() when init != null:
return init(_that);case SendMessageJoin() when join != null:
return join(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SendMessageUpdate value)  update,required TResult Function( SendMessageSelection value)  selection,required TResult Function( SendMessageUnselect value)  unselect,required TResult Function( SendMessageInit value)  init,required TResult Function( SendMessageJoin value)  join,}){
final _that = this;
switch (_that) {
case SendMessageUpdate():
return update(_that);case SendMessageSelection():
return selection(_that);case SendMessageUnselect():
return unselect(_that);case SendMessageInit():
return init(_that);case SendMessageJoin():
return join(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SendMessageUpdate value)?  update,TResult? Function( SendMessageSelection value)?  selection,TResult? Function( SendMessageUnselect value)?  unselect,TResult? Function( SendMessageInit value)?  init,TResult? Function( SendMessageJoin value)?  join,}){
final _that = this;
switch (_that) {
case SendMessageUpdate() when update != null:
return update(_that);case SendMessageSelection() when selection != null:
return selection(_that);case SendMessageUnselect() when unselect != null:
return unselect(_that);case SendMessageInit() when init != null:
return init(_that);case SendMessageJoin() when join != null:
return join(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function(@Uint8ListConverter()  Uint8List bytes)?  update,TResult Function( int start,  int end)?  selection,TResult Function()?  unselect,TResult Function(@Uint8ListConverter()  Uint8List bytes,  Map<String, Selection> selections,  String to)?  init,TResult Function(@Uint8ListConverter()  Uint8List bytes)?  join,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SendMessageUpdate() when update != null:
return update(_that.bytes);case SendMessageSelection() when selection != null:
return selection(_that.start,_that.end);case SendMessageUnselect() when unselect != null:
return unselect();case SendMessageInit() when init != null:
return init(_that.bytes,_that.selections,_that.to);case SendMessageJoin() when join != null:
return join(_that.bytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function(@Uint8ListConverter()  Uint8List bytes)  update,required TResult Function( int start,  int end)  selection,required TResult Function()  unselect,required TResult Function(@Uint8ListConverter()  Uint8List bytes,  Map<String, Selection> selections,  String to)  init,required TResult Function(@Uint8ListConverter()  Uint8List bytes)  join,}) {final _that = this;
switch (_that) {
case SendMessageUpdate():
return update(_that.bytes);case SendMessageSelection():
return selection(_that.start,_that.end);case SendMessageUnselect():
return unselect();case SendMessageInit():
return init(_that.bytes,_that.selections,_that.to);case SendMessageJoin():
return join(_that.bytes);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function(@Uint8ListConverter()  Uint8List bytes)?  update,TResult? Function( int start,  int end)?  selection,TResult? Function()?  unselect,TResult? Function(@Uint8ListConverter()  Uint8List bytes,  Map<String, Selection> selections,  String to)?  init,TResult? Function(@Uint8ListConverter()  Uint8List bytes)?  join,}) {final _that = this;
switch (_that) {
case SendMessageUpdate() when update != null:
return update(_that.bytes);case SendMessageSelection() when selection != null:
return selection(_that.start,_that.end);case SendMessageUnselect() when unselect != null:
return unselect();case SendMessageInit() when init != null:
return init(_that.bytes,_that.selections,_that.to);case SendMessageJoin() when join != null:
return join(_that.bytes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class SendMessageUpdate implements SendMessage {
  const SendMessageUpdate({@Uint8ListConverter() required this.bytes, final  String? $type}): $type = $type ?? 'update';
  factory SendMessageUpdate.fromJson(Map<String, dynamic> json) => _$SendMessageUpdateFromJson(json);

@Uint8ListConverter() final  Uint8List bytes;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SendMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendMessageUpdateCopyWith<SendMessageUpdate> get copyWith => _$SendMessageUpdateCopyWithImpl<SendMessageUpdate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendMessageUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendMessageUpdate&&const DeepCollectionEquality().equals(other.bytes, bytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes));

@override
String toString() {
  return 'SendMessage.update(bytes: $bytes)';
}


}

/// @nodoc
abstract mixin class $SendMessageUpdateCopyWith<$Res> implements $SendMessageCopyWith<$Res> {
  factory $SendMessageUpdateCopyWith(SendMessageUpdate value, $Res Function(SendMessageUpdate) _then) = _$SendMessageUpdateCopyWithImpl;
@useResult
$Res call({
@Uint8ListConverter() Uint8List bytes
});




}
/// @nodoc
class _$SendMessageUpdateCopyWithImpl<$Res>
    implements $SendMessageUpdateCopyWith<$Res> {
  _$SendMessageUpdateCopyWithImpl(this._self, this._then);

  final SendMessageUpdate _self;
  final $Res Function(SendMessageUpdate) _then;

/// Create a copy of SendMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bytes = null,}) {
  return _then(SendMessageUpdate(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SendMessageSelection implements SendMessage {
  const SendMessageSelection({required this.start, required this.end, final  String? $type}): $type = $type ?? 'selection';
  factory SendMessageSelection.fromJson(Map<String, dynamic> json) => _$SendMessageSelectionFromJson(json);

 final  int start;
 final  int end;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SendMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendMessageSelectionCopyWith<SendMessageSelection> get copyWith => _$SendMessageSelectionCopyWithImpl<SendMessageSelection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendMessageSelectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendMessageSelection&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end);

@override
String toString() {
  return 'SendMessage.selection(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class $SendMessageSelectionCopyWith<$Res> implements $SendMessageCopyWith<$Res> {
  factory $SendMessageSelectionCopyWith(SendMessageSelection value, $Res Function(SendMessageSelection) _then) = _$SendMessageSelectionCopyWithImpl;
@useResult
$Res call({
 int start, int end
});




}
/// @nodoc
class _$SendMessageSelectionCopyWithImpl<$Res>
    implements $SendMessageSelectionCopyWith<$Res> {
  _$SendMessageSelectionCopyWithImpl(this._self, this._then);

  final SendMessageSelection _self;
  final $Res Function(SendMessageSelection) _then;

/// Create a copy of SendMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,}) {
  return _then(SendMessageSelection(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SendMessageUnselect implements SendMessage {
  const SendMessageUnselect({final  String? $type}): $type = $type ?? 'unselect';
  factory SendMessageUnselect.fromJson(Map<String, dynamic> json) => _$SendMessageUnselectFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$SendMessageUnselectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendMessageUnselect);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SendMessage.unselect()';
}


}




/// @nodoc
@JsonSerializable()

class SendMessageInit implements SendMessage {
  const SendMessageInit({@Uint8ListConverter() required this.bytes, required final  Map<String, Selection> selections, required this.to, final  String? $type}): _selections = selections,$type = $type ?? 'init';
  factory SendMessageInit.fromJson(Map<String, dynamic> json) => _$SendMessageInitFromJson(json);

@Uint8ListConverter() final  Uint8List bytes;
 final  Map<String, Selection> _selections;
 Map<String, Selection> get selections {
  if (_selections is EqualUnmodifiableMapView) return _selections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_selections);
}

 final  String to;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SendMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendMessageInitCopyWith<SendMessageInit> get copyWith => _$SendMessageInitCopyWithImpl<SendMessageInit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendMessageInitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendMessageInit&&const DeepCollectionEquality().equals(other.bytes, bytes)&&const DeepCollectionEquality().equals(other._selections, _selections)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes),const DeepCollectionEquality().hash(_selections),to);

@override
String toString() {
  return 'SendMessage.init(bytes: $bytes, selections: $selections, to: $to)';
}


}

/// @nodoc
abstract mixin class $SendMessageInitCopyWith<$Res> implements $SendMessageCopyWith<$Res> {
  factory $SendMessageInitCopyWith(SendMessageInit value, $Res Function(SendMessageInit) _then) = _$SendMessageInitCopyWithImpl;
@useResult
$Res call({
@Uint8ListConverter() Uint8List bytes, Map<String, Selection> selections, String to
});




}
/// @nodoc
class _$SendMessageInitCopyWithImpl<$Res>
    implements $SendMessageInitCopyWith<$Res> {
  _$SendMessageInitCopyWithImpl(this._self, this._then);

  final SendMessageInit _self;
  final $Res Function(SendMessageInit) _then;

/// Create a copy of SendMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bytes = null,Object? selections = null,Object? to = null,}) {
  return _then(SendMessageInit(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,selections: null == selections ? _self._selections : selections // ignore: cast_nullable_to_non_nullable
as Map<String, Selection>,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SendMessageJoin implements SendMessage {
  const SendMessageJoin({@Uint8ListConverter() required this.bytes, final  String? $type}): $type = $type ?? 'join';
  factory SendMessageJoin.fromJson(Map<String, dynamic> json) => _$SendMessageJoinFromJson(json);

@Uint8ListConverter() final  Uint8List bytes;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SendMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendMessageJoinCopyWith<SendMessageJoin> get copyWith => _$SendMessageJoinCopyWithImpl<SendMessageJoin>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendMessageJoinToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendMessageJoin&&const DeepCollectionEquality().equals(other.bytes, bytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes));

@override
String toString() {
  return 'SendMessage.join(bytes: $bytes)';
}


}

/// @nodoc
abstract mixin class $SendMessageJoinCopyWith<$Res> implements $SendMessageCopyWith<$Res> {
  factory $SendMessageJoinCopyWith(SendMessageJoin value, $Res Function(SendMessageJoin) _then) = _$SendMessageJoinCopyWithImpl;
@useResult
$Res call({
@Uint8ListConverter() Uint8List bytes
});




}
/// @nodoc
class _$SendMessageJoinCopyWithImpl<$Res>
    implements $SendMessageJoinCopyWith<$Res> {
  _$SendMessageJoinCopyWithImpl(this._self, this._then);

  final SendMessageJoin _self;
  final $Res Function(SendMessageJoin) _then;

/// Create a copy of SendMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bytes = null,}) {
  return _then(SendMessageJoin(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

ReceiveMessage _$ReceiveMessageFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'welcome':
          return ReceiveMessageWelcome.fromJson(
            json
          );
                case 'update':
          return ReceiveMessageUpdate.fromJson(
            json
          );
                case 'selection':
          return ReceiveMessageSelection.fromJson(
            json
          );
                case 'unselect':
          return ReceiveMessageUnselect.fromJson(
            json
          );
                case 'read':
          return ReceiveMessageRead.fromJson(
            json
          );
                case 'init':
          return ReceiveMessageInit.fromJson(
            json
          );
                case 'connected':
          return ReceiveMessageConnected.fromJson(
            json
          );
                case 'disconnected':
          return ReceiveMessageDisconnected.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'ReceiveMessage',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$ReceiveMessage {



  /// Serializes this ReceiveMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiveMessage);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReceiveMessage()';
}


}

/// @nodoc
class $ReceiveMessageCopyWith<$Res>  {
$ReceiveMessageCopyWith(ReceiveMessage _, $Res Function(ReceiveMessage) __);
}


/// Adds pattern-matching-related methods to [ReceiveMessage].
extension ReceiveMessagePatterns on ReceiveMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReceiveMessageWelcome value)?  welcome,TResult Function( ReceiveMessageUpdate value)?  update,TResult Function( ReceiveMessageSelection value)?  selection,TResult Function( ReceiveMessageUnselect value)?  unselect,TResult Function( ReceiveMessageRead value)?  read,TResult Function( ReceiveMessageInit value)?  init,TResult Function( ReceiveMessageConnected value)?  connected,TResult Function( ReceiveMessageDisconnected value)?  disconnected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReceiveMessageWelcome() when welcome != null:
return welcome(_that);case ReceiveMessageUpdate() when update != null:
return update(_that);case ReceiveMessageSelection() when selection != null:
return selection(_that);case ReceiveMessageUnselect() when unselect != null:
return unselect(_that);case ReceiveMessageRead() when read != null:
return read(_that);case ReceiveMessageInit() when init != null:
return init(_that);case ReceiveMessageConnected() when connected != null:
return connected(_that);case ReceiveMessageDisconnected() when disconnected != null:
return disconnected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReceiveMessageWelcome value)  welcome,required TResult Function( ReceiveMessageUpdate value)  update,required TResult Function( ReceiveMessageSelection value)  selection,required TResult Function( ReceiveMessageUnselect value)  unselect,required TResult Function( ReceiveMessageRead value)  read,required TResult Function( ReceiveMessageInit value)  init,required TResult Function( ReceiveMessageConnected value)  connected,required TResult Function( ReceiveMessageDisconnected value)  disconnected,}){
final _that = this;
switch (_that) {
case ReceiveMessageWelcome():
return welcome(_that);case ReceiveMessageUpdate():
return update(_that);case ReceiveMessageSelection():
return selection(_that);case ReceiveMessageUnselect():
return unselect(_that);case ReceiveMessageRead():
return read(_that);case ReceiveMessageInit():
return init(_that);case ReceiveMessageConnected():
return connected(_that);case ReceiveMessageDisconnected():
return disconnected(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReceiveMessageWelcome value)?  welcome,TResult? Function( ReceiveMessageUpdate value)?  update,TResult? Function( ReceiveMessageSelection value)?  selection,TResult? Function( ReceiveMessageUnselect value)?  unselect,TResult? Function( ReceiveMessageRead value)?  read,TResult? Function( ReceiveMessageInit value)?  init,TResult? Function( ReceiveMessageConnected value)?  connected,TResult? Function( ReceiveMessageDisconnected value)?  disconnected,}){
final _that = this;
switch (_that) {
case ReceiveMessageWelcome() when welcome != null:
return welcome(_that);case ReceiveMessageUpdate() when update != null:
return update(_that);case ReceiveMessageSelection() when selection != null:
return selection(_that);case ReceiveMessageUnselect() when unselect != null:
return unselect(_that);case ReceiveMessageRead() when read != null:
return read(_that);case ReceiveMessageInit() when init != null:
return init(_that);case ReceiveMessageConnected() when connected != null:
return connected(_that);case ReceiveMessageDisconnected() when disconnected != null:
return disconnected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String peerId)?  welcome,TResult Function(@Uint8ListConverter()  Uint8List bytes,  String peerId)?  update,TResult Function( int start,  int end,  String peerId)?  selection,TResult Function( String peerId)?  unselect,TResult Function(@Uint8ListConverter()  Uint8List bytes,  String from)?  read,TResult Function(@Uint8ListConverter()  Uint8List bytes,  Map<String, Selection> selections,  String to)?  init,TResult Function( String peerId)?  connected,TResult Function( String peerId)?  disconnected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReceiveMessageWelcome() when welcome != null:
return welcome(_that.peerId);case ReceiveMessageUpdate() when update != null:
return update(_that.bytes,_that.peerId);case ReceiveMessageSelection() when selection != null:
return selection(_that.start,_that.end,_that.peerId);case ReceiveMessageUnselect() when unselect != null:
return unselect(_that.peerId);case ReceiveMessageRead() when read != null:
return read(_that.bytes,_that.from);case ReceiveMessageInit() when init != null:
return init(_that.bytes,_that.selections,_that.to);case ReceiveMessageConnected() when connected != null:
return connected(_that.peerId);case ReceiveMessageDisconnected() when disconnected != null:
return disconnected(_that.peerId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String peerId)  welcome,required TResult Function(@Uint8ListConverter()  Uint8List bytes,  String peerId)  update,required TResult Function( int start,  int end,  String peerId)  selection,required TResult Function( String peerId)  unselect,required TResult Function(@Uint8ListConverter()  Uint8List bytes,  String from)  read,required TResult Function(@Uint8ListConverter()  Uint8List bytes,  Map<String, Selection> selections,  String to)  init,required TResult Function( String peerId)  connected,required TResult Function( String peerId)  disconnected,}) {final _that = this;
switch (_that) {
case ReceiveMessageWelcome():
return welcome(_that.peerId);case ReceiveMessageUpdate():
return update(_that.bytes,_that.peerId);case ReceiveMessageSelection():
return selection(_that.start,_that.end,_that.peerId);case ReceiveMessageUnselect():
return unselect(_that.peerId);case ReceiveMessageRead():
return read(_that.bytes,_that.from);case ReceiveMessageInit():
return init(_that.bytes,_that.selections,_that.to);case ReceiveMessageConnected():
return connected(_that.peerId);case ReceiveMessageDisconnected():
return disconnected(_that.peerId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String peerId)?  welcome,TResult? Function(@Uint8ListConverter()  Uint8List bytes,  String peerId)?  update,TResult? Function( int start,  int end,  String peerId)?  selection,TResult? Function( String peerId)?  unselect,TResult? Function(@Uint8ListConverter()  Uint8List bytes,  String from)?  read,TResult? Function(@Uint8ListConverter()  Uint8List bytes,  Map<String, Selection> selections,  String to)?  init,TResult? Function( String peerId)?  connected,TResult? Function( String peerId)?  disconnected,}) {final _that = this;
switch (_that) {
case ReceiveMessageWelcome() when welcome != null:
return welcome(_that.peerId);case ReceiveMessageUpdate() when update != null:
return update(_that.bytes,_that.peerId);case ReceiveMessageSelection() when selection != null:
return selection(_that.start,_that.end,_that.peerId);case ReceiveMessageUnselect() when unselect != null:
return unselect(_that.peerId);case ReceiveMessageRead() when read != null:
return read(_that.bytes,_that.from);case ReceiveMessageInit() when init != null:
return init(_that.bytes,_that.selections,_that.to);case ReceiveMessageConnected() when connected != null:
return connected(_that.peerId);case ReceiveMessageDisconnected() when disconnected != null:
return disconnected(_that.peerId);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class ReceiveMessageWelcome implements ReceiveMessage {
  const ReceiveMessageWelcome({required this.peerId, final  String? $type}): $type = $type ?? 'welcome';
  factory ReceiveMessageWelcome.fromJson(Map<String, dynamic> json) => _$ReceiveMessageWelcomeFromJson(json);

 final  String peerId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiveMessageWelcomeCopyWith<ReceiveMessageWelcome> get copyWith => _$ReceiveMessageWelcomeCopyWithImpl<ReceiveMessageWelcome>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiveMessageWelcomeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiveMessageWelcome&&(identical(other.peerId, peerId) || other.peerId == peerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,peerId);

@override
String toString() {
  return 'ReceiveMessage.welcome(peerId: $peerId)';
}


}

/// @nodoc
abstract mixin class $ReceiveMessageWelcomeCopyWith<$Res> implements $ReceiveMessageCopyWith<$Res> {
  factory $ReceiveMessageWelcomeCopyWith(ReceiveMessageWelcome value, $Res Function(ReceiveMessageWelcome) _then) = _$ReceiveMessageWelcomeCopyWithImpl;
@useResult
$Res call({
 String peerId
});




}
/// @nodoc
class _$ReceiveMessageWelcomeCopyWithImpl<$Res>
    implements $ReceiveMessageWelcomeCopyWith<$Res> {
  _$ReceiveMessageWelcomeCopyWithImpl(this._self, this._then);

  final ReceiveMessageWelcome _self;
  final $Res Function(ReceiveMessageWelcome) _then;

/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? peerId = null,}) {
  return _then(ReceiveMessageWelcome(
peerId: null == peerId ? _self.peerId : peerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class ReceiveMessageUpdate implements ReceiveMessage {
  const ReceiveMessageUpdate({@Uint8ListConverter() required this.bytes, required this.peerId, final  String? $type}): $type = $type ?? 'update';
  factory ReceiveMessageUpdate.fromJson(Map<String, dynamic> json) => _$ReceiveMessageUpdateFromJson(json);

@Uint8ListConverter() final  Uint8List bytes;
 final  String peerId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiveMessageUpdateCopyWith<ReceiveMessageUpdate> get copyWith => _$ReceiveMessageUpdateCopyWithImpl<ReceiveMessageUpdate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiveMessageUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiveMessageUpdate&&const DeepCollectionEquality().equals(other.bytes, bytes)&&(identical(other.peerId, peerId) || other.peerId == peerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes),peerId);

@override
String toString() {
  return 'ReceiveMessage.update(bytes: $bytes, peerId: $peerId)';
}


}

/// @nodoc
abstract mixin class $ReceiveMessageUpdateCopyWith<$Res> implements $ReceiveMessageCopyWith<$Res> {
  factory $ReceiveMessageUpdateCopyWith(ReceiveMessageUpdate value, $Res Function(ReceiveMessageUpdate) _then) = _$ReceiveMessageUpdateCopyWithImpl;
@useResult
$Res call({
@Uint8ListConverter() Uint8List bytes, String peerId
});




}
/// @nodoc
class _$ReceiveMessageUpdateCopyWithImpl<$Res>
    implements $ReceiveMessageUpdateCopyWith<$Res> {
  _$ReceiveMessageUpdateCopyWithImpl(this._self, this._then);

  final ReceiveMessageUpdate _self;
  final $Res Function(ReceiveMessageUpdate) _then;

/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bytes = null,Object? peerId = null,}) {
  return _then(ReceiveMessageUpdate(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,peerId: null == peerId ? _self.peerId : peerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class ReceiveMessageSelection implements ReceiveMessage {
  const ReceiveMessageSelection({required this.start, required this.end, required this.peerId, final  String? $type}): $type = $type ?? 'selection';
  factory ReceiveMessageSelection.fromJson(Map<String, dynamic> json) => _$ReceiveMessageSelectionFromJson(json);

 final  int start;
 final  int end;
 final  String peerId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiveMessageSelectionCopyWith<ReceiveMessageSelection> get copyWith => _$ReceiveMessageSelectionCopyWithImpl<ReceiveMessageSelection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiveMessageSelectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiveMessageSelection&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.peerId, peerId) || other.peerId == peerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end,peerId);

@override
String toString() {
  return 'ReceiveMessage.selection(start: $start, end: $end, peerId: $peerId)';
}


}

/// @nodoc
abstract mixin class $ReceiveMessageSelectionCopyWith<$Res> implements $ReceiveMessageCopyWith<$Res> {
  factory $ReceiveMessageSelectionCopyWith(ReceiveMessageSelection value, $Res Function(ReceiveMessageSelection) _then) = _$ReceiveMessageSelectionCopyWithImpl;
@useResult
$Res call({
 int start, int end, String peerId
});




}
/// @nodoc
class _$ReceiveMessageSelectionCopyWithImpl<$Res>
    implements $ReceiveMessageSelectionCopyWith<$Res> {
  _$ReceiveMessageSelectionCopyWithImpl(this._self, this._then);

  final ReceiveMessageSelection _self;
  final $Res Function(ReceiveMessageSelection) _then;

/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,Object? peerId = null,}) {
  return _then(ReceiveMessageSelection(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as int,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as int,peerId: null == peerId ? _self.peerId : peerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class ReceiveMessageUnselect implements ReceiveMessage {
  const ReceiveMessageUnselect({required this.peerId, final  String? $type}): $type = $type ?? 'unselect';
  factory ReceiveMessageUnselect.fromJson(Map<String, dynamic> json) => _$ReceiveMessageUnselectFromJson(json);

 final  String peerId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiveMessageUnselectCopyWith<ReceiveMessageUnselect> get copyWith => _$ReceiveMessageUnselectCopyWithImpl<ReceiveMessageUnselect>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiveMessageUnselectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiveMessageUnselect&&(identical(other.peerId, peerId) || other.peerId == peerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,peerId);

@override
String toString() {
  return 'ReceiveMessage.unselect(peerId: $peerId)';
}


}

/// @nodoc
abstract mixin class $ReceiveMessageUnselectCopyWith<$Res> implements $ReceiveMessageCopyWith<$Res> {
  factory $ReceiveMessageUnselectCopyWith(ReceiveMessageUnselect value, $Res Function(ReceiveMessageUnselect) _then) = _$ReceiveMessageUnselectCopyWithImpl;
@useResult
$Res call({
 String peerId
});




}
/// @nodoc
class _$ReceiveMessageUnselectCopyWithImpl<$Res>
    implements $ReceiveMessageUnselectCopyWith<$Res> {
  _$ReceiveMessageUnselectCopyWithImpl(this._self, this._then);

  final ReceiveMessageUnselect _self;
  final $Res Function(ReceiveMessageUnselect) _then;

/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? peerId = null,}) {
  return _then(ReceiveMessageUnselect(
peerId: null == peerId ? _self.peerId : peerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ReceiveMessageRead implements ReceiveMessage {
  const ReceiveMessageRead({@Uint8ListConverter() required this.bytes, required this.from, final  String? $type}): $type = $type ?? 'read';
  factory ReceiveMessageRead.fromJson(Map<String, dynamic> json) => _$ReceiveMessageReadFromJson(json);

@Uint8ListConverter() final  Uint8List bytes;
 final  String from;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiveMessageReadCopyWith<ReceiveMessageRead> get copyWith => _$ReceiveMessageReadCopyWithImpl<ReceiveMessageRead>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiveMessageReadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiveMessageRead&&const DeepCollectionEquality().equals(other.bytes, bytes)&&(identical(other.from, from) || other.from == from));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes),from);

@override
String toString() {
  return 'ReceiveMessage.read(bytes: $bytes, from: $from)';
}


}

/// @nodoc
abstract mixin class $ReceiveMessageReadCopyWith<$Res> implements $ReceiveMessageCopyWith<$Res> {
  factory $ReceiveMessageReadCopyWith(ReceiveMessageRead value, $Res Function(ReceiveMessageRead) _then) = _$ReceiveMessageReadCopyWithImpl;
@useResult
$Res call({
@Uint8ListConverter() Uint8List bytes, String from
});




}
/// @nodoc
class _$ReceiveMessageReadCopyWithImpl<$Res>
    implements $ReceiveMessageReadCopyWith<$Res> {
  _$ReceiveMessageReadCopyWithImpl(this._self, this._then);

  final ReceiveMessageRead _self;
  final $Res Function(ReceiveMessageRead) _then;

/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bytes = null,Object? from = null,}) {
  return _then(ReceiveMessageRead(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ReceiveMessageInit implements ReceiveMessage {
  const ReceiveMessageInit({@Uint8ListConverter() required this.bytes, required final  Map<String, Selection> selections, required this.to, final  String? $type}): _selections = selections,$type = $type ?? 'init';
  factory ReceiveMessageInit.fromJson(Map<String, dynamic> json) => _$ReceiveMessageInitFromJson(json);

@Uint8ListConverter() final  Uint8List bytes;
 final  Map<String, Selection> _selections;
 Map<String, Selection> get selections {
  if (_selections is EqualUnmodifiableMapView) return _selections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_selections);
}

 final  String to;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiveMessageInitCopyWith<ReceiveMessageInit> get copyWith => _$ReceiveMessageInitCopyWithImpl<ReceiveMessageInit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiveMessageInitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiveMessageInit&&const DeepCollectionEquality().equals(other.bytes, bytes)&&const DeepCollectionEquality().equals(other._selections, _selections)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes),const DeepCollectionEquality().hash(_selections),to);

@override
String toString() {
  return 'ReceiveMessage.init(bytes: $bytes, selections: $selections, to: $to)';
}


}

/// @nodoc
abstract mixin class $ReceiveMessageInitCopyWith<$Res> implements $ReceiveMessageCopyWith<$Res> {
  factory $ReceiveMessageInitCopyWith(ReceiveMessageInit value, $Res Function(ReceiveMessageInit) _then) = _$ReceiveMessageInitCopyWithImpl;
@useResult
$Res call({
@Uint8ListConverter() Uint8List bytes, Map<String, Selection> selections, String to
});




}
/// @nodoc
class _$ReceiveMessageInitCopyWithImpl<$Res>
    implements $ReceiveMessageInitCopyWith<$Res> {
  _$ReceiveMessageInitCopyWithImpl(this._self, this._then);

  final ReceiveMessageInit _self;
  final $Res Function(ReceiveMessageInit) _then;

/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bytes = null,Object? selections = null,Object? to = null,}) {
  return _then(ReceiveMessageInit(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,selections: null == selections ? _self._selections : selections // ignore: cast_nullable_to_non_nullable
as Map<String, Selection>,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class ReceiveMessageConnected implements ReceiveMessage {
  const ReceiveMessageConnected({required this.peerId, final  String? $type}): $type = $type ?? 'connected';
  factory ReceiveMessageConnected.fromJson(Map<String, dynamic> json) => _$ReceiveMessageConnectedFromJson(json);

 final  String peerId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiveMessageConnectedCopyWith<ReceiveMessageConnected> get copyWith => _$ReceiveMessageConnectedCopyWithImpl<ReceiveMessageConnected>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiveMessageConnectedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiveMessageConnected&&(identical(other.peerId, peerId) || other.peerId == peerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,peerId);

@override
String toString() {
  return 'ReceiveMessage.connected(peerId: $peerId)';
}


}

/// @nodoc
abstract mixin class $ReceiveMessageConnectedCopyWith<$Res> implements $ReceiveMessageCopyWith<$Res> {
  factory $ReceiveMessageConnectedCopyWith(ReceiveMessageConnected value, $Res Function(ReceiveMessageConnected) _then) = _$ReceiveMessageConnectedCopyWithImpl;
@useResult
$Res call({
 String peerId
});




}
/// @nodoc
class _$ReceiveMessageConnectedCopyWithImpl<$Res>
    implements $ReceiveMessageConnectedCopyWith<$Res> {
  _$ReceiveMessageConnectedCopyWithImpl(this._self, this._then);

  final ReceiveMessageConnected _self;
  final $Res Function(ReceiveMessageConnected) _then;

/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? peerId = null,}) {
  return _then(ReceiveMessageConnected(
peerId: null == peerId ? _self.peerId : peerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class ReceiveMessageDisconnected implements ReceiveMessage {
  const ReceiveMessageDisconnected({required this.peerId, final  String? $type}): $type = $type ?? 'disconnected';
  factory ReceiveMessageDisconnected.fromJson(Map<String, dynamic> json) => _$ReceiveMessageDisconnectedFromJson(json);

 final  String peerId;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiveMessageDisconnectedCopyWith<ReceiveMessageDisconnected> get copyWith => _$ReceiveMessageDisconnectedCopyWithImpl<ReceiveMessageDisconnected>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReceiveMessageDisconnectedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiveMessageDisconnected&&(identical(other.peerId, peerId) || other.peerId == peerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,peerId);

@override
String toString() {
  return 'ReceiveMessage.disconnected(peerId: $peerId)';
}


}

/// @nodoc
abstract mixin class $ReceiveMessageDisconnectedCopyWith<$Res> implements $ReceiveMessageCopyWith<$Res> {
  factory $ReceiveMessageDisconnectedCopyWith(ReceiveMessageDisconnected value, $Res Function(ReceiveMessageDisconnected) _then) = _$ReceiveMessageDisconnectedCopyWithImpl;
@useResult
$Res call({
 String peerId
});




}
/// @nodoc
class _$ReceiveMessageDisconnectedCopyWithImpl<$Res>
    implements $ReceiveMessageDisconnectedCopyWith<$Res> {
  _$ReceiveMessageDisconnectedCopyWithImpl(this._self, this._then);

  final ReceiveMessageDisconnected _self;
  final $Res Function(ReceiveMessageDisconnected) _then;

/// Create a copy of ReceiveMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? peerId = null,}) {
  return _then(ReceiveMessageDisconnected(
peerId: null == peerId ? _self.peerId : peerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
