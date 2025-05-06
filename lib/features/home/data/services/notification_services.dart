// import 'dart:developer';
// import 'dart:io';
// import 'package:alarm/alarm.dart';
// import 'package:alarm/model/volume_settings.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class NotificationService {
//   static initNotificationPermission() async {
//     var notificationPermission = await Permission.notification.request();
//     if (notificationPermission.isGranted) {
//       await Alarm.init();
//       setAlarm();
//     } else {
//       notificationPermission = await Permission.notification.request();
//       if (notificationPermission.isGranted) {
//         await Alarm.init();
//         setAlarm();
//       }
//     }
//   }
//
//   static var alarmSettings = AlarmSettings(
//     id: 45,
//     dateTime: DateTime.now().add(const Duration(seconds: 5)),
//     assetAudioPath: 'assets/audio/alarm.mp3',
//     loopAudio: true,
//     vibrate: false,
//     warningNotificationOnKill: Platform.isIOS,
//     androidFullScreenIntent: true,
//     volumeSettings: VolumeSettings.fade(
//       volume: 1,
//       fadeDuration: const Duration(seconds: 10),
//       volumeEnforced: true,
//     ),
//     notificationSettings: const NotificationSettings(
//       title: 'This is the title',
//       body: 'This is the body',
//       stopButton: 'Stop the alarm',
//       icon: 'notification_icon',
//       // iconColor: Color(0xff862778),
//     ),
//   );
//   static var alarmSettings2 = AlarmSettings(
//     id: 45,
//     dateTime: DateTime.now().add(const Duration(seconds: 25)),
//     assetAudioPath: 'assets/audio/alarm.mp3',
//     loopAudio: true,
//     vibrate: false,
//     warningNotificationOnKill: Platform.isIOS,
//     androidFullScreenIntent: true,
//     volumeSettings: VolumeSettings.fade(
//       // volume: 1,
//       fadeDuration: const Duration(seconds: 5),
//       volumeEnforced: true,
//     ),
//     notificationSettings: const NotificationSettings(
//       title: 'This is the title',
//       body: 'This is the body',
//       stopButton: 'Stop the alarm',
//       icon: 'notification_icon',
//       // iconColor: Color(0xff862778),
//     ),
//   );
//
//   static setAlarm() async {
//     log('Notification Service setAlarm');
//     await Alarm.set(alarmSettings: alarmSettings);
//     await Alarm.set(alarmSettings: alarmSettings2);
//   }
// }
