import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/collaborative_selectable_text.dart';
import 'package:kunlabori/event_handler.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/settings_page.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page.g.dart';

@riverpod
class _CollaboratorIndexes extends _$CollaboratorIndexes {
  @override
  Map<String, RemoteSelection> build() {
    return {};
  }

  void update(String addr, RemoteSelection selection) {
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

  void setSelection(String id, int offset, int length) {
    update(
      'you',
      (
        offset: offset,
        length: length,
        addr: 'you',
      ),
    );

    ref
        .read(partialEventHandlerProvider)
        .setSelection(id, offset: offset, length: length);
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

    final textStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontFamily: 'monospace',
      fontSize: 24,
    );

    ref.listen(messagesProvider, (previous, next) {
      // debugPrint('WebSocket message: $next');
      final notifier = ref.read(_collaboratorIndexesProvider.notifier);
      switch (next) {
        case AsyncData(:final value):
          ref
              .read(websocketEventHandlerProvider)
              .handle(
                docId,
                value,
                onSelection: (selection) => notifier.update(
                  selection.addr,
                  selection,
                ),
                onUnselected: notifier.remove,
                onDisconnected: notifier.remove,
              );
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
              ref
                  .read(partialEventHandlerProvider)
                  .handle(
                    docId,
                    partial,
                    onText: (text_) => text.value = text_,
                  );
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
                    offset: entry.value.offset,
                    length: entry.value.length,
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
              var offset = selection.baseOffset;
              var length = selection.extentOffset - offset;

              if (length.isNegative) {
                offset = offset + length;
                length = -length;
              }

              ref
                  .read(_collaboratorIndexesProvider.notifier)
                  .setSelection(
                    docId,
                    offset,
                    length,
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
    int offset() => ref.read(partialEventHandlerProvider).offset ?? 0;
    int length() => ref.read(partialEventHandlerProvider).length ?? 0;
    final controller = useTextEditingController();

    void insert({
      required String id,
      int? position,
      String? text,
    }) {
      final pos = position ?? offset();
      final txt = text ?? controller.text;

      if (txt.isEmpty) return;

      rust_api.insert(id: id, position: pos, text: txt);
      ref
          .read(_collaboratorIndexesProvider.notifier)
          .setSelection(id, pos + txt.length, 0);
      controller.clear();
    }

    void delete({
      required String id,
      int? position,
      int? deleteCount,
    }) {
      final pos = position ?? offset();
      final count = deleteCount ?? length();
      if (count == 0) return;
      rust_api.delete(id: id, position: pos, deleteCount: count);
      ref.read(_collaboratorIndexesProvider.notifier).setSelection(id, pos, 0);
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
