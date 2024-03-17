import 'package:artevo/common/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Helper Functions
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

  /// formatter function from [duration] to "mm:ss".
  static String secondToMinute(Duration? duration) {
    if (duration != null) {
      return "${(duration.inSeconds / 60).toString().split(".").first}:${(duration.inSeconds % 60).truncate().toString().padLeft(2, '0')}";
    } else {
      return "0:00";
    }
  }

  /// Convert a string expression to a string expression shorter than @length.
  /// default length is 30.
  static String stringShorter(String str, {int? length = 30}) {
    if (str.length > length!) return str.substring(0, length - 3) + "...";

    return str;
  }
}
