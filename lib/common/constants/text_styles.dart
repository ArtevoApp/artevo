import 'package:artevo/common/constants/fonts.dart';
import 'package:flutter/material.dart';

abstract class TextStyles {
  // welcome screen text styles
  static const welcomeTitle = TextStyle(fontSize: 48);

  static const welcomeBody =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  // common text styles
  static const title = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  static const body = TextStyle(fontSize: 16, wordSpacing: 3);

  static const bodyv2 = TextStyle(fontSize: 14);

  static const bodyv3 = TextStyle(fontSize: 12);

  static const info = TextStyle(fontStyle: FontStyle.italic, fontSize: 12);

  // for quotes
  static const quote =
      TextStyle(fontSize: 20, wordSpacing: 5, fontWeight: FontWeight.w600);

  // for "Johann Wolfgang von Goethe"
  static const goethe = TextStyle(fontFamily: Fonts.chomsky, fontSize: 26);
}
