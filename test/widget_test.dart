import 'package:flutter_test/flutter_test.dart';
import 'package:findmytutor/app.dart';

void main() {
  testWidgets('Find My Tutor app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const FindMyTutorApp());

    expect(find.byType(FindMyTutorApp), findsOneWidget);
  });
}