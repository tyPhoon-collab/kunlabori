# Instruction

このプロジェクトはRustとFlutterで構成されています。また、ツール群は`mise`によって提供されています。

以下のルールに従ってコードを提案してください。

## General
- Deprecatedなコードは使用しないでください。
- 可能な限り最新の安定版のライブラリを使用してください。
- コードの可読性を重視してください。
- 警告はできるだけ残さないでください。

## Rust
- `rust/src/api`フォルダ直下を変更した場合は、`mise run generate`を使ってDartコードを生成してください。

## Flutter
- 自動生成は`mise run dev:build`で行います。
- 自動生成されたコードは変更しないでください。
- 適切にWidgetに分割してネストを減らしてください。
- Widgetを戻り値に持つ関数は、StatelessWidget/StatefulWidgetなどにすることを検討してください。
- 状態管理はRiverpodやHooksを使用してください。
- RiverpodのProviderを定義する場合は、`@Riverpod(keepAlive: true)`や`@riverpod`アノテーションを使用してください。
- プライベートにできる場合はプライベートにしてください。