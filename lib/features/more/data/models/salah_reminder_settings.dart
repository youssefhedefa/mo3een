enum SalahReminderSound {
  short('salah_qaser'),
  long('salah_taweel');

  const SalahReminderSound(this.resource);
  final String resource;
}

class SalahReminderSettings {
  const SalahReminderSettings({
    this.enabled = false,
    this.sound = SalahReminderSound.short,
    this.intervalMinutes = 60,
    this.allDay = true,
    this.startMinutes = 480,
    this.endMinutes = 1320,
  });

  static const intervals = [30, 60, 120, 180, 240, 360, 720];
  final bool enabled;
  final SalahReminderSound sound;
  final int intervalMinutes;
  final bool allDay;
  final int startMinutes;
  final int endMinutes;

  bool get isValid =>
      intervals.contains(intervalMinutes) &&
      startMinutes >= 0 &&
      startMinutes < 1440 &&
      endMinutes >= 0 &&
      endMinutes < 1440 &&
      (allDay || startMinutes != endMinutes);

  /// Local clock times, anchored at the beginning of each daily window.
  List<int> get dailySlots {
    if (!isValid) throw ArgumentError('Invalid reminder settings');
    final start = allDay ? 0 : startMinutes;
    final length = allDay ? 1440 : (endMinutes - startMinutes + 1440) % 1440;
    return [
      for (var offset = 0; offset < length; offset += intervalMinutes)
        (start + offset) % 1440,
    ];
  }

  SalahReminderSettings copyWith({
    bool? enabled,
    SalahReminderSound? sound,
    int? intervalMinutes,
    bool? allDay,
    int? startMinutes,
    int? endMinutes,
  }) => SalahReminderSettings(
    enabled: enabled ?? this.enabled,
    sound: sound ?? this.sound,
    intervalMinutes: intervalMinutes ?? this.intervalMinutes,
    allDay: allDay ?? this.allDay,
    startMinutes: startMinutes ?? this.startMinutes,
    endMinutes: endMinutes ?? this.endMinutes,
  );

  Map<String, dynamic> toMap() => {
    'enabled': enabled,
    'sound': sound.name,
    'intervalMinutes': intervalMinutes,
    'allDay': allDay,
    'startMinutes': startMinutes,
    'endMinutes': endMinutes,
  };

  factory SalahReminderSettings.fromMap(dynamic value) {
    if (value is! Map) return const SalahReminderSettings();
    final settings = SalahReminderSettings(
      enabled: value['enabled'] == true,
      sound: value['sound'] == 'long'
          ? SalahReminderSound.long
          : SalahReminderSound.short,
      intervalMinutes: value['intervalMinutes'] is int
          ? value['intervalMinutes'] as int
          : 60,
      allDay: value['allDay'] != false,
      startMinutes: value['startMinutes'] is int
          ? value['startMinutes'] as int
          : 480,
      endMinutes: value['endMinutes'] is int
          ? value['endMinutes'] as int
          : 1320,
    );
    return settings.isValid ? settings : const SalahReminderSettings();
  }
}
