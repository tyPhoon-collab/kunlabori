import 'package:kunlabori/domain/model/client_event.dart';
import 'package:kunlabori/domain/model/message.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;
import 'package:kunlabori/src/rust/api/model.dart';

final class PartialEventHandler {
  PartialEventHandler({
    required Send send,
    required Sink sink,
  }) : _send = send,
       _sink = sink;

  final Send _send;
  final Sink _sink;
  Selection? _selection;

  int? get start => _selection?.start;
  int? get end => _selection?.end;
  int? get length =>
      (_selection != null) ? _selection!.end - _selection!.start : null;

  void setSelection(String id, Selection selection) {
    _selection = selection;
    rust_api.setSelection(id: id, start: selection.start, end: selection.end);
    _send(SendMessage.selection(start: selection.start, end: selection.end));
  }

  void handle(String id, Partial partial) {
    final action = switch (partial) {
      Partial_Delta(:final field0) => () => _sink(
        ClientEvent.delta(delta: field0),
      ),
      Partial_Text(:final field0) => () => _sink(
        ClientEvent.text(text: field0),
      ),
      Partial_Update(:final field0) => () {
        _send(SendMessage.update(bytes: field0));
        final stickySelection = rust_api.selection(id: id);
        final start = stickySelection.$1;
        final end = stickySelection.$2;

        if (_selection case final selection?
            when selection.start != start || selection.end != end) {
          switch ((start, end)) {
            case (null, null):
              _selection = null;
              _send(const SendMessage.unselect());
            case (final s?, null):
              setSelection(id, Selection(start: s, end: s));
            case (null, final e?):
              setSelection(id, Selection(start: e, end: e));
            case (final s?, final e?):
              setSelection(id, Selection(start: s, end: e));
          }
        }
      },
    };
    action();
  }
}
