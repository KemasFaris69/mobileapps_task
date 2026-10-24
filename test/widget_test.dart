import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('empty state, add, toggle, delete todo', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Belum ada task, tambahkan dulu'), findsOneWidget);
    expect(find.text('your remaining todos : 0'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Belajar Flutter');
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('Belajar Flutter'), findsOneWidget);
    expect(find.text('Belum ada task, tambahkan dulu'), findsNothing);
    expect(find.text('your remaining todos : 1'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(find.text('your remaining todos : 0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    expect(find.text('Belajar Flutter'), findsNothing);
    expect(find.text('Belum ada task, tambahkan dulu'), findsOneWidget);
  });
}
