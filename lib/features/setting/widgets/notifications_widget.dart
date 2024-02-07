import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/services/notification/notification_service.dart';
import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/common/widgets/unknow_error_alert_dialog.dart';
import 'package:artevo/services/hive/hive_user_data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({super.key});

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  HiveUserDataService hive = HiveUserDataService();
  int hour = 08;
  int min = 00;
  bool notificationStatus = false;

  @override
  void initState() {
    notificationStatus = hive.getNotificationSendingStatus;
    super.initState();
  }

  @override
  void dispose() {
    hive;
    hour;
    min;
    notificationStatus;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    hour = hive.getNotificationHour;
    min = hive.getNotificationMinute;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(context.loc.notifications),
      subtitle: Row(
        children: [
          Text(
              notificationStatus
                  ? context.loc.notificationTimeDescription(hour, min)
                  : context.loc.notificationDescriptionText,
              style: TextStyles.infoTextStyle),

          // * Edit Button
          Visibility(
            visible: notificationStatus,
            child: CupertinoButton(
              onPressed: notificationTimeEditFunction,
              minSize: 14,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(context.loc.edit, style: TextStyles.infoTextStyle),
            ),
          ),
        ],
      ),
      trailing: Switch.adaptive(
          value: notificationStatus,
          onChanged: notificationStatusSwitchFunction),
    );
  }

  void notificationTimeEditFunction() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay(hour: hour, minute: min),
      builder: (BuildContext context, Widget? child) {
        if (context.loc.langCode == 'tr') {
          return MediaQuery(
              data: const MediaQueryData(alwaysUse24HourFormat: true),
              child: child!);
        } else {
          return Localizations.override(
            context: context,
            locale: Locale(context.loc.langCode),
            child: child,
          );
        }
      },
    );

    if (selectedTime != null) {
      await hive.setNotificationHour(selectedTime.hour);
      await hive.setNotificationMinute(selectedTime.minute);
      NotificationsService.init();
    }

    setState(() {});
  }

  void notificationStatusSwitchFunction(newStatus) async {
    NotificationsService().requestPermission(newStatus).then((result) async {
      // artevo notifications opened.
      if (newStatus) {
        // os permission check
        if (result == true) {
          await hive.setNotificationSendingStatus(true);
          NotificationsService.init();
          setState(() {
            notificationStatus = newStatus;
          });
          //  NotificationsManager().showNotification();
        } else {
          showDialog(
            context: context,
            builder: (context) => UnknowErrorAlertDialog(
              msg: context.loc.notificationPermissionText,
            ),
          );
        }
      }
      // artevo notifications closed.
      else {
        await hive.setNotificationSendingStatus(false);
        NotificationsService().closeNotifications();
        setState(() {
          notificationStatus = newStatus;
        });
      }
    });
  }
}
