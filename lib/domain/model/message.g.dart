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
  start: (json['start'] as num).toInt(),
  end: (json['end'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SendMessageSelectionToJson(
  SendMessageSelection instance,
) => <String, dynamic>{
  'start': instance.start,
  'end': instance.end,
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
      selections: (json['selections'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Selection.fromJson(e as Map<String, dynamic>)),
      ),
      to: json['to'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SendMessageInitToJson(SendMessageInit instance) =>
    <String, dynamic>{
      'bytes': const Uint8ListConverter().toJson(instance.bytes),
      'selections': instance.selections,
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

ReceiveMessageWelcome _$ReceiveMessageWelcomeFromJson(
  Map<String, dynamic> json,
) => ReceiveMessageWelcome(
  peerId: json['peer_id'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ReceiveMessageWelcomeToJson(
  ReceiveMessageWelcome instance,
) => <String, dynamic>{'peer_id': instance.peerId, 'type': instance.$type};

ReceiveMessageUpdate _$ReceiveMessageUpdateFromJson(
  Map<String, dynamic> json,
) => ReceiveMessageUpdate(
  bytes: const Uint8ListConverter().fromJson(json['bytes'] as String),
  peerId: json['peer_id'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ReceiveMessageUpdateToJson(
  ReceiveMessageUpdate instance,
) => <String, dynamic>{
  'bytes': const Uint8ListConverter().toJson(instance.bytes),
  'peer_id': instance.peerId,
  'type': instance.$type,
};

ReceiveMessageSelection _$ReceiveMessageSelectionFromJson(
  Map<String, dynamic> json,
) => ReceiveMessageSelection(
  start: (json['start'] as num).toInt(),
  end: (json['end'] as num).toInt(),
  peerId: json['peer_id'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ReceiveMessageSelectionToJson(
  ReceiveMessageSelection instance,
) => <String, dynamic>{
  'start': instance.start,
  'end': instance.end,
  'peer_id': instance.peerId,
  'type': instance.$type,
};

ReceiveMessageUnselect _$ReceiveMessageUnselectFromJson(
  Map<String, dynamic> json,
) => ReceiveMessageUnselect(
  peerId: json['peer_id'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ReceiveMessageUnselectToJson(
  ReceiveMessageUnselect instance,
) => <String, dynamic>{'peer_id': instance.peerId, 'type': instance.$type};

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
      selections: (json['selections'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Selection.fromJson(e as Map<String, dynamic>)),
      ),
      to: json['to'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ReceiveMessageInitToJson(ReceiveMessageInit instance) =>
    <String, dynamic>{
      'bytes': const Uint8ListConverter().toJson(instance.bytes),
      'selections': instance.selections,
      'to': instance.to,
      'type': instance.$type,
    };

ReceiveMessageConnected _$ReceiveMessageConnectedFromJson(
  Map<String, dynamic> json,
) => ReceiveMessageConnected(
  peerId: json['peer_id'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ReceiveMessageConnectedToJson(
  ReceiveMessageConnected instance,
) => <String, dynamic>{'peer_id': instance.peerId, 'type': instance.$type};

ReceiveMessageDisconnected _$ReceiveMessageDisconnectedFromJson(
  Map<String, dynamic> json,
) => ReceiveMessageDisconnected(
  peerId: json['peer_id'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ReceiveMessageDisconnectedToJson(
  ReceiveMessageDisconnected instance,
) => <String, dynamic>{'peer_id': instance.peerId, 'type': instance.$type};
