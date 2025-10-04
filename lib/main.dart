import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/home_page.dart';
import 'package:kunlabori/provider.dart';
import 'package:kunlabori/src/rust/frb_generated.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontFamily = ref.watch(selectedFontProvider);

    return MaterialApp(
      home: const HomePage(),
      theme: _buildTheme(fontFamily),
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData _buildTheme(String fontFamily) {
    return ThemeData(
      fontFamily: fontFamily.isEmpty ? null : fontFamily,
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
