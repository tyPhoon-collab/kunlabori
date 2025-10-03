import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@immutable
class CollaboratorSelection {
  const CollaboratorSelection({
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
    this.onTap,
    this.onSelectionChanged,
  });

  final String text;
  final TextStyle textStyle;
  final List<CollaboratorSelection> collaboratorSelections;

  final VoidCallback? onTap;
  final SelectionChangedCallback? onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    final blinkController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    final blinkOpacity = useMemoized(
      () => Tween<double>(begin: 1, end: 0.2).animate(
        CurvedAnimation(parent: blinkController, curve: Curves.easeInOut),
      ),
      [blinkController],
    );

    useEffect(() {
      unawaited(blinkController.repeat(reverse: true));
      return null;
    }, [blinkController]);

    // TextPainterのキャッシュ
    final textPainterCache = useRef<TextPainter?>(null);
    final lastMaxWidth = useRef<double?>(null);

    /// TextPainterを取得または作成（キャッシュあり）
    TextPainter getOrCreateTextPainter(TextStyle style, double maxWidth) {
      final cachedPainter = textPainterCache.value;
      final cachedWidth = lastMaxWidth.value;

      // キャッシュが有効な場合は再利用
      if (cachedPainter != null &&
          cachedWidth != null &&
          (cachedWidth - maxWidth).abs() < 0.001) {
        return cachedPainter;
      }

      // 新しいTextPainterを作成
      final painter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: maxWidth);

      textPainterCache.value = painter;
      lastMaxWidth.value = maxWidth;
      return painter;
    }

    useEffect(() {
      textPainterCache.value = null;
      lastMaxWidth.value = null;
      return null;
    }, [text, textStyle]);

    List<Widget> buildSelections(
      TextPainter textPainter,
      List<CollaboratorSelection> selections,
    ) {
      final widgets = <Widget>[];
      for (final selection in selections) {
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
              ),
            ),
          );
        }
      }
      return widgets;
    }

    List<Widget> buildCursors(
      TextPainter textPainter,
      List<CollaboratorSelection> selections,
    ) {
      final widgets = <Widget>[];
      for (final selection in selections) {
        final caretOffset = textPainter.getOffsetForCaret(
          TextPosition(offset: selection.start),
          Rect.zero,
        );
        widgets.add(
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
            left: caretOffset.dx,
            top: caretOffset.dy,
            child: _CursorView(
              blinkOpacity: blinkOpacity,
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
        final painter = getOrCreateTextPainter(textStyle, constraints.maxWidth);

        final remoteSelections = buildSelections(
          painter,
          collaboratorSelections,
        );
        final remoteCursors = buildCursors(
          painter,
          collaboratorSelections,
        );

        return Stack(
          clipBehavior: Clip.none,
          children: [
            SelectableText(
              text,
              style: textStyle,
              onTap: onTap,
              onSelectionChanged: onSelectionChanged,
            ),
            ...remoteSelections,
            ...remoteCursors,
          ],
        );
      },
    );
  }
}

class _SelectionView extends StatelessWidget {
  const _SelectionView({
    required this.selection,
  });

  final CollaboratorSelection selection;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: selection.color.withValues(alpha: 0.28),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}

class _CursorView extends StatelessWidget {
  const _CursorView({
    required this.blinkOpacity,
    required this.selection,
    required this.height,
  });

  final Animation<double> blinkOpacity;
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
                width: 2,
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
