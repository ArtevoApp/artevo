import 'dart:async';
import 'artevo_app.dart';
import 'common/config/app_initialize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await AppInitialize.init();

  runApp(const ProviderScope(child: ArtevoApp()));
}
