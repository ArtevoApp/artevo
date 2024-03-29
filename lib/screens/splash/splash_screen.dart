import 'package:artevo/common/config/routes.dart';
import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/strings.dart';
import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/common/widgets/error_dialog.dart';
import 'package:artevo/common/widgets/force_update_alert_dialog.dart';
import 'package:artevo/common/widgets/loader.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/services/_service_manager.dart';
import 'package:artevo/services/admob/admob_service.dart';
import 'package:artevo/services/hive/hive_user_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part "splash_screen_mixin.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SplashScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(largePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(appName, style: TextStyles.welcomeTitle),
              const Text(appAuthor, style: TextStyles.bodyv3),
              const Spacer(),
              Text(context.loc.goetheQuote,
                  style: TextStyles.quote, textAlign: TextAlign.center),
              const SizedBox(height: hugePadding),
              const Text(goetheFName, style: TextStyles.goethe),
              const Spacer(flex: 2),
              const Loader(),
              const Spacer()
            ],
          ).animate().fade(duration: const Duration(seconds: 2)),
        ),
      ),
    );
  }
}
