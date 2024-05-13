import '../../common/constants/dimens.dart';
import '../../common/constants/strings.dart';
import '../../common/enums/errors.dart';
import '../../common/extensions/error_extension.dart';
import '../../localization/app_localizations_context.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, this.msg});

  final String? msg;

  /// [contentNotFound] show when content is not found.
  static Widget contentNotFound(BuildContext _) =>
      ErrorScreen(msg: _.loc.contentIsNotFound);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Center(
          child: Text(
        msg ?? IError.errUnknow.msg(context, data: appContactMail),
        textAlign: TextAlign.center,
      )),
    );
  }
}
