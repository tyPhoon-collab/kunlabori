import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/debug_view.dart';
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

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final docId = useMemoized(const Uuid().v4);
    final text = useState<String>('');
    final quillController = useMemoized(QuillController.basic);
    final index = useRef<int>(0);

    void insert({required String text}) {
      quillController.document.insert(index.value, text);
      index.value = 0;
    }

    void delete({required int deleteCount}) {
      quillController.document.delete(index.value, deleteCount);
      index.value = 0;
    }

    useEffect(() {
      final subscription = create(id: docId).listen(
        (partial) {
          debugPrint('Received delta: $partial');
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
            Partial_Update(:final field0) => () {
              debugPrint('Update received: $field0');
            },
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text.value),
            QuillEditor.basic(controller: quillController),
            Editor(docId: docId),
            DebugView(id: docId),
          ],
        ),
      ),
    );
  }
}

class Editor extends StatelessWidget {
  const Editor({required this.docId, super.key});

  final String docId;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (text) {
        final [op, position, value] = text.split(',');

        final action = switch (op) {
          'insert' => () => insert(
            id: docId,
            position: int.parse(position),
            text: value,
          ),
          'delete' => () => delete(
            id: docId,
            position: int.parse(position),
            deleteCount: int.parse(value),
          ),
          _ => () {},
        };

        try {
          action();
        } catch (e) {
          debugPrint('Error: $e');
        }
      },
    );
  }
}
