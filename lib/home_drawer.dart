import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kunlabori/home_page.dart';
import 'package:kunlabori/settings_page.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSize = ref.watch(fontSizeProvider);
    final textTheme = Theme.of(context).textTheme;

    return NavigationDrawer(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'メニュー',
            style: textTheme.titleSmall,
          ),
        ),
        const _Divider(),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: Row(
                  children: [
                    const Icon(Icons.format_size_rounded, size: 24),
                    const SizedBox(width: 12),
                    Text('フォントサイズ', style: textTheme.titleSmall),
                  ],
                ),
              ),
              Slider(
                value: fontSize,
                min: FontSize.minFontSize,
                max: FontSize.maxFontSize,
                divisions: FontSize.fontSizeRange.toInt(),
                label: '${fontSize.toStringAsFixed(1)} pt',
                onChanged: ref.read(fontSizeProvider.notifier).update,
              ),
              Center(
                child: TextButton.icon(
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('リセット'),
                  onPressed: ref.read(fontSizeProvider.notifier).reset,
                ),
              ),
            ],
          ),
        ),
        const _Divider(),
        const SizedBox(height: 4),
        NavigationDrawerDestination(
          icon: const Icon(Icons.copy_all_rounded),
          label: Text('コピー (${text.length} 文字)'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: Text('設定'),
        ),
      ],
      onDestinationSelected: (index) async {
        // フォントサイズセクションを除いた実際の選択肢のインデックス
        switch (index) {
          case 0: // コピー
            try {
              await Clipboard.setData(ClipboardData(text: text));
              if (context.mounted) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('クリップボードにコピーされました: ${text.length} 文字'),
                  ),
                );
              }
            } on Exception catch (e) {
              if (context.mounted) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('コピーに失敗しました: $e'),
                  ),
                );
              }
            }
          case 1: // 設定
            if (context.mounted) {
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const SettingsPage(),
                ),
              );
            }
        }
      },
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(indent: 28, endIndent: 28);
  }
}
