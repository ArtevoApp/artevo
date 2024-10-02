import 'package:artevo_package/enums/content_type.dart';
import 'package:artevo_package/models/music_content.dart';
import 'package:artevo_package/models/painting_content.dart';
import 'package:artevo_package/models/poetry_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../common/constants/dimens.dart';
import '../../../../common/extensions/content_type_extension.dart';
import '../../../../common/widgets/image_viewer.dart';
import '../../../../features/bookmark/bookmark_repository.dart';
import '../../../../features/music/widgets/music_card.dart';
import '../../../../features/painting/widgets/painting_zoom_dialog.dart';
import '../../../../features/poetry/poetry_card.dart';
import '../../../../core/localization/app_localizations_context.dart';

class BookmarksDetailScreen extends StatelessWidget {
  const BookmarksDetailScreen({super.key, required this.type});

  final ContentType type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(type.title(context)),
      ),
      body: FutureBuilder(
          future: BookmarkRepository.instance.getBookmarks(type, getAll: true),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Center(child: Text(context.loc.contentIsNotFound));
              }
              if (type.isMusicContent) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      MusicCard(music: snapshot.data![index] as MusicContent),
                );
              } else if (type.isPaintingContent) {
                return GridView.builder(
                  itemCount: snapshot.data!.length,
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
                    final painting = snapshot.data![index] as PaintingContent;
                    return InkWell(
                      onTap: () => PaintingZoomDialog.show(context, painting),
                      onLongPress: () =>
                          PaintingZoomDialog.show(context, painting),
                      child: ImageViewer(
                          url: painting.imageUrl, byDownloading: true),
                    );
                  },
                );
              } else if (type.isPoetryContent) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      PoemCard(poem: snapshot.data![index] as PoetryContent),
                );
              } else {
                return const SizedBox.shrink();
              }
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
