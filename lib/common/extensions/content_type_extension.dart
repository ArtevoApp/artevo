import 'package:artevo_package/enums/content_type.dart';
import 'package:flutter/material.dart';

import '../../localization/app_localizations_context.dart';

extension ContentTypeExtension on ContentType {
  bool get isMusicContent => this == ContentType.musicContent;
  bool get isPaintingContent => this == ContentType.paintingContent;
  bool get isPoetryContent => this == ContentType.poetryContent;

  String title(BuildContext context) {
    switch (this) {
      case ContentType.musicContent:
        return context.loc.musics;
      case ContentType.paintingContent:
        return context.loc.paintings;
      case ContentType.poetryContent:
        return context.loc.poems;
      default:
        return context.loc.err;
    }
  }

  String get localDBTableName {
    switch (this) {
      case ContentType.musicContent:
        return 'music';
      case ContentType.paintingContent:
        return 'painting';
      case ContentType.poetryContent:
        return 'poetry';
      default:
        return 'err';
    }
  }
}
