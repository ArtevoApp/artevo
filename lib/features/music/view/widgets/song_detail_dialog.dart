import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/features/music/models/music_platforms.dart';
import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo/features/music/view/widgets/music_platform.dart';
import 'package:artevo_package/models/music_content.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SongDetailDialog extends StatelessWidget {
  const SongDetailDialog({super.key, required this.music});

  final MusicContent music;

  static Future<void> show(BuildContext context, MusicContent music) async {
    return showDialog(
        context: context, builder: (context) => SongDetailDialog(music: music));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: SizedBox(
      width: dialogWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageViewer(
              url: music.albumImageUrl,
              height: xLargeImageSize,
              width: xLargeImageSize),
          const SizedBox(height: 8),
          const Icon(Iconsax.sound, size: 16),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.user, size: 14, color: Colors.grey),
              Expanded(child: Text(music.creator, textAlign: TextAlign.center))
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.track_changes, size: 14, color: Colors.grey),
              Expanded(child: Text(music.title, textAlign: TextAlign.center))
            ],
          ),
          const SizedBox(height: 8),
          const Divider(indent: 16, endIndent: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MusicPlatformButtonWidget(
                  platform: MusicPlatform.ytMusic, url: music.ytMusicUrl),
              MusicPlatformButtonWidget(
                  platform: MusicPlatform.spotify, url: music.spotifyUrl),
              MusicPlatformButtonWidget(
                  platform: MusicPlatform.appleMusic, url: music.appleMusicUrl),
            ],
          ),
        ],
      ),
    ));
  }
}
