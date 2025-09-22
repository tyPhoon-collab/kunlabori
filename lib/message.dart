import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
sealed class Message with _$Message {
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  const factory Message.connected({
    required String addr,
  }) = MessageConnected;
  const factory Message.update({
    @Uint8ListConverter() required Uint8List bytes,
  }) = MessageUpdate;
  const factory Message.read({
    @Uint8ListConverter() required Uint8List bytes,
    required String from,
  }) = MessageRead;
  const factory Message.init({
    @Uint8ListConverter() required Uint8List bytes,
    required String to,
  }) = MessageInit;
  const factory Message.join({
    @Uint8ListConverter() required Uint8List bytes,
  }) = MessageJoin;
}

class Uint8ListConverter implements JsonConverter<Uint8List, String> {
  const Uint8ListConverter();

  @override
  Uint8List fromJson(String json) => base64Decode(json);

  @override
  String toJson(Uint8List object) => base64Encode(object);
}
