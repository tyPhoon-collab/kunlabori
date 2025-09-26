import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
sealed class SendMessage with _$SendMessage {
  const factory SendMessage.update({
    @Uint8ListConverter() required Uint8List bytes,
  }) = SendMessageUpdate;

  const factory SendMessage.selection({
    required int start,
    required int end,
  }) = SendMessageSelection;

  const factory SendMessage.unselect() = SendMessageUnselect;

  const factory SendMessage.init({
    @Uint8ListConverter() required Uint8List bytes,
    required String to,
  }) = SendMessageInit;

  const factory SendMessage.join({
    @Uint8ListConverter() required Uint8List bytes,
  }) = SendMessageJoin;

  factory SendMessage.fromJson(Map<String, dynamic> json) =>
      _$SendMessageFromJson(json);
}

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
sealed class ReceiveMessage with _$ReceiveMessage {
  const factory ReceiveMessage.update({
    @Uint8ListConverter() required Uint8List bytes,
    required String addr,
  }) = ReceiveMessageUpdate;

  const factory ReceiveMessage.selection({
    required int start,
    required int end,
    required String addr,
  }) = ReceiveMessageSelection;

  const factory ReceiveMessage.unselect({
    required String addr,
  }) = ReceiveMessageUnselect;

  const factory ReceiveMessage.read({
    @Uint8ListConverter() required Uint8List bytes,
    required String from,
  }) = ReceiveMessageRead;

  const factory ReceiveMessage.init({
    @Uint8ListConverter() required Uint8List bytes,
    required String to,
  }) = ReceiveMessageInit;

  const factory ReceiveMessage.connected({
    required String addr,
  }) = ReceiveMessageConnected;

  const factory ReceiveMessage.disconnected({
    required String addr,
  }) = ReceiveMessageDisconnected;

  factory ReceiveMessage.fromJson(Map<String, dynamic> json) =>
      _$ReceiveMessageFromJson(json);
}

class Uint8ListConverter implements JsonConverter<Uint8List, String> {
  const Uint8ListConverter();

  @override
  Uint8List fromJson(String json) => base64Decode(json);

  @override
  String toJson(Uint8List object) => base64Encode(object);
}
