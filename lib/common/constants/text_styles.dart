import 'fonts.dart';
import 'package:flutter/material.dart';

abstract class TextStyles {
  //
  // ─── HEADERS ────────────────────────────────────────────────────────────────────
  //

  /// Title text style for all screens.
  static const title = TextStyle(
      fontSize: 22, fontWeight: FontWeight.w700, fontFamily: Fonts.domine);

  /// 1st Header text style.
  static const h1 = TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, fontFamily: Fonts.domine);

  /// 2nd Header text style.
  static const h2 = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, fontFamily: Fonts.domine);

  /// 3rd Header text style.
  static const h3 = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, fontFamily: Fonts.domine);

  //
  // ─── BODY ───────────────────────────────────────────────────────────────────────
  //

  /// 1st Body text style.
  static const b1 = TextStyle(fontSize: 16);

  /// 2nd Body text style. Default text style.
  static const b2 = TextStyle(fontSize: 14);

  /// 3rd Body text style.
  static const b3 = TextStyle(fontSize: 12);

  //
  // ─── OTHER ──────────────────────────────────────────────────────────────────────
  //

  static const info = TextStyle(fontStyle: FontStyle.italic, fontSize: 12);

  static const infoV2 = TextStyle(fontStyle: FontStyle.italic, fontSize: 10);

  static const quote =
      TextStyle(fontSize: 20, wordSpacing: 5, fontWeight: FontWeight.w600);

  static const quoteV2 =
      TextStyle(fontSize: 16, wordSpacing: 3, fontWeight: FontWeight.w600);

  // for "Johann Wolfgang von Goethe"
  static const goethe = TextStyle(fontSize: 24, fontFamily: Fonts.chomsky);
}
