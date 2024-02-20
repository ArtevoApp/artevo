import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/features/song/models/music_platforms.dart';
import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo/features/song/view/widgets/music_platform.dart';
import 'package:artevo_package/models/song.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SongDetailDialog extends StatelessWidget {
  const SongDetailDialog({super.key, required this.song});

  final Song song;

  static Future<void> show(BuildContext context, Song song) async {
    return showDialog(
        context: context, builder: (context) => SongDetailDialog(song: song));
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
              url: song.albumImageUrl,
              height: xLargeImageSize,
              width: xLargeImageSize),
          const SizedBox(height: 8),
          const Icon(Iconsax.sound, size: 16),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.user, size: 14, color: Colors.grey),
              Expanded(child: Text(song.artist, textAlign: TextAlign.center))
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.track_changes, size: 14, color: Colors.grey),
              Expanded(child: Text(song.name, textAlign: TextAlign.center))
            ],
          ),
          const SizedBox(height: 8),
          const Divider(indent: 16, endIndent: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MusicPlatformButtonWidget(
                  platform: MusicPlatform.ytMusic, url: song.ytMusicUrl),
              MusicPlatformButtonWidget(
                  platform: MusicPlatform.spotify, url: song.spotifyUrl),
              MusicPlatformButtonWidget(
                  platform: MusicPlatform.appleMusic, url: song.appleMusicUrl),
            ],
          ),
        ],
      ),
    ));
  }
}
