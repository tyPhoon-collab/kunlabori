import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/domain/model/client_event.dart';
import 'package:kunlabori/home_page.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;

class DocumentController {
  const DocumentController(this.ref);
  final Ref ref;

  void insert({
    required String id,
    required int position,
    required String text,
  }) {
    if (text.isEmpty) return;

    rust_api.insert(id: id, position: position, text: text);
    ref
        .read(collaboratorIndexesProvider.notifier)
        .select(id, Selection.same(position + text.length));
  }

  void delete({
    required String id,
    required int position,
    required int deleteCount,
  }) {
    if (deleteCount == 0) return;
    rust_api.delete(id: id, position: position, deleteCount: deleteCount);
    ref
        .read(collaboratorIndexesProvider.notifier)
        .select(id, Selection.same(position));
  }

  void undo({
    required String id,
  }) {
    rust_api.undo(id: id);
  }

  void redo({
    required String id,
  }) {
    rust_api.redo(id: id);
  }
}
