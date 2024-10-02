import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/constants/dimens.dart';
import '../../../common/constants/text_styles.dart';
import '../../../common/widgets/image_viewer.dart';
import '../models/playlist_info.dart';
import '../screens/playlist_screen.dart';

class PlaylistInfoCard extends StatelessWidget {
  const PlaylistInfoCard({super.key, required this.playlistInfo});

  final PlaylistInfo playlistInfo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultPadding),
      onTap: () async => showModalBottomSheet(
        context: context,
        useSafeArea: true,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (context) => PlaylistScreen(playlistInfo: playlistInfo),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultPadding),
          border: Border.all(
            width: .1,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        padding: const EdgeInsets.all(defaultPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ImageViewer(byDownloading: true, url: playlistInfo.coverUrl),
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
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Text(
                playlistInfo.name,
                style: TextStyles.b1.copyWith(fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
