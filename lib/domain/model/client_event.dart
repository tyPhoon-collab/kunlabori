import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kunlabori/src/rust/api/model.dart';

part 'client_event.freezed.dart';

@immutable
final class Selection {
  const Selection({
    required this.start,
    required this.end,
  });

  const Selection.zero() : start = 0, end = 0;
  const Selection.same(int index) : start = index, end = index;

  final int start;
  final int end;

  @override
  int get hashCode => Object.hash(start, end);

  @override
  bool operator ==(Object other) {
    return other is Selection && other.start == start && other.end == end;
  }
}

@freezed
sealed class ClientEvent with _$ClientEvent {
  /// 初期状態
  const factory ClientEvent.init() = ClientEventInit;

  /// Websocketサーバーに接続した
  const factory ClientEvent.connected({required String addr}) =
      ClientEventConnected;

  /// Websocketサーバーから切断した
  const factory ClientEvent.disconnected({required String addr}) =
      ClientEventDisconnected;

  /// 他のユーザーがテキストを選択した
  const factory ClientEvent.selected({
    required Selection selection,
    required String addr,
  }) = ClientEventSelected;

  /// 他のユーザーがテキストの選択を解除した
  const factory ClientEvent.unselected({required String addr}) =
      ClientEventUnselected;

  /// テキストが更新された
  const factory ClientEvent.text({required String text}) = ClientEventText;

  /// テキストの一部が更新された
  const factory ClientEvent.delta({required SimpleDelta delta}) =
      ClientEventDelta;
}
