import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/use_case_provider.dart';

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
    final controller = useTextEditingController();
    final useCase = ref.read(documentUseCaseProvider);

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
            useCase.insert(id: docId, text: controller.text);
            controller.clear();
            focusNode.requestFocus();
          },
          icon: const Icon(Icons.add),
          tooltip: 'Insert',
        ),
        IconButton.filled(
          onPressed: () {
            useCase.enter(id: docId);
          },
          icon: const Icon(Icons.keyboard_return),
          tooltip: 'New Line',
        ),
        IconButton.filled(
          onPressed: () {
            useCase.delete(id: docId);
          },
          icon: const Icon(Icons.delete),
          tooltip: 'Delete',
        ),
      ],
    );
  }
}
