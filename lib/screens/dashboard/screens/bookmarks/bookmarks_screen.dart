import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:artevo_package/enums/content_type.dart';
import 'package:artevo_package/models/content.dart';
import 'package:artevo_package/models/music_content.dart';
import 'package:artevo_package/models/painting_content.dart';
import 'package:artevo_package/models/poetry_content.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/constants/dimens.dart';
import '../../../../common/constants/text_styles.dart';
import '../../../../common/extensions/content_type_extension.dart';
import '../../../../common/extensions/music_content_extension.dart';
import '../../../../common/global_variables/global_audio_handler.dart';
import '../../../../common/widgets/image_viewer.dart';
import '../../../../common/widgets/loader.dart';
import '../../../../features/bookmark/bookmark_repository.dart';
import '../../../../features/music/widgets/music_card.dart';
import '../../../../features/painting/widgets/painting_zoom_dialog.dart';
import '../../../../features/poetry/poetry_card.dart';
import '../../../../localization/app_localizations_context.dart';
import 'bookmarks_detail_screen.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(defaultPadding),
        children: [
          AppBar(
            centerTitle: true,
            title: Text(context.loc.bookmarks),
            surfaceTintColor: Colors.transparent,
          ),
          _contents(context, ContentType.musicContent),
          _contents(context, ContentType.paintingContent),
          _contents(context, ContentType.poetryContent),
          const SizedBox(height: xLargeImageSize),
        ],
      ).animate().fade(duration: const Duration(milliseconds: 500)),
    );
  }

  Widget _contents(BuildContext context, ContentType type) {
    final limit = 9;
    return FutureBuilder<List<Content>>(
      future: BookmarkRepository.instance.getBookmarks(type, limit: limit),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (type.isMusicContent) ...{
                Row(
                  children: [
                    Expanded(
                        child:
                            Text(type.title(context), style: TextStyles.title)),
                    TextButton.icon(
                      onPressed: () => audioHandler.updateQueue(
                          (snapshot.data!.cast<MusicContent>())
                              .map((e) => e.toMediaItem())
                              .toList()),
                      icon: const Icon(Iconsax.play_add, size: smallIconSize),
                      label: Text(context.loc.playAll),
                    )
                  ],
                ),
                const Divider(height: 0),
                musicList(context, snapshot.data!.cast())
              } else if (type.isPaintingContent) ...{
                Text(type.title(context), style: TextStyles.title),
                const Divider(),
                paintingList(context, snapshot.data!.cast()),
              } else if (type.isPoetryContent) ...{
                Text(type.title(context), style: TextStyles.title),
                const Divider(),
                poetyList(context, snapshot.data!.cast()),
              },

              // Show all button
              if (snapshot.data!.length >= limit) ...{
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BookmarksDetailScreen(type: type),
                              ),
                            ),
                        child: Text(context.loc.showAll)))
              } else ...{
                const SizedBox(
                  height: largePadding,
                )
              }
            ],
          );
        }
        return const Center(child: Loader());
      },
    );
  }

  Widget musicList(BuildContext context, List<MusicContent> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(
        list.length,
        (index) => MusicCard(isDense: true, music: list[index]),
      ),
    );
  }

  Widget paintingList(BuildContext context, List<PaintingContent> list) {
    return SizedBox(
      height: 400,
      child: GridView.builder(
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 3,
          mainAxisSpacing: smallPadding,
          crossAxisSpacing: smallPadding,
          repeatPattern: QuiltedGridRepeatPattern.inverted,
          pattern: [
            const QuiltedGridTile(2, 2),
            const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 1)
          ],
        ),
        itemBuilder: (context, index) {
          final painting = list[index];
          return InkWell(
            onTap: () => PaintingZoomDialog.show(context, painting),
            onLongPress: () => PaintingZoomDialog.show(context, painting),
            child: ImageViewer(url: painting.imageUrl, height: 400),
          );
        },
      ),
    );
  }

  Widget poetyList(BuildContext context, List<PoetryContent> list) {
    return Column(
      children:
          List.generate(list.length, (index) => PoemCard(poem: list[index])),
    );
  }
}
