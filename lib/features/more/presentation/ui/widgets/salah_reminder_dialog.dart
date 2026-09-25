import 'package:flutter/material.dart';
import 'package:mo3een/features/home/data/services/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/features/more/data/models/salah_reminder_settings.dart';
import 'package:mo3een/features/more/data/services/salah_reminder_manager.dart';

class SalahReminderDialog extends StatefulWidget {
  const SalahReminderDialog({
    super.key,
    required this.initialSettings,
    required this.onSave,
  });
  final SalahReminderSettings initialSettings;
  final Future<void> Function(SalahReminderSettings) onSave;

  @override
  State<SalahReminderDialog> createState() => _SalahReminderDialogState();
}

class _SalahReminderDialogState extends State<SalahReminderDialog> {
  late SalahReminderSettings _settings = widget.initialSettings;
  bool _saving = false;
  String? _error;
  bool _permissionDenied = false;

  Future<void> _pickTime(bool start) async {
    final minutes = start ? _settings.startMinutes : _settings.endMinutes;
    final result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60),
    );
    if (result == null || !mounted) return;
    setState(() {
      final value = result.hour * 60 + result.minute;
      _settings = start
          ? _settings.copyWith(startMinutes: value)
          : _settings.copyWith(endMinutes: value);
      _error = null;
    });
  }

  String _time(int value) =>
      TimeOfDay(hour: value ~/ 60, minute: value % 60).format(context);

  Future<void> _save() async {
    if (!_settings.isValid) {
      setState(
        () => _error =
            'اختر وقت نهاية مختلفًا عن وقت البداية، أو فعّل طوال اليوم.',
      );
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
      _permissionDenied = false;
    });
    try {
      await widget.onSave(_settings);
      if (mounted) Navigator.of(context).pop();
    } on SalahReminderPermissionException {
      if (mounted) {
        setState(() {
          _permissionDenied = true;
          _error =
              'اسمح بالإشعارات من إعدادات التطبيق، ثم حاول الحفظ مرة أخرى.';
        });
      }
    } on SalahReminderDeliveryException {
      if (mounted) {
        setState(
          () => _error =
              'تم حفظ الإعدادات، لكن تعذّر إرسال الإشعار الآن. حاول مرة أخرى.',
        );
      }
    } catch (_) {
      if (mounted) setState(() => _error = 'تعذّر حفظ التذكير. حاول مرة أخرى.');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: PopScope(
        canPop: !_saving,
        child: AlertDialog(
          backgroundColor: AppColorHelper.whiteColor,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: const Text(
            'تذكير الصلاة على محمد',
            style: TextStyle(fontSize: 18),
          ),
          scrollable: true,
          content: SizedBox(
            width: 360,
            child: AbsorbPointer(
              absorbing: _saving,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('تفعيل التذكير'),
                    value: _settings.enabled,
                    onChanged: (value) => setState(
                      () => _settings = _settings.copyWith(enabled: value),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text('صوت التذكير'),
                  const SizedBox(height: 8),
                  SegmentedButton<SalahReminderSound>(
                    segments: const [
                      ButtonSegment(
                        value: SalahReminderSound.short,
                        label: Text('قصير'),
                      ),
                      ButtonSegment(
                        value: SalahReminderSound.long,
                        label: Text('طويل'),
                      ),
                    ],
                    selected: {_settings.sound},
                    onSelectionChanged: (value) => setState(
                      () => _settings = _settings.copyWith(sound: value.single),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    isExpanded: true,
                    initialValue: _settings.intervalMinutes,
                    decoration: const InputDecoration(
                      labelText: 'تكرار التذكير',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 30, child: Text('كل ٣٠ دقيقة')),
                      DropdownMenuItem(value: 60, child: Text('كل ساعة')),
                      DropdownMenuItem(value: 120, child: Text('كل ساعتين')),
                      DropdownMenuItem(value: 180, child: Text('كل ٣ ساعات')),
                      DropdownMenuItem(value: 240, child: Text('كل ٤ ساعات')),
                      DropdownMenuItem(value: 360, child: Text('كل ٦ ساعات')),
                      DropdownMenuItem(value: 720, child: Text('كل ١٢ ساعة')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(
                          () => _settings = _settings.copyWith(
                            intervalMinutes: value,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('طوال اليوم'),
                    value: _settings.allDay,
                    onChanged: (value) => setState(() {
                      _settings = _settings.copyWith(allDay: value);
                      _error = null;
                    }),
                  ),
                  if (!_settings.allDay) ...[
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('من'),
                      trailing: Text(_time(_settings.startMinutes)),
                      onTap: () => _pickTime(true),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('إلى'),
                      trailing: Text(_time(_settings.endMinutes)),
                      onTap: () => _pickTime(false),
                    ),
                    if (_settings.endMinutes < _settings.startMinutes)
                      const Text(
                        'ينتهي التذكير في اليوم التالي.',
                        style: TextStyle(fontSize: 12),
                      ),
                    const Text(
                      'يبدأ التذكير في وقت البداية ويتوقف قبل وقت النهاية.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    if (_permissionDenied)
                      const TextButton(
                        onPressed: openAppSettings,
                        child: Text('فتح إعدادات التطبيق'),
                      ),
                  ],
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: _saving ? null : () => Navigator.of(context).pop(),
              child: const Text('إلغاء'),
            ),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }
}
