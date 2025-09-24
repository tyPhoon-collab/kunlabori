import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/src/rust/api/interface.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docId = useMemoized(() => 'memo');
    final insertText = useRef('add');
    final offset = useRef<int>(0);
    final length = useRef<int>(0);

    final focusNode = useFocusNode();
    final text = useState<String>('');

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
      final subscription = create(id: docId).listen(
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
        destroy(id: docId);
      };
    }, const []);

    void insert_({
      required String id,
      int? position,
      String? text,
    }) {
      final pos = position ?? offset.value;
      final txt = text ?? insertText.value;
      debugPrint('inserting "$txt" at $pos');
      insert(id: docId, position: pos, text: txt);
      length.value = 0;
    }

    void delete_({
      required String id,
      int? position,
      int? deleteCount,
    }) {
      var pos = position ?? offset.value;
      var count = deleteCount ?? length.value;

      if (count == 0) {
        return;
      }

      if (count.isNegative) {
        pos = pos + count;
        count = -count;
      }

      debugPrint('deleting at $pos for $count');
      delete(id: id, position: pos, deleteCount: count);
      length.value = 0;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
      body: Center(
        child: SingleChildScrollView(
          child: SelectableText(
            text.value,
            showCursor: true,
            style: const TextStyle(fontSize: 30),
            onTap: focusNode.requestFocus,
            onSelectionChanged: (selection, cause) {
              offset.value = selection.baseOffset;
              length.value = selection.extentOffset - selection.baseOffset;
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
                insert_(id: docId);
              },
              icon: const Icon(Icons.add),
              tooltip: 'Insert',
            ),
            IconButton.filled(
              onPressed: () {
                insert_(id: docId, text: '\n');
              },
              icon: const Icon(Icons.keyboard_return),
              tooltip: 'New Line',
            ),
            IconButton.filled(
              onPressed: () {
                delete_(id: docId);
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
