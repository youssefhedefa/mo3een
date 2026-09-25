import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mo3een/features/more/data/models/salah_reminder_settings.dart';
import 'package:mo3een/features/more/data/services/salah_reminder_manager.dart';
import 'package:mo3een/features/more/presentation/ui/widgets/salah_reminder_dialog.dart';

Future<void> openDialog(
  WidgetTester tester, {
  SalahReminderSettings settings = const SalahReminderSettings(),
  required Future<void> Function(SalahReminderSettings) onSave,
}) async {
  tester.view.physicalSize = const Size(360, 800);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () => showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (_) => SalahReminderDialog(
                initialSettings: settings,
                onSave: onSave,
              ),
            ),
            child: const Text('open'),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('interval and overnight window remain usable on a small screen', (
    tester,
  ) async {
    SalahReminderSettings? saved;
    await openDialog(
      tester,
      settings: const SalahReminderSettings(
        allDay: false,
        startMinutes: 1320,
        endMinutes: 300,
      ),
      onSave: (value) async {
        saved = value;
      },
    );
    tester.view.physicalSize = const Size(320, 640);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(DropdownButtonFormField<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('كل ساعتين').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('حفظ'));
    await tester.pumpAndSettle();
    expect(saved!.intervalMinutes, 120);
    expect(saved!.allDay, false);
    expect(saved!.startMinutes, 1320);
    expect(saved!.endMinutes, 300);
  });

  testWidgets('cancel discards edits; save passes chosen settings and closes', (
    tester,
  ) async {
    SalahReminderSettings? saved;
    await openDialog(
      tester,
      onSave: (value) async {
        saved = value;
      },
    );
    await tester.tap(find.text('طويل'));
    await tester.tap(find.text('إلغاء'));
    await tester.pumpAndSettle();
    expect(saved, isNull);
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    final sound = tester.widget<SegmentedButton<SalahReminderSound>>(
      find.byType(SegmentedButton<SalahReminderSound>),
    );
    expect(sound.selected, {SalahReminderSound.short});
    await tester.tap(find.text('تفعيل التذكير'));
    await tester.tap(find.text('طويل'));
    await tester.tap(find.text('حفظ'));
    await tester.pumpAndSettle();
    expect(saved!.enabled, true);
    expect(saved!.sound, SalahReminderSound.long);
    expect(find.byType(SalahReminderDialog), findsNothing);
  });

  testWidgets('equal endpoints show validation without saving', (tester) async {
    var calls = 0;
    await openDialog(
      tester,
      settings: const SalahReminderSettings(
        allDay: false,
        startMinutes: 480,
        endMinutes: 480,
      ),
      onSave: (_) async {
        calls++;
      },
    );
    await tester.tap(find.text('حفظ'));
    await tester.pumpAndSettle();
    expect(find.textContaining('اختر وقت نهاية'), findsOneWidget);
    expect(calls, 0);
  });

  testWidgets('permission denial keeps dialog open with settings action', (
    tester,
  ) async {
    await openDialog(
      tester,
      onSave: (_) async {
        throw SalahReminderPermissionException();
      },
    );
    await tester.tap(find.text('حفظ'));
    await tester.pumpAndSettle();
    expect(find.byType(SalahReminderDialog), findsOneWidget);
    expect(find.text('فتح إعدادات التطبيق'), findsOneWidget);
  });

  testWidgets('saving disables submission and cancellation', (tester) async {
    final gate = Completer<void>();
    var calls = 0;
    await openDialog(
      tester,
      onSave: (_) async {
        calls++;
        await gate.future;
      },
    );
    await tester.tap(find.text('حفظ'));
    await tester.pump();
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    expect(
      tester
          .widget<TextButton>(find.widgetWithText(TextButton, 'إلغاء'))
          .onPressed,
      isNull,
    );
    expect(calls, 1);
    gate.complete();
    await tester.pumpAndSettle();
    expect(find.byType(SalahReminderDialog), findsNothing);
  });

  testWidgets('scheduling failure permits retry', (tester) async {
    var calls = 0;
    await openDialog(
      tester,
      onSave: (_) async {
        if (++calls == 1) throw StateError('failure');
      },
    );
    await tester.tap(find.text('حفظ'));
    await tester.pumpAndSettle();
    expect(find.text('تعذّر حفظ التذكير. حاول مرة أخرى.'), findsOneWidget);
    await tester.tap(find.text('حفظ'));
    await tester.pumpAndSettle();
    expect(calls, 2);
    expect(find.byType(SalahReminderDialog), findsNothing);
  });
}
