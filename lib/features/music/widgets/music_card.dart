import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import 'package:artevo_package/models/music_content.dart';

import '../../../common/constants/dimens.dart';
import '../../../common/extensions/music_content_extension.dart';
import '../../../common/global_variables/global_audio_handler.dart';
import '../../../common/helpers/functions.dart';
import '../../../common/widgets/bookmarking_button.dart';
import '../../../common/widgets/image_viewer.dart';
import '../../../localization/app_localizations_context.dart';
import '../../../services/cache/lazy_user_data_manager.dart';
import '../repository/music_repository.dart';
import '../service/audio_player_helper.dart';
import 'choose_playlist_dialog.dart';

class MusicCard extends ConsumerWidget {
  const MusicCard({
    super.key,
    required this.music,
    this.isDense = true,
    this.padding,
    this.onTap,
    this.onTapIsEnabled = true,
    this.enabled = true,
  });

  /// The music content.
  final MusicContent music;

  /// If the card is dense.
  final bool isDense;

  /// The padding between the card and the content.
  final double? padding;

  /// Custom function for different actions.
  final Future<void> Function()? onTap;

  final bool onTapIsEnabled;

  final bool enabled;

  @override
  Widget build(BuildContext context, ref) {
    final isCurrentSong = audioHandler.mediaItem.value?.id == music.songID;

    return ListTile(
      dense: isDense,
      enabled: enabled,
      selected: isCurrentSong,
      horizontalTitleGap: mediumPadding,
      contentPadding: EdgeInsets.only(left: padding ?? defaultPadding),
      leading: ImageViewer(url: music.thumbnailUrl),
      title: Text(Functions.stringShorter(music.title)),
      subtitle: Text(Functions.stringShorter(music.creator)),
      trailing: onTapIsEnabled
          ? Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(Functions.secondToMinute(music.duration.seconds),
                    style: const TextStyle(color: Colors.grey)),
                MusicCardPopupMenu(music: music),
              ],
            )
          : null,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.elliptical(mediumPadding, defaultPadding))),
      onTap: onTapIsEnabled
          ? () async {
              onTap != null
                  ? await onTap!.call()
                  : await AudioPlayerHelper.addQueueAndPlay(music);

              MusicRepository.instance.addToListenedMusicList(music);
            }
          : null,
    );
  }
}

class MusicCardPopupMenu extends StatelessWidget {
  const MusicCardPopupMenu({super.key, required this.music});

  final MusicContent music;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: hugeIconSize,
      height: hugeIconSize,
      child: PopupMenuButton<int>(
        icon: const Icon(Icons.more_vert),
        iconColor: Colors.grey,
        itemBuilder: (_) => [
          PopupMenuItem(
            value: 0,
            child: BookmarkingButton(content: music, onlyIcon: false),
          ),
          PopupMenuItem(
            value: 1,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(_.loc.addQueue),
              leading: const Icon(Iconsax.play_add),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(_.loc.addToPlaylist),
              leading: const Icon(Iconsax.music_playlist),
            ),
          ),
        ],
        onSelected: (int value) async {
          if (value == 1) audioHandler.addQueueItem(music.toMediaItem());
          if (value == 2) {
            final playlistInfo = await ChoosePlaylistDialog.show(context);
            if (playlistInfo != null) {
              LazyUserDataManager.instance
                  .addMusicToPlaylist(playlistInfo.id, music);
            }
          }
        },
      ),
    );
  }
}
