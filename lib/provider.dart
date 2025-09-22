import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_client/web_socket_client.dart';

part 'provider.g.dart';

@Riverpod(keepAlive: true)
WebSocket socket(Ref ref) {
  final uri = Uri.parse('ws://localhost:8080');
  return WebSocket(uri, timeout: const Duration(seconds: 5));
}
