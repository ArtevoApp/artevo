import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:in_app_review/in_app_review.dart';
import '../../../../common/constants/dimens.dart';
import '../../../../common/constants/strings.dart';
import '../../../../common/constants/text_styles.dart';
import '../../../../common/global_variables/theme_mode.dart';
import '../../../../common/helpers/functions.dart';
import '../../../../common/widgets/app_switch_button.dart';
import '../../../../common/widgets/footer_widget.dart';
import '../../../../common/widgets/language_selection_widgets.dart';
import '../../../../features/notification/notifications_widget.dart';
import '../../../../core/localization/app_localizations_context.dart';
import '../../../../services/cache/user_data_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: largePadding),
        children: [
          AppBar(
            centerTitle: true,
            title: Text(context.loc.settings, style: TextStyles.title),
            surfaceTintColor: Colors.transparent,
          ),
          const NotificationsWidget(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(context.loc.darkTheme),
            trailing: AppSwitch(
              initialValue: themeModeController.value == ThemeMode.dark,
              onChanged: (value) async {
                final mode = value ? ThemeMode.dark : ThemeMode.light;
                themeModeController.value = mode;
                await UserDataManager.instance.setTheme(mode);
              },
            ),
          ),
          const LanguageSelectWithDropdownWidget(),
          const SizedBox(height: largePadding),
          sectionWidget(context.loc.contactUs),
          Text(context.loc.contactText, textAlign: TextAlign.center),
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text(appContactMail),
              onPressed: () => appContactMailOnPressed(context)),
          discordButton(context),
          const SizedBox(height: largePadding),
          sectionWidget(context.loc.other),
          rateArtevo(context),
          const SizedBox(height: largePadding),
          const FooterWidget(),
        ],
      ),
    );
  }

  static Future<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>>
      appContactMailOnPressed(BuildContext context) async =>
          await Clipboard.setData(const ClipboardData(text: appContactMail))
              .then(
            (v) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(context.loc.copyEmailInfo),
                  backgroundColor: Theme.of(context).colorScheme.primary),
            ),
          );

  Widget sectionWidget(String title) => Padding(
        padding: const EdgeInsets.only(bottom: mediumPadding),
        child: Row(
          children: [
            Text(title, style: TextStyles.h1),
          ],
        ),
      );

  Widget discordButton(BuildContext context) => CupertinoButton(
      padding: EdgeInsets.zero,
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.elliptical(mediumPadding, defaultPadding),
          ),
        ),
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
