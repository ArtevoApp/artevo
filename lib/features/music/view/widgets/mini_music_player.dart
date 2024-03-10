import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/widgets/add_bookmark_button.dart';
import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo/features/music/controllers/music_controllers.dart';
import 'package:artevo/features/music/view/widgets/music_player_controllers.dart';
import 'package:artevo/screens/home/controllers/view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:text_scroll/text_scroll.dart';

class MiniMusicPlayer extends ConsumerWidget {
  const MiniMusicPlayer({super.key});

  @override
  Widget build(BuildContext context, ref) {
    bool isHomeView = ref.watch(homeViewController) == 0;

    if (isHomeView) return SizedBox.shrink();

    final content = ref
        .watch(audioPlayerRepositoryProvider.select((v) => v.getCurrentSong));

    return ClipRRect(
      borderRadius: BorderRadius.circular(defaultPadding),
      child: Container(
        height: mediumImageSize,
        width: columnWidth,
        padding: EdgeInsets.all(smallPadding),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: .3))),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
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
                  ),
                  MusicPlayerControllers()
                ],
              ),
            ),
            SizedBox(width: defaultPadding),
            ImageViewer(
              url: content.albumImageUrl,
              height: smallImageSize,
              width: smallImageSize,
            ),
          ],
        ),
      ),
    );
  }
}
