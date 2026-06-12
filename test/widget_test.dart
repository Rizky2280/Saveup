import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saveup/app.dart';

void main() {
  testWidgets('navigates from splash to onboarding', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: SaveUpApp()));

    expect(find.text('SaveUp'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1500));
    await tester.pumpAndSettle();

    expect(find.text('Simulate every goal before you commit'), findsOneWidget);
  });
}
