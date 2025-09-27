import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/action_view.dart';
import 'package:kunlabori/collaborative_selectable_text.dart';
import 'package:kunlabori/domain/model/client_event.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/settings_page.dart';
import 'package:kunlabori/src/rust/api/interface.dart' as rust_api;
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
    final collaboratorIndexes = ref.watch(collaboratorIndexesProvider);

    ref.listen(eventProvider, (previous, next) {
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
          padding: const EdgeInsets.all(16),
          child: CollaborativeSelectableText(
            text.value,
            textStyle: textStyle,
            collaboratorSelections: collaboratorIndexes.entries.map(
              (entry) {
                final collaboratorColor = _colorFromAddress(entry.key);
                return CollaboratorSelection(
                  start: entry.value.start,
                  end: entry.value.end,
                  color: collaboratorColor,
                  name: entry.key,
                );
              },
            ).toList(),
            onTap: focusNode.requestFocus,
            onSelectionChanged: (selection, cause) {
              debugPrint('Selection changed: $selection');
              ref
                  .read(collaboratorIndexesProvider.notifier)
                  .setSelection(
                    docId,
                    Selection(start: selection.start, end: selection.end),
                  );
            },
          ),
        ),
      ),
      persistentFooterButtons: [
        ActionView(focusNode: focusNode, docId: docId),
      ],
    );
  }

  Color _colorFromAddress(String addr) {
    return Colors.primaries[addr.codeUnits.fold(0, (a, b) => a + b) %
        Colors.primaries.length];
  }
}
