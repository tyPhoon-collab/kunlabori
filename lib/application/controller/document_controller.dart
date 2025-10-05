import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/domain/model/client_event.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;
import 'package:kunlabori/src/rust/api/model.dart';

class DocumentController {
  DocumentController(this.ref, {required this.id});
  final Ref ref;
  final String id;

  StreamSubscription<Partial>? _subscription;

  void create() {
    _subscription = rust_api.create(id: id, existsOk: true).listen(
      (partial) {
        // debugPrint('Stream partial: $partial');
        ref.read(partialEventHandlerProvider(id)).handle(partial);
      },
    );
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
    _subscription = null;
  }

  void insert({
    required int position,
    required String text,
  }) {
    if (text.isEmpty) return;

    rust_api.insert(id: id, position: position, text: text);
    ref.read(selectionControllerProvider(id)).value = Selection.same(
      position + text.length,
    );
  }

  void delete({
    required int position,
    required int deleteCount,
  }) {
    if (deleteCount == 0) return;
    rust_api.delete(id: id, position: position, deleteCount: deleteCount);
    ref.read(selectionControllerProvider(id)).value = Selection.same(position);
  }

  void undo() {
    rust_api.undo(id: id);
  }

  void redo() {
    rust_api.redo(id: id);
  }
}
