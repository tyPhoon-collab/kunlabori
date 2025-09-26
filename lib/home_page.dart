import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/collaborative_selectable_text.dart';
import 'package:kunlabori/domain/model/client_event.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/settings_page.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page.g.dart';

@riverpod
class _CollaboratorIndexes extends _$CollaboratorIndexes {
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

  void setSelection(String id, Selection selection) {
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
    final collaboratorIndexes = ref.watch(_collaboratorIndexesProvider);

    ref.listen(eventProvider, (previous, next) {
      final notifier = ref.read(_collaboratorIndexesProvider.notifier);

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
        case ClientEventMoved(:final selection):
          notifier.setSelection(docId, selection);
        default:
          break;
      }
    });

    final textStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontFamily: 'monospace',
      fontSize: 24,
    );

    ref.listen(messagesProvider, (previous, next) {
      debugPrint('WebSocket message: $next');
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
              debugPrint('Stream partial: $partial');
              ref.read(partialEventHandlerProvider).handle(docId, partial);
            },
            onError: (Object? error) {
              debugPrint('Error in stream: $error');
            },
          );

      return () async {
        await eventSubscription.cancel();
        rust_api.destroy(id: docId);
      };
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_rust_bridge quickstart'),
        actions: [
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
      body: Center(
        child: SingleChildScrollView(
          child: CollaborativeSelectableText(
            text.value,
            textStyle: textStyle,
            collaboratorSelections: collaboratorIndexes.entries
                .map(
                  (entry) => CollaboratorSelection(
                    start: entry.value.start,
                    end: entry.value.end,
                    color:
                        Colors.primaries[entry.key.codeUnits.fold(
                              0,
                              (a, b) => a + b,
                            ) %
                            Colors.primaries.length],
                    name: entry.key,
                  ),
                )
                .toList(),
            onTap: focusNode.requestFocus,
            onSelectionChanged: (selection, cause) {
              ref
                  .read(_collaboratorIndexesProvider.notifier)
                  .setSelection(
                    docId,
                    Selection(start: selection.start, end: selection.end),
                  );
            },
          ),
        ),
      ),
      persistentFooterButtons: [
        _Actions(focusNode: focusNode, docId: docId),
      ],
    );
  }
}

class _Actions extends HookConsumerWidget {
  const _Actions({
    required this.focusNode,
    required this.docId,
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
          .read(_collaboratorIndexesProvider.notifier)
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
          .read(_collaboratorIndexesProvider.notifier)
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
