import 'package:flutter/material.dart';
import '../../services/cache/user_data_manager.dart';

final localeController = ValueNotifier<Locale?>(UserDataManager.getLocale());
