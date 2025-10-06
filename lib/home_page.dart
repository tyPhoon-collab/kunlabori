import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/action_view.dart';
import 'package:kunlabori/collaborative_selectable_text.dart';
import 'package:kunlabori/domain/model/client_event.dart';
import 'package:kunlabori/home_drawer.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/use_case_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page.g.dart';

@riverpod
class CollaboratorIndexes extends _$CollaboratorIndexes {
  @override
  Map<String, Selection> build() {
    return {};
  }

  void update(String id, Selection selection) {
    state = {
      ...state,
      id: selection,
    };
  }

  void remove(String id) {
    state = {
      ...state,
    }..remove(id);
  }
}

@Riverpod(keepAlive: true)
class _IsActionViewActive extends _$IsActionViewActive {
  @override
  bool build() => true;

  void activate() => state = true;

  void deactivate() => state = false;
}

@riverpod
class FontSize extends _$FontSize {
  static const minFontSize = 10.0;
  static const maxFontSize = 48.0;
  static const double fontSizeRange = maxFontSize - minFontSize;
  static const defaultFontSize = 20.0;

  @override
  double build() => defaultFontSize;

  void update(double size) {
    state = size.clamp(minFontSize, maxFontSize);
  }

  void reset() {
    state = defaultFontSize;
  }

  void scale(double scaleFactor) {
    final newSize = state * scaleFactor;
    update(newSize);
  }
}

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docId = useMemoized(() => 'doc');
    final focusNode = useFocusNode();
    final text = useState<String>('');
    final isActionViewActive = ref.watch(_isActionViewActiveProvider);
    final controller = useTextEditingController();

    useEffect(() {
      ref.read(documentControllerProvider(docId)).create();
      return null;
    }, const []);

    void unfocus() {
      focusNode.unfocus();
      ref.read(_isActionViewActiveProvider.notifier).deactivate();
    }

    void focus() {
      focusNode.requestFocus();
      ref.read(_isActionViewActiveProvider.notifier).activate();
    }

    return _EventListeners(
      docId: docId,
      text: text,
      child: Scaffold(
        appBar: const _HomeAppBar(),
        drawer: HomeDrawer(text: text.value),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: _CollaborativeTextCard(
                      docId: docId,
                      text: text.value,
                      isActionViewActive: isActionViewActive,
                      onToggleActive: () {
                        if (!isActionViewActive) {
                          focus();
                        } else {
                          unfocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: isActionViewActive
            ? ActionView(
                controller: controller,
                focusNode: focusNode,
                docId: docId,
              )
            : null,
        floatingActionButton: isActionViewActive
            ? FloatingActionButton.small(
                onPressed: unfocus,
                tooltip: 'Close Action View',
                child: const Icon(Icons.keyboard_hide_rounded),
              )
            : FloatingActionButton(
                onPressed: focus,
                tooltip: 'Open Action View',
                child: const Icon(Icons.keyboard_rounded),
              ),
      ),
    );
  }
}

class _HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const Text('Kunlabori'),
      actions: [
        IconButton(
          onPressed: () {
            ref.invalidate(socketProvider);
          },
          icon: const Icon(Icons.refresh_rounded),
        ),
      ],
    );
  }
}

class _CollaborativeTextCard extends ConsumerWidget {
  const _CollaborativeTextCard({
    required this.docId,
    required this.text,
    required this.isActionViewActive,
    required this.onToggleActive,
  });

  final String docId;
  final String text;
  final bool isActionViewActive;
  final VoidCallback onToggleActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionController = ref.watch(selectionControllerProvider(docId));
    final collaboratorIndexes = ref.watch(collaboratorIndexesProvider);
    final useCase = ref.watch(documentUseCaseProvider(docId));
    final fontSize = ref.watch(fontSizeProvider);

    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: fontSize,
      height: 1.5,
    );

    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          switch (event.logicalKey) {
            case LogicalKeyboardKey.enter:
              useCase.enter();
            case LogicalKeyboardKey.backspace:
              useCase.backspace();
          }
        }
        return KeyEventResult.ignored;
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ValueListenableBuilder(
            valueListenable: selectionController,
            builder: (context, value, child) {
              return CollaborativeSelectableText(
                text,
                textStyle: textStyle,
                collaboratorSelections: [
                  for (final entry in collaboratorIndexes.entries)
                    CollaboratorSelection(
                      start: entry.value.start,
                      end: entry.value.end,
                      color: _colorFromAddress(entry.key),
                      name: entry.key.substring(0, 5),
                    ),
                  if (value != null)
                    CollaboratorSelection(
                      start: value.start,
                      end: value.end,
                      color: colorScheme.primary,
                      name: 'you',
                    ),
                ],
                onTap: onToggleActive,
                onSelectionChanged: (selection, cause) {
                  ref
                      .read(selectionControllerProvider(docId))
                      .value = Selection(
                    start: selection.start,
                    end: selection.end,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _EventListeners extends HookConsumerWidget {
  const _EventListeners({
    required this.docId,
    required this.text,
    required this.child,
  });

  final String docId;
  final ValueNotifier<String> text;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(eventProvider, (previous, next) {
        final notifier = ref.read(collaboratorIndexesProvider.notifier);

        switch (next) {
          case ClientEventWelcome():
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(selectionControllerProvider(docId)).value =
                  const Selection.zero();
            });
          case ClientEventSelected(:final selection, :final peerId):
            notifier.update(peerId, selection);
          case ClientEventDisconnected(:final peerId):
          case ClientEventUnselected(:final peerId):
            notifier.remove(peerId);
          case ClientEventText():
            text.value = next.text;
          default:
            break;
        }
      })
      ..listen(messagesProvider, (previous, next) {
        switch (next) {
          case AsyncData(:final value):
            ref.read(websocketEventHandlerProvider).handle(docId, value);
          case AsyncError(:final error, :final stackTrace):
            debugPrint('WebSocket error: $error');
            debugPrintStack(stackTrace: stackTrace);
          case AsyncLoading():
            debugPrint('WebSocket loading...');
        }
      });

    return child;
  }
}

Color _colorFromAddress(String addr) {
  return Colors.primaries[addr.codeUnits.fold(0, (a, b) => a + b) %
      Colors.primaries.length];
}
