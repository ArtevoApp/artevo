import 'dart:io';
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

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(appName), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // * SETTINGS
              SectionWidget(title: context.loc.settings),
              const LanguageSelectWithDropdownWidget(isSmallWidget: false),
              const ThemeModeToggleWidget(),
              const NotificationsWidget(),

              // * CONTACT
              SectionWidget(title: context.loc.contactUs),
              Text(context.loc.contactText,
                  style: TextStyles.bodyv3, textAlign: TextAlign.center),
              CupertinoButton(
                child: const Text(appContactMail),
                onPressed: () async {
                  await Clipboard.setData(
                          const ClipboardData(text: appContactMail))
                      .then((value) => ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(
                              content: Text(context.loc.copyEmailInfo),
                              backgroundColor: Colors.teal)));
                },
              ),
              CupertinoButton(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.discord_sharp, size: 20),
                      SizedBox(width: 8),
                      Text(discord)
                    ],
                  ),
                  onPressed: () => Functions.openUrl(context, discordUrl)),

              // * OTHER
              SectionWidget(title: context.loc.other),
              newMethod(context),
              const FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }

  ListTile newMethod(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(context.loc.rateArtevo),
        trailing: const Icon(Iconsax.ranking_14, color: Colors.teal),
        onTap: () => Functions.openUrl(
            context, Platform.isIOS ? appStoreUrl : playStoreUrl));
  }
}

class SectionWidget extends StatelessWidget {
  const SectionWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: mediumPadding),
      child: Row(children: [
        Text(title),
        const Expanded(child: Divider(indent: mediumPadding))
      ]),
    );
  }
}
