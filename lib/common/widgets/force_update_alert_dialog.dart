import 'dart:io';
import '../constants/strings.dart';
import '../constants/dimens.dart';
import '../../localization/app_localizations_context.dart';
import '../../services/database/firebase/realtime_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdateAlertDialog extends StatelessWidget {
  const ForceUpdateAlertDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const ForceUpdateAlertDialog());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.loc.forceUpdateTitle),
      content: SizedBox(
        width: dialogWidth,
        child: Text(context.loc.forceUpdateText),
      ),
      actions: [
        CupertinoButton(
            onPressed: () async {
              final String? url = await RealtimeService().getAppDownloadLink();
              final uri = Uri.parse(
                  url ?? (Platform.isIOS ? appStoreUrl : playStoreUrl));

              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
            child: const Text("Mağazaya Git"))
      ],
    );
  }
}
