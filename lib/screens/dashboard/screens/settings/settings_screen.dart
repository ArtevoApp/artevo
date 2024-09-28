import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:in_app_review/in_app_review.dart';
import '../../../../common/constants/dimens.dart';
import '../../../../common/constants/strings.dart';
import '../../../../common/helpers/functions.dart';
import '../../../../common/widgets/footer_widget.dart';
import '../../../../common/widgets/language_selection_widgets.dart';
import '../../../../common/widgets/notifications_widget.dart';
import '../../../../common/widgets/theme_toggle_button.dart';
import '../../../../localization/app_localizations_context.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: largePadding),
      children: [
        AppBar(
          centerTitle: true,
          title: Text(context.loc.settings),
          surfaceTintColor: Colors.transparent,
        ),
        sectionWidget(context.loc.settings),
        const LanguageSelectWithDropdownWidget(),
        const ThemeModeToggleWidget(),
        const NotificationsWidget(),
        sectionWidget(context.loc.contactUs),
        Text(context.loc.contactText, textAlign: TextAlign.center),
        CupertinoButton(
            child: const Text(appContactMail),
            onPressed: () => appContactMailOnPressed(context)),
        discordButton(context),
        sectionWidget(context.loc.other),
        rateArtevo(context),
        const FooterWidget(),
        const SizedBox(height: xLargeImageSize),
      ],
    ).animate().fade(duration: const Duration(milliseconds: 500));
  }

  static Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>>
      appContactMailOnPressed(BuildContext _) async =>
          await Clipboard.setData(const ClipboardData(text: appContactMail))
              .then(
            (v) => ScaffoldMessenger.of(_).showSnackBar(
              SnackBar(
                  content: Text(_.loc.copyEmailInfo),
                  backgroundColor: Theme.of(_).colorScheme.primary),
            ),
          );

  Widget sectionWidget(String title) => Padding(
        padding: const EdgeInsets.only(bottom: mediumPadding),
        child: Row(
          children: [
            Text(title),
            const Expanded(child: Divider(indent: mediumPadding))
          ],
        ),
      );

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
            final inAppReview = InAppReview.instance;
            final Future<bool> isAvailable = inAppReview.isAvailable();
            isAvailable.then((result) async {
              if (result) {
                inAppReview.requestReview();
                //await inAppReview.openStoreListing(appStoreId: appStoreID);
              } else {
                Functions.openUrl(
                    context, Platform.isIOS ? appStoreUrl : playStoreUrl);
              }
            });
          } catch (e) {
            Functions.openUrl(context, appStoreUrl);
          }
        },
      );
}
