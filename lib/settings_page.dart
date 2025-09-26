import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/provider.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlController = useTextEditingController(
      text: ref.watch(socketUrlProvider),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          controller: urlController,
          decoration: const InputDecoration(
            labelText: 'WebSocket URL',
          ),
          onSubmitted: (value) =>
              ref.read(socketUrlProvider.notifier).setUrl(value),
        ),
      ),
    );
  }
}
