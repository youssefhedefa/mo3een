import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/features/more/presentation/cubit/more_settings_state.dart';

class MoreSettingsCubit extends Cubit<MoreSettingsState> {
  MoreSettingsCubit()
    : _settingsBox = Hive.box(AppBoxConstants.notificationSettingsBox),
      super(
        const MoreSettingsState(
          prayerNotificationsEnabled: true,
          morningAzkarEnabled: true,
          eveningAzkarEnabled: false,
        ),
      ) {
    _loadSettings();
  }

  static const String _prayerNotificationsKey = 'prayer_notifications';
  static const String _morningAzkarKey = 'morning_azkar_notifications';
  static const String _eveningAzkarKey = 'evening_azkar_notifications';

  final Box<dynamic> _settingsBox;

  void _loadSettings() {
    emit(
      MoreSettingsState(
        prayerNotificationsEnabled:
            _settingsBox.get(_prayerNotificationsKey, defaultValue: true)
                as bool,
        morningAzkarEnabled:
            _settingsBox.get(_morningAzkarKey, defaultValue: true) as bool,
        eveningAzkarEnabled:
            _settingsBox.get(_eveningAzkarKey, defaultValue: false) as bool,
      ),
    );
  }

  Future<void> setPrayerNotifications(bool enabled) async {
    await _settingsBox.put(_prayerNotificationsKey, enabled);
    emit(state.copyWith(prayerNotificationsEnabled: enabled));
  }

  Future<void> setMorningAzkarNotifications(bool enabled) async {
    await _settingsBox.put(_morningAzkarKey, enabled);
    emit(state.copyWith(morningAzkarEnabled: enabled));
  }

  Future<void> setEveningAzkarNotifications(bool enabled) async {
    await _settingsBox.put(_eveningAzkarKey, enabled);
    emit(state.copyWith(eveningAzkarEnabled: enabled));
  }
}
