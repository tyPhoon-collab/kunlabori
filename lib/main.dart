import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/debug_view.dart';
import 'package:kunlabori/editor_view.dart';
import 'package:kunlabori/message.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/src/rust/api/interface.dart';
import 'package:kunlabori/src/rust/api/model.dart';
import 'package:kunlabori/src/rust/frb_generated.dart';
import 'package:uuid/uuid.dart';

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
    final docId = useMemoized(const Uuid().v4);
    final text = useState<String>('');
    final quillController = useMemoized(QuillController.basic);
    final index = useRef<int>(0);

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
                    Message.join(
                      bytes: stateVector(id: docId),
                    ),
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

    void insert({required String text}) {
      quillController.document.insert(index.value, text);
      index.value = 0;
    }

    void delete({required int deleteCount}) {
      quillController.document.delete(index.value, deleteCount);
      index.value = 0;
    }

    void sendUpdate(Uint8List bytes) {
      ref
          .read(socketProvider.notifier)
          .sendMessage(Message.update(bytes: bytes));
    }

    useEffect(() {
      final subscription = create(id: docId).listen(
        (partial) {
          text.value += '$partial\n';
          final action = switch (partial) {
            Partial_Delta(:final field0) => switch (field0) {
              SimpleDelta_Insert(:final text) => () => insert(text: text),
              SimpleDelta_Delete(:final deleteCount) => () => delete(
                deleteCount: deleteCount,
              ),
              SimpleDelta_Retain(:final retainCount) =>
                () => index.value = retainCount,
            },
            Partial_Update(:final field0) => () => sendUpdate(field0),
          };
          action();
        },
        onError: (Object? error) {
          debugPrint('Error in stream: $error');
        },
      );
      return () {
        subscription.cancel();
        quillController.dispose();
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
              Text(text.value),
              QuillEditor.basic(controller: quillController),
              EditorView(docId: docId),
              DebugView(id: docId),
            ],
          ),
        ),
      ),
    );
  }
}
