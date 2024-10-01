import 'package:flutter/material.dart';
import '../../services/cache/user_data_manager.dart';

final themeModeController = ValueNotifier<ThemeMode>(
    UserDataManager.instance.getTheme() ?? ThemeMode.light);
