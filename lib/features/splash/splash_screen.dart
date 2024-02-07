import 'package:artevo/common/config/routes.dart';
import 'package:artevo/common/widgets/force_update_alert_dialog.dart';
import 'package:artevo/common/widgets/unknow_error_alert_dialog.dart';
import 'package:artevo/services/_service_manager.dart';
import 'package:artevo/features/splash/splash_screen_body_widget.dart';
import 'package:artevo/services/hive/hive_user_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SplashScreenBodyWidget());
  }

  void loadData() async {
    bool isFirstLogin = HiveUserDataService().getFirstLoginStatus;
    if (isFirstLogin) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushNamedAndRemoveUntil(
            context, Screens.welcome.routeName, (route) => false);
      });
    } else {
      Future<bool> versionControl = ServiceManger().checkAppVersionData();
      Future<bool> contentControl = ServiceManger().checkContentData();

      Future delay = Future.delayed(const Duration(seconds: 3));

      await Future.wait([versionControl, contentControl, delay])
          .then((controls) {
        // version control
        if (controls[0]) {
          // content control
          if (controls[1]) {
            Navigator.pushNamedAndRemoveUntil(
                context, Screens.home.routeName, (route) => false);
          } else {
            showDialog(
                context: context,
                builder: (context) => const UnknowErrorAlertDialog());
          }
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const ForceUpdateAlertDialog(),
          );
        }
      });
    }
  }
}
