import 'package:flutter/material.dart';

abstract class TextStyles {
  static const welcomeTitle = TextStyle(fontSize: 48);

  static const welcomeBody =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static const title = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static const body = TextStyle(fontSize: 18, wordSpacing: 3);

  static const bodyv2 = TextStyle(fontSize: 14);

  static const bodyv3 = TextStyle(fontSize: 12);

  static const info = TextStyle(fontStyle: FontStyle.italic, fontSize: 12);

  static const quote =
      TextStyle(fontSize: 20, wordSpacing: 5, fontWeight: FontWeight.w600);

  static const goethe = TextStyle(fontFamily: "Chomsky", fontSize: 26);
}
