import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mo3een/features/home/data/models/prayer_model.dart';
import 'package:mo3een/features/home/data/services/notification_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MockNotifications extends Mock
    implements FlutterLocalNotificationsPlugin {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const sounds = {
    'الفجر': 'el_fajr_notification',
    'الظهر': 'el_zohr_notification',
    'العصر': 'el_3asr_notification',
    'المغرب': 'el_ma8rb_notification',
    'العشاء': 'el_3e4a_notification',
  };
  late MockNotifications plugin;
  late NotificationService service;
  late List<Invocation> scheduled;

  setUpAll(() {
    tz.initializeTimeZones();
    registerFallbackValue(const InitializationSettings());
    registerFallbackValue(const NotificationDetails());
    registerFallbackValue(tz.TZDateTime(tz.UTC, 2030));
    registerFallbackValue(AndroidScheduleMode.inexactAllowWhileIdle);
  });

  setUp(() async {
    plugin = MockNotifications();
    scheduled = [];
    when(
      () => plugin.initialize(settings: any(named: 'settings')),
    ).thenAnswer((_) async => true);
    when(() => plugin.cancel(id: any(named: 'id'))).thenAnswer((_) async {});
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
    ).thenAnswer((invocation) async {
      scheduled.add(invocation);
    });
    service = NotificationService(flutterLocalNotificationsPlugin: plugin);
    await service.initNotification();
  });

  test(
    'each prayer schedules its bundled sound on a separate Android channel',
    () async {
      await service.schedulePrayerReminders(
        prayers: sounds.keys
            .map(
              (name) => PrayerModel(
                prayer: name,
                time: '12:00',
                icon: '',
                hisTurn: false,
              ),
            )
            .toList(),
        timeZone: 'Africa/Cairo',
      );

      expect(scheduled, hasLength(5));
      final channels = <String>{};
      for (var i = 0; i < scheduled.length; i++) {
        final args = scheduled[i].namedArguments;
        final sound = sounds.values.elementAt(i);
        final details = args[#notificationDetails] as NotificationDetails;
        expect(args[#id], 1001 + i);
        expect(args[#matchDateTimeComponents], DateTimeComponents.time);
        expect((args[#scheduledDate] as tz.TZDateTime).minute, 55);
        expect(details.android!.channelId, isNot('notify'));
        channels.add(details.android!.channelId);
        expect(details.android!.playSound, isTrue);
        // Native Android rejects a custom LED color without both timings.
        expect(details.android!.ledOnMs, isNotNull);
        expect(details.android!.ledOffMs, isNotNull);
        expect(
          (details.android!.sound as RawResourceAndroidNotificationSound).sound,
          sound,
        );
        expect(details.iOS!.sound, '$sound.wav');
        expect(details.iOS!.presentSound, isTrue);
        expect(details.iOS!.presentBanner, isTrue);
        expect(details.iOS!.presentList, isTrue);
        expect(
          File('android/app/src/main/res/raw/$sound.mp3').readAsBytesSync(),
          File('assets/audio/$sound.mp3').readAsBytesSync(),
        );
        expect(File('ios/Runner/Sounds/$sound.wav').existsSync(), isTrue);
      }
      expect(channels, hasLength(5));
      // Existing reminders must be replaced, including those using the old channel.
      for (final id in [0, 1, 2, 3, 4, 5, 1001, 1002, 1003, 1004, 1005]) {
        verify(() => plugin.cancel(id: id)).called(1);
      }
    },
  );

  test('iOS initialization enables foreground sound and presentation', () {
    final settings =
        verify(
              () => plugin.initialize(settings: captureAny(named: 'settings')),
            ).captured.single
            as InitializationSettings;
    expect(settings.iOS!.requestSoundPermission, isTrue);
    expect(settings.iOS!.defaultPresentSound, isTrue);
    expect(settings.iOS!.defaultPresentBanner, isTrue);
    expect(settings.iOS!.defaultPresentList, isTrue);
  });

  test('sunrise and invalid times do not schedule prayer sounds', () async {
    await service.schedulePrayerReminders(
      prayers: [
        PrayerModel(prayer: 'الشروق', time: '06:00', icon: '', hisTurn: false),
        PrayerModel(prayer: 'الفجر', time: 'invalid', icon: '', hisTurn: false),
      ],
      timeZone: 'Africa/Cairo',
    );
    expect(scheduled, isEmpty);
  });
}
