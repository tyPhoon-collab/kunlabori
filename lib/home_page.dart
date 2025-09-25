import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/collaborative_selectable_text.dart';
import 'package:kunlabori/event_handler.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docId = useMemoized(() => 'memo');
    final insertText = useRef('');

    final focusNode = useFocusNode();
    final text = useState<String>('');
    final collaboratorIndexes = useState<Map<String, RemoteSelection>>(
      {},
    );

    final textStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontFamily: 'monospace',
      fontSize: 24,
    );

    ref.listen(messagesProvider, (previous, next) {
      debugPrint('WebSocket message: $next');
      switch (next) {
        case AsyncData(:final value):
          ref
              .read(websocketEventHandlerProvider)
              .handle(
                docId,
                value,
                onSelection: (selection) => collaboratorIndexes.value = {
                  ...collaboratorIndexes.value,
                  selection.addr: selection,
                },
                onUnselected: (addr) => collaboratorIndexes.value = {
                  ...collaboratorIndexes.value,
                }..remove(addr),
                onDisconnected: (addr) => collaboratorIndexes.value = {
                  ...collaboratorIndexes.value,
                }..remove(addr),
              );
        case AsyncError(:final error, :final stackTrace):
          debugPrint('WebSocket error: $error');
          debugPrintStack(stackTrace: stackTrace);
        case AsyncLoading():
          debugPrint('WebSocket loading...');
      }
    });

    useEffect(() {
      final subscription = rust_api
          .create(id: docId)
          .listen(
            (partial) {
              debugPrint('Stream partial: $partial');
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

      return () {
        subscription.cancel();
        rust_api.destroy(id: docId);
      };
    }, const []);

    int offset() => ref.read(partialEventHandlerProvider).offset ?? 0;
    int length() => ref.read(partialEventHandlerProvider).length ?? 0;
    void setLength(int length) =>
        ref.read(partialEventHandlerProvider).setLength(docId, length);

    void insert({
      required String id,
      int? position,
      String? text,
    }) {
      final pos = position ?? offset();
      final txt = text ?? insertText.value;
      debugPrint('inserting "$txt" at $pos');
      rust_api.insert(id: id, position: pos, text: txt);
      setLength(0);
    }

    void delete({
      required String id,
      int? position,
      int? deleteCount,
    }) {
      final pos = position ?? offset();
      final count = deleteCount ?? length();

      if (count == 0) return;

      debugPrint('deleting at $pos for $count');
      rust_api.delete(id: id, position: pos, deleteCount: count);
      setLength(0);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
      body: Center(
        child: SingleChildScrollView(
          child: CollaborativeSelectableText(
            text.value,
            textStyle: textStyle,
            collaboratorSelections: [
              for (final MapEntry(:key, :value)
                  in collaboratorIndexes.value.entries)
                CollaboratorSelection(
                  offset: value.offset,
                  length: value.length,
                  color:
                      Colors.primaries[key.codeUnits.fold(
                            0,
                            (a, b) => a + b,
                          ) %
                          Colors.primaries.length],
                  name: key,
                ),
            ],
            onTap: focusNode.requestFocus,
            onSelectionChanged: (selection, cause) {
              var offset = selection.baseOffset;
              var length = selection.extentOffset - offset;

              if (length.isNegative) {
                offset = offset + length;
                length = -length;
              }

              ref
                  .read(partialEventHandlerProvider)
                  .setSelection(docId, offset: offset, length: length);
            },
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(labelText: 'Insert Text'),
                onChanged: (value) {
                  insertText.value = value;
                },
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
        ),
      ],
    );
  }
}
