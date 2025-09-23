import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/debug_view.dart';
import 'package:kunlabori/editor_view.dart';
import 'package:kunlabori/message.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/src/rust/api/interface.dart';
import 'package:kunlabori/src/rust/api/model.dart';
import 'package:kunlabori/src/rust/frb_generated.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

typedef SocketSubscription = StreamSubscription<dynamic>;

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docId = useMemoized(() => 'memo');
    final log = useState<String>('');
    final text = useState<String>('');

    ref.listen(messagesProvider, (previous, next) {
      debugPrint('WebSocket message: $next');
      switch (next) {
        case AsyncData(:final value):
          final action = switch (value) {
            MessageConnected(:final addr) => () {
              debugPrint('Connected to $addr');
              ref
                  .read(socketProvider.notifier)
                  .sendMessage(
                    Message.join(bytes: stateVector(id: docId)),
                  );
            },
            MessageUpdate(:final bytes) => () => merge(
              id: docId,
              update: bytes,
            ),
            MessageRead(:final bytes, :final from) =>
              () => ref
                  .read(socketProvider.notifier)
                  .sendMessage(
                    Message.init(
                      bytes: diff(id: docId, since: bytes),
                      to: from,
                    ),
                  ),
            MessageInit(:final bytes) => () => merge(
              id: docId,
              update: bytes,
            ),
            _ => () {},
          };
          action();
        case AsyncError(:final error, :final stackTrace):
          debugPrint('WebSocket error: $error');
          debugPrintStack(stackTrace: stackTrace);
        case AsyncLoading():
          debugPrint('WebSocket loading...');
      }
    });

    void sendUpdate(Uint8List bytes) {
      ref
          .read(socketProvider.notifier)
          .sendMessage(Message.update(bytes: bytes));
    }

    useEffect(() {
      final subscription = create(id: docId).listen(
        (partial) {
          debugPrint('Stream partial: $partial');
          log.value += '$partial\n';
          final action = switch (partial) {
            Partial_Delta() => () {},
            Partial_Update(:final field0) => () => sendUpdate(field0),
            Partial_Text(:final field0) => () => text.value = field0,
          };
          action();
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

    return Scaffold(
      appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(log.value),
              Text(text.value),
              EditorView(docId: docId),
              DebugView(id: docId),
            ],
          ),
        ),
      ),
    );
  }
}
