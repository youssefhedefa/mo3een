import 'dart:developer';
import 'package:mo3een/features/more/data/models/salah_reminder_settings.dart';
import 'package:mo3een/features/more/data/services/salah_reminder_manager.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mo3een/core/helpers/get_current_position_helper.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/features/home/data/models/home_data_model.dart';
import 'package:mo3een/features/home/data/models/prayer_model.dart';
import 'package:mo3een/features/home/data/services/notification_service.dart';
import 'package:mo3een/features/more/presentation/cubit/more_settings_state.dart';

class MoreSettingsCubit extends Cubit<MoreSettingsState> {
  MoreSettingsCubit({
    required NotificationServiceContract notificationService,
    required LocationHelper locationHelper,
    required SalahReminderManager salahReminderManager,
  }) : _notificationService = notificationService,
       _locationHelper = locationHelper,
       _salahReminderManager = salahReminderManager,
       _settingsBox = Hive.box(AppBoxConstants.notificationSettingsBox),
       super(
         const MoreSettingsState(
           prayerNotificationsEnabled: true,
           morningAzkarEnabled: true,
           eveningAzkarEnabled: false,
         ),
       ) {
    _loadSettings();
  }

  static const String _morningAzkarKey = 'morning_azkar_notifications';
  static const String _eveningAzkarKey = 'evening_azkar_notifications';

  final NotificationServiceContract _notificationService;
  final LocationHelper _locationHelper;
  final SalahReminderManager _salahReminderManager;
  final Box<dynamic> _settingsBox;

  void _loadSettings() {
    emit(
      MoreSettingsState(
        salahReminder: _salahReminderManager.settings,
        prayerNotificationsEnabled:
            _settingsBox.get(
                  AppBoxConstants.prayerNotificationsKey,
                  defaultValue: true,
                )
                as bool,
        morningAzkarEnabled:
            _settingsBox.get(_morningAzkarKey, defaultValue: true) as bool,
        eveningAzkarEnabled:
            _settingsBox.get(_eveningAzkarKey, defaultValue: false) as bool,
      ),
    );
  }

  Future<void> saveSalahReminder(SalahReminderSettings settings) async {
    try {
      await _salahReminderManager.save(settings);
      if (settings.enabled) {
        await _notificationService.showSalahReminder(settings);
      }
    } finally {
      if (!isClosed) {
        emit(state.copyWith(salahReminder: _salahReminderManager.settings));
      }
    }
  }

  Future<void> setPrayerNotifications(bool enabled) async {
    await _settingsBox.put(AppBoxConstants.prayerNotificationsKey, enabled);
    emit(state.copyWith(prayerNotificationsEnabled: enabled));

    try {
      if (!enabled) {
        await _notificationService.cancelPrayerReminders();
        return;
      }

      await _scheduleCachedPrayerReminders();
    } catch (error, stackTrace) {
      log(
        'Unable to update prayer reminders from settings.',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> setMorningAzkarNotifications(bool enabled) async {
    await _settingsBox.put(_morningAzkarKey, enabled);
    emit(state.copyWith(morningAzkarEnabled: enabled));
  }

  Future<void> setEveningAzkarNotifications(bool enabled) async {
    await _settingsBox.put(_eveningAzkarKey, enabled);
    emit(state.copyWith(eveningAzkarEnabled: enabled));
  }

  Future<void> _scheduleCachedPrayerReminders() async {
    final Box<HomeDataModel> homeDataBox = Hive.box<HomeDataModel>(
      AppBoxConstants.homeDataBox,
    );
    if (homeDataBox.isEmpty) {
      return;
    }

    final List<PrayerModel>? prayers = homeDataBox.getAt(0)?.prayers;
    if (prayers == null || prayers.isEmpty) {
      return;
    }

    final List<PrayerModel> notificationPrayers = prayers
        .where((PrayerModel prayer) => prayer.prayer != 'الشروق')
        .toList(growable: false);
    final String timeZone = await _locationHelper.getLocal();
    await _notificationService.schedulePrayerReminders(
      prayers: notificationPrayers,
      timeZone: timeZone,
    );
  }
}
