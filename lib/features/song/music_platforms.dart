import 'package:artevo/common/helpers/functions.dart';
import 'package:flutter/material.dart';

enum MusicPlatform { ytMusic, spotify, appleMusic }

extension MusicPlatformExtension on MusicPlatform {
  String path() {
    String basePath = "assets/music_platforms/";
    switch (this) {
      case MusicPlatform.ytMusic:
        return "${basePath}yt_music.svg";
      case MusicPlatform.spotify:
        return "${basePath}spotify.svg";
      case MusicPlatform.appleMusic:
        return "${basePath}apple_music.svg";
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
    return Expanded(
      child: TextButton(
        onPressed: isExistUrl ? () => Functions.openUrl(context, url!) : null,
        child: SizedBox(
          height: platform == MusicPlatform.spotify ? 19 : null,
          width: 79,
          child: Image.asset(
            platform.path(),
            color: isExistUrl ? null : Colors.grey,
          ),
        ),
      ),
    );
  }
}
