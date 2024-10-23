import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

abstract class AppPermissionHelper {
  static Completer<void>? _permissionCompleter;

  static Future<bool> _checkPermission(Permission permission) async {
    if (_permissionCompleter != null) {
      await _permissionCompleter!.future;
    } else {
      _permissionCompleter = Completer<void>();
      try {
        PermissionStatus status = await permission.status;
        if (status.isGranted) {
          return true;
        } else {
          if (status.isPermanentlyDenied) {
            await openAppSettings();
            status = await permission.status;
            return status.isGranted;
          }
          status = await permission.request();
          return status.isGranted;
        }
      } finally {
        _permissionCompleter!.complete();
        _permissionCompleter = null;
      }
    }
    return false;
  }

  static Future<bool> checkLocationPermission() async {
    return await _checkPermission(Permission.location);
  }

  static Future<bool> checkNotifyPermission() async {
    return await _checkPermission(Permission.notification);
  }
}