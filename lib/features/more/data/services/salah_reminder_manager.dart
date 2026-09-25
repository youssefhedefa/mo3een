import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:mo3een/core/helpers/get_current_position_helper.dart';
import 'package:mo3een/features/home/data/services/notification_service.dart';
import 'package:mo3een/features/more/data/models/salah_reminder_settings.dart';

class SalahReminderPermissionException implements Exception {}

/// Shared by settings and lifecycle so a resume cannot overwrite a save.
class SalahReminderManager {
  SalahReminderManager({
    required this.service,
    required this.locationHelper,
    required this.box,
  });
  static const settingsKey = 'salah_reminder_settings';
  final NotificationServiceContract service;
  final LocationHelper locationHelper;
  final Box<dynamic> box;
  Future<void> _pending = Future.value();
  String? _scheduledTimeZone;

  SalahReminderSettings get settings =>
      SalahReminderSettings.fromMap(box.get(settingsKey));

  Future<void> _serialize(Future<void> Function() action) {
    final operation = _pending.then((_) => action());
    _pending = operation.then<void>(
      (_) {},
      onError: (Object _, StackTrace __) {},
    );
    return operation;
  }

  Future<void> save(SalahReminderSettings next) => _serialize(() async {
    if (!next.isValid) throw ArgumentError('Invalid reminder settings');
    if (next.enabled && !await service.requestSalahReminderPermission()) {
      throw SalahReminderPermissionException();
    }
    final previous = settings;
    final zone = await locationHelper.getLocal();
    var settingsWriteStarted = false;
    try {
      await service.scheduleSalahReminders(settings: next, timeZone: zone);
      settingsWriteStarted = true;
      await box.put(settingsKey, next.toMap());
      _scheduledTimeZone = zone;
    } catch (error, stack) {
      try {
        await service.scheduleSalahReminders(
          settings: previous,
          timeZone: zone,
        );
        if (settingsWriteStarted) {
          await box.put(settingsKey, previous.toMap());
        }
      } catch (rollbackError, rollbackStack) {
        _scheduledTimeZone = null;
        log(
          'Unable to restore Salah reminders',
          error: rollbackError,
          stackTrace: rollbackStack,
        );
        try {
          await service.cancelSalahReminders();
        } finally {
          await box.put(settingsKey, previous.copyWith(enabled: false).toMap());
        }
      }
      Error.throwWithStackTrace(error, stack);
    }
  });

  Future<void> reconcile({bool force = false}) => _serialize(() async {
    try {
      final zone = await locationHelper.getLocal();
      if (!force && _scheduledTimeZone == zone) return;
      await service.scheduleSalahReminders(settings: settings, timeZone: zone);
      _scheduledTimeZone = zone;
    } catch (error, stack) {
      _scheduledTimeZone = null;
      log(
        'Unable to reconcile Salah reminders',
        error: error,
        stackTrace: stack,
      );
    }
  });
}
