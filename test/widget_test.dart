// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iot_pet_feeder/main.dart';

void main() {
  testWidgets('Dashboard smoke test loads feed logs and clock', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: IoTPetFeederApp()));

    await tester.pumpAndSettle();

    // Verify header and feeder title
    expect(find.text('IoT Pet Feeder'), findsOneWidget);
    expect(find.text('Jadwal Pemberian Pakan'), findsOneWidget);

    // Verify filter chips exist
    expect(find.widgetWithText(ChoiceChip, 'Semua'), findsOneWidget);
    expect(find.widgetWithText(ChoiceChip, 'Hari Ini'), findsOneWidget);
    expect(find.widgetWithText(ChoiceChip, 'Terjadwal'), findsOneWidget);

    // Verify initial dummy items are displayed
    expect(find.text('07:00'), findsOneWidget);
    expect(find.text('12:30'), findsOneWidget);

    // Verify FAB
    expect(find.text('Tambah Jadwal Pakan'), findsOneWidget);

    // Verify offline fallback SnackBar
    expect(
      find.text('Server offline/paused. Menampilkan data lokal.'),
      findsOneWidget,
    );
  });

  testWidgets('Open bottom sheet and add schedule', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: IoTPetFeederApp()));
    await tester.pumpAndSettle();

    // Tap tambah jadwal
    await tester.tap(find.text('Tambah Jadwal Pakan'));
    await tester.pumpAndSettle();

    // Verify bottom sheet title and submit button
    expect(find.text('Tambah Jadwal IoT'), findsOneWidget);
    expect(find.text('Simpan Jadwal IoT'), findsOneWidget);

    // Tap submit button in bottom sheet
    await tester.tap(find.text('Simpan Jadwal IoT'));
    await tester.pumpAndSettle();

    // Verify bottom sheet dismissed
    expect(find.text('Tambah Jadwal IoT'), findsNothing);
  });
}
