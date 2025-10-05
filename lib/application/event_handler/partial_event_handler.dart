import 'package:kunlabori/application/controller/selection_controller.dart';
import 'package:kunlabori/domain/model/client_event.dart';
import 'package:kunlabori/domain/model/message.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;
import 'package:kunlabori/src/rust/api/model.dart';

final class PartialEventHandler {
  PartialEventHandler({
    required this.id,
    required Send send,
    required Sink sink,
    required SelectionController selectionController,
  }) : _send = send,
       _sink = sink,
       _selectionController = selectionController;

  final String id;
  final Send _send;
  final Sink _sink;
  final SelectionController _selectionController;

  void handle(Partial partial) {
    final action = switch (partial) {
      Partial_Delta(:final field0) => () => _sink(
        ClientEvent.delta(delta: field0),
      ),
      Partial_Text(:final field0) => () => _sink(
        ClientEvent.text(text: field0),
      ),
      Partial_Update(:final bytes, :final remote) => () {
        if (!remote) {
          _send(SendMessage.update(bytes: bytes));
        }
        final stickySelection = rust_api.selection(id: id);

        final newSelection = switch (stickySelection) {
          (null, null) => null,
          (final s?, null) => Selection(start: s, end: s),
          (null, final e?) => Selection(start: e, end: e),
          (final s?, final e?) => Selection(start: s, end: e),
        };
        _selectionController.value = newSelection;
      },
    };
    action();
  }
}
