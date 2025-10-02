import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/use_case_provider.dart';

/// ボトムシート形式のアクションパネル
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
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'テキスト',
              hintText: '入力してください',
              prefixIcon: const Icon(Icons.text_fields_rounded, size: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            focusNode: focusNode,
            maxLines: 2,
            style: const TextStyle(fontSize: 14),
            textInputAction: TextInputAction.done,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                useCase.insert(id: docId, text: value);
                controller.clear();
                focusNode.requestFocus();
              }
            },
          ),
          OverflowBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ActionButton(
                icon: Icons.add_circle_outline_rounded,
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
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.filledTonal(
          onPressed: onPressed,
          icon: Icon(icon, size: 22),
          style: IconButton.styleFrom(
            minimumSize: const Size(48, 48),
          ),
          tooltip: label,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
