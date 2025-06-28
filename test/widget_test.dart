// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notecraft_projet_upc/main.dart';

void main() {
  testWidgets('Application NoteCraft se lance correctement', (WidgetTester tester) async {
    // Construction de l'application et déclenchement d'une frame.
    await tester.pumpWidget(const ApplicationNoteCraft());

    // Vérification que l'application se lance (recherche d'un widget Material)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
