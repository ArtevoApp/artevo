import '../constants/strings.dart';
import '../constants/dimens.dart';
import 'package:flutter/material.dart';

import '../enums/errors.dart';
import '../extensions/error_extension.dart';

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
        children: [Text(IError.err.msg(context)), const CloseButton()],
      ),
      content: SizedBox(
        width: dialogWidth,
        child: Text(msg != null
            ? msg.toString()
            : IError.errUnknow.msg(context, data: appContactMail)),
      ),
    );
  }
}
