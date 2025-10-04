import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/provider.dart';

enum FontOption {
  mplus('MPLUSRounded1c', 'M PLUS Rounded', 'やさしいゴシック体'),
  hachi('HachiMaruPop', 'Hachi Maru Pop', '手書き風フォント'),
  system('', 'システム', 'デフォルトフォント');

  const FontOption(this.fontFamily, this.displayName, this.description);

  final String fontFamily;
  final String displayName;
  final String description;
}

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _WebSocketUrlSetting(),
          SizedBox(height: 16),
          _FontSelectionSetting(),
        ],
      ),
    );
  }
}

class _WebSocketUrlSetting extends HookConsumerWidget {
  const _WebSocketUrlSetting();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final urlController = useTextEditingController(
      text: ref.watch(socketUrlProvider),
    );
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(
              icon: Icons.cable,
              title: 'WebSocket URL',
              color: colorScheme.primary,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: 'URL',
                hintText: 'ws://localhost:8080',
                prefixIcon: const Icon(Icons.link),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () =>
                      _onApplyUrl(context, ref, urlController.text),
                  tooltip: 'Apply',
                ),
              ),
              onSubmitted: (value) => _onApplyUrl(context, ref, value),
            ),
          ],
        ),
      ),
    );
  }

  void _onApplyUrl(BuildContext context, WidgetRef ref, String url) {
    ref.read(socketUrlProvider.notifier).setUrl(url);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('URL updated'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class _FontSelectionSetting extends ConsumerWidget {
  const _FontSelectionSetting();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFont = ref.watch(selectedFontProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(
              icon: Icons.font_download,
              title: 'Font Family',
              color: colorScheme.primary,
            ),
            const SizedBox(height: 16),
            _FontSelector(selectedFont: selectedFont),
            const SizedBox(height: 24),
            _FontPreview(selectedFont: selectedFont),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.color,
  });

  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        Icon(icon, color: color),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _FontSelector extends ConsumerWidget {
  const _FontSelector({required this.selectedFont});

  final String selectedFont;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOption = FontOption.values.firstWhere(
      (f) => f.fontFamily == selectedFont,
      orElse: () => FontOption.mplus,
    );

    return SegmentedButton<FontOption>(
      segments: FontOption.values.map((font) {
        return ButtonSegment<FontOption>(
          value: font,
          label: Text(font.displayName),
          icon: Icon(
            font == FontOption.system ? Icons.phone_android : Icons.text_fields,
          ),
        );
      }).toList(),
      selected: {selectedOption},
      onSelectionChanged: (Set<FontOption> newSelection) {
        ref
            .read(selectedFontProvider.notifier)
            .setFont(newSelection.first.fontFamily);
      },
    );
  }
}

class _FontPreview extends StatelessWidget {
  const _FontPreview({required this.selectedFont});

  final String selectedFont;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final selectedOption = FontOption.values.firstWhere(
      (f) => f.fontFamily == selectedFont,
      orElse: () => FontOption.mplus,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preview',
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'こんにちは世界',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 4),
          const Text(
            'Hello World 123',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            selectedOption.description,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
