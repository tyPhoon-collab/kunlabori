import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kunlabori/src/rust/api/model.dart';

part 'client_event.freezed.dart';
part 'client_event.g.dart';

@freezed
sealed class Selection with _$Selection {
  const factory Selection({
    required int start,
    required int end,
  }) = _Selection;

  factory Selection.zero() => const Selection(start: 0, end: 0);
  factory Selection.same(int index) => Selection(start: index, end: index);

  factory Selection.fromJson(Map<String, dynamic> json) =>
      _$SelectionFromJson(json);
}

@freezed
sealed class ClientEvent with _$ClientEvent {
  /// 初期状態
  const factory ClientEvent.init() = ClientEventInit;

  /// WebsocketサーバーからWelcomeメッセージを受け取った
  const factory ClientEvent.welcome({required String peerId}) =
      ClientEventWelcome;

  /// Websocketサーバーに接続した
  const factory ClientEvent.connected({required String peerId}) =
      ClientEventConnected;

  /// Websocketサーバーから切断した
  const factory ClientEvent.disconnected({required String peerId}) =
      ClientEventDisconnected;

  /// 他のユーザーがテキストを選択した
  const factory ClientEvent.selected({
    required Selection selection,
    required String peerId,
  }) = ClientEventSelected;

  /// 他のユーザーがテキストの選択を解除した
  const factory ClientEvent.unselected({required String peerId}) =
      ClientEventUnselected;

  /// テキストが更新された
  const factory ClientEvent.text({required String text}) = ClientEventText;

  /// テキストの一部が更新された
  const factory ClientEvent.delta({required SimpleDelta delta}) =
      ClientEventDelta;
}
