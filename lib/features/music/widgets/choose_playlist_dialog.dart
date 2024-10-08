import 'package:flutter/material.dart';

import '../../../common/constants/dimens.dart';
import '../../../common/constants/text_styles.dart';
import '../../../common/widgets/image_viewer.dart';
import '../../../core/localization/app_localizations_context.dart';
import '../../../services/cache/lazy_user_data_manager.dart';
import '../models/playlist_info.dart';

class ChoosePlaylistDialog extends StatelessWidget {
  const ChoosePlaylistDialog({super.key});

  static Future<PlaylistInfo?> show(BuildContext context) async {
    return showDialog<PlaylistInfo>(
      context: context,
      builder: (context) => const ChoosePlaylistDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.loc.playlists, style: TextStyles.h1),
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: dialogWidth,
          minWidth: dialogWidth,
          maxHeight: dialogWidth * 2,
          minHeight: dialogWidth / 2,
        ),
        child: FutureBuilder(
          future: LazyUserDataManager.instance.getAllPlaylistInfos(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: defaultPadding),
                itemBuilder: (context, index) => ListTile(
                  onTap: () => Navigator.of(context).pop(snapshot.data![index]),
                  title: Text(snapshot.data![index].name),
                  leading: AspectRatio(
                    aspectRatio: 1,
                    child: ImageViewer(
                      url: snapshot.data![index].coverUrl,
                      byDownloading: true,
                    ),
                  ),
                ),
              );
            }
            return Text(context.loc.dataIsNotFound);
          },
        ),
      ),
    );
  }
}
