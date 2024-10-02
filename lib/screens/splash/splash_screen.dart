import '../../core/config/routes.dart';
import '../../common/constants/dimens.dart';
import '../../common/constants/strings.dart';
import '../../common/constants/text_styles.dart';
import '../../common/widgets/error_dialog.dart';
import '../../common/widgets/force_update_alert_dialog.dart';
import '../../common/widgets/loader.dart';
import '../../features/painting/repository/painting_repository.dart';
import '../../core/localization/app_localizations_context.dart';
import '../../services/data_manager.dart';
import '../../services/ads/admob_service.dart';
import '../../services/cache/user_data_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
              const Text(appName, style: TextStyles.title),
              const Spacer(),
              Text(context.loc.goetheQuote,
                  style: TextStyles.quote, textAlign: TextAlign.center),
              const SizedBox(height: hugePadding),
              const Text(goetheFName,
                  style: TextStyles.goethe, textAlign: TextAlign.center),
              const Spacer(flex: 2),
              const Center(child: Loader()),
              const Spacer()
            ],
          ).animate().fade(duration: const Duration(seconds: 2)),
        ),
      ),
    );
  }
}
