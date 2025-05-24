import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/screens/pantallaRegistro.dart';

void main() {
  testWidgets('Register screen tiene los campos necesarios', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: PantallaRegistro()));

    expect(find.byType(TextField), findsWidgets);
    expect(find.text('Register'), findsOneWidget);
  });
}
