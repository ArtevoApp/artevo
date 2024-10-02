import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  surface: Color(0xffF9F2E0),
  onSurface: Color(0xff1e1e1f),
  primary: Color(0xffCF644D),
  onPrimary: Color(0xffF9F2E0),
  secondary: Color(0xff1e1e1f),
  onSecondary: Color(0xff1e1e1f),
  error: Color(0xff690005),
  onError: Color(0xffffffff),
  tertiary: Color.fromARGB(255, 245, 240, 227),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  surface: Color(0xff1e1e1f),
  onSurface: Color(0xffF9F2E0),
  primary: Color(0xffFF9876),
  onPrimary: Color(0xffF9F2E0),
  secondary: Color(0xffF9F2E0),
  onSecondary: Color(0xffF9F2E0),
  error: Color(0xff690005),
  onError: Color(0xffffffff),
  tertiary: Color.fromARGB(255, 40, 40, 40),
);
