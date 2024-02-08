import 'package:artevo/common/constants/strings.dart';
import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, this.msg});

  final String? msg;

  static Future<void> show(BuildContext context, {String? msg}) {
    return showDialog(
        context: context, builder: (context) => ErrorDialog(msg: msg));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(context.loc.error), const CloseButton()],
      ),
      content: SizedBox(
        width: dialogWidth,
        child: Text(msg != null
            ? msg.toString()
            : context.loc.unknowErrorText(appContactMail)),
      ),
    );
  }
}
