import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:artevo_package/models/music_content.dart';
import '../../../common/constants/dimens.dart';
import '../../../common/extensions/music_content_extension.dart';
import '../../../common/global_variables/audio_handler.dart';
import '../../../common/helpers/functions.dart';
import '../../../common/widgets/bookmarking_button.dart';
import '../../../common/widgets/image_viewer.dart';
import '../../../core/localization/app_localizations_context.dart';
import '../../../services/cache/lazy_user_data_manager.dart';
import '../repository/listening_history_reposiory.dart';
import '../service/audio_player_helper.dart';
import 'choose_playlist_dialog.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({
    super.key,
    required this.music,
    this.isDense = true,
    this.padding,
    this.onTap,
    this.isSelected = false,
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

  final bool isSelected;

  final bool onTapIsEnabled;

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: isDense,
      enabled: enabled,
      selected: isSelected,
      horizontalTitleGap: mediumPadding,
      contentPadding: EdgeInsets.only(left: padding ?? defaultPadding),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.elliptical(mediumPadding, defaultPadding),
        ),
      ),
      leading: ImageViewer(url: music.thumbnailUrl),
      title: Text(Functions.stringShorter(music.title)),
      subtitle: Text(Functions.stringShorter(music.creator)),
      trailing: onTapIsEnabled
          ? Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  Functions.secondToMinute(music.duration.seconds),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                MusicCardPopupMenu(music: music),
              ],
            )
          : null,
      onTap: onTapIsEnabled
          ? () async {
              await Future.wait(
                [
                  onTap?.call() ?? AudioPlayerHelper.addQueueAndPlay(music),
                  ListeningHistoryReposiory.instance.addToHistory(music),
                ],
              );
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
        iconColor: Theme.of(context).colorScheme.onSurface,
        color: Theme.of(context).colorScheme.tertiary,
        itemBuilder: (_) => [
          PopupMenuItem(
            value: 0,
            child: BookmarkingButton(content: music, onlyIcon: false),
          ),
          PopupMenuItem(
            onTap: () => audioHandler.addQueueItem(music.toMediaItem()),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(context.loc.addQueue),
              leading: const Icon(Iconsax.play_add),
            ),
          ),
          PopupMenuItem(
            onTap: () async {
              final playlistInfo = await ChoosePlaylistDialog.show(context);
              if (playlistInfo != null) {
                LazyUserDataManager.instance
                    .addMusicToPlaylist(playlistInfo.id, music);
              }
            },
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(context.loc.addToPlaylist),
              leading: const Icon(Iconsax.music_playlist),
            ),
          ),
        ],
      ),
    );
  }
}
