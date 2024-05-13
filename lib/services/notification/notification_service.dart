import 'dart:io';
import '../cache/user_data_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationsService {
  static final NotificationsService _singleton = NotificationsService.init();

  factory NotificationsService() {
    return _singleton;
  }

  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  late InitializationSettings initializationSettings;

  late tz.TZDateTime _scheduledDateTime;

  int hours = 08;
  int minutes = 00;
  String notificationMessage = "";
  String notificationChannelDsc = "";
  String notificationChannelName = "";

  NotificationsService.init() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    initialize();
  }

  Future<void> initialize() async {
    final repository = UserDataManager.instance;
    hours = repository.getNotificationHour;
    minutes = repository.getNotificationMinute;

    await _flutterLocalNotificationsPlugin.cancelAll();

    // initialize Timezone
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    // initialize Platform
    const initializationSettingsAndroid =
        AndroidInitializationSettings("app_icon");

    final initializationSettingsIOS = const DarwinInitializationSettings(
        requestAlertPermission: true, requestSoundPermission: true);

    initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    _scheduledDateTime = await calculateNextDate();

    showNotification();
  }

  Future<tz.TZDateTime> calculateNextDate() async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local).toLocal();

    tz.TZDateTime newScheduledDateTime =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hours, minutes);

    if (newScheduledDateTime.isBefore(now)) {
      newScheduledDateTime = newScheduledDateTime.add(const Duration(days: 1));
    }

    return newScheduledDateTime;
  }

  Future<void> showNotification() async {
    if (Platform.localeName.split('_').first == 'tr') {
      notificationMessage = "Artevo'da yeni bir gün, yeni bir içerik! 📖🎵";
      notificationChannelDsc = "Artevo Günün İçeriği";
      notificationChannelName = "Artevo Hatırlatıcı";
    } else {
      notificationMessage = "Artevo, a new day, a new content! 📖🎵";
      notificationChannelDsc = "Artevo Content of the Day";
      notificationChannelName = "Artevo Reminder";
    }

    final androidChannel = AndroidNotificationDetails(
        'com.opifer.artevo.channel.notification', notificationChannelName,
        channelDescription: notificationChannelDsc,
        icon: "@mipmap/ic_launcher_foreground",
        importance: Importance.high,
        priority: Priority.high,
        playSound: true);

    final iosChannel = const DarwinNotificationDetails(
      sound: 'default.wav',
      presentAlert: true,
      // presentBadge: true,
      presentSound: true,
    );

    final platformChannel = NotificationDetails(
      android: androidChannel,
      iOS: iosChannel,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Artevo',
      notificationMessage,
      _scheduledDateTime,
      platformChannel,
      payload: 'Default_Sound',
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<bool?> requestPermission(bool permission) async {
    final bool? result = Platform.isIOS
        ? await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: permission,
              //   badge: permission,
              sound: permission,
            )
        : await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();

    return result;
  }

  Future<void> closeNotifications() async {
    _flutterLocalNotificationsPlugin.cancelAll();
  }
}
