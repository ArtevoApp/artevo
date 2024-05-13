import '../../localization/app_localizations_context.dart';
import '../../services/cache/user_data_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>(
    (ref) => UserDataManager.instance.getTheme() ?? ThemeMode.light);

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
            final ThemeMode mode = isDark ? ThemeMode.dark : ThemeMode.light;
            ref.read(themeModeProvider.notifier).state = mode;
            await UserDataManager.instance.setTheme(mode);
          },
        ),
      );
    });
  }
}
