import 'package:flutter/widgets.dart';

import '../../core/localization/app_localizations_context.dart';
import '../enums/errors.dart';

extension ErrorExtension on IError {
  String msg(BuildContext context, {String? data}) {
    switch (this) {
      case IError.err:
        return context.loc.err;
      case IError.errConnection:
        return context.loc.errConnection;
      case IError.errContentNotFound:
        return context.loc.contentIsNotFound;
      case IError.errInternetConnection:
        return context.loc.errInternetConnection;
      case IError.errTimeSync:
        return context.loc.errTimeSync;
      case IError.errUnknow:
        return context.loc.errUnknow(data.toString());
    }
  }
}
