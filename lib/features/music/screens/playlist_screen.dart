import 'package:artevo_package/models/music_content.dart';
import 'package:artevo_package/models/painting_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';

import '../../../common/constants/dimens.dart';
import '../../../common/constants/text_styles.dart';
import '../../../common/extensions/music_content_extension.dart';
import '../../../common/global_variables/audio_handler.dart';
import '../../../common/helpers/functions.dart';
import '../../../common/widgets/image_viewer.dart';
import '../../../core/localization/app_localizations_context.dart';
import '../../../services/cache/lazy_user_data_manager.dart';
import '../../painting/repository/painting_repository.dart';
import '../models/playlist_info.dart';
import '../repository/playlist_repository.dart';
import '../widgets/music_card.dart';

part 'playlist_screen_mixin.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key, required this.playlistInfo});

  final PlaylistInfo playlistInfo;

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen>
    with PlaylistScreenMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: editMode,
        builder: (context, editModeIsOn, ch) {
          return ListView(
            padding: const EdgeInsets.all(largePadding),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                    valueListenable: paintingContent,
                    builder: (context, value, child) {
                      if (editModeIsOn) {
                        return Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            ImageViewer(
                              width: largeImageSize,
                              height: largeImageSize,
                              byDownloading: true,
                              url: value?.imageUrl ?? playlistInfo.coverUrl,
                            ),
                            if (editModeIsOn)
                              Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  backgroundColor: Colors.black87,
                                  child: IconButton(
                                    onPressed: getPaintingContent,
                                    icon: const Icon(Iconsax.refresh5),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        );
                      }
                      return ImageViewer(
                        width: largeImageSize,
                        height: largeImageSize,
                        byDownloading: true,
                        url: playlistInfo.coverUrl,
                      );
                    },
                  ),
                  const SizedBox(width: largePadding),
                  Expanded(
                    child: EditableText(
                      autofocus: true,
                      readOnly: !editModeIsOn,
                      focusNode: focusNode,
                      controller: playlistNameController,
                      textInputAction: TextInputAction.done,
                      maxLines: 4,
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontSize: 18),
                      inputFormatters: [LengthLimitingTextInputFormatter(40)],
                      cursorColor: Theme.of(context).colorScheme.primary,
                      backgroundCursorColor:
                          Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  const SizedBox(width: defaultPadding),
                  if (editModeIsOn)
                    SizedBox(
                      width: hugeIconSize,
                      child: Column(
                        children: [
                          CloseButton(onPressed: () => editMode.value = false),
                          IconButton(
                            onPressed: saveEdits,
                            icon: const Icon(Ionicons.checkmark),
                          ),
                        ],
                      ).animate().scaleX(),
                    ),
                  if (!editModeIsOn)
                    SizedBox(
                      height: hugeIconSize,
                      width: hugeIconSize,
                      child: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        tooltip: "",
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              onTap: () => editMode.value = true,
                              child: ListTile(
                                leading: const Icon(Iconsax.edit_2),
                                title: Text(context.loc.edit),
                              )),
                          PopupMenuItem(
                            onTap: () {
                              PlaylistRepository.instance
                                  .deletePlaylist(playlistInfo.id);
                              Navigator.pop(context);
                            },
                            child: ListTile(
                              leading: const Icon(Icons.delete_outline),
                              title: Text(context.loc.delete),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: smallPadding),
              ValueListenableBuilder(
                  valueListenable: paintingContent,
                  builder: (context, value, child) {
                    return SelectableText(
                      Functions.stringShorter(
                          "${context.loc.cover}: ${editModeIsOn ? value?.title : playlistInfo.coverTitle}",
                          length: 60),
                      style: TextStyles.infoV2,
                    );
                  }),
              const Divider(),
              ValueListenableBuilder(
                valueListenable: playlist,
                builder: (context, value, child) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(context.loc.musics, style: TextStyles.quoteV2),
                          const SizedBox(width: defaultPadding),
                          Text(value.length.toString(),
                              style: TextStyles.quote),
                          const Spacer(),
                          TextButton.icon(
                              onPressed: playAllButtonPressed,
                              icon: const Icon(Iconsax.play_add),
                              label: Text(context.loc.playAll)),
                          IconButton(
                              tooltip: context.loc.addQueue,
                              onPressed: addQueueButtonPressed,
                              icon: const Icon(Icons.queue_music_outlined))
                        ],
                      ),
                      if (!editModeIsOn)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.length,
                          itemBuilder: (context, index) =>
                              MusicCard(music: value[index]),
                        ),
                      if (editModeIsOn)
                        ReorderableListView.builder(
                          shrinkWrap: true,
                          itemCount: value.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Row(
                            key: ValueKey(index),
                            children: [
                              const Icon(Ionicons.reorder_three),
                              Expanded(
                                child: MusicCard(
                                  music: value[index],
                                  onTapIsEnabled: false,
                                  padding: defaultPadding,
                                ),
                              ),
                              IconButton(
                                onPressed: () => deletePlaylistItem(index),
                                icon: const Icon(Ionicons.close_outline),
                                color: Colors.red,
                              ),
                            ],
                          ),
                          onReorder: onReorder,
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: xxLargeImageSize),
            ],
          );
        });
  }
}
