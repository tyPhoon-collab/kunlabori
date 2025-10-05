import 'package:flutter/material.dart';
import 'package:kunlabori/domain/model/client_event.dart';
import 'package:kunlabori/domain/model/message.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;

final class SelectionController extends ValueNotifier<Selection?> {
  SelectionController({
    required this.id,
    required Send send,
  }) : _send = send,
       super(null);

  final String id;
  final Send _send;

  int? get start => value?.start;
  int? get end => value?.end;
  int? get length => (value != null) ? value!.end - value!.start : null;

  @override
  set value(Selection? selection) {
    if (super.value == selection) return;
    if (selection == null) {
      _send(const SendMessage.unselect());
      return;
    }

    rust_api.setSelection(id: id, start: selection.start, end: selection.end);
    _send(SendMessage.selection(start: selection.start, end: selection.end));

    super.value = selection;
  }
}
