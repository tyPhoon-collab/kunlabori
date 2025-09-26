// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageUpdate _$SendMessageUpdateFromJson(Map<String, dynamic> json) =>
    SendMessageUpdate(
      bytes: const Uint8ListConverter().fromJson(json['bytes'] as String),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SendMessageUpdateToJson(SendMessageUpdate instance) =>
    <String, dynamic>{
      'bytes': const Uint8ListConverter().toJson(instance.bytes),
      'type': instance.$type,
    };

SendMessageSelection _$SendMessageSelectionFromJson(
  Map<String, dynamic> json,
) => SendMessageSelection(
  offset: (json['offset'] as num).toInt(),
  length: (json['length'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SendMessageSelectionToJson(
  SendMessageSelection instance,
) => <String, dynamic>{
  'offset': instance.offset,
  'length': instance.length,
  'type': instance.$type,
};

SendMessageUnselect _$SendMessageUnselectFromJson(Map<String, dynamic> json) =>
    SendMessageUnselect($type: json['type'] as String?);

Map<String, dynamic> _$SendMessageUnselectToJson(
  SendMessageUnselect instance,
) => <String, dynamic>{'type': instance.$type};

SendMessageInit _$SendMessageInitFromJson(Map<String, dynamic> json) =>
    SendMessageInit(
      bytes: const Uint8ListConverter().fromJson(json['bytes'] as String),
      to: json['to'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SendMessageInitToJson(SendMessageInit instance) =>
    <String, dynamic>{
      'bytes': const Uint8ListConverter().toJson(instance.bytes),
      'to': instance.to,
      'type': instance.$type,
    };

SendMessageJoin _$SendMessageJoinFromJson(Map<String, dynamic> json) =>
    SendMessageJoin(
      bytes: const Uint8ListConverter().fromJson(json['bytes'] as String),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SendMessageJoinToJson(SendMessageJoin instance) =>
    <String, dynamic>{
      'bytes': const Uint8ListConverter().toJson(instance.bytes),
      'type': instance.$type,
    };

ReceiveMessageUpdate _$ReceiveMessageUpdateFromJson(
  Map<String, dynamic> json,
) => ReceiveMessageUpdate(
  bytes: const Uint8ListConverter().fromJson(json['bytes'] as String),
  addr: json['addr'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ReceiveMessageUpdateToJson(
  ReceiveMessageUpdate instance,
) => <String, dynamic>{
  'bytes': const Uint8ListConverter().toJson(instance.bytes),
  'addr': instance.addr,
  'type': instance.$type,
};

ReceiveMessageSelection _$ReceiveMessageSelectionFromJson(
  Map<String, dynamic> json,
) => ReceiveMessageSelection(
  offset: (json['offset'] as num).toInt(),
  length: (json['length'] as num).toInt(),
  addr: json['addr'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ReceiveMessageSelectionToJson(
  ReceiveMessageSelection instance,
) => <String, dynamic>{
  'offset': instance.offset,
  'length': instance.length,
  'addr': instance.addr,
  'type': instance.$type,
};

ReceiveMessageUnselect _$ReceiveMessageUnselectFromJson(
  Map<String, dynamic> json,
) => ReceiveMessageUnselect(
  addr: json['addr'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ReceiveMessageUnselectToJson(
  ReceiveMessageUnselect instance,
) => <String, dynamic>{'addr': instance.addr, 'type': instance.$type};

ReceiveMessageRead _$ReceiveMessageReadFromJson(Map<String, dynamic> json) =>
    ReceiveMessageRead(
      bytes: const Uint8ListConverter().fromJson(json['bytes'] as String),
      from: json['from'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ReceiveMessageReadToJson(ReceiveMessageRead instance) =>
    <String, dynamic>{
      'bytes': const Uint8ListConverter().toJson(instance.bytes),
      'from': instance.from,
      'type': instance.$type,
    };

ReceiveMessageInit _$ReceiveMessageInitFromJson(Map<String, dynamic> json) =>
    ReceiveMessageInit(
      bytes: const Uint8ListConverter().fromJson(json['bytes'] as String),
      to: json['to'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ReceiveMessageInitToJson(ReceiveMessageInit instance) =>
    <String, dynamic>{
      'bytes': const Uint8ListConverter().toJson(instance.bytes),
      'to': instance.to,
      'type': instance.$type,
    };

ReceiveMessageConnected _$ReceiveMessageConnectedFromJson(
  Map<String, dynamic> json,
) => ReceiveMessageConnected(
  addr: json['addr'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ReceiveMessageConnectedToJson(
  ReceiveMessageConnected instance,
) => <String, dynamic>{'addr': instance.addr, 'type': instance.$type};

ReceiveMessageDisconnected _$ReceiveMessageDisconnectedFromJson(
  Map<String, dynamic> json,
) => ReceiveMessageDisconnected(
  addr: json['addr'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ReceiveMessageDisconnectedToJson(
  ReceiveMessageDisconnected instance,
) => <String, dynamic>{'addr': instance.addr, 'type': instance.$type};
