import 'package:artevo/common/constants/strings.dart';
import 'package:artevo/common/helpers/functions.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';

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
                onPressed: () => Functions.openUrl(context, privacyPolicyUrl),
                child: Text(context.loc.privacyPolicy)),
            TextButton(
                onPressed: () => Functions.openUrl(context, termOfUseUrl),
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
