import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CollaboratorSelection {
  CollaboratorSelection({
    required this.start,
    required this.end,
    required this.color,
    required this.name,
  });
  final int start;
  final int end;
  final Color color;
  final String name;
}

class CollaborativeSelectableText extends HookWidget {
  const CollaborativeSelectableText(
    this.text, {
    required this.collaboratorSelections,
    required this.textStyle,
    super.key,
    this.caretWidth = 2.0,
    this.caretBlinkDuration = const Duration(milliseconds: 500),
    this.cursorMoveAnimDuration = const Duration(milliseconds: 100),
    this.selectionOpacity = 0.28,
    this.onTap,
    this.onSelectionChanged,
  });

  final String text;
  final TextStyle textStyle;
  final List<CollaboratorSelection> collaboratorSelections;

  final double caretWidth;
  final Duration caretBlinkDuration;
  final Duration cursorMoveAnimDuration;
  final double selectionOpacity;

  final VoidCallback? onTap;
  final SelectionChangedCallback? onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    final blinkController = useAnimationController(
      duration: caretBlinkDuration,
    );

    final blinkOpacity = useMemoized(
      () => Tween<double>(begin: 1, end: 0.2).animate(
        CurvedAnimation(parent: blinkController, curve: Curves.easeInOut),
      ),
      [blinkController],
    );

    // アニメーションの開始
    useEffect(() {
      blinkController.repeat(reverse: true);
      return null;
    }, [blinkController]);

    // TextPainterのキャッシュ
    final textPainterCache = useRef<TextPainter?>(null);
    final lastMaxWidth = useRef<double?>(null);

    TextPainter obtainTextPainter(TextStyle style, double maxWidth) {
      if (textPainterCache.value != null && lastMaxWidth.value == maxWidth) {
        return textPainterCache.value!;
      }
      final painter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: maxWidth);
      textPainterCache.value = painter;
      lastMaxWidth.value = maxWidth;
      return painter;
    }

    // textが変更された時にキャッシュをクリア
    useEffect(() {
      textPainterCache.value = null;
      return null;
    }, [text]);

    List<Widget> buildRemoteSelections(TextPainter textPainter) {
      final widgets = <Widget>[];
      for (final selection in collaboratorSelections) {
        final boxes = textPainter.getBoxesForSelection(
          TextSelection(
            baseOffset: selection.start,
            extentOffset: selection.end,
          ),
        );
        for (final box in boxes) {
          final rect = box.toRect();
          widgets.add(
            Positioned(
              left: rect.left,
              top: rect.top,
              width: rect.width,
              height: rect.height,
              child: _SelectionView(
                selection: selection,
                selectionOpacity: selectionOpacity,
              ),
            ),
          );
        }
      }
      return widgets;
    }

    List<Widget> buildRemoteCursors(TextPainter textPainter) {
      final widgets = <Widget>[];
      for (final selection in collaboratorSelections) {
        final caretOffset = textPainter.getOffsetForCaret(
          TextPosition(offset: selection.start),
          Rect.zero,
        );
        widgets.add(
          AnimatedPositioned(
            duration: cursorMoveAnimDuration,
            curve: Curves.easeOut,
            left: caretOffset.dx,
            top: caretOffset.dy,
            child: _CursorView(
              blinkOpacity: blinkOpacity,
              caretWidth: caretWidth,
              selection: selection,
              height: textPainter.preferredLineHeight,
            ),
          ),
        );
      }
      return widgets;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = obtainTextPainter(textStyle, constraints.maxWidth);
        return Stack(
          clipBehavior: Clip.none,
          children: [
            SelectableText(
              text,
              style: textStyle,
              onTap: onTap,
              onSelectionChanged: onSelectionChanged,
            ),
            ...buildRemoteSelections(painter),
            ...buildRemoteCursors(painter),
          ],
        );
      },
    );
  }
}

class _SelectionView extends StatelessWidget {
  const _SelectionView({
    required this.selection,
    required this.selectionOpacity,
  });

  final CollaboratorSelection selection;
  final double selectionOpacity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: selection.color.withValues(alpha: selectionOpacity),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}

class _CursorView extends StatelessWidget {
  const _CursorView({
    required this.blinkOpacity,
    required this.caretWidth,
    required this.selection,
    required this.height,
  });

  final Animation<double> blinkOpacity;
  final double caretWidth;
  final CollaboratorSelection selection;
  final double height;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedBuilder(
            animation: blinkOpacity,
            builder: (context, child) => Opacity(
              opacity: blinkOpacity.value,
              child: Container(
                width: caretWidth,
                height: height,
                color: selection.color,
              ),
            ),
          ),
          const SizedBox(height: 2),
          _LabelView(userId: selection.name, color: selection.color),
        ],
      ),
    );
  }
}

class _LabelView extends HookWidget {
  const _LabelView({required this.userId, required this.color});
  final String userId;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // シンプル化：三角（Tail）を廃止してラベル本体のみ
        DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.25),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            child: Text(
              userId,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                height: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
