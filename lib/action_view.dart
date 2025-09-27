import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/provider.dart';

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
    final documentController = ref.read(documentControllerProvider);

    void insert({
      required String id,
      int? position,
      String? text,
    }) {
      final pos = position ?? start();
      final txt = text ?? controller.text;
      documentController.insert(
        id: id,
        position: pos,
        text: txt,
      );
    }

    void delete({
      required String id,
      int? position,
      int? deleteCount,
    }) {
      final pos = position ?? start();
      final count = deleteCount ?? length();
      documentController.delete(
        id: id,
        position: pos,
        deleteCount: count,
      );
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
            controller.clear();
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
