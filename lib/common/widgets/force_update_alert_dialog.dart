import 'dart:io';
import 'package:artevo/common/constants/app_constants.dart';
import 'package:artevo/common/constants/dimes.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/services/firebase/realtime_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdateAlertDialog extends StatelessWidget {
  const ForceUpdateAlertDialog({super.key});

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
              String? url = await RealtimeService().getAppDownloadLink();
              final uri = Uri.parse(
                  url ?? (Platform.isIOS ? appStoreUrl : playStoreUrl));

              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                throw 'Url Açılamadı! ${Platform.isIOS ? appStoreUrl : playStoreUrl}';
              }
            },
            child: const Text("Mağazaya Git"))
      ],
    );
  }
}
