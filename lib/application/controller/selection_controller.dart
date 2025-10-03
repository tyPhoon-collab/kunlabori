import 'package:kunlabori/domain/model/client_event.dart';
import 'package:kunlabori/domain/model/message.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;

final class SelectionController {
  SelectionController({
    required Send send,
  }) : _send = send;

  final Send _send;
  Selection? _selection;

  int? get start => _selection?.start;
  int? get end => _selection?.end;
  int? get length =>
      (_selection != null) ? _selection!.end - _selection!.start : null;

  void update(String id, Selection? selection) {
    _selection = selection;

    if (selection == null) {
      _send(const SendMessage.unselect());
      return;
    }

    rust_api.setSelection(id: id, start: selection.start, end: selection.end);
    _send(SendMessage.selection(start: selection.start, end: selection.end));
  }
}
