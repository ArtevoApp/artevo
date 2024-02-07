import 'package:artevo/common/constants/app_constants.dart';
import 'package:artevo/common/constants/dimes.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';

class UnknowErrorAlertDialog extends StatelessWidget {
  const UnknowErrorAlertDialog({super.key, this.msg});

  final String? msg;

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
