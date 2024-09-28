import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/constants/dimens.dart';
import '../../../common/widgets/image_viewer.dart';
import '../models/playlist.dart';
import '../screens/playlist_screen.dart';

class PlaylistInfoCard extends StatelessWidget {
  const PlaylistInfoCard({super.key, required this.playlistInfo});

  final PlaylistInfo playlistInfo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(smallPadding),
      leading: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ImageViewer(
              byDownloading: true,
              borderRadius: mediumPadding,
              url: playlistInfo.coverUrl,
            ),
            const Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Iconsax.music_playlist,
                color: Colors.white,
                size: smallIconSize,
              ),
            )
          ],
        ),
      ),
      title: Text(playlistInfo.name),
      onTap: () async => showModalBottomSheet(
        context: context,
        useSafeArea: true,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => PlaylistScreen(playlistInfo: playlistInfo),
      ),
    );
  }
}
