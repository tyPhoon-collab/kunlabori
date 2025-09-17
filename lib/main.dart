import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:kunlabori/src/rust/api/interface.dart';
import 'package:kunlabori/src/rust/frb_generated.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomePage());
  }
}

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const docId = "doc1";
    final textStream = useState<Stream<String>?>(null);

    return Scaffold(
      appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                textStream.value = create(id: docId);
              },
              child: const Text('Create Document'),
            ),
            StreamBuilder<String>(
              stream: textStream.value,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Text('Document content: ${snapshot.data}');
                } else {
                  return const Text('No data');
                }
              },
            ),
            TextField(
              onSubmitted: (text) {
                insert(id: docId, position: 0, text: text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
