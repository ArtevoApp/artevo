import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/strings.dart';
import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/common/helpers/functions.dart';
import 'package:artevo/common/widgets/language_selection_widgets.dart';
import 'package:artevo/common/widgets/theme_toggle_button.dart';
import 'package:artevo/common/widgets/footer_widget.dart';
import 'package:artevo/screens/setting/widgets/notifications_widget.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:in_app_review/in_app_review.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(appName), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: largePadding),
        children: [
          sectionWidget(context.loc.settings),
          const LanguageSelectWithDropdownWidget(isSmallWidget: false),
          const ThemeModeToggleWidget(),
          const NotificationsWidget(),
          sectionWidget(context.loc.contactUs),
          Text(context.loc.contactText,
              style: TextStyles.bodyv3, textAlign: TextAlign.center),
          CupertinoButton(
              child: const Text(appContactMail),
              onPressed: () => appContactMailOnPressed(context)),
          discordButton(context),
          sectionWidget(context.loc.other),
          rateArtevo(context),
          const FooterWidget(),
        ],
      ),
    );
  }

  static appContactMailOnPressed(BuildContext _) async =>
      await Clipboard.setData(const ClipboardData(text: appContactMail)).then(
          (value) => ScaffoldMessenger.of(_).showSnackBar(SnackBar(
              content: Text(_.loc.copyEmailInfo),
              backgroundColor: Colors.teal)));

  Widget sectionWidget(String title) => Padding(
      padding: const EdgeInsets.only(bottom: mediumPadding),
      child: Row(children: [
        Text(title),
        const Expanded(child: Divider(indent: mediumPadding))
      ]));

  Widget discordButton(BuildContext context) => CupertinoButton(
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.discord_sharp, size: smallIconSize),
            SizedBox(width: defaultPadding),
            Text(discord)
          ]),
      onPressed: () => Functions.openUrl(context, discordUrl));

  Widget rateArtevo(BuildContext context) => ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(context.loc.rateArtevo),
      trailing: const Icon(Iconsax.ranking_14),
      onTap: () async {
        try {
          var inAppReview = InAppReview.instance;
          Future<bool> isAvailable = inAppReview.isAvailable();
          isAvailable.then((result) async {
            if (result) {
              inAppReview.requestReview();
              //await inAppReview.openStoreListing(appStoreId: appStoreID);
            } else {
              Functions.openUrl(context, appStoreUrl);
            }
          });
        } catch (e) {
          Functions.openUrl(context, appStoreUrl);
        }
      });
}
