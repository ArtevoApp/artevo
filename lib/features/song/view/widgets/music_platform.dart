import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/helpers/functions.dart';
import 'package:artevo/features/song/models/music_platforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultPadding)))),
      icon: SvgPicture.asset(
        platform.path,
        height: smallImageSize,
        colorFilter: !isExistUrl
            ? const ColorFilter.mode(Colors.grey, BlendMode.srcATop)
            : null,
      ),
    );
  }
}
