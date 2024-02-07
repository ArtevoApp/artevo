import 'dart:io';
import 'package:artevo/common/constants/app_constants.dart';
import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/common/widgets/language_selection_widgets.dart';
import 'package:artevo/common/widgets/theme_toggle_button.dart';
import 'package:artevo/common/widgets/unknow_error_alert_dialog.dart';
import 'package:artevo/common/widgets/footer_widget.dart';
import 'package:artevo/features/setting/widgets/notifications_widget.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
          children: [Text(title), const Expanded(child: Divider(indent: 10))]),
    );
  }
}

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
              // * AYARLAR
              SectionWidget(title: context.loc.settings),
              const LanguageSelectWithDropdownWidget(isSmallWidget: false),
              const ThemeModeToggleWidget(),
              const NotificationsWidget(),

              // * İLETİŞİM
              SectionWidget(title: context.loc.contactUs),
              Text(context.loc.contactText,
                  style: TextStyles.bodyv3TextStyle,
                  textAlign: TextAlign.center),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/social_media/discord_logo_white.png",
                        color: Colors.teal, height: 16, width: 16),
                    const SizedBox(width: 8),
                    const Text("Artevo Discord")
                  ],
                ),
                onPressed: () async {
                  try {
                    final uri = Uri.parse(discordUrl);

                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    showDialog(
                        context: context,
                        builder: (context) => const UnknowErrorAlertDialog());
                  }
                },
              ),

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
      onTap: () async {
        try {
          final uri = Uri.parse(Platform.isIOS ? appStoreUrl : playStoreUrl);

          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            throw 'Url Açılamadı! $uri';
          }
        } catch (e) {
          // ignore: use_build_context_synchronously
          showDialog(
              context: context,
              builder: (context) => const UnknowErrorAlertDialog());
        }
      },
    );
  }
}
