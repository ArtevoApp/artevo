import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo/features/music/controllers/music_controllers.dart';
import 'package:artevo_package/models/music_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:text_scroll/text_scroll.dart';

// TODO:
// responsive test for music card
// title, iphone 7

class MusicCard extends ConsumerWidget {
  const MusicCard({super.key, required this.musicContent});

  final MusicContent musicContent;

  @override
  Widget build(BuildContext context, ref) {
    final songName = musicContent.title.length > 27
        ? musicContent.title.substring(0, 27) + "..."
        : musicContent.title;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: smallPadding),
      leading: ImageViewer(
        url: musicContent.albumImageUrl,
        height: smallImageSize,
        width: smallImageSize,
      ),
      title: Text(songName, style: TextStyle(fontSize: 14)),
      subtitle: TextScroll(
        musicContent.creator,
        mode: TextScrollMode.endless,
        velocity: Velocity(pixelsPerSecond: Offset(20, 0)),
        delayBefore: Duration(milliseconds: 500),
      ),
      trailing:
          IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_outline)),
      onTap: () =>
          ref.read(audioPlayerRepositoryProvider).changeSong(musicContent),
    );
  }
}
