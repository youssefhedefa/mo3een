import 'dart:async';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mo3een/core/helpers/get_current_position_helper.dart';
import 'package:mo3een/features/home/data/services/notification_service.dart';
import 'package:mo3een/features/more/data/models/salah_reminder_settings.dart';
import 'package:mo3een/features/more/data/services/salah_reminder_manager.dart';
import 'package:timezone/data/latest.dart' as data;
import 'package:timezone/timezone.dart' as tz;

class MockPlugin extends Mock implements FlutterLocalNotificationsPlugin {}

class MockService extends Mock implements NotificationServiceContract {}

class MockLocation extends Mock implements LocationHelper {}

class MockSettingsBox extends Mock implements Box<dynamic> {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    data.initializeTimeZones();
    registerFallbackValue(const SalahReminderSettings());
    registerFallbackValue(const NotificationDetails());
    registerFallbackValue(tz.TZDateTime(tz.UTC, 2030));
    registerFallbackValue(AndroidScheduleMode.inexactAllowWhileIdle);
  });

  group('daily slots', () {
    test('defaults are disabled, short and hourly all day', () {
      const settings = SalahReminderSettings();
      expect(settings.enabled, false);
      expect(settings.sound, SalahReminderSound.short);
      expect(settings.dailySlots, List.generate(24, (i) => i * 60));
      expect(settings.copyWith(intervalMinutes: 30).dailySlots, hasLength(48));
    });
    test('includes start and excludes end, including overnight ranges', () {
      const daytime = SalahReminderSettings(allDay: false);
      expect(daytime.dailySlots, List.generate(14, (i) => 480 + i * 60));
      const overnight = SalahReminderSettings(
        allDay: false,
        startMinutes: 1350,
        endMinutes: 150,
      );
      expect(overnight.dailySlots, [1350, 1410, 30, 90]);
      expect(overnight.copyWith(intervalMinutes: 120).dailySlots, [1350, 30]);
    });
    test('invalid ranges and intervals cannot schedule', () {
      expect(
        const SalahReminderSettings(
          allDay: false,
          startMinutes: 0,
          endMinutes: 0,
        ).isValid,
        false,
      );
      expect(
        () => const SalahReminderSettings(intervalMinutes: 0).dailySlots,
        throwsArgumentError,
      );
      expect(
        SalahReminderSettings.fromMap({'intervalMinutes': -1}).enabled,
        false,
      );
    });
    test('all settings round trip through persistence', () {
      const settings = SalahReminderSettings(
        enabled: true,
        sound: SalahReminderSound.long,
        intervalMinutes: 180,
        allDay: false,
        startMinutes: 1320,
        endMinutes: 300,
      );
      expect(
        SalahReminderSettings.fromMap(settings.toMap()).toMap(),
        settings.toMap(),
      );
    });
    test('next occurrence is future, rolls calendar day at equality', () {
      final now = tz.TZDateTime(tz.UTC, 2026, 9, 25, 8);
      expect(
        nextSalahReminderDate(now, 480),
        tz.TZDateTime(tz.UTC, 2026, 9, 26, 8),
      );
      expect(
        nextSalahReminderDate(now, 540),
        tz.TZDateTime(tz.UTC, 2026, 9, 25, 9),
      );
      expect(
        nextSalahReminderDate(tz.TZDateTime(tz.UTC, 2026, 12, 31, 23, 59), 0),
        tz.TZDateTime(tz.UTC, 2027, 1, 1),
      );
    });
    test('DST gap is skipped and autumn clock time stays local', () {
      final location = tz.getLocation('America/New_York');
      expect(
        nextSalahReminderDate(tz.TZDateTime(location, 2026, 3, 8, 0), 150),
        tz.TZDateTime(location, 2026, 3, 9, 2, 30),
      );
      expect(
        nextSalahReminderDate(tz.TZDateTime(location, 2026, 10, 31, 23), 480),
        tz.TZDateTime(location, 2026, 11, 1, 8),
      );
    });
  });

  group('native scheduling', () {
    late MockPlugin plugin;
    late NotificationService service;
    late Map<int, Invocation> requests;
    late List<int> cancelled;
    setUp(() {
      plugin = MockPlugin();
      service = NotificationService(flutterLocalNotificationsPlugin: plugin);
      requests = {};
      cancelled = [];
      when(() => plugin.cancel(id: any(named: 'id'))).thenAnswer((call) async {
        final id = call.namedArguments[#id] as int;
        cancelled.add(id);
        requests.remove(id);
      });
      when(
        () => plugin.zonedSchedule(
          id: any(named: 'id'),
          title: any(named: 'title'),
          body: any(named: 'body'),
          scheduledDate: any(named: 'scheduledDate'),
          notificationDetails: any(named: 'notificationDetails'),
          androidScheduleMode: any(named: 'androidScheduleMode'),
          matchDateTimeComponents: any(named: 'matchDateTimeComponents'),
        ),
      ).thenAnswer((call) async {
        requests[call.namedArguments[#id] as int] = call;
      });
    });

    test(
      'repeated saves replace slots and sound without touching prayer IDs',
      () async {
        const short = SalahReminderSettings(enabled: true, intervalMinutes: 30);
        await service.scheduleSalahReminders(
          settings: short,
          timeZone: 'Africa/Cairo',
        );
        expect(requests, hasLength(48));
        final shortDetails =
            requests[2000]!.namedArguments[#notificationDetails]
                as NotificationDetails;
        expect(shortDetails.android!.channelId, 'salah_salah_qaser_v1');
        expect(shortDetails.iOS!.sound, 'salah_qaser.wav');
        await service.scheduleSalahReminders(
          settings: short.copyWith(
            sound: SalahReminderSound.long,
            intervalMinutes: 60,
            allDay: false,
          ),
          timeZone: 'Africa/Cairo',
        );
        expect(requests, hasLength(14));
        final args = requests[2000]!.namedArguments;
        final longDetails = args[#notificationDetails] as NotificationDetails;
        expect(longDetails.android!.channelId, 'salah_salah_taweel_v1');
        expect(
          (longDetails.android!.sound as RawResourceAndroidNotificationSound)
              .sound,
          'salah_taweel',
        );
        expect(longDetails.iOS!.sound, 'salah_taweel.wav');
        expect(args[#matchDateTimeComponents], DateTimeComponents.time);
        expect((args[#scheduledDate] as tz.TZDateTime).hour, 8);
        expect(cancelled.every((id) => id >= 2000 && id < 2048), true);
        await service.scheduleSalahReminders(
          settings: short.copyWith(enabled: false),
          timeZone: 'Africa/Cairo',
        );
        expect(requests, isEmpty);
      },
    );

    test(
      'partial scheduling failure cleans up all reminder requests',
      () async {
        when(
          () => plugin.zonedSchedule(
            id: 2001,
            title: any(named: 'title'),
            body: any(named: 'body'),
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            androidScheduleMode: any(named: 'androidScheduleMode'),
            matchDateTimeComponents: any(named: 'matchDateTimeComponents'),
          ),
        ).thenThrow(StateError('schedule failed'));
        await expectLater(
          service.scheduleSalahReminders(
            settings: const SalahReminderSettings(enabled: true),
            timeZone: 'Africa/Cairo',
          ),
          throwsStateError,
        );
        expect(requests, isEmpty);
        expect(cancelled, hasLength(96));
      },
    );

    test('native sound resources are packaged and retained', () {
      for (final sound in SalahReminderSound.values) {
        final name = sound.resource;
        expect(
          File('android/app/src/main/res/raw/$name.mp3').readAsBytesSync(),
          File('assets/audio/$name.mp3').readAsBytesSync(),
        );
        expect(File('ios/Runner/Sounds/$name.wav').readAsBytesSync().take(4), [
          82,
          73,
          70,
          70,
        ]);
        expect(
          File('android/app/src/main/res/raw/keep.xml').readAsStringSync(),
          contains('@raw/$name'),
        );
        expect(
          File('ios/Runner.xcodeproj/project.pbxproj').readAsStringSync(),
          contains('$name.wav in Resources'),
        );
      }
    });
  });

  group('settings and lifecycle', () {
    late Directory directory;
    late Box<dynamic> box;
    late MockService service;
    late MockLocation location;
    late SalahReminderManager manager;
    late List<SalahReminderSettings> scheduled;
    setUp(() async {
      directory = await Directory.systemTemp.createTemp('salah-reminder-test-');
      box = await Hive.openBox<dynamic>('settings', path: directory.path);
      service = MockService();
      location = MockLocation();
      scheduled = [];
      when(
        () => service.requestSalahReminderPermission(),
      ).thenAnswer((_) async => true);
      when(() => service.cancelSalahReminders()).thenAnswer((_) async {});
      when(() => location.getLocal()).thenAnswer((_) async => 'Africa/Cairo');
      when(
        () => service.scheduleSalahReminders(
          settings: any(named: 'settings'),
          timeZone: any(named: 'timeZone'),
        ),
      ).thenAnswer((call) async {
        scheduled.add(call.namedArguments[#settings] as SalahReminderSettings);
      });
      manager = SalahReminderManager(
        service: service,
        locationHelper: location,
        box: box,
      );
    });
    tearDown(() async {
      await box.close();
      await directory.delete(recursive: true);
    });

    test(
      'persistence failure restores memory and the previous schedule',
      () async {
        final storage = MockSettingsBox();
        const previous = SalahReminderSettings(enabled: true);
        dynamic stored = previous.toMap();
        var writes = 0;
        when(
          () => storage.get(SalahReminderManager.settingsKey),
        ).thenAnswer((_) => stored);
        when(
          () => storage.put(SalahReminderManager.settingsKey, any()),
        ).thenAnswer((call) async {
          stored = call.positionalArguments[1];
          if (++writes == 1) throw StateError('disk unavailable');
        });
        final failingManager = SalahReminderManager(
          service: service,
          locationHelper: location,
          box: storage,
        );
        await expectLater(
          failingManager.save(
            previous.copyWith(sound: SalahReminderSound.long),
          ),
          throwsStateError,
        );
        expect(failingManager.settings.toMap(), previous.toMap());
        expect(scheduled.last.toMap(), previous.toMap());
        expect(writes, 2);
      },
    );

    test(
      'save persists across box reopen and disabling retains choices',
      () async {
        const settings = SalahReminderSettings(
          enabled: true,
          sound: SalahReminderSound.long,
          intervalMinutes: 120,
        );
        await manager.save(settings);
        await manager.save(settings.copyWith(enabled: false));
        await box.close();
        box = await Hive.openBox<dynamic>('settings', path: directory.path);
        final reopened = SalahReminderManager(
          service: service,
          locationHelper: location,
          box: box,
        );
        expect(
          reopened.settings.toMap(),
          settings.copyWith(enabled: false).toMap(),
        );
        verify(() => service.requestSalahReminderPermission()).called(1);
      },
    );

    test(
      'permission denial leaves stored settings and schedule intact',
      () async {
        when(
          () => service.requestSalahReminderPermission(),
        ).thenAnswer((_) async => false);
        await expectLater(
          manager.save(const SalahReminderSettings(enabled: true)),
          throwsA(isA<SalahReminderPermissionException>()),
        );
        expect(manager.settings.enabled, false);
        expect(scheduled, isEmpty);
        expect(box.get(SalahReminderManager.settingsKey), isNull);
      },
    );

    test(
      'schedule failure restores previous configuration and permits retry',
      () async {
        const previous = SalahReminderSettings(enabled: true);
        await manager.save(previous);
        var fail = true;
        when(
          () => service.scheduleSalahReminders(
            settings: any(named: 'settings'),
            timeZone: any(named: 'timeZone'),
          ),
        ).thenAnswer((call) async {
          final settings =
              call.namedArguments[#settings] as SalahReminderSettings;
          scheduled.add(settings);
          if (settings.sound == SalahReminderSound.long && fail) {
            throw StateError('failed');
          }
        });
        await expectLater(
          manager.save(previous.copyWith(sound: SalahReminderSound.long)),
          throwsStateError,
        );
        expect(manager.settings.toMap(), previous.toMap());
        expect(scheduled.last.toMap(), previous.toMap());
        fail = false;
        await manager.save(previous.copyWith(sound: SalahReminderSound.long));
        expect(manager.settings.sound, SalahReminderSound.long);
      },
    );

    test(
      'rollback failure records disabled state rather than false success',
      () async {
        await manager.save(const SalahReminderSettings(enabled: true));
        when(
          () => service.scheduleSalahReminders(
            settings: any(named: 'settings'),
            timeZone: any(named: 'timeZone'),
          ),
        ).thenThrow(StateError('unavailable'));
        await expectLater(
          manager.save(
            const SalahReminderSettings(enabled: true, intervalMinutes: 120),
          ),
          throwsStateError,
        );
        expect(manager.settings.enabled, false);
        verify(() => service.cancelSalahReminders()).called(1);
      },
    );

    test(
      'startup restores, unchanged resume skips, timezone change reschedules',
      () async {
        await box.put(
          SalahReminderManager.settingsKey,
          const SalahReminderSettings(enabled: true).toMap(),
        );
        await manager.reconcile(force: true);
        await manager.reconcile();
        expect(scheduled, hasLength(1));
        when(
          () => location.getLocal(),
        ).thenAnswer((_) async => 'Europe/London');
        await manager.reconcile();
        expect(scheduled, hasLength(2));
        verify(
          () => service.scheduleSalahReminders(
            settings: any(named: 'settings'),
            timeZone: 'Europe/London',
          ),
        ).called(1);
      },
    );

    test('resume waits for a save instead of restoring old settings', () async {
      final gate = Completer<void>();
      when(() => service.requestSalahReminderPermission()).thenAnswer((
        _,
      ) async {
        await gate.future;
        return true;
      });
      final save = manager.save(
        const SalahReminderSettings(
          enabled: true,
          sound: SalahReminderSound.long,
        ),
      );
      final resume = manager.reconcile();
      gate.complete();
      await Future.wait([save, resume]);
      expect(scheduled, hasLength(1));
      expect(scheduled.single.sound, SalahReminderSound.long);
    });
  });
}
