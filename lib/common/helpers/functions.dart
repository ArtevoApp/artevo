import 'package:artevo/common/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class Functions {
  /// open @url
  static Future<void> openUrl(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        if (context.mounted) {
          ErrorDialog.show(context);
        }
      }
    } catch (e) {
      if (context.mounted) {
        ErrorDialog.show(context);
      }
    }
  }
}
