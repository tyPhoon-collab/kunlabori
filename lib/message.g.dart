// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageConnected _$MessageConnectedFromJson(Map<String, dynamic> json) =>
    MessageConnected(
      addr: json['addr'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$MessageConnectedToJson(MessageConnected instance) =>
    <String, dynamic>{'addr': instance.addr, 'type': instance.$type};

MessageUpdate _$MessageUpdateFromJson(Map<String, dynamic> json) =>
    MessageUpdate(
      bytes: const Uint8ListConverter().fromJson(json['bytes'] as String),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$MessageUpdateToJson(MessageUpdate instance) =>
    <String, dynamic>{
      'bytes': const Uint8ListConverter().toJson(instance.bytes),
      'type': instance.$type,
    };

MessageRead _$MessageReadFromJson(Map<String, dynamic> json) => MessageRead(
  bytes: const Uint8ListConverter().fromJson(json['bytes'] as String),
  from: json['from'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$MessageReadToJson(MessageRead instance) =>
    <String, dynamic>{
      'bytes': const Uint8ListConverter().toJson(instance.bytes),
      'from': instance.from,
      'type': instance.$type,
    };

MessageInit _$MessageInitFromJson(Map<String, dynamic> json) => MessageInit(
  bytes: const Uint8ListConverter().fromJson(json['bytes'] as String),
  to: json['to'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$MessageInitToJson(MessageInit instance) =>
    <String, dynamic>{
      'bytes': const Uint8ListConverter().toJson(instance.bytes),
      'to': instance.to,
      'type': instance.$type,
    };

MessageJoin _$MessageJoinFromJson(Map<String, dynamic> json) => MessageJoin(
  bytes: const Uint8ListConverter().fromJson(json['bytes'] as String),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$MessageJoinToJson(MessageJoin instance) =>
    <String, dynamic>{
      'bytes': const Uint8ListConverter().toJson(instance.bytes),
      'type': instance.$type,
    };
