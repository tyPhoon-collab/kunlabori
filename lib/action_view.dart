import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/domain/model/client_event.dart';
import 'package:kunlabori/home_page.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;

class ActionView extends HookConsumerWidget {
  const ActionView({
    required this.focusNode,
    required this.docId,
    super.key,
  });

  final FocusNode focusNode;
  final String docId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int start() => ref.read(partialEventHandlerProvider).start ?? 0;
    int length() => ref.read(partialEventHandlerProvider).length ?? 0;
    final controller = useTextEditingController();

    void insert({
      required String id,
      int? position,
      String? text,
    }) {
      final pos = position ?? start();
      final txt = text ?? controller.text;

      if (txt.isEmpty) return;

      rust_api.insert(id: id, position: pos, text: txt);
      ref
          .read(collaboratorIndexesProvider.notifier)
          .setSelection(id, Selection.same(pos + txt.length));
      controller.clear();
    }

    void delete({
      required String id,
      int? position,
      int? deleteCount,
    }) {
      final pos = position ?? start();
      final count = deleteCount ?? length();
      if (count == 0) return;
      rust_api.delete(id: id, position: pos, deleteCount: count);
      ref
          .read(collaboratorIndexesProvider.notifier)
          .setSelection(id, Selection.same(pos));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Insert Text'),
            focusNode: focusNode,
            maxLines: null,
            expands: true,
          ),
        ),

        IconButton.filled(
          onPressed: () {
            insert(id: docId);
          },
          icon: const Icon(Icons.add),
          tooltip: 'Insert',
        ),
        IconButton.filled(
          onPressed: () {
            insert(id: docId, text: '\n');
          },
          icon: const Icon(Icons.keyboard_return),
          tooltip: 'New Line',
        ),
        IconButton.filled(
          onPressed: () {
            delete(id: docId);
          },
          icon: const Icon(Icons.delete),
          tooltip: 'Delete',
        ),
      ],
    );
  }
}
