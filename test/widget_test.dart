
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cosmic_explorer/main.dart';

void main() {
  testWidgets('Cosmic Explorer displays five planets', (tester) async {
    await tester.pumpWidget(const CosmicExplorerApp());
    await tester.pumpAndSettle();

    expect(find.text('Mercury'), findsOneWidget);
    expect(find.text('Mars'), findsOneWidget);
    expect(find.text('Jupiter'), findsOneWidget);
    expect(find.text('Kepler-186f'), findsOneWidget);
    expect(find.text('Proxima Centauri b'), findsOneWidget);
  });

  testWidgets('Mission Control has navigation menu', (tester) async {
    await tester.pumpWidget(const CosmicExplorerApp());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.menu), findsOneWidget);
  });
}
