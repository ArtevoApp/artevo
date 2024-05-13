import 'package:artevo_package/models/painting_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/config/color_schemes.dart';
import '../../../common/constants/dimens.dart';
import '../../../common/constants/text_styles.dart';
import '../../../common/widgets/image_viewer.dart';
import '../../../localization/app_localizations_context.dart';
import '../../../services/cache/lazy_user_data_manager.dart';
import '../../painting/repository/painting_repository.dart';
import '../models/playlist.dart';

class CreatePlaylistDialog extends StatefulWidget {
  const CreatePlaylistDialog({super.key});

  static Future<bool?> show(BuildContext context) async {
    return showDialog(
        context: context, builder: (context) => const CreatePlaylistDialog());
  }

  @override
  State<CreatePlaylistDialog> createState() => _CreatePlaylistDialogState();
}

class _CreatePlaylistDialogState extends State<CreatePlaylistDialog> {
  final paintingContent = ValueNotifier<PaintingContent?>(null);
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPainting();
  }

  @override
  void dispose() {
    paintingContent.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> getPainting() async =>
      paintingContent.value = await PaintingRepository.instance
          .getPaintingsRandomly(limit: 1)
          .then((value) => value.first);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(context.loc.createPlaylist),
      content: SizedBox(
        width: dialogWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: defaultPadding),
            ValueListenableBuilder(
              valueListenable: paintingContent,
              builder: (context, value, child) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: mediumImageSize,
                      width: mediumImageSize,
                      child: value != null
                          ? ImageViewer(url: value.imageUrl)
                          : const Placeholder(),
                    ),
                    const SizedBox(width: defaultPadding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              Text(context.loc.cover, style: TextStyles.title),
                              const SizedBox(width: largePadding),
                              SizedBox(
                                height: largeIconSize,
                                child: OutlinedButton.icon(
                                  onPressed: getPainting,
                                  icon: const Icon(
                                    Iconsax.refresh,
                                    size: xsmallIconSize,
                                  ),
                                  label: Text(context.loc.refresh),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: defaultPadding),
                          Text(value?.title ?? "?_?", style: TextStyles.bodyv3),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
            const SizedBox(height: largePadding),
            TextField(
              autofocus: true,
              controller: controller,
              inputFormatters: [LengthLimitingTextInputFormatter(40)],
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                hintText: context.loc.playlistName,
                fillColor: lightColorScheme.tertiary.withOpacity(.15),
                suffixIcon: const Icon(Iconsax.music_playlist),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(mediumPadding),
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.loc.cancel)),
        FilledButton(
            onPressed: () async {
              if (paintingContent.value != null && controller.text.isNotEmpty) {
                final createdAt = DateTime.now().microsecondsSinceEpoch;

                final playlistInfo = PlaylistInfo(
                  id: createdAt.toString(),
                  name: controller.text,
                  coverContentID: paintingContent.value!.id!,
                  coverUrl: paintingContent.value!.imageUrl,
                  createdAt: createdAt,
                  description: "",
                  coverTitle: paintingContent.value!.title,
                );

                await LazyUserDataManager.instance
                    .addOrUpdatePlaylistInfo(playlistInfo);

                Navigator.pop(context, true);
              }
            },
            child: Text(context.loc.create)),
      ],
    );
  }
}
