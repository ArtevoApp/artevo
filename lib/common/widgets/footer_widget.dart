import 'package:artevo/common/constants/app_constants.dart';
import 'package:artevo/common/widgets/unknow_error_alert_dialog.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            TextButton(
                onPressed: () async {
                  try {
                    final uri = Uri.parse(privacyPolicyUrl);

                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  } catch (e) {
                    const UnknowErrorAlertDialog();
                  }
                },
                child: Text(context.loc.privacyPolicy)),
            TextButton(
                onPressed: () async {
                  try {
                    final uri = Uri.parse(termOfUseUrl);

                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  } catch (e) {
                    const UnknowErrorAlertDialog();
                  }
                },
                child: Text(context.loc.termsOfUse)),
            TextButton(
                onPressed: () => showLicensePage(
                      context: context,
                      applicationIcon: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child:
                              Image.asset("assets/app/logo.jpeg", height: 100)),
                      applicationName: appName,
                      applicationVersion: appVersion,
                      applicationLegalese: appLegalese,
                    ),
                child: Text(context.loc.licenses))
          ],
        ),
        const SizedBox(height: 32),
        const Text("$appName v$appVersion \n$appCopyright",
            style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
      ],
    );
  }
}
