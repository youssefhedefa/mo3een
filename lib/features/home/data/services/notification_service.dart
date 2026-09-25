import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mo3een/features/home/data/models/prayer_model.dart';
import 'package:mo3een/features/more/data/models/salah_reminder_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

abstract class NotificationServiceContract {
  Future<void> initNotification();

  Future<void> schedulePrayerReminders({
    required List<PrayerModel> prayers,
    required String timeZone,
  });

  Future<void> cancelPrayerReminders();
  Future<bool> requestSalahReminderPermission();
  Future<void> scheduleSalahReminders({
    required SalahReminderSettings settings,
    required String timeZone,
  });
  Future<void> cancelSalahReminders();
  Future<void> showSalahReminder(SalahReminderSettings settings);
}

class SalahReminderDeliveryException implements Exception {
  const SalahReminderDeliveryException();
}

/// Uses calendar days and skips nonexistent local times at a DST transition.
tz.TZDateTime nextSalahReminderDate(tz.TZDateTime now, int minutes) {
  for (var day = 0; day < 3; day++) {
    final date = tz.TZDateTime(
      now.location,
      now.year,
      now.month,
      now.day + day,
      minutes ~/ 60,
      minutes % 60,
    );
    if (date.isAfter(now) &&
        date.hour == minutes ~/ 60 &&
        date.minute == minutes % 60) {
      return date;
    }
  }
  throw StateError('Unable to find next reminder date');
}

class NotificationService implements NotificationServiceContract {
  NotificationService({
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) : _notificationPlugin = flutterLocalNotificationsPlugin;

  static const Map<String, int> _prayerNotificationIds = {
    'الفجر': 1001,
    'الظهر': 1002,
    'العصر': 1003,
    'المغرب': 1004,
    'العشاء': 1005,
  };

  // Native resource names: Android res/raw/*.mp3 and iOS bundle *.wav.
  static const Map<String, String> _prayerNotificationSounds = {
    'الفجر': 'el_fajr_notification',
    'الظهر': 'el_zohr_notification',
    'العصر': 'el_3asr_notification',
    'المغرب': 'el_ma8rb_notification',
    'العشاء': 'el_3e4a_notification',
  };
  static const List<int> _legacyPrayerNotificationIds = [0, 1, 2, 3, 4, 5];
  static const Duration _reminderOffset = Duration(minutes: 5);
  // Separate from the recurring IDs (2000–2047), so showing a reminder now
  // cannot replace a scheduled request on iOS.
  static const int _immediateSalahReminderId = 2048;

  final FlutterLocalNotificationsPlugin _notificationPlugin;

  @override
  Future<bool> requestSalahReminderPermission() async {
    if (Platform.isAndroid) {
      return await _notificationPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()
              ?.requestNotificationsPermission() ??
          false;
    }
    if (Platform.isIOS) {
      return await _notificationPlugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >()
              ?.requestPermissions(alert: true, badge: true, sound: true) ??
          false;
    }
    return false;
  }

  @override
  Future<void> cancelSalahReminders() async {
    for (var id = 2000; id < 2048; id++) {
      await _notificationPlugin.cancel(id: id);
    }
  }

  @override
  Future<void> scheduleSalahReminders({
    required SalahReminderSettings settings,
    required String timeZone,
  }) async {
    final slots = settings.dailySlots;
    await cancelSalahReminders();
    if (!settings.enabled) return;
    final channel = _salahChannel(settings.sound);
    try {
      await _notificationPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);
      final mode = await _getAndroidScheduleMode();
      final now = tz.TZDateTime.now(_getLocation(timeZone));
      for (var index = 0; index < slots.length; index++) {
        await _notificationPlugin.zonedSchedule(
          id: 2000 + index,
          title: 'صلِّ على محمد ﷺ',
          body: 'اللهم صلِّ وسلم على نبينا محمد',
          scheduledDate: nextSalahReminderDate(now, slots[index]),
          notificationDetails: _salahNotificationDetails(settings.sound),
          androidScheduleMode: mode,
          matchDateTimeComponents: DateTimeComponents.time,
        );
      }
    } catch (_) {
      await cancelSalahReminders();
      rethrow;
    }
  }

  AndroidNotificationChannel _salahChannel(SalahReminderSound sound) {
    return AndroidNotificationChannel(
      'salah_${sound.resource}_v1',
      sound == SalahReminderSound.short
          ? 'الصلاة على محمد - قصير'
          : 'الصلاة على محمد - طويل',
      description: 'تذكير الصلاة على محمد',
      importance: Importance.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(sound.resource),
    );
  }

  NotificationDetails _salahNotificationDetails(SalahReminderSound sound) {
    final channel = _salahChannel(sound);
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        sound: channel.sound,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
        presentBanner: true,
        presentList: true,
        sound: '${sound.resource}.wav',
      ),
    );
  }

  @override
  Future<void> showSalahReminder(SalahReminderSettings settings) async {
    if (!settings.enabled) return;
    try {
      // Replacing the immediate notification must alert again, including when
      // the newly selected sound uses a different Android channel.
      await _notificationPlugin.cancel(id: _immediateSalahReminderId);
      await _notificationPlugin.show(
        id: _immediateSalahReminderId,
        title: 'صلِّ على محمد ﷺ',
        body: 'اللهم صلِّ وسلم على نبينا محمد',
        notificationDetails: _salahNotificationDetails(settings.sound),
      );
    } catch (error, stackTrace) {
      log(
        'Unable to show immediate Salah reminder.',
        error: error,
        stackTrace: stackTrace,
      );
      throw const SalahReminderDeliveryException();
    }
  }

  @override
  Future<void> initNotification() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          defaultPresentAlert: true,
          defaultPresentSound: true,
          defaultPresentBanner: true,
          defaultPresentList: true,
        );
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosInitializationSettings,
        );

    await _notificationPlugin.initialize(settings: initializationSettings);

    if (Platform.isIOS) {
      await _notificationPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
          _notificationPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      for (final entry in _prayerNotificationSounds.entries) {
        await androidPlugin?.createNotificationChannel(
          _prayerChannel(entry.key, entry.value),
        );
      }

      final bool? permissionGranted = await androidPlugin
          ?.requestNotificationsPermission();
      if (permissionGranted == false) {
        final PermissionStatus status = await Permission.notification.request();
        if (!status.isGranted) {
          log('Notification permission was not granted.');
        }
      }
    }

    tz.initializeTimeZones();
  }

  @override
  Future<void> schedulePrayerReminders({
    required List<PrayerModel> prayers,
    required String timeZone,
  }) async {
    await cancelPrayerReminders();

    final tz.Location location = _getLocation(timeZone);
    final tz.TZDateTime now = tz.TZDateTime.now(location);
    final AndroidScheduleMode scheduleMode = await _getAndroidScheduleMode();

    for (final PrayerModel prayer in prayers) {
      final int? id = _prayerNotificationIds[prayer.prayer];
      final String? sound = _prayerNotificationSounds[prayer.prayer];
      final ({int hour, int minute})? parsedTime = _parseTime(prayer.time);
      if (id == null || sound == null || parsedTime == null) {
        continue;
      }

      final tz.TZDateTime reminderDate = _buildReminderDate(
        location: location,
        now: now,
        hour: parsedTime.hour,
        minute: parsedTime.minute - 5,
      );

      final AndroidNotificationChannel channel = _prayerChannel(
        prayer.prayer,
        sound,
      );

      // Native scheduling lets the OS present and play the sound even when
      // the Flutter app is in the background or its process is not running.
      await _notificationPlugin.zonedSchedule(
        id: id,
        title: 'اقتربت صلاة ${prayer.prayer}',
        body: 'متبقي ٥ دقائق على صلاة ${prayer.prayer}',
        scheduledDate: reminderDate,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: channel.importance,
            priority: Priority.high,
            playSound: true,
            sound: channel.sound,
            audioAttributesUsage: channel.audioAttributesUsage,
            enableLights: channel.enableLights,
            ledColor: channel.ledColor,
            ledOnMs: 1000,
            ledOffMs: 1000,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            presentBanner: true,
            presentList: true,
            sound: '$sound.wav',
          ),
        ),
        androidScheduleMode: scheduleMode,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  AndroidNotificationChannel _prayerChannel(String prayer, String sound) {
    return AndroidNotificationChannel(
      'prayer_${sound}_v1',
      'Prayer reminder: $prayer',
      description: 'Reminder five minutes before $prayer',
      importance: Importance.high,
      audioAttributesUsage: AudioAttributesUsage.alarm,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(sound),
      ledColor: const Color(0xFFE4E028),
      enableLights: true,
    );
  }

  @override
  Future<void> cancelPrayerReminders() async {
    final Set<int> ids = {
      ..._legacyPrayerNotificationIds,
      ..._prayerNotificationIds.values,
    };
    for (final int id in ids) {
      await _notificationPlugin.cancel(id: id);
    }
  }

  tz.Location _getLocation(String timeZone) {
    try {
      return tz.getLocation(timeZone);
    } catch (error) {
      log('Unable to load timezone $timeZone: $error');
      return tz.getLocation('Africa/Cairo');
    }
  }

  ({int hour, int minute})? _parseTime(String value) {
    final RegExpMatch? match = RegExp(
      r'^(\d{1,2}):(\d{2})',
    ).firstMatch(value.trim());
    if (match == null) {
      log('Unable to parse prayer time: $value');
      return null;
    }

    final int hour = int.parse(match.group(1)!);
    final int minute = int.parse(match.group(2)!);
    if (hour > 23 || minute > 59) {
      log('Prayer time is outside the valid range: $value');
      return null;
    }
    return (hour: hour, minute: minute);
  }

  tz.TZDateTime _buildReminderDate({
    required tz.Location location,
    required tz.TZDateTime now,
    required int hour,
    required int minute,
  }) {
    tz.TZDateTime prayerDate = tz.TZDateTime(
      location,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    tz.TZDateTime reminderDate = prayerDate.subtract(_reminderOffset);

    if (!reminderDate.isAfter(now)) {
      final tz.TZDateTime tomorrow = now.add(const Duration(days: 1));
      prayerDate = tz.TZDateTime(
        location,
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
        hour,
        minute,
      );
      reminderDate = prayerDate.subtract(_reminderOffset);
    }

    return reminderDate;
  }

  Future<AndroidScheduleMode> _getAndroidScheduleMode() async {
    if (!Platform.isAndroid) {
      return AndroidScheduleMode.inexactAllowWhileIdle;
    }

    final bool canScheduleExactly =
        await _notificationPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.canScheduleExactNotifications() ??
        false;

    return canScheduleExactly
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;
  }
}
