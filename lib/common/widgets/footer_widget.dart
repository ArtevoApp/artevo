import '../constants/strings.dart';
import '../constants/text_styles.dart';
import '../helpers/functions.dart';
import '../../localization/app_localizations_context.dart';
import 'package:flutter/cupertino.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key, this.showLiceses = false});

  final bool showLiceses;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            CupertinoButton(
                onPressed: () => Functions.openUrl(context, privacyPolicyUrl),
                child: Text(context.loc.privacyPolicy)),
            CupertinoButton(
                onPressed: () => Functions.openUrl(context, termOfUseUrl),
                child: Text(context.loc.termsOfUse)),

            // * temporarily disabled due to responsive issues
            // if (showLiceses)
            //   CupertinoButton(
            //       onPressed: () => showLicenses(context),
            //       child: Text(context.loc.licenses))
          ],
        ),
        const Text("$appName v$appVersion\n$appCopyright",
            style: TextStyles.bodyv3, textAlign: TextAlign.center),
      ],
    );
  }

  // void showLicenses(_) => showLicensePage(
  //       context: _,
  //       applicationIcon: ClipRRect(
  //           borderRadius: BorderRadius.circular(largePadding),
  //           child: Image.asset(logoPath, height: mediumImageSize)),
  //       applicationName: appName,
  //       applicationVersion: appVersion,
  //       applicationLegalese: appLegalese,
  //     );
}
