import 'package:artevo/common/config/routes.dart';
import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/strings.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(largePadding),
          child: Column(
            children: [
              const Spacer(),
              const Text(appName, style: TextStyles.welcomeTitle),
              const Spacer(),
              Text(context.loc.welcome, style: TextStyles.welcomeTitle),
              const Spacer(),
              Text(context.loc.appPurpose,
                  style: TextStyles.welcomeBody, textAlign: TextAlign.center),
              const Spacer(),
              const LanguageSelectWithDropdownWidget(isSmallWidget: true),
              const Spacer(),
              Text(context.loc.termsOfUseToContinue,
                  style: TextStyles.bodyv3, textAlign: TextAlign.center),
              const SizedBox(height: hugePadding),
              continueButton(context),
              const Spacer(),
              const FooterWidget()
            ],
          ).animate().shimmer(duration: const Duration(seconds: 3)),
        ),
      ),
    );
  }

  Align continueButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CupertinoButton.filled(
          onPressed: () async {
            HiveUserDataService.instance.setFirstLoginStatus(false);
            Navigator.pushNamedAndRemoveUntil(
                context, splashRoute, (route) => false);
          },
          child: Text(context.loc.continuee)),
    );
  }
}
