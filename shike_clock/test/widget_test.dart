// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shike_clock/components/shike.dart';
import 'package:shike_clock/components/digital_clock.dart';

void main() {
  testWidgets('Shi-Ke Clock smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(ShiKe(
        now: DateTime(2020, 1, 1, 0, 0), maxWidth: 200, color: Colors.white70));
    //00:00 ->  子時五刻
    expect(find.text('子'), findsOneWidget);
    expect(find.text('五'), findsOneWidget);

    await tester.pumpWidget(ShiKe(
        now: DateTime(2020, 1, 1, 23, 0),
        maxWidth: 200,
        color: Colors.white70));
    //23:00 ->  子時一刻
    expect(find.text('五'), findsNothing);
    expect(find.text('子'), findsOneWidget);
    expect(find.text('一'), findsOneWidget);

    await tester.pumpWidget(ShiKe(
        now: DateTime(2020, 1, 1, 06, 0),
        maxWidth: 200,
        color: Colors.white70));
    //06:00 ->  卯時五刻
    expect(find.text('子'), findsNothing);
    expect(find.text('一'), findsNothing);
    expect(find.text('卯'), findsOneWidget);
    expect(find.text('五'), findsOneWidget);

    await tester.pumpWidget(ShiKe(
        now: DateTime(2020, 1, 1, 16, 20),
        maxWidth: 200,
        color: Colors.white70));
    //16:20 ->  申時六刻
    expect(find.text('申'), findsOneWidget);
    expect(find.text('六'), findsOneWidget);

    await tester.pumpWidget(DigitalClock(DateTime(2020, 1, 1, 0, 0),
        is24HourFormat: true, maxWidth: 200, color: Colors.white));
    expect(find.text('00'), findsWidgets);

    await tester.pumpWidget(DigitalClock(DateTime(2020, 1, 1, 23, 0),
        is24HourFormat: true, maxWidth: 200, color: Colors.white));
    expect(find.text('23'), findsOneWidget);
    expect(find.text('11'), findsNothing);

    await tester.pumpWidget(DigitalClock(DateTime(2020, 1, 1, 23, 0),
        is24HourFormat: false, maxWidth: 200, color: Colors.white));
    expect(find.text('11'), findsOneWidget);
    expect(find.text('23'), findsNothing);
  });
}
