import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mo3een/features/home/data/models/prayer_model.dart';
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
  static const List<int> _legacyPrayerNotificationIds = [0, 1, 2, 3, 4, 5];
  static const Duration _reminderOffset = Duration(minutes: 5);

  final FlutterLocalNotificationsPlugin _notificationPlugin;
  late final AndroidNotificationChannel _channel;

  @override
  Future<void> initNotification() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosInitializationSettings,
        );

    await _notificationPlugin.initialize(settings: initializationSettings);

    _channel = const AndroidNotificationChannel(
      'notify',
      'Azan Notifications',
      description: 'This channel is used for Azan notifications.',
      importance: Importance.high,
      audioAttributesUsage: AudioAttributesUsage.alarm,
      playSound: true,
      ledColor: Color(0xFFE4E028),
      enableLights: true,
      sound: RawResourceAndroidNotificationSound('el_3asr_notification'),
    );

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

      await androidPlugin?.createNotificationChannel(_channel);

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
      final ({int hour, int minute})? parsedTime = _parseTime(prayer.time);
      if (id == null || parsedTime == null) {
        continue;
      }

      final tz.TZDateTime reminderDate = _buildReminderDate(
        location: location,
        now: now,
        hour: parsedTime.hour,
        minute: parsedTime.minute,
      );

      await _notificationPlugin.zonedSchedule(
        id: id,
        title: 'اقتربت صلاة ${prayer.prayer}',
        body: 'متبقي ٥ دقائق على صلاة ${prayer.prayer}',
        scheduledDate: reminderDate,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            sound: 'default',
          ),
        ),
        androidScheduleMode: scheduleMode,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
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
