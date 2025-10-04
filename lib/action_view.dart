import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/use_case_provider.dart';

class ActionView extends ConsumerWidget {
  const ActionView({
    required this.controller,
    required this.focusNode,
    required this.docId,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String docId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: _Body(
        controller: controller,
        focusNode: focusNode,
        docId: docId,
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({
    required this.controller,
    required this.focusNode,
    required this.docId,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String docId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useCase = ref.read(documentUseCaseProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12,
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'カーソル位置に挿入するテキスト',
              hintText: '入力してください',
              prefixIcon: Icon(Icons.text_fields_rounded, size: 20),
            ),
            focusNode: focusNode,
            textInputAction: TextInputAction.done,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                useCase.insert(id: docId, text: value);
                controller.clear();
                focusNode.requestFocus();
              }
            },
          ),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: 4,
            runSpacing: 4,
            children: [
              _ActionButton(
                icon: Icons.add_rounded,
                label: '挿入',
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    useCase.insert(id: docId, text: controller.text);
                    controller.clear();
                    focusNode.requestFocus();
                  }
                },
              ),
              _ActionButton(
                icon: Icons.keyboard_return_rounded,
                label: '改行',
                onPressed: () {
                  useCase.enter(id: docId);
                },
              ),
              _ActionButton(
                icon: Icons.backspace_outlined,
                label: '削除',
                onPressed: () {
                  useCase.backspace(id: docId);
                },
              ),
              _ActionButton(
                icon: Icons.undo_rounded,
                label: '元に戻す',
                onPressed: () {
                  useCase.undo(id: docId);
                },
              ),
              _ActionButton(
                icon: Icons.redo_rounded,
                label: 'やり直し',
                onPressed: () {
                  useCase.redo(id: docId);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      tooltip: label,
    );
  }
}
