import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/screens/register_screen.dart';

void main() {
  testWidgets('Register screen has necessary input fields', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

    expect(find.byType(TextField), findsWidgets);
    expect(find.text('Register'), findsOneWidget);
  });
}
