import 'package:mo3een/features/more/data/models/salah_reminder_settings.dart';

class MoreSettingsState {
  const MoreSettingsState({
    required this.prayerNotificationsEnabled,
    required this.morningAzkarEnabled,
    required this.eveningAzkarEnabled,
    this.salahReminder = const SalahReminderSettings(),
  });

  final bool prayerNotificationsEnabled;
  final bool morningAzkarEnabled;
  final bool eveningAzkarEnabled;
  final SalahReminderSettings salahReminder;

  MoreSettingsState copyWith({
    bool? prayerNotificationsEnabled,
    bool? morningAzkarEnabled,
    bool? eveningAzkarEnabled,
    SalahReminderSettings? salahReminder,
  }) {
    return MoreSettingsState(
      salahReminder: salahReminder ?? this.salahReminder,
      prayerNotificationsEnabled:
          prayerNotificationsEnabled ?? this.prayerNotificationsEnabled,
      morningAzkarEnabled: morningAzkarEnabled ?? this.morningAzkarEnabled,
      eveningAzkarEnabled: eveningAzkarEnabled ?? this.eveningAzkarEnabled,
    );
  }
}
