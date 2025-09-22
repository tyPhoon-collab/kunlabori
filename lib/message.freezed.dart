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
Message _$MessageFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'connected':
          return MessageConnected.fromJson(
            json
          );
                case 'update':
          return MessageUpdate.fromJson(
            json
          );
                case 'read':
          return MessageRead.fromJson(
            json
          );
                case 'init':
          return MessageInit.fromJson(
            json
          );
                case 'join':
          return MessageJoin.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'Message',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$Message {



  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Message);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Message()';
}


}

/// @nodoc
class $MessageCopyWith<$Res>  {
$MessageCopyWith(Message _, $Res Function(Message) __);
}


/// Adds pattern-matching-related methods to [Message].
extension MessagePatterns on Message {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MessageConnected value)?  connected,TResult Function( MessageUpdate value)?  update,TResult Function( MessageRead value)?  read,TResult Function( MessageInit value)?  init,TResult Function( MessageJoin value)?  join,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MessageConnected() when connected != null:
return connected(_that);case MessageUpdate() when update != null:
return update(_that);case MessageRead() when read != null:
return read(_that);case MessageInit() when init != null:
return init(_that);case MessageJoin() when join != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MessageConnected value)  connected,required TResult Function( MessageUpdate value)  update,required TResult Function( MessageRead value)  read,required TResult Function( MessageInit value)  init,required TResult Function( MessageJoin value)  join,}){
final _that = this;
switch (_that) {
case MessageConnected():
return connected(_that);case MessageUpdate():
return update(_that);case MessageRead():
return read(_that);case MessageInit():
return init(_that);case MessageJoin():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MessageConnected value)?  connected,TResult? Function( MessageUpdate value)?  update,TResult? Function( MessageRead value)?  read,TResult? Function( MessageInit value)?  init,TResult? Function( MessageJoin value)?  join,}){
final _that = this;
switch (_that) {
case MessageConnected() when connected != null:
return connected(_that);case MessageUpdate() when update != null:
return update(_that);case MessageRead() when read != null:
return read(_that);case MessageInit() when init != null:
return init(_that);case MessageJoin() when join != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String addr)?  connected,TResult Function(@Uint8ListConverter()  Uint8List bytes)?  update,TResult Function(@Uint8ListConverter()  Uint8List bytes,  String from)?  read,TResult Function(@Uint8ListConverter()  Uint8List bytes,  String to)?  init,TResult Function(@Uint8ListConverter()  Uint8List bytes)?  join,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MessageConnected() when connected != null:
return connected(_that.addr);case MessageUpdate() when update != null:
return update(_that.bytes);case MessageRead() when read != null:
return read(_that.bytes,_that.from);case MessageInit() when init != null:
return init(_that.bytes,_that.to);case MessageJoin() when join != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String addr)  connected,required TResult Function(@Uint8ListConverter()  Uint8List bytes)  update,required TResult Function(@Uint8ListConverter()  Uint8List bytes,  String from)  read,required TResult Function(@Uint8ListConverter()  Uint8List bytes,  String to)  init,required TResult Function(@Uint8ListConverter()  Uint8List bytes)  join,}) {final _that = this;
switch (_that) {
case MessageConnected():
return connected(_that.addr);case MessageUpdate():
return update(_that.bytes);case MessageRead():
return read(_that.bytes,_that.from);case MessageInit():
return init(_that.bytes,_that.to);case MessageJoin():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String addr)?  connected,TResult? Function(@Uint8ListConverter()  Uint8List bytes)?  update,TResult? Function(@Uint8ListConverter()  Uint8List bytes,  String from)?  read,TResult? Function(@Uint8ListConverter()  Uint8List bytes,  String to)?  init,TResult? Function(@Uint8ListConverter()  Uint8List bytes)?  join,}) {final _that = this;
switch (_that) {
case MessageConnected() when connected != null:
return connected(_that.addr);case MessageUpdate() when update != null:
return update(_that.bytes);case MessageRead() when read != null:
return read(_that.bytes,_that.from);case MessageInit() when init != null:
return init(_that.bytes,_that.to);case MessageJoin() when join != null:
return join(_that.bytes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class MessageConnected implements Message {
  const MessageConnected({required this.addr, final  String? $type}): $type = $type ?? 'connected';
  factory MessageConnected.fromJson(Map<String, dynamic> json) => _$MessageConnectedFromJson(json);

 final  String addr;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageConnectedCopyWith<MessageConnected> get copyWith => _$MessageConnectedCopyWithImpl<MessageConnected>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageConnectedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageConnected&&(identical(other.addr, addr) || other.addr == addr));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,addr);

@override
String toString() {
  return 'Message.connected(addr: $addr)';
}


}

/// @nodoc
abstract mixin class $MessageConnectedCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $MessageConnectedCopyWith(MessageConnected value, $Res Function(MessageConnected) _then) = _$MessageConnectedCopyWithImpl;
@useResult
$Res call({
 String addr
});




}
/// @nodoc
class _$MessageConnectedCopyWithImpl<$Res>
    implements $MessageConnectedCopyWith<$Res> {
  _$MessageConnectedCopyWithImpl(this._self, this._then);

  final MessageConnected _self;
  final $Res Function(MessageConnected) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? addr = null,}) {
  return _then(MessageConnected(
addr: null == addr ? _self.addr : addr // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class MessageUpdate implements Message {
  const MessageUpdate({@Uint8ListConverter() required this.bytes, final  String? $type}): $type = $type ?? 'update';
  factory MessageUpdate.fromJson(Map<String, dynamic> json) => _$MessageUpdateFromJson(json);

@Uint8ListConverter() final  Uint8List bytes;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageUpdateCopyWith<MessageUpdate> get copyWith => _$MessageUpdateCopyWithImpl<MessageUpdate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageUpdateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageUpdate&&const DeepCollectionEquality().equals(other.bytes, bytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes));

@override
String toString() {
  return 'Message.update(bytes: $bytes)';
}


}

/// @nodoc
abstract mixin class $MessageUpdateCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $MessageUpdateCopyWith(MessageUpdate value, $Res Function(MessageUpdate) _then) = _$MessageUpdateCopyWithImpl;
@useResult
$Res call({
@Uint8ListConverter() Uint8List bytes
});




}
/// @nodoc
class _$MessageUpdateCopyWithImpl<$Res>
    implements $MessageUpdateCopyWith<$Res> {
  _$MessageUpdateCopyWithImpl(this._self, this._then);

  final MessageUpdate _self;
  final $Res Function(MessageUpdate) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bytes = null,}) {
  return _then(MessageUpdate(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

/// @nodoc
@JsonSerializable()

class MessageRead implements Message {
  const MessageRead({@Uint8ListConverter() required this.bytes, required this.from, final  String? $type}): $type = $type ?? 'read';
  factory MessageRead.fromJson(Map<String, dynamic> json) => _$MessageReadFromJson(json);

@Uint8ListConverter() final  Uint8List bytes;
 final  String from;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageReadCopyWith<MessageRead> get copyWith => _$MessageReadCopyWithImpl<MessageRead>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageReadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageRead&&const DeepCollectionEquality().equals(other.bytes, bytes)&&(identical(other.from, from) || other.from == from));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes),from);

@override
String toString() {
  return 'Message.read(bytes: $bytes, from: $from)';
}


}

/// @nodoc
abstract mixin class $MessageReadCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $MessageReadCopyWith(MessageRead value, $Res Function(MessageRead) _then) = _$MessageReadCopyWithImpl;
@useResult
$Res call({
@Uint8ListConverter() Uint8List bytes, String from
});




}
/// @nodoc
class _$MessageReadCopyWithImpl<$Res>
    implements $MessageReadCopyWith<$Res> {
  _$MessageReadCopyWithImpl(this._self, this._then);

  final MessageRead _self;
  final $Res Function(MessageRead) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bytes = null,Object? from = null,}) {
  return _then(MessageRead(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class MessageInit implements Message {
  const MessageInit({@Uint8ListConverter() required this.bytes, required this.to, final  String? $type}): $type = $type ?? 'init';
  factory MessageInit.fromJson(Map<String, dynamic> json) => _$MessageInitFromJson(json);

@Uint8ListConverter() final  Uint8List bytes;
 final  String to;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageInitCopyWith<MessageInit> get copyWith => _$MessageInitCopyWithImpl<MessageInit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageInitToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageInit&&const DeepCollectionEquality().equals(other.bytes, bytes)&&(identical(other.to, to) || other.to == to));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes),to);

@override
String toString() {
  return 'Message.init(bytes: $bytes, to: $to)';
}


}

/// @nodoc
abstract mixin class $MessageInitCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $MessageInitCopyWith(MessageInit value, $Res Function(MessageInit) _then) = _$MessageInitCopyWithImpl;
@useResult
$Res call({
@Uint8ListConverter() Uint8List bytes, String to
});




}
/// @nodoc
class _$MessageInitCopyWithImpl<$Res>
    implements $MessageInitCopyWith<$Res> {
  _$MessageInitCopyWithImpl(this._self, this._then);

  final MessageInit _self;
  final $Res Function(MessageInit) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bytes = null,Object? to = null,}) {
  return _then(MessageInit(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class MessageJoin implements Message {
  const MessageJoin({@Uint8ListConverter() required this.bytes, final  String? $type}): $type = $type ?? 'join';
  factory MessageJoin.fromJson(Map<String, dynamic> json) => _$MessageJoinFromJson(json);

@Uint8ListConverter() final  Uint8List bytes;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageJoinCopyWith<MessageJoin> get copyWith => _$MessageJoinCopyWithImpl<MessageJoin>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageJoinToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageJoin&&const DeepCollectionEquality().equals(other.bytes, bytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes));

@override
String toString() {
  return 'Message.join(bytes: $bytes)';
}


}

/// @nodoc
abstract mixin class $MessageJoinCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $MessageJoinCopyWith(MessageJoin value, $Res Function(MessageJoin) _then) = _$MessageJoinCopyWithImpl;
@useResult
$Res call({
@Uint8ListConverter() Uint8List bytes
});




}
/// @nodoc
class _$MessageJoinCopyWithImpl<$Res>
    implements $MessageJoinCopyWith<$Res> {
  _$MessageJoinCopyWithImpl(this._self, this._then);

  final MessageJoin _self;
  final $Res Function(MessageJoin) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bytes = null,}) {
  return _then(MessageJoin(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

// dart format on
