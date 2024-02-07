import 'package:artevo/common/config/routes.dart';
import 'package:artevo/common/constants/app_constants.dart';
import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/common/widgets/language_selection_widgets.dart';
import 'package:artevo/common/widgets/footer_widget.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/services/hive/hive_user_data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 32),
                const Text(appName, style: TextStyle(fontSize: 48)),
                const Text(appAuthor, style: TextStyle(fontSize: 12)),
                const SizedBox(height: 32),
                Text(
                  context.loc.welcome,
                  style: const TextStyle(fontSize: 48),
                ),
                Text(
                  context.loc.appPurpose,
                  style: TextStyles.other,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                const LanguageSelectWithDropdownWidget(isSmallWidget: true),
                const Spacer(),
                Text(
                  context.loc.termsOfUseToContinue,
                  style: TextStyles.bodyv3TextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton.filled(
                      onPressed: () async {
                        HiveUserDataService().setFirstLoginStatus(false);
                        Navigator.pushNamedAndRemoveUntil(context,
                            Screens.splash.routeName, (route) => false);
                      },
                      child: Text(context.loc.continuee)),
                ),
                const Spacer(),
                const FooterWidget()
              ],
            ).animate().shimmer(duration: const Duration(seconds: 3)),
          ),
        ),
      ),
    );
  }
}
