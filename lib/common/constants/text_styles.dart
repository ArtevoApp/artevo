import 'fonts.dart';
import 'package:flutter/material.dart';

abstract class TextStyles {
  // welcome screen text styles
  static const welcomeTitle = TextStyle(fontSize: 48);

  static const welcomeBody =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  // common text styles
  static const title = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

  static const body = TextStyle(fontSize: 15, wordSpacing: 3);

  static const bodyv2 = TextStyle(fontSize: 14);

  static const bodyv3 = TextStyle(fontSize: 12);

  static const info = TextStyle(fontStyle: FontStyle.italic, fontSize: 12);

  static const infoV2 = TextStyle(fontStyle: FontStyle.italic, fontSize: 10);

  // for quotes
  static const quote =
      TextStyle(fontSize: 20, wordSpacing: 5, fontWeight: FontWeight.w600);

  static const quoteV2 =
      TextStyle(fontSize: 16, wordSpacing: 3, fontWeight: FontWeight.w600);

  // for "Johann Wolfgang von Goethe"
  static const goethe = TextStyle(fontFamily: Fonts.chomsky, fontSize: 24);

  static const pageTitle = TextStyle(fontSize: 22, fontWeight: FontWeight.w600);

  static const pageSubtitle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
}
