import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/use_case_provider.dart';

class ActionView extends HookConsumerWidget {
  const ActionView({
    required this.controller,
    required this.focusNode,
    required this.docId,
    this.onClose,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback? onClose;
  final String docId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = useState(const Offset(20, 20));

    return Positioned(
      left: position.value.dx,
      top: position.value.dy,
      child: Draggable<ActionView>(
        feedback: Material(
          child: ActionWindow(
            controller: controller,
            onClose: onClose,
            isDragging: true,
            focusNode: focusNode,
            docId: docId,
          ),
        ),
        childWhenDragging: const SizedBox.shrink(),
        onDragEnd: (details) {
          // Draggable の details.offset はグローバル座標。
          // Positioned は親 Stack のローカル座標を期待するため、祖先の RenderStack に変換する。
          final renderStack = context
              .findAncestorRenderObjectOfType<RenderStack>();
          if (renderStack case final renderStack?) {
            final local = renderStack.globalToLocal(details.offset);
            position.value = local;
          } else {
            // 万一 Stack が見つからない場合は従来挙動をフォールバック
            position.value = details.offset;
          }
        },
        child: ActionWindow(
          controller: controller,
          onClose: onClose,
          isDragging: false,
          focusNode: focusNode,
          docId: docId,
        ),
      ),
    );
  }
}

class ActionWindow extends StatelessWidget {
  const ActionWindow({
    required this.controller,
    required this.onClose,
    required this.isDragging,
    required this.focusNode,
    required this.docId,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback? onClose;
  final bool isDragging;
  final String docId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDragging ? 0.3 : 0.15),
            blurRadius: isDragging ? 20 : 10,
            offset: Offset(0, isDragging ? 8 : 4),
          ),
        ],
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Header(onClose: onClose),
          _Body(
            controller: controller,
            focusNode: focusNode,
            docId: docId,
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({this.onClose});

  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foregroundColor = colorScheme.onPrimaryContainer;
    final backgroundColor = colorScheme.primaryContainer;
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Icon(
            Icons.edit,
            size: 16,
            color: foregroundColor,
          ),
          const SizedBox(width: 8),
          Text(
            'Action Panel',
            style: TextStyle(
              color: foregroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          // Window controls (optional decorative elements)
          IconButton(
            onPressed: onClose,
            icon: Icon(Icons.close, size: 24, color: foregroundColor),
          ),
        ],
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
          SizedBox(
            height: 80,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Insert Text',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
              focusNode: focusNode,
              maxLines: null,
              expands: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ActionButton(
                icon: Icons.add,
                label: 'Insert',
                onPressed: () {
                  useCase.insert(id: docId, text: controller.text);
                  controller.clear();
                  focusNode.requestFocus();
                },
              ),
              _ActionButton(
                icon: Icons.keyboard_return,
                label: 'New Line',
                onPressed: () {
                  useCase.enter(id: docId);
                },
              ),
              _ActionButton(
                icon: Icons.delete,
                label: 'Delete',
                onPressed: () {
                  useCase.delete(id: docId);
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
        IconButton.filled(
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
          style: IconButton.styleFrom(
            minimumSize: const Size(40, 40),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: textTheme.labelSmall,
        ),
      ],
    );
  }
}
