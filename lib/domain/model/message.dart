// JsonSerializableとFreezedの相性が悪い
// コンストラクタにJsonSerializableを指定すると以下の警告が出るため、このファイルでは無視する
// ignore_for_file: invalid_annotation_target

import 'dart:convert';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kunlabori/domain/model/client_event.dart';

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
    required Map<String, Selection> selections,
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
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ReceiveMessage.welcome({
    required String peerId,
  }) = ReceiveMessageWelcome;

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ReceiveMessage.update({
    @Uint8ListConverter() required Uint8List bytes,
    required String peerId,
  }) = ReceiveMessageUpdate;

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ReceiveMessage.selection({
    required int start,
    required int end,
    required String peerId,
  }) = ReceiveMessageSelection;

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ReceiveMessage.unselect({
    required String peerId,
  }) = ReceiveMessageUnselect;

  const factory ReceiveMessage.read({
    @Uint8ListConverter() required Uint8List bytes,
    required String from,
  }) = ReceiveMessageRead;

  const factory ReceiveMessage.init({
    @Uint8ListConverter() required Uint8List bytes,
    required Map<String, Selection> selections,
    required String to,
  }) = ReceiveMessageInit;

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ReceiveMessage.connected({
    required String peerId,
  }) = ReceiveMessageConnected;

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ReceiveMessage.disconnected({
    required String peerId,
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
