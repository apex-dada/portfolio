import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('Portfolio smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(milliseconds: 100));

    // Verify that our main developer name is present.
    expect(find.textContaining('Mariz'), findsAtLeast(1));
  });
}
