import 'package:artevo/common/constants/dimens.dart';
import 'package:artevo/common/constants/text_styles.dart';
import 'package:artevo/common/widgets/image_viewer.dart';
import 'package:artevo/features/painting/views/painting_zoom_view.dart';
import 'package:artevo/localization/app_localizations_context.dart';
import 'package:artevo/services/hive/hive_daily_content_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class PaintingDetailScreen extends ConsumerWidget {
  const PaintingDetailScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final hive = HiveDailyContentDataService.instance;

    final painting = hive.getPaintingContentData();

    final detail = hive.getPaintingDetail(context.loc.langCode);

    if (painting == null) return const SizedBox.shrink();

    return Scaffold(
        appBar: AppBar(title: Text(painting.title)),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: dialogWidth * 2,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => PaintingZoomScreen.show(
                              url: painting.imageUrl, context: context),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              ImageViewer(url: painting.imageUrl),
                              const Icon(Icons.zoom_out_map_outlined,
                                  color: Colors.white, size: xLargeIconSize),
                            ],
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        Text(
                            "${painting.title} (${painting.year})\n${painting.creator}",
                            style: TextStyles.body,
                            textAlign: TextAlign.center),
                        const SizedBox(height: defaultPadding),

                        //? painting detail is not found
                        if (detail == null) ...{
                          Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: Text(
                              context.loc.contentIsNotFound,
                              style: TextStyles.body,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        } else ...{
                          Padding(
                            padding: const EdgeInsets.all(largePadding),
                            child: Column(
                              children: [
                                Text(detail.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyles.title),
                                const SizedBox(height: hugePadding),
                                Text(detail.detail, style: TextStyles.body),
                                ListTile(
                                    title: Text(detail.creator,
                                        textAlign: TextAlign.end),
                                    trailing: const Icon(Iconsax.user,
                                        size: smallIconSize)),
                              ],
                            ),
                          ),
                        },
                        const SizedBox(height: hugePadding),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
