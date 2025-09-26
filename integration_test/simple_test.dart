import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kunlabori/main.dart';
import 'package:kunlabori/src/rust/frb_generated.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async => RustLib.init());
  testWidgets('Can call rust function', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.textContaining('Result: `Hello, Tom!`'), findsOneWidget);
  });
}
