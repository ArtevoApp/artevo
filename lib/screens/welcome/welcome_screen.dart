import '../../core/config/color_schemes.dart';
import '../../core/config/routes.dart';
import '../../common/constants/dimens.dart';
import '../../common/constants/paths.dart';
import '../../common/constants/strings.dart';
import '../../common/constants/text_styles.dart';
import '../../common/widgets/language_selection_widgets.dart';
import '../../common/widgets/footer_widget.dart';
import '../../core/localization/app_localizations_context.dart';
import '../../services/cache/user_data_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColorScheme.surface,
      body: body1(context),
    );
  }

  SafeArea body1(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(largePadding),
        child: Column(
          children: [
            const Spacer(),
            const Text(appName, style: TextStyles.title),
            const Spacer(),
            Text(context.loc.welcome, style: TextStyles.title),
            const Spacer(),
            Text(context.loc.appPurpose,
                style: TextStyles.title, textAlign: TextAlign.center),
            const Spacer(),
            const Spacer(),
            Text(context.loc.termsOfUseToContinue, textAlign: TextAlign.center),
            const SizedBox(height: hugePadding),
            continueButton(context),
            const Spacer(),
            const FooterWidget()
          ],
        ).animate().shimmer(duration: const Duration(seconds: 3)),
      ),
    );
  }

  Align continueButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: CupertinoButton.filled(
          onPressed: () async {
            UserDataManager.instance.setFirstLoginStatus(false);
            Navigator.pushNamedAndRemoveUntil(
                context, splashRoute, (route) => false);
          },
          child: Text(context.loc.continuee)),
    );
  }

  Widget body2(BuildContext context) {
    final art =
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Rembrandt_Christ_in_the_Storm_on_the_Lake_of_Galilee.jpg/1545px-Rembrandt_Christ_in_the_Storm_on_the_Lake_of_Galilee.jpg";
    final screen = MediaQuery.of(context);
    print("top padding: ${screen.padding.top}");
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(mediumPadding),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(art),
          fit: BoxFit.cover,
          opacity: .65,
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: screen.padding.top),
              Text(context.loc.welcome, style: TextStyles.title),
              const SizedBox(height: largePadding),
              const Text(appName, style: TextStyles.title),
              const SizedBox(height: xxLargePadding),
              Text("“${context.loc.goetheQuote}”",
                  style: TextStyles.title, textAlign: TextAlign.center),
              const SizedBox(height: mediumPadding),
              Text("—$goetheFName",
                  style: TextStyles.goethe.copyWith(color: Colors.white),
                  textAlign: TextAlign.center),
              const SizedBox(height: xxLargePadding),
              Image.asset(dividerPath, height: 20, color: Colors.white),
              const SizedBox(height: xxLargePadding),
              Text(
                context.loc.appPurpose,
                style: TextStyles.title,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: screen.padding.top),
            child: const Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: LanguageSelectionWithPopupWidget(
                  iconColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
