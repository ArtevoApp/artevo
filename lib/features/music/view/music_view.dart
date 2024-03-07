import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/widgets/add_bookmark_button.dart';
import 'package:artevo/features/music/controllers/music_controllers.dart';
import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo/features/music/view/widgets/music_player.dart';
import 'package:artevo/features/music/view/widgets/song_detail_dialog.dart';
import 'package:artevo_package/models/music_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:text_scroll/text_scroll.dart';

class MusicView extends ConsumerWidget {
  const MusicView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    MusicContent currentSong = ref
        .watch(audioPlayerRepositoryProvider.select((v) => v.getCurrentSong));

    return Center(
      child: SizedBox(
        width: columnWidth,
        child: Row(
          children: [
            Expanded(
                child: Column(children: [header(currentSong), MusicPlayer()])),
            albulCoverWidget(context, currentSong),
          ],
        ),
      ),
    );
  }

  Widget header(MusicContent content) {
    return Row(
      children: [
        SizedBox(width: defaultIconSize),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: TextScroll(
              content.creator + " - " + content.title,
              mode: TextScrollMode.endless,
              velocity: Velocity(pixelsPerSecond: Offset(20, 0)),
              delayBefore: Duration(milliseconds: 500),
              textAlign: TextAlign.right,
              selectable: true,
            ),
          ),
        ),
        AddBookmarkButton(content: content),
      ],
    );
  }

  Padding albulCoverWidget(_, MusicContent currentsong) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: InkWell(
        onTap: currentsong.albumImageUrl.isEmpty
            ? null
            : () => SongDetailDialog.show(_, currentsong),
        child: ImageViewer(
          url: currentsong.albumImageUrl,
          height: smallImageSize,
          width: smallImageSize,
        ),
      ),
    );
  }
}
