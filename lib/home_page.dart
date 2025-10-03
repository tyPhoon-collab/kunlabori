import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/action_view.dart';
import 'package:kunlabori/collaborative_selectable_text.dart';
import 'package:kunlabori/domain/model/client_event.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/settings_page.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;
import 'package:kunlabori/use_case_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page.g.dart';

@riverpod
class CollaboratorIndexes extends _$CollaboratorIndexes {
  @override
  Map<String, Selection> build() {
    return {};
  }

  void update(String addr, Selection selection) {
    state = {
      ...state,
      addr: selection,
    };
  }

  void remove(String addr) {
    state = {
      ...state,
    }..remove(addr);
  }

  void select(String id, Selection selection) {
    update(
      'you',
      Selection(
        start: selection.start,
        end: selection.end,
      ),
    );

    ref.read(partialEventHandlerProvider).setSelection(id, selection);
  }
}

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docId = useMemoized(() => 'memo');
    final focusNode = useFocusNode();
    final text = useState<String>('');
    final isActionViewActive = useState<bool>(true);
    final controller = useTextEditingController();

    final collaboratorIndexes = ref.watch(collaboratorIndexesProvider);
    final useCase = ref.watch(documentUseCaseProvider);

    ref
      ..listen(eventProvider, (previous, next) {
        final notifier = ref.read(collaboratorIndexesProvider.notifier);

        switch (next) {
          case ClientEventSelected(:final selection, :final addr):
            notifier.update(
              addr,
              selection,
            );
          case ClientEventDisconnected(:final addr):
          case ClientEventUnselected(:final addr):
            notifier.remove(addr);
          case ClientEventText():
            text.value = next.text;
          default:
            break;
        }
      })
      ..listen(messagesProvider, (previous, next) {
        // debugPrint('WebSocket message: $next');
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

    useEffect(() {
      final eventSubscription = rust_api
          .create(id: docId)
          .listen(
            (partial) {
              // debugPrint('Stream partial: $partial');
              ref.read(partialEventHandlerProvider).handle(docId, partial);
            },
            onError: (Object? error) {
              debugPrint('Error in stream: $error');
            },
          );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(collaboratorIndexesProvider.notifier)
            .select(docId, const Selection.zero());
      });

      return () async {
        rust_api.destroy(id: docId);
        await eventSubscription.cancel();
      };
    }, const []);

    final textStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: 20,
      height: 1.5,
    );

    void unfocus() {
      focusNode.unfocus();
      isActionViewActive.value = false;
    }

    void focus() {
      focusNode.requestFocus();
      isActionViewActive.value = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kunlabori'),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy_all_rounded),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: text.value));
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('クリップボードにコピーされました: ${text.value.length} 文字'),
                  ),
                );
              }
            },
            tooltip: 'クリップボードにコピー',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Focus(
                  onKeyEvent: (node, event) {
                    if (event is KeyDownEvent) {
                      switch (event.logicalKey) {
                        case LogicalKeyboardKey.enter:
                          useCase.enter(id: docId);
                        case LogicalKeyboardKey.backspace:
                          useCase.backspace(id: docId);
                      }
                    }
                    return KeyEventResult.ignored;
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: CollaborativeSelectableText(
                        text.value,
                        textStyle: textStyle,
                        collaboratorSelections: collaboratorIndexes.entries
                            .map(
                              (entry) => CollaboratorSelection(
                                start: entry.value.start,
                                end: entry.value.end,
                                color: _colorFromAddress(entry.key),
                                name: entry.key,
                              ),
                            )
                            .toList(),
                        onTap: () {
                          if (!isActionViewActive.value) {
                            focus();
                          } else {
                            unfocus();
                          }
                        },
                        onSelectionChanged: (selection, cause) {
                          // debugPrint('Selection changed: $selection');
                          ref
                              .read(collaboratorIndexesProvider.notifier)
                              .select(
                                docId,
                                Selection(
                                  start: selection.start,
                                  end: selection.end,
                                ),
                              );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (isActionViewActive.value) ...[
              const Divider(),
              ActionView(
                controller: controller,
                focusNode: focusNode,
                docId: docId,
                onClose: unfocus,
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: !isActionViewActive.value
          ? FloatingActionButton(
              onPressed: () {
                isActionViewActive.value = true;
              },
              tooltip: 'Toggle Action View',
              child: const Icon(Icons.keyboard_rounded),
            )
          : null,
    );
  }

  Color _colorFromAddress(String addr) {
    return Colors.primaries[addr.codeUnits.fold(0, (a, b) => a + b) %
        Colors.primaries.length];
  }
}
