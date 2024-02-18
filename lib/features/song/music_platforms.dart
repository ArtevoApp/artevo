import 'package:artevo/common/helpers/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum MusicPlatform { ytMusic, spotify, appleMusic }

extension MusicPlatformExtension on MusicPlatform {
  String _path() {
    switch (this) {
      case MusicPlatform.ytMusic:
        return "yt_music";
      case MusicPlatform.spotify:
        return "spotify";
      case MusicPlatform.appleMusic:
        return "apple_music";
    }
  }

  String get path => "assets/music_platforms/${_path()}.svg";
}

class MusicPlatformButtonWidget extends StatelessWidget {
  const MusicPlatformButtonWidget(
      {super.key, required this.platform, this.url});
  final String? url;
  final MusicPlatform platform;
  @override
  Widget build(BuildContext context) {
    bool isExistUrl = url != null && url != "";
    return IconButton(
      onPressed: isExistUrl ? () => Functions.openUrl(context, url!) : null,
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))),
      icon: SvgPicture.asset(
        platform.path,
        height: 25,
        colorFilter: !isExistUrl
            ? const ColorFilter.mode(Colors.grey, BlendMode.srcATop)
            : null,
      ),
    );
  }
}
