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

  int? _start;
  int? _end;

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

        if (_start != start || _end != end) {
          switch ((start, end)) {
            case (null, null):
              _start = null;
              _end = null;
              _sink(const ClientEvent.moved(selection: null));
            case (final s?, null):
              _start = s;
              _end = s;
              _sink(
                ClientEvent.moved(
                  selection: Selection(start: s, end: s),
                ),
              );
            case (null, final e?):
              _start = e;
              _end = e;
              _sink(
                ClientEvent.moved(
                  selection: Selection(start: e, end: e),
                ),
              );
            case (final s?, final e?):
              _start = s;
              _end = e;
              _sink(
                ClientEvent.moved(
                  selection: Selection(start: s, end: e),
                ),
              );
          }
        }
      },
    };
    action();
  }
}
