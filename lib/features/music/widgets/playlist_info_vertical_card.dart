import 'package:artevo_package/models/music_content.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../common/constants/dimens.dart';
import '../../../common/constants/text_styles.dart';
import '../../../common/extensions/music_content_extension.dart';
import '../../../common/global_variables/audio_handler.dart';
import '../../../common/widgets/image_viewer.dart';
import '../../../services/cache/lazy_user_data_manager.dart';
import '../models/playlist_info.dart';
import '../screens/playlist_screen.dart';

class PlaylistVerticalCard extends StatelessWidget {
  const PlaylistVerticalCard({super.key, required this.playlistInfo});

  final PlaylistInfo playlistInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: xLargeImageSize,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(mediumPadding),
            onTap: () async => showModalBottomSheet(
              context: context,
              useSafeArea: true,
              showDragHandle: true,
              isScrollControlled: true,
              builder: (context) => PlaylistScreen(playlistInfo: playlistInfo),
            ),
            child: Stack(
              children: [
                ImageViewer(
                  byDownloading: true,
                  width: xLargeImageSize,
                  height: xLargeImageSize,
                  url: playlistInfo.coverUrl,
                  borderRadius: mediumPadding,
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton.filledTonal(
                      onPressed: () async {
                        final playlist = await LazyUserDataManager.instance
                            .getPlaylist(playlistInfo.id);

                        if (playlist.isEmpty) return;

                        await audioHandler.updateQueue(playlist
                            .map((e) => MusicContent.fromJson((e as Map).cast())
                                .toMediaItem())
                            .toList());

                        audioHandler.play();
                      },
                      icon: Icon(
                        Iconsax.play_circle,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: smallPadding),
          Text(
            playlistInfo.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.b1.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
