import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/services/hive/hive_user_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>(
    (ref) => HiveUserDataService().getTheme() ?? ThemeMode.dark);

class ThemeModeToggleWidget extends StatelessWidget {
  const ThemeModeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final theme = ref.watch(themeModeProvider);

      return ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Text(context.loc.darkTheme),
        trailing: Switch.adaptive(
          value: theme == ThemeMode.dark ? true : false,
          onChanged: (isDark) async {
            ThemeMode mode = isDark ? ThemeMode.dark : ThemeMode.light;
            ref.read(themeModeProvider.notifier).state = mode;
            await HiveUserDataService().setTheme(mode);
          },
        ),
      );
    });
  }
}
