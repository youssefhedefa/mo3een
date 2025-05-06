import 'dart:developer';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mo3een/features/home/data/models/prayer_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

abstract class NotificationServiceContract {
  Future<void> initNotification();
  Future<void> scheduleDailyNotifications(
      {required List<PrayerModel> prayers, String? local});
}

class NotificationService implements NotificationServiceContract {
  final FlutterLocalNotificationsPlugin _notificationPlugin;
  late AndroidNotificationChannel channel;

  NotificationService({
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) : _notificationPlugin = flutterLocalNotificationsPlugin;

  @override
  Future<void> initNotification() async {
    if (Platform.isIOS) {
      await _notificationPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      bool? res = await _notificationPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      if (res == null || res == false) {
        PermissionStatus status = await Permission.notification.request();
        if (!status.isGranted) {
          openAppSettings();
          return;
        }
      }
    }

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

    await _notificationPlugin.initialize(
      initializationSettings,
    );

    channel = const AndroidNotificationChannel(
      'notify',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await _notificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    tz.initializeTimeZones();
  }

  @override
  Future<void> scheduleDailyNotifications(
      {required List<PrayerModel> prayers, String? local}) async {
    if (prayers.isEmpty) return;
    for (int i = 0; i < prayers.length; i++) {
      final PrayerModel prayer = prayers[i];
      final int hour = int.parse(prayer.time.split(':')[0]);
      final int minute = int.parse(prayer.time.split(':')[1]);
      await _scheduleNotification(
        id: i,
        title: 'اقتربت صلاه ${prayer.prayer}',
        body: 'اقتربت صلاه ${prayer.prayer}',
        hour: hour,
        minute: minute,
        local: local,
      );
    }
  }

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
    String? local,
  }) async {
    final tz.TZDateTime now =
        tz.TZDateTime.now(tz.getLocation(local ?? 'Africa/Cairo'));
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      now.location,
      now.year,
      now.month,
      now.day,
      hour,
      minute - 5,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notificationPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
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
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      // matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
