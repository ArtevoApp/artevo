import 'dart:async';
import 'artevo_app.dart';
import 'core/config/app_initialize.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await AppInitialize.init();

  runApp(const ArtevoApp());
}
