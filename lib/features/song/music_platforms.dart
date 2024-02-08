import 'package:artevo/common/helpers/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artevo/common/widgets/theme_toggle_button.dart';

enum MusicPlatform { ytMusic, spotify, appleMusic }

extension MusicPlatformExtension on MusicPlatform {
  String path(ThemeMode? themeMode) {
    String basePath = "assets/music_platforms/";
    String mode = themeMode == ThemeMode.dark ? "white" : "dark";
    switch (this) {
      case MusicPlatform.ytMusic:
        return "${basePath}yt_music_$mode.png";
      case MusicPlatform.spotify:
        return "${basePath}spotify_$mode.png";
      case MusicPlatform.appleMusic:
        return "${basePath}apple_music_$mode.png";
    }
  }
}

class MusicPlatformButtonWidget extends StatelessWidget {
  const MusicPlatformButtonWidget(
      {super.key, required this.platform, this.url});
  final String? url;
  final MusicPlatform platform;
  @override
  Widget build(BuildContext context) {
    bool isExistUrl = url != null && url != "";
    return TextButton(
      onPressed: isExistUrl ? () => Functions.openUrl(context, url!) : null,
      child: SizedBox(
        height: platform == MusicPlatform.spotify ? 19 : null,
        width: 79,
        child: Consumer(builder: (context, ref, child) {
          var theme = ref.watch(themeModeProvider);
          return Image.asset(
            platform.path(theme),
            color: isExistUrl ? null : Colors.grey,
          );
        }),
      ),
    );
  }
}
