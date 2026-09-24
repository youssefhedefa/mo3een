class MoreSettingsState {
  const MoreSettingsState({
    required this.prayerNotificationsEnabled,
    required this.morningAzkarEnabled,
    required this.eveningAzkarEnabled,
  });

  final bool prayerNotificationsEnabled;
  final bool morningAzkarEnabled;
  final bool eveningAzkarEnabled;

  MoreSettingsState copyWith({
    bool? prayerNotificationsEnabled,
    bool? morningAzkarEnabled,
    bool? eveningAzkarEnabled,
  }) {
    return MoreSettingsState(
      prayerNotificationsEnabled:
          prayerNotificationsEnabled ?? this.prayerNotificationsEnabled,
      morningAzkarEnabled: morningAzkarEnabled ?? this.morningAzkarEnabled,
      eveningAzkarEnabled: eveningAzkarEnabled ?? this.eveningAzkarEnabled,
    );
  }
}
