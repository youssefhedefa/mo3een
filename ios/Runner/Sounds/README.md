These WAV files are the iOS notification versions of `assets/audio/*_notification.mp3`.
They use 44.1 kHz, mono, 16-bit PCM and are registered in the Runner target's
Copy Bundle Resources phase. Flutter asset registration alone is insufficient.

To replace a sound, update its Android copy in `android/app/src/main/res/raw/`
and convert the source for iOS, for example:

```sh
ffmpeg -i assets/audio/el_fajr_notification.mp3 -ac 1 -ar 44100 -c:a pcm_s16le ios/Runner/Sounds/el_fajr_notification.wav
```

Keep iOS sounds shorter than 30 seconds. The map in `notification_service.dart`
uses resource basenames without extensions. Android channels include the sound
name because channel sounds cannot be changed after creation; bump the channel
version when changing an existing channel's sound configuration.

Fully rebuild and launch the app after native sound changes so prayer reminders
are rescheduled. Verify each prayer on real Android and iOS devices with the app
in the foreground, background, and normally terminated. Notifications remain
subject to notification permissions, user sound settings, iOS silent/Focus modes,
and Android force-stop or manufacturer battery restrictions. No Dart background
callback is required for the OS to deliver an already scheduled reminder.
