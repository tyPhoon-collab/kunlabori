import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/application/controller/document_controller.dart';
import 'package:kunlabori/provider.dart';

class DocumentUseCase {
  DocumentUseCase(this.ref);
  final Ref ref;

  late final DocumentController controller = ref.read(
    documentControllerProvider,
  );

  int start() => ref.read(selectionControllerProvider).start ?? 0;
  int length() => ref.read(selectionControllerProvider).length ?? 0;

  void insert({
    required String id,
    required String text,
    int? position,
  }) {
    if (text.isEmpty) return;

    final pos = position ?? start();
    controller.insert(id: id, position: pos, text: text);
  }

  void backspace({
    required String id,
  }) {
    final pos = start();
    final count = length();

    if (count > 0) {
      // 選択範囲がある場合はそれを削除
      controller.delete(id: id, position: pos, deleteCount: count);
      return;
    } else {
      // 選択範囲がない場合は1文字削除
      if (pos <= 0) return;
      controller.delete(id: id, position: pos - 1, deleteCount: 1);
    }
  }

  void enter({
    required String id,
  }) {
    final pos = start();
    controller.insert(id: id, position: pos, text: '\n');
  }
}
