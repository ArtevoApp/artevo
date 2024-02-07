import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveUserDataService {
  final Box box = Hive.box('userDataBox');

  HiveUserDataService() {
    if (!box.isOpen) {
      openBox();
    }
  }

  Future openBox() async => Hive.box('userDataBox');

  bool isEmty() => box.isEmpty;

  Future<void> setTheme(ThemeMode themeMode) async {
    await box.put("themeMode", themeMode.name);
  }

  ThemeMode? getTheme() {
    try {
      return ThemeMode.values.byName(box.get("themeMode").toString());
    } catch (e) {
      return null;
    }
  }

  /// Saving the information that the user logs in for the first time.
  Future<void> setFirstLoginStatus(bool status) async {
    await box.put("isFirstLogin", status);
  }

  /// Fetching whether the user is logging in for the first time.
  bool get getFirstLoginStatus {
    return box.get("isFirstLogin") as bool? ?? true;
  }

  /// Save notification sending status.
  Future<void> setNotificationSendingStatus(bool status) async {
    await box.put("notification_send", status);
  }

  /// Get notification sending status.
  bool get getNotificationSendingStatus {
    return box.get("notification_send") as bool? ?? false;
  }

  /// Save the hour when notification will be sent.
  Future<void> setNotificationHour(int hour) async {
    await box.put("notification_hour", hour);
  }

  /// Get the hour when notification will be sent.
  int get getNotificationHour {
    return box.get("notification_hour") as int? ?? 08;
  }

  /// Save the minute when notification will be sent.
  Future<void> setNotificationMinute(int min) async {
    await box.put("notification_min", min);
  }

  /// Get the minute when notification will be sent.
  int get getNotificationMinute {
    return box.get("notification_min") as int? ?? 00;
  }

  /// clear box.
  Future<void> clearBox() async {
    await box.clear();
  }

  /// close box.
  Future<void> closeBox() async {
    await box.close();
  }
}
